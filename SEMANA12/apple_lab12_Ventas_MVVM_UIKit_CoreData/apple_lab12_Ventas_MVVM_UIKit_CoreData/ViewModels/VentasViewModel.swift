//
//  VentasViewModel.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (MVVM · UIKit + Core Data)
//

import Foundation
import CoreData

enum PeriodoVentas: Int, CaseIterable {
    case todas, hoy, mes
    var titulo: String { ["Todas", "Hoy", "Mes"][rawValue] }
}

struct VentaFila {
    let cliente: String
    let detalle: String
    let extra: String?
    let total: String
    let anulada: Bool
}

/// ViewModel de "Mis ventas" (vendedor) y "Ventas del equipo" (supervisor).
final class VentasViewModel {
    enum Modo { case vendedor, supervisor }

    let modo: Modo
    var onChange: (() -> Void)?

    private(set) var filas: [VentaFila] = []
    private(set) var indicadores: String?
    private(set) var nombresVendedores: [String] = []
    private var ventas: [Venta] = []
    private var vendedores: [Usuario] = []

    var periodo: PeriodoVentas = .todas { didSet { recargar() } }
    var busqueda = "" { didSet { recargar() } }
    private(set) var vendedorSeleccionado: Int?     // índice en nombresVendedores; nil = todos

    init(modo: Modo) { self.modo = modo }

    func seleccionarVendedor(_ indice: Int?) {
        vendedorSeleccionado = indice
        recargar()
    }

    /// Consulta con NSPredicate sobre fechas y relaciones.
    func recargar() {
        var p: [NSPredicate] = []
        if modo == .vendedor, let u = Sesion.shared.usuario {
            p.append(NSPredicate(format: "vendedor == %@", u))        // el vendedor solo ve lo suyo
        } else if let i = vendedorSeleccionado, i < vendedores.count {
            p.append(NSPredicate(format: "vendedor == %@", vendedores[i]))
        }
        switch periodo {
        case .hoy: p.append(NSPredicate(format: "fecha >= %@", Date().inicioDelDia as NSDate))
        case .mes: p.append(NSPredicate(format: "fecha >= %@", Date().inicioDelMes as NSDate))
        case .todas: break
        }
        if !busqueda.isEmpty { p.append(NSPredicate(format: "cliente.nombre CONTAINS[cd] %@", busqueda)) }
        ventas = Datos.ventas(p)
        filas = ventas.map { v in
            var lineas: [String] = []
            if modo == .supervisor { lineas.append("Vendedor: \(v.vendedor?.nombre ?? "-")") }
            if v.anulada { lineas.append("Motivo: \(v.motivoAnulacion ?? "-")") }
            return VentaFila(cliente: v.cliente?.nombre ?? "(cliente eliminado)",
                             detalle: "\(v.cantidad) × \(v.producto?.nombre ?? "-") · \(v.fecha?.texto ?? "")",
                             extra: lineas.isEmpty ? nil : lineas.joined(separator: " · "),
                             total: v.total.moneda, anulada: v.anulada)
        }
        if modo == .vendedor { calcularIndicadores() } else { cargarVendedores() }
        onChange?()
    }

    private func calcularIndicadores() {
        guard let u = Sesion.shared.usuario else { return }
        let hoy = Datos.total(Datos.ventasValidas(desde: Date().inicioDelDia, hasta: Date().sumando(dias: 1).inicioDelDia, vendedor: u))
        let mes = Datos.total(Datos.ventasValidas(desde: Date().inicioDelMes, hasta: Date().sumando(dias: 1).inicioDelDia, vendedor: u))
        indicadores = "Hoy: \(hoy.moneda)   ·   Mes: \(mes.moneda)"
    }

    private func cargarVendedores() {
        let request: NSFetchRequest<Usuario> = Usuario.fetchRequest()
        request.predicate = NSPredicate(format: "ventas.@count > 0")
        request.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending: true)]
        vendedores = (try? Datos.contexto.fetch(request)) ?? []
        nombresVendedores = vendedores.map { $0.nombre ?? "" }
    }

    // MARK: Anulación (solo supervisor)

    func puedeAnular(en indice: Int) -> Bool {
        modo == .supervisor && Sesion.shared.esSupervisor && !ventas[indice].anulada
    }

    func resumenAnulacion(en indice: Int) -> String {
        let v = ventas[indice]
        let resumen = "\(v.cliente?.nombre ?? "") · \(v.cantidad) × \(v.producto?.nombre ?? "") · \(v.total.moneda)"
        return "\(resumen)\n\nEl stock se devolverá: +\(v.cantidad) \(v.producto?.nombre ?? "")."
    }

    /// Devuelve nil si se anuló; si no, el mensaje de error. Exige motivo.
    func anular(en indice: Int, motivo: String) -> String? {
        let motivo = motivo.trimmingCharacters(in: .whitespaces)
        let v = ventas[indice]
        guard !motivo.isEmpty, !v.anulada else { return "Escribe el motivo de la anulación" }
        v.anulada = true
        v.motivoAnulacion = motivo
        if let p = v.producto { p.stock += v.cantidad }    // devuelve el stock
        do {
            try Datos.guardar()
        } catch {
            Datos.contexto.rollback()
            return "No se pudo anular"
        }
        recargar()
        return nil
    }
}
