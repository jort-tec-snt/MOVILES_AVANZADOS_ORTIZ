//
//  ClienteFormViewModel.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (MVVM · UIKit + Core Data)
//

import Foundation
import CoreData

/// ViewModel del formulario de cliente (alta y edición).
final class ClienteFormViewModel {
    private let cliente: Cliente?

    init(cliente: Cliente?) { self.cliente = cliente }

    var titulo: String { cliente == nil ? "Nuevo cliente" : "Editar cliente" }
    var nombre: String? { cliente?.nombre }
    var documento: String? { cliente?.documento }

    /// Devuelve nil si se guardó; si no, el mensaje de error.
    func guardar(nombre: String, documento: String) -> String? {
        let nombre = nombre.trimmingCharacters(in: .whitespaces)
        let documento = documento.trimmingCharacters(in: .whitespaces)
        guard !nombre.isEmpty, !documento.isEmpty else { return "Completa nombre y documento" }
        let c = cliente ?? Cliente(context: Datos.contexto)
        c.nombre = nombre; c.documento = documento
        do {
            try Datos.guardar()
            return nil
        } catch {
            Datos.contexto.rollback()
            return "No se pudo guardar el cliente"
        }
    }
}
