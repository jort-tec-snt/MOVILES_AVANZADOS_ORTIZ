//
//  LoginViewModel.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (MVVM · UIKit + Core Data)
//

import Foundation

/// ViewModel del login: valida las credenciales y abre la sesión. No conoce UIKit.
final class LoginViewModel {

    /// Devuelve nil si entró; si no, el mensaje genérico (no dice qué falló).
    func ingresar(usuario: String, clave: String) -> String? {
        let nombre = usuario.trimmingCharacters(in: .whitespaces)
        guard !nombre.isEmpty, let u = Datos.buscarUsuario(nombre), u.clave == clave else {
            return "Usuario o clave incorrectos"
        }
        Sesion.shared.usuario = u
        return nil
    }
}
