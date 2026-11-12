//
//  RegistroViewController.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (UIKit + Core Data)
//

import UIKit

/// A2 · Crear cuenta (vista). La lógica está en RegistroViewModel. Al registrarse, la persona entra directo a la app.
final class RegistroViewController: FormularioBase {
    private let viewModel = RegistroViewModel()
    private var nombreField: UITextField!
    private var usuarioField: UITextField!
    private var avisoUsuario: UILabel!
    private var claveField: UITextField!
    private var confirmarField: UITextField!
    private var rolControl: UISegmentedControl!
    private var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crear cuenta"                                      // ① título y volver al login
        navigationController?.setNavigationBarHidden(false, animated: false)

        nombreField = campo("Nombre completo", mayusculas: .words)  // ②
        usuarioField = campo("Usuario")                             // ③
        avisoUsuario = mensaje()
        usuarioField.addAction(UIAction { [weak self] _ in self?.revisarUsuario() }, for: .editingChanged)
        claveField = campo(viewModel.placeholderClave, seguro: true)  // ④
        confirmarField = campo("Confirmar clave", seguro: true)
        let rolEtiqueta = Estilo.etiqueta(.subheadline, color: .secondaryLabel); rolEtiqueta.text = "Rol"  // ⑤
        pila.addArrangedSubview(rolEtiqueta)
        rolControl = UISegmentedControl(items: viewModel.roles)
        rolControl.selectedSegmentIndex = 0
        pila.addArrangedSubview(rolControl)
        errorLabel = mensaje()
        boton("Registrarme") { [weak self] in self?.registrar() }   // ⑥
    }

    /// Aviso en vivo: lo calcula el ViewModel.
    private func revisarUsuario() {
        mostrar(avisoUsuario, viewModel.avisoUsuario(usuarioField.text ?? ""))
    }

    private func registrar() {
        let error = viewModel.registrar(nombre: nombreField.text ?? "", usuario: usuarioField.text ?? "",
                                        clave: claveField.text ?? "", confirmar: confirmarField.text ?? "",
                                        rolIndice: rolControl.selectedSegmentIndex)
        mostrar(errorLabel, error)
        if error == nil { Navegacion.mostrarApp() }
    }
}
