//
//  ProductosViewModel.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (MVVM · UIKit + Core Data)
//

import Foundation
import CoreData

/// Nivel de stock: el ViewModel decide el nivel, la vista decide el color.
enum NivelStock {
    case bajo, medio, alto
    init(stock: Int64) {
        if stock <= Int64(Reglas.stockBajo) { self = .bajo }
        else if stock <= Int64(Reglas.stockAmbarMax) { self = .medio }
        else { self = .alto }
    }
}

struct ProductoFila {
    let nombre: String
    let detalle: String
    let stockTexto: String
    let nivel: NivelStock
}

/// ViewModel de la lista de productos: búsqueda, categorías y borrado.
final class ProductosViewModel {
    /// La vista se suscribe para redibujarse cuando cambian los datos.
    var onChange: (() -> Void)?

    private(set) var filas: [ProductoFila] = []
    private(set) var categorias: [String] = []
    private var productos: [Producto] = []

    var categoriaSeleccionada: String? { didSet { recargar() } }
    var busqueda = "" { didSet { recargar() } }
    var puedeEditar: Bool { Sesion.shared.esSupervisor }

    func recargar() {
        var predicados: [NSPredicate] = []
        if let c = categoriaSeleccionada { predicados.append(NSPredicate(format: "categoria == %@", c)) }
        if !busqueda.isEmpty { predicados.append(NSPredicate(format: "nombre CONTAINS[cd] %@", busqueda)) }
        let request: NSFetchRequest<Producto> = Producto.fetchRequest()
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicados)
        request.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending: true)]
        productos = (try? Datos.contexto.fetch(request)) ?? []
        filas = productos.map {
            ProductoFila(nombre: $0.nombre ?? "", detalle: "\($0.categoria ?? "") · \($0.precio.moneda)",
                         stockTexto: "Stock \($0.stock)", nivel: NivelStock(stock: $0.stock))
        }
        let todos: NSFetchRequest<Producto> = Producto.fetchRequest()
        categorias = Set(((try? Datos.contexto.fetch(todos)) ?? []).compactMap { $0.categoria }).sorted()
        onChange?()
    }

    func producto(en indice: Int) -> Producto { productos[indice] }

    /// Devuelve nil si se borró; si no, el motivo (el producto tiene ventas).
    func borrar(en indice: Int) -> String? {
        let p = productos[indice]
        if (p.ventas?.count ?? 0) > 0 { return "\"\(p.nombre ?? "")\" tiene ventas registradas." }
        Datos.contexto.delete(p)
        do {
            try Datos.guardar()
        } catch {
            Datos.contexto.rollback()
            return "El producto tiene ventas asociadas."
        }
        productos.remove(at: indice)
        filas.remove(at: indice)
        return nil
    }
}
