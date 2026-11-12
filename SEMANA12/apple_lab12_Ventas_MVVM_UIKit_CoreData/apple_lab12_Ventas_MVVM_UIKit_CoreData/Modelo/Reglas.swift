//
//  Reglas.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (UIKit + Core Data)
//

import Foundation

/// Categoría del cliente: se calcula con lo comprado (ventas no anuladas), no se guarda.
enum CategoriaCliente: String {
    case regular = "Regular"
    case frecuente = "Frecuente"
    case vip = "VIP"

    static func desde(totalComprado: Double) -> CategoriaCliente {
        if totalComprado >= 5000 { return .vip }
        if totalComprado >= 1000 { return .frecuente }
        return .regular
    }

    /// VIP 10 % del subtotal; los demás 0 %.
    var porcentajeDescuento: Double { self == .vip ? 0.10 : 0 }
}

struct ResumenVenta {
    let subtotal: Double
    let descuento: Double
    let igv: Double
    let total: Double
}

enum Reglas {
    static let tasaIGV = 0.18
    static let stockBajo = 5          // rojo: 5 o menos
    static let stockAmbarMax = 10     // ámbar: de 6 a 10; verde: más de 10
    static let claveMinima = 6

    static func redondear(_ valor: Double) -> Double {
        (valor * 100).rounded() / 100
    }

    /// Subtotal = cantidad × precio. Descuento = % de la categoría sobre el subtotal.
    /// IGV = 18 % sobre (subtotal − descuento). Total = subtotal − descuento + IGV.
    static func calcularVenta(cantidad: Int, precio: Double, categoria: CategoriaCliente) -> ResumenVenta {
        let subtotal = redondear(Double(cantidad) * precio)
        let descuento = redondear(subtotal * categoria.porcentajeDescuento)
        let igv = redondear((subtotal - descuento) * tasaIGV)
        let total = redondear(subtotal - descuento + igv)
        return ResumenVenta(subtotal: subtotal, descuento: descuento, igv: igv, total: total)
    }
}
