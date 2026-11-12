//
//  Sesion.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (UIKit + Core Data)
//

import Foundation

enum Rol: String, CaseIterable {
    case vendedor = "Vendedor"
    case supervisor = "Supervisor"
}

/// Sesión: un único objeto compartido con el usuario conectado.
/// Para cerrar sesión se pone `usuario` en nil y se vuelve al login.
final class Sesion {
    static let shared = Sesion()
    private init() {}

    var usuario: Usuario?

    var rol: Rol { Rol(rawValue: usuario?.rol ?? "") ?? .vendedor }
    var esSupervisor: Bool { rol == .supervisor }

    func cerrar() {
        usuario = nil
    }
}
