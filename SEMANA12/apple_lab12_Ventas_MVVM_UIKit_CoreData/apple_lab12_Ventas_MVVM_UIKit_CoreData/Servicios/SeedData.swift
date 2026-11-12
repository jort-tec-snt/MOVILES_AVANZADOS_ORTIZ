//
//  SeedData.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (UIKit + Core Data)
//

import CoreData

/// Datos de ejemplo para poder probar los casos sin cargar todo a mano.
/// Se cargan solo si no hay productos. Para empezar de cero, borra la app del simulador.
enum SeedData {
    static func cargarSiEstaVacio(en ctx: NSManagedObjectContext) {
        let request: NSFetchRequest<Producto> = Producto.fetchRequest()
        guard ((try? ctx.count(for: request)) ?? 0) == 0 else { return }

        func producto(_ nombre: String, _ categoria: String, _ precio: Double, _ stock: Int64) -> Producto {
            let p = Producto(context: ctx)
            p.nombre = nombre; p.categoria = categoria; p.precio = precio; p.stock = stock
            return p
        }
        func cliente(_ nombre: String, _ documento: String) -> Cliente {
            let c = Cliente(context: ctx)
            c.nombre = nombre; c.documento = documento
            return c
        }

        let laptop = producto("Laptop", "Cómputo", 200, 40)
        let mouse = producto("Mouse", "Accesorios", 35, 60)
        _ = producto("Teclado", "Accesorios", 60, 25)
        _ = producto("Monitor 24\"", "Cómputo", 450, 8)
        _ = producto("Impresora", "Oficina", 380, 4)
        _ = producto("Papel A4 (resma)", "Oficina", 18, 120)

        _ = cliente("Ana Torres", "45871236")                       // Regular
        let frecuente = cliente("Luis Paredes", "40111222")          // Frecuente
        let vip = cliente("Comercial Andina SAC", "20512345678")     // VIP

        // Usuario de ejemplo (supervisor) dueño de las ventas históricas.
        let demo = Usuario(context: ctx)
        demo.nombre = "Supervisor de ejemplo"; demo.usuario = "supervisor"; demo.clave = "123456"
        demo.rol = Rol.supervisor.rawValue

        // Ventas históricas (no modifican el stock inicial de arriba).
        func venta(_ cli: Cliente, _ prod: Producto, _ cantidad: Int64, haceDias: Int) {
            let r = Reglas.calcularVenta(cantidad: Int(cantidad), precio: prod.precio, categoria: .regular)
            let v = Venta(context: ctx)
            v.fecha = Date().sumando(dias: -haceDias)
            v.cantidad = cantidad; v.precioUnitario = prod.precio
            v.descuento = r.descuento; v.igv = r.igv; v.total = r.total
            v.anulada = false
            v.vendedor = demo; v.producto = prod; v.cliente = cli
        }
        venta(vip, laptop, 30, haceDias: 3)        // total 7,080.00 → VIP
        venta(frecuente, mouse, 30, haceDias: 1)   // total 1,239.00 → Frecuente

        try? ctx.save()
    }
}
