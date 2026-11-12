//
//  ProductoFormViewController.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (MVVM · UIKit + Core Data)
//

import UIKit

/// Alta y edición de producto (vista). La validación y el guardado están en ProductoFormViewModel.
final class ProductoFormViewController: FormularioBase {
    private let viewModel: ProductoFormViewModel
    private var nombreField: UITextField!
    private var categoriaField: UITextField!
    private var precioField: UITextField!
    private var stockField: UITextField!
    private var errorLabel: UILabel!

    init(viewModel: ProductoFormViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) no se usa") }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.titulo
        nombreField = campo("Nombre", texto: viewModel.nombre, mayusculas: .words)
        categoriaField = campo("Categoría", texto: viewModel.categoria, mayusculas: .words)
        precioField = campo("Precio (S/)", texto: viewModel.precio, teclado: .decimalPad)
        stockField = campo("Stock", texto: viewModel.stock, teclado: .numberPad)
        errorLabel = mensaje()
        boton("Guardar") { [weak self] in self?.guardar() }
    }

    private func guardar() {
        let error = viewModel.guardar(nombre: nombreField.text ?? "", categoria: categoriaField.text ?? "",
                                      precio: precioField.text ?? "", stock: stockField.text ?? "")
        mostrar(errorLabel, error)
        if error == nil { navigationController?.popViewController(animated: true) }
    }
}
