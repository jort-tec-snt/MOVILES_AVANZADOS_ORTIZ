//
//  ProductosViewController.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (MVVM · UIKit + Core Data)
//

import UIKit

/// A3 · Productos (vista). Búsqueda, categorías, filtros y borrado los resuelve ProductosViewModel.
final class ProductosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    private let viewModel: ProductosViewModel
    private let tabla = UITableView(frame: .zero, style: .plain)
    private let chipsScroll = UIScrollView()
    private let chipsPila = UIStackView()

    init(viewModel: ProductosViewModel = ProductosViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) no se usa") }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        if viewModel.puedeEditar {                                          // ① botón +
            let mas = UIBarButtonItem(image: UIImage(systemName: "plus"), primaryAction: UIAction { [weak self] _ in
                self?.abrirFormulario(producto: nil)
            })
            mas.accessibilityLabel = "Nuevo producto"
            navigationItem.rightBarButtonItem = mas
        }

        let buscador = UISearchController(searchResultsController: nil)     // ② búsqueda
        buscador.searchResultsUpdater = self
        buscador.obscuresBackgroundDuringPresentation = false
        buscador.searchBar.placeholder = "Buscar producto"
        navigationItem.searchController = buscador
        navigationItem.hidesSearchBarWhenScrolling = false

        chipsScroll.showsHorizontalScrollIndicator = false                  // ③ chips de categoría
        chipsScroll.translatesAutoresizingMaskIntoConstraints = false
        chipsPila.axis = .horizontal; chipsPila.spacing = 8
        chipsPila.translatesAutoresizingMaskIntoConstraints = false
        chipsScroll.addSubview(chipsPila)
        tabla.translatesAutoresizingMaskIntoConstraints = false
        tabla.dataSource = self; tabla.delegate = self
        view.addSubview(chipsScroll); view.addSubview(tabla)
        NSLayoutConstraint.activate([
            chipsScroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chipsScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chipsScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chipsScroll.heightAnchor.constraint(equalToConstant: 52),
            chipsPila.topAnchor.constraint(equalTo: chipsScroll.contentLayoutGuide.topAnchor, constant: 8),
            chipsPila.bottomAnchor.constraint(equalTo: chipsScroll.contentLayoutGuide.bottomAnchor, constant: -8),
            chipsPila.leadingAnchor.constraint(equalTo: chipsScroll.contentLayoutGuide.leadingAnchor, constant: 16),
            chipsPila.trailingAnchor.constraint(equalTo: chipsScroll.contentLayoutGuide.trailingAnchor, constant: -16),
            tabla.topAnchor.constraint(equalTo: chipsScroll.bottomAnchor),
            tabla.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabla.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabla.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        // Enlace con el ViewModel: cuando cambian los datos, la vista se redibuja.
        viewModel.onChange = { [weak self] in self?.redibujar() }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.recargar()
    }

    func updateSearchResults(for searchController: UISearchController) {
        viewModel.busqueda = searchController.searchBar.text ?? ""
    }

    private func redibujar() {
        tabla.backgroundView = viewModel.filas.isEmpty ? fondoVacio("No hay productos") : nil
        tabla.reloadData()
        chipsPila.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for cat in [nil] + viewModel.categorias.map({ Optional($0) }) {
            var c: UIButton.Configuration = (cat == viewModel.categoriaSeleccionada) ? .filled() : .tinted()
            c.title = cat ?? "Todas"
            c.cornerStyle = .capsule
            chipsPila.addArrangedSubview(UIButton(configuration: c, primaryAction: UIAction { [weak self] _ in
                self?.viewModel.categoriaSeleccionada = cat
            }))
        }
    }

    private func abrirFormulario(producto: Producto?) {
        let vc = ProductoFormViewController(viewModel: ProductoFormViewModel(producto: producto))
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: Tabla

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { viewModel.filas.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "p") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "p")
        let fila = viewModel.filas[indexPath.row]
        var cfg = celda.defaultContentConfiguration()
        cfg.text = fila.nombre
        cfg.secondaryText = fila.detalle
        celda.contentConfiguration = cfg
        let stock = UILabel()                                              // ④ stock en color
        stock.font = .preferredFont(forTextStyle: .headline)
        stock.adjustsFontForContentSizeCategory = true
        stock.text = fila.stockTexto
        stock.textColor = Estilo.color(fila.nivel)
        stock.sizeToFit()
        celda.accessoryView = stock
        celda.selectionStyle = viewModel.puedeEditar ? .default : .none
        return celda
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard viewModel.puedeEditar else { return }
        abrirFormulario(producto: viewModel.producto(en: indexPath.row))
    }

    // ⑤ Deslizar para borrar (solo supervisor; bloqueado si tiene ventas)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard viewModel.puedeEditar else { return nil }
        let borrar = UIContextualAction(style: .destructive, title: "Borrar") { [weak self] _, _, hecho in
            guard let self = self else { return hecho(false) }
            if let motivo = self.viewModel.borrar(en: indexPath.row) {
                self.mostrarAlerta("No se puede borrar", motivo)
                return hecho(false)
            }
            self.tabla.deleteRows(at: [indexPath], with: .automatic)
            hecho(true)
        }
        return UISwipeActionsConfiguration(actions: [borrar])
    }
}
