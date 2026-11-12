//
//  Datos.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (UIKit + Core Data)
//

import UIKit
import CoreData

/// Acceso al contexto de Core Data y consultas comunes.
enum Datos {
    static var contexto: NSManagedObjectContext {
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    static func guardar() throws {
        if contexto.hasChanges { try contexto.save() }
    }

    // MARK: Usuarios

    /// Usuario único sin distinguir mayúsculas: fetch con "usuario ==[c] %@".
    static func buscarUsuario(_ nombreUsuario: String) -> Usuario? {
        let request: NSFetchRequest<Usuario> = Usuario.fetchRequest()
        request.predicate = NSPredicate(format: "usuario ==[c] %@", nombreUsuario)
        request.fetchLimit = 1
        return (try? contexto.fetch(request))?.first
    }

    // MARK: Ventas

    static func ventas(_ predicados: [NSPredicate] = []) -> [Venta] {
        let request: NSFetchRequest<Venta> = Venta.fetchRequest()
        if !predicados.isEmpty {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicados)
        }
        request.sortDescriptors = [NSSortDescriptor(key: "fecha", ascending: false)]
        return (try? contexto.fetch(request)) ?? []
    }

    /// Ventas válidas (no anuladas) entre dos fechas [desde, hasta).
    static func ventasValidas(desde: Date, hasta: Date, vendedor: Usuario? = nil) -> [Venta] {
        var p = [NSPredicate(format: "anulada == NO AND fecha >= %@ AND fecha < %@", desde as NSDate, hasta as NSDate)]
        if let vendedor = vendedor { p.append(NSPredicate(format: "vendedor == %@", vendedor)) }
        return ventas(p)
    }

    static func total(_ ventas: [Venta]) -> Double {
        ventas.reduce(0) { $0 + $1.total }
    }

    // MARK: Clientes

    static func ventasDe(_ cliente: Cliente) -> [Venta] {
        (cliente.ventas as? Set<Venta>).map(Array.init) ?? []
    }

    /// Lo comprado por el cliente: suma de ventas no anuladas.
    static func totalComprado(_ cliente: Cliente) -> Double {
        ventasDe(cliente).filter { !$0.anulada }.reduce(0) { $0 + $1.total }
    }

    static func categoria(de cliente: Cliente) -> CategoriaCliente {
        CategoriaCliente.desde(totalComprado: totalComprado(cliente))
    }
}
