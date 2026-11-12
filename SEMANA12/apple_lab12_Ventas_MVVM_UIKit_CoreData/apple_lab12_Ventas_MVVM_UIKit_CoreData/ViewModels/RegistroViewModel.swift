//
//  RegistroViewModel.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (MVVM · UIKit + Core Data)
//

import Foundation
import CoreData

/// ViewModel del registro: usuario único, clave mínima y confirmación.
final class RegistroViewModel {
    let roles = Rol.allCases.map { $0.rawValue }
    let placeholderClave = "Clave (mínimo \(Reglas.claveMinima) caracteres)"

    /// Aviso en vivo si el usuario ya existe (sin distinguir mayúsculas).
    func avisoUsuario(_ texto: String) -> String? {
        let nombre = texto.trimmingCharacters(in: .whitespaces)
        return (!nombre.isEmpty && Datos.buscarUsuario(nombre) != nil) ? "Ese usuario ya existe" : nil
    }

    /// Devuelve nil si se registró y entró; si no, el mensaje de error.
    func registrar(nombre: String, usuario: String, clave: String, confirmar: String, rolIndice: Int) -> String? {
        let nombre = nombre.trimmingCharacters(in: .whitespaces)
        let usuario = usuario.trimmingCharacters(in: .whitespaces)
        if nombre.isEmpty || usuario.isEmpty { return "Completa tu nombre y un usuario" }
        if Datos.buscarUsuario(usuario) != nil { return "Ese usuario ya existe" }
        if clave.count < Reglas.claveMinima { return "La clave debe tener al menos \(Reglas.claveMinima) caracteres" }
        if clave != confirmar { return "Las claves no coinciden" }

        let u = Usuario(context: Datos.contexto)
        u.nombre = nombre
        u.usuario = usuario
        u.clave = clave
        u.rol = Rol.allCases[rolIndice].rawValue
        do {
            try Datos.guardar()
        } catch {
            Datos.contexto.rollback()
            return "No se pudo crear la cuenta"
        }
        Sesion.shared.usuario = u
        return nil
    }
}
