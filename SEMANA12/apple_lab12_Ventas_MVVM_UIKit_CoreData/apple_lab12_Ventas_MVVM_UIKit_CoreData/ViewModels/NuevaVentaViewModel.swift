//
//  NuevaVentaViewModel.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (MVVM · UIKit + Core Data)
//

import Foundation
import CoreData

enum ResultadoVenta {
    case registrada(mensaje: String)
    case rechazada(titulo: String, mensaje: String)
}

/// ViewModel de "Nueva venta": estado del formulario, cálculo y registro.
final class NuevaVentaViewModel {
    var onChange: (() -> Void)?

    private(set) var cliente: Cliente?
    private(set) var producto: Producto?
    private(set) var cantidad = 1
    private var clientes: [Cliente] = []
    private var productos: [Producto] = []

    // MARK: Textos para la vista

    var vendedorTexto: String { "Vendedor: \(Sesion.shared.usuario?.nombre ?? "-")" }
    var clienteTexto: String { cliente?.nombre ?? "Seleccionar cliente" }
    var productoTexto: String { producto.map { "\($0.nombre ?? "") · \($0.precio.moneda)" } ?? "Seleccionar producto" }
    var stockTexto: String { producto.map { "Stock disponible: \($0.stock)" } ?? "Stock disponible: -" }
    var categoria: CategoriaCliente { cliente.map { Datos.categoria(de: $0) } ?? .regular }
    var categoriaTexto: String? { cliente == nil ? nil : "Categoría del cliente: \(categoria.rawValue)" }

    var resumen: ResumenVenta {
        Reglas.calcularVenta(cantidad: cantidad, precio: producto?.precio ?? 0, categoria: categoria)
    }
    var descuentoTexto: String {
        let p = categoria.porcentajeDescuento
        return "- " + resumen.descuento.moneda + (p > 0 ? " (\(Int(p * 100)) %)" : "")
    }

    // MARK: Acciones

    func opcionesClientes() -> [(titulo: String, detalle: String)] {
        let request: NSFetchRequest<Cliente> = Cliente.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending: true)]
        clientes = (try? Datos.contexto.fetch(request)) ?? []
        return clientes.map { ($0.nombre ?? "", "\($0.documento ?? "") · \(Datos.categoria(de: $0).rawValue)") }
    }

    func opcionesProductos() -> [(titulo: String, detalle: String)] {
        let request: NSFetchRequest<Producto> = Producto.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending: true)]
        productos = (try? Datos.contexto.fetch(request)) ?? []
        return productos.map { ($0.nombre ?? "", "\($0.precio.moneda) · stock \($0.stock)") }
    }

    func elegirCliente(en indice: Int) { cliente = clientes[indice]; onChange?() }
    func elegirProducto(en indice: Int) { producto = productos[indice]; onChange?() }
    func cambiarCantidad(_ nueva: Int) { cantidad = max(1, nueva); onChange?() }

    /// Si el supervisor borró lo elegido, se limpia la selección.
    func refrescar() {
        if let c = cliente, c.managedObjectContext == nil || c.isDeleted { cliente = nil }
        if let p = producto, p.managedObjectContext == nil || p.isDeleted { producto = nil }
        onChange?()
    }

    func registrar() -> ResultadoVenta {
        guard let cliente = cliente else { return .rechazada(titulo: "Falta el cliente", mensaje: "Elige un cliente para registrar la venta.") }
        guard let producto = producto else { return .rechazada(titulo: "Falta el producto", mensaje: "Elige un producto para registrar la venta.") }
        // Regla de stock: si la cantidad supera el stock, alerta y no se registra.
        guard Int64(cantidad) <= producto.stock else {
            return .rechazada(titulo: "Stock insuficiente", mensaje: "Solo hay \(producto.stock) unidades de \(producto.nombre ?? "este producto").")
        }
        let r = Reglas.calcularVenta(cantidad: cantidad, precio: producto.precio, categoria: Datos.categoria(de: cliente))

        let v = Venta(context: Datos.contexto)
        v.fecha = Date()
        v.cantidad = Int64(cantidad)
        v.precioUnitario = producto.precio
        v.descuento = r.descuento
        v.igv = r.igv
        v.total = r.total
        v.anulada = false
        v.vendedor = Sesion.shared.usuario     // la venta guarda quién la registró
        v.producto = producto
        v.cliente = cliente
        producto.stock -= Int64(cantidad)      // al registrar baja el stock
        do {
            try Datos.guardar()
        } catch {
            Datos.contexto.rollback()
            return .rechazada(titulo: "No se pudo registrar", mensaje: "Intenta de nuevo.")
        }
        let mensaje = "Total: \(r.total.moneda)\nStock restante de \(producto.nombre ?? ""): \(producto.stock)"
        self.cliente = nil; self.producto = nil; cantidad = 1
        onChange?()
        return .registrada(mensaje: mensaje)
    }
}
