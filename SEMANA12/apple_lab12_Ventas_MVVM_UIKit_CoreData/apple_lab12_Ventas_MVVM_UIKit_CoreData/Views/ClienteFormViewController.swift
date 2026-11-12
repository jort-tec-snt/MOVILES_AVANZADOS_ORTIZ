//
//  ClienteFormViewController.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (MVVM · UIKit + Core Data)
//

import UIKit

/// Alta y edición de cliente (vista). La validación y el guardado están en ClienteFormViewModel.
final class ClienteFormViewController: FormularioBase {
    private let viewModel: ClienteFormViewModel
    private var nombreField: UITextField!
    private var documentoField: UITextField!
    private var errorLabel: UILabel!

    init(viewModel: ClienteFormViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) no se usa") }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.titulo
        nombreField = campo("Nombre", texto: viewModel.nombre, mayusculas: .words)
        documentoField = campo("Documento (DNI o RUC)", texto: viewModel.documento, teclado: .numberPad)
        errorLabel = mensaje()
        boton("Guardar") { [weak self] in self?.guardar() }
    }

    private func guardar() {
        let error = viewModel.guardar(nombre: nombreField.text ?? "", documento: documentoField.text ?? "")
        mostrar(errorLabel, error)
        if error == nil { navigationController?.popViewController(animated: true) }
    }
}
