//
//  ClientesViewController.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (MVVM · UIKit + Core Data)
//

import UIKit

/// A4 · Clientes (vista). El total comprado, la categoría y el borrado los resuelve ClientesViewModel.
final class ClientesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let viewModel: ClientesViewModel
    private let tabla = UITableView(frame: .zero, style: .plain)

    init(viewModel: ClientesViewModel = ClientesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) no se usa") }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let mas = UIBarButtonItem(image: UIImage(systemName: "plus"), primaryAction: UIAction { [weak self] _ in   // ① botón +
            self?.abrirFormulario(cliente: nil)
        })
        mas.accessibilityLabel = "Nuevo cliente"
        navigationItem.rightBarButtonItem = mas

        tabla.translatesAutoresizingMaskIntoConstraints = false
        tabla.dataSource = self; tabla.delegate = self
        tabla.rowHeight = UITableView.automaticDimension
        tabla.estimatedRowHeight = 76
        tabla.register(ClienteCell.self, forCellReuseIdentifier: "c")
        view.addSubview(tabla)
        NSLayoutConstraint.activate([
            tabla.topAnchor.constraint(equalTo: view.topAnchor), tabla.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabla.leadingAnchor.constraint(equalTo: view.leadingAnchor), tabla.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        viewModel.onChange = { [weak self] in
            guard let self = self else { return }
            self.tabla.backgroundView = self.viewModel.filas.isEmpty ? fondoVacio("No hay clientes") : nil
            self.tabla.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.recargar()
    }

    private func abrirFormulario(cliente: Cliente?) {
        let vc = ClienteFormViewController(viewModel: ClienteFormViewModel(cliente: cliente))
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { viewModel.filas.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "c", for: indexPath) as! ClienteCell
        celda.configurar(viewModel.filas[indexPath.row])
        return celda
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        abrirFormulario(cliente: viewModel.cliente(en: indexPath.row))
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard viewModel.puedeBorrar else { return nil }
        let borrar = UIContextualAction(style: .destructive, title: "Borrar") { [weak self] _, _, hecho in
            guard let self = self else { return hecho(false) }
            if let motivo = self.viewModel.borrar(en: indexPath.row) {      // delete rule Deny: alerta
                self.mostrarAlerta("No se puede borrar", motivo)
                return hecho(false)
            }
            self.tabla.deleteRows(at: [indexPath], with: .automatic)
            hecho(true)
        }
        return UISwipeActionsConfiguration(actions: [borrar])
    }
}

/// ② Fila con iniciales, nombre, documento y total comprado; ③ categoría calculada.
final class ClienteCell: UITableViewCell {
    private let avatar = UILabel()
    private let nombre = Estilo.etiqueta(.headline)
    private let documento = Estilo.etiqueta(.subheadline, color: .secondaryLabel)
    private let total = Estilo.etiqueta(.headline)
    private let categoria = Estilo.etiqueta(.caption1, negrita: true)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        avatar.font = .preferredFont(forTextStyle: .headline)
        avatar.textColor = .white; avatar.textAlignment = .center
        avatar.backgroundColor = .systemIndigo
        avatar.layer.cornerRadius = 22; avatar.clipsToBounds = true
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.isAccessibilityElement = false

        let izquierda = UIStackView(arrangedSubviews: [nombre, documento]); izquierda.axis = .vertical; izquierda.spacing = 2
        let derecha = UIStackView(arrangedSubviews: [total, categoria]); derecha.axis = .vertical; derecha.alignment = .trailing; derecha.spacing = 2
        izquierda.translatesAutoresizingMaskIntoConstraints = false
        derecha.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(avatar); contentView.addSubview(izquierda); contentView.addSubview(derecha)
        derecha.setContentHuggingPriority(.required, for: .horizontal)
        derecha.setContentCompressionResistancePriority(.required, for: .horizontal)
        NSLayoutConstraint.activate([
            avatar.widthAnchor.constraint(equalToConstant: 44), avatar.heightAnchor.constraint(equalToConstant: 44),
            avatar.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            avatar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            izquierda.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            izquierda.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 10),
            izquierda.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            izquierda.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 12),
            izquierda.trailingAnchor.constraint(equalTo: derecha.leadingAnchor, constant: -12),
            derecha.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            derecha.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 64),
        ])
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) no se usa") }

    func configurar(_ fila: ClienteFila) {
        avatar.text = fila.iniciales
        nombre.text = fila.nombre
        documento.text = fila.documento
        total.text = fila.totalTexto
        categoria.text = fila.categoria.rawValue
        categoria.textColor = Estilo.colorCategoria(fila.categoria)
    }
}
