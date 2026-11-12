//
//  ResumenViewModel.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (MVVM · UIKit + Core Data)
//

import Foundation
import CoreData

enum Tendencia { case sube, baja, neutra }

/// ViewModel del panel del supervisor: indicadores, 7 días, ranking y stock bajo.
final class ResumenViewModel {
    let saludo: String
    let rol: String

    private(set) var hoyTexto = ""
    private(set) var ayerTexto = ""
    private(set) var variacionTexto = ""
    private(set) var tendencia: Tendencia = .neutra
    private(set) var operacionesTexto = ""
    private(set) var serie: [(etiqueta: String, valor: Double)] = []
    private(set) var ranking: [(nombre: String, monto: String)] = []
    private(set) var stockBajo: [(nombre: String, texto: String, nivel: NivelStock)] = []

    init() {
        let u = Sesion.shared.usuario
        saludo = "Hola, \(u?.nombre ?? "")"
        rol = u?.rol ?? ""
    }

    func cargar() {
        let hoyInicio = Date().inicioDelDia
        let manana = hoyInicio.sumando(dias: 1)
        let ventasHoy = Datos.ventasValidas(desde: hoyInicio, hasta: manana)
        let totalHoy = Datos.total(ventasHoy)
        let totalAyer = Datos.total(Datos.ventasValidas(desde: hoyInicio.sumando(dias: -1), hasta: hoyInicio))

        hoyTexto = totalHoy.moneda
        ayerTexto = "Ayer: \(totalAyer.moneda)"
        operacionesTexto = "\(ventasHoy.count) venta(s) hoy"
        if totalAyer > 0 {
            let porcentaje = (totalHoy - totalAyer) / totalAyer * 100
            variacionTexto = String(format: "%@ %.0f %% vs. ayer", porcentaje >= 0 ? "▲" : "▼", abs(porcentaje))
            tendencia = porcentaje >= 0 ? .sube : .baja
        } else {
            variacionTexto = totalHoy > 0 ? "▲ Sin ventas ayer" : "Sin movimiento"
            tendencia = totalHoy > 0 ? .sube : .neutra
        }

        serie = (0..<7).map { i in
            let dia = hoyInicio.sumando(dias: i - 6)
            return (dia.diaCorto, Datos.total(Datos.ventasValidas(desde: dia, hasta: dia.sumando(dias: 1))))
        }

        var porVendedor: [String: Double] = [:]
        for v in Datos.ventasValidas(desde: Date().inicioDelMes, hasta: manana) {
            porVendedor[v.vendedor?.nombre ?? "(sin vendedor)", default: 0] += v.total
        }
        ranking = porVendedor.sorted { $0.value > $1.value }.map { ($0.key, $0.value.moneda) }

        let request: NSFetchRequest<Producto> = Producto.fetchRequest()
        request.predicate = NSPredicate(format: "stock <= %d", Reglas.stockBajo)
        request.sortDescriptors = [NSSortDescriptor(key: "stock", ascending: true)]
        stockBajo = ((try? Datos.contexto.fetch(request)) ?? []).map {
            ($0.nombre ?? "", "Stock \($0.stock)", NivelStock(stock: $0.stock))
        }
    }
}
