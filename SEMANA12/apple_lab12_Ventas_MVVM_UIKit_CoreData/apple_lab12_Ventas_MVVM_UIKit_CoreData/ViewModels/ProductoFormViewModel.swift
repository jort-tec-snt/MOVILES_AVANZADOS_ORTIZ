//
//  ProductoFormViewModel.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (MVVM · UIKit + Core Data)
//

import Foundation
import CoreData

/// ViewModel del formulario de producto (alta y edición).
final class ProductoFormViewModel {
    private let producto: Producto?

    init(producto: Producto?) { self.producto = producto }

    var titulo: String { producto == nil ? "Nuevo producto" : "Editar producto" }
    var nombre: String? { producto?.nombre }
    var categoria: String? { producto?.categoria }
    var precio: String? { producto.map { String($0.precio) } }
    var stock: String? { producto.map { String($0.stock) } }

    /// Devuelve nil si se guardó; si no, el mensaje de error.
    func guardar(nombre: String, categoria: String, precio: String, stock: String) -> String? {
        let nombre = nombre.trimmingCharacters(in: .whitespaces)
        let categoria = categoria.trimmingCharacters(in: .whitespaces)
        guard !nombre.isEmpty, !categoria.isEmpty else { return "Completa nombre y categoría" }
        guard let precio = Double(precio.replacingOccurrences(of: ",", with: ".")), precio > 0 else { return "El precio debe ser mayor a 0" }
        guard let stock = Int64(stock), stock >= 0 else { return "El stock debe ser un número entero" }

        let p = producto ?? Producto(context: Datos.contexto)
        p.nombre = nombre; p.categoria = categoria; p.precio = precio; p.stock = stock
        do {
            try Datos.guardar()
            return nil
        } catch {
            Datos.contexto.rollback()
            return "No se pudo guardar el producto"
        }
    }
}
