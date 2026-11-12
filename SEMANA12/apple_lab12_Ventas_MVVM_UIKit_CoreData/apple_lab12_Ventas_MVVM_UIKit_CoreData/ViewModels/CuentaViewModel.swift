//
//  CuentaViewModel.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (MVVM · UIKit + Core Data)
//

import Foundation

/// ViewModel de la pestaña Cuenta.
final class CuentaViewModel {
    private let u = Sesion.shared.usuario

    var nombre: String { u?.nombre ?? "-" }
    var usuario: String { u?.usuario ?? "-" }
    var rol: String { u?.rol ?? "-" }
    var iniciales: String {
        (u?.nombre ?? "").split(separator: " ").prefix(2).compactMap { $0.first }.map(String.init).joined().uppercased()
    }

    func cerrarSesion() {
        Sesion.shared.cerrar()
    }
}
