//
//  ClientesViewModel.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (MVVM · UIKit + Core Data)
//

import Foundation
import CoreData

struct ClienteFila {
    let iniciales: String
    let nombre: String
    let documento: String
    let totalTexto: String
    let categoria: CategoriaCliente
}

/// ViewModel de la lista de clientes: total comprado y categoría calculados.
final class ClientesViewModel {
    var onChange: (() -> Void)?
    private(set) var filas: [ClienteFila] = []
    private var clientes: [Cliente] = []

    /// Solo el supervisor borra.
    var puedeBorrar: Bool { Sesion.shared.esSupervisor }

    func recargar() {
        let request: NSFetchRequest<Cliente> = Cliente.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending: true)]
        clientes = (try? Datos.contexto.fetch(request)) ?? []
        filas = clientes.map { c in
            let comprado = Datos.totalComprado(c)
            return ClienteFila(
                iniciales: (c.nombre ?? "").split(separator: " ").prefix(2).compactMap { $0.first }.map(String.init).joined().uppercased(),
                nombre: c.nombre ?? "", documento: c.documento ?? "",
                totalTexto: comprado.moneda, categoria: CategoriaCliente.desde(totalComprado: comprado))
        }
        onChange?()
    }

    func cliente(en indice: Int) -> Cliente { clientes[indice] }

    /// Devuelve nil si se borró; si no, el motivo (delete rule Deny).
    func borrar(en indice: Int) -> String? {
        let c = clientes[indice]
        if (c.ventas?.count ?? 0) > 0 { return "\"\(c.nombre ?? "")\" tiene ventas registradas." }
        Datos.contexto.delete(c)
        do {
            try Datos.guardar()
        } catch {
            Datos.contexto.rollback()
            return "El cliente tiene ventas asociadas."
        }
        clientes.remove(at: indice)
        filas.remove(at: indice)
        return nil
    }
}
