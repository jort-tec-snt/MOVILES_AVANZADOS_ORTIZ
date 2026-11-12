//
//  CuentaViewController.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (MVVM · UIKit + Core Data)
//

import UIKit

/// Pestaña Cuenta (vista): nombre, usuario, rol y Cerrar sesión. Los datos vienen de CuentaViewModel.
final class CuentaViewController: FormularioBase {
    private let viewModel = CuentaViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cuenta"

        let avatar = UILabel()
        avatar.text = viewModel.iniciales
        avatar.font = .preferredFont(forTextStyle: .title1)
        avatar.textColor = .white; avatar.textAlignment = .center
        avatar.backgroundColor = .systemBlue
        avatar.layer.cornerRadius = 40; avatar.clipsToBounds = true
        avatar.widthAnchor.constraint(equalToConstant: 80).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 80).isActive = true
        avatar.isAccessibilityElement = false
        let fila = UIStackView(arrangedSubviews: [avatar]); fila.axis = .vertical; fila.alignment = .center
        pila.addArrangedSubview(fila)

        func dato(_ titulo: String, _ valor: String) {
            let t = Estilo.etiqueta(.footnote, color: .secondaryLabel); t.text = titulo
            let v = Estilo.etiqueta(.body); v.text = valor
            let s = UIStackView(arrangedSubviews: [t, v]); s.axis = .vertical; s.spacing = 2
            pila.addArrangedSubview(Estilo.tarjeta(s))
        }
        dato("Nombre", viewModel.nombre)
        dato("Usuario", viewModel.usuario)
        dato("Rol", viewModel.rol)

        let b = boton("Cerrar sesión") { [weak self] in
            self?.viewModel.cerrarSesion()     // usuario = nil y de vuelta al login
            Navegacion.mostrarLogin()
        }
        b.configuration?.baseBackgroundColor = .systemRed
    }
}
