//
//  LoginViewController.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (UIKit + Core Data)
//

import UIKit

/// A1 · Inicio de sesión (vista). La lógica está en LoginViewModel.
final class LoginViewController: FormularioBase {
    private let viewModel = LoginViewModel()
    private var usuarioField: UITextField!
    private var claveField: UITextField!
    private var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

        // ① Logo y nombre
        let logo = UIImageView(image: UIImage(systemName: "cart.fill"))
        logo.tintColor = .white
        logo.contentMode = .center
        logo.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 44, weight: .bold)
        logo.backgroundColor = .systemBlue
        logo.layer.cornerRadius = 28
        logo.clipsToBounds = true
        logo.isAccessibilityElement = false
        logo.widthAnchor.constraint(equalToConstant: 96).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 96).isActive = true
        let logoFila = UIStackView(arrangedSubviews: [logo]); logoFila.alignment = .center; logoFila.axis = .vertical
        pila.addArrangedSubview(logoFila)

        let nombre = Estilo.etiqueta(.largeTitle, negrita: true); nombre.text = "Ventas"; nombre.textAlignment = .center
        let sub = Estilo.etiqueta(.subheadline, color: .secondaryLabel); sub.text = "Inicia sesión para continuar"; sub.textAlignment = .center
        pila.addArrangedSubview(nombre); pila.addArrangedSubview(sub)
        pila.setCustomSpacing(28, after: sub)

        usuarioField = campo("Usuario")                         // ②
        claveField = campo("Clave", seguro: true)               // ③
        errorLabel = mensaje()                                  // ④
        boton("Ingresar") { [weak self] in self?.ingresar() }   // ⑤
        boton("Crear cuenta", relleno: false) { [weak self] in  // ⑥
            self?.navigationController?.pushViewController(RegistroViewController(), animated: true)
        }
        claveField.addAction(UIAction { [weak self] _ in self?.ingresar() }, for: .editingDidEndOnExit)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func ingresar() {
        // La vista solo pasa lo escrito; el ViewModel decide.
        let error = viewModel.ingresar(usuario: usuarioField.text ?? "", clave: claveField.text ?? "")
        mostrar(errorLabel, error)
        if error == nil { Navegacion.mostrarApp() }
    }
}
