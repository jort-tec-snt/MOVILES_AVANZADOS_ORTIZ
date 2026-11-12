//
//  VentasViewController.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (MVVM · UIKit + Core Data)
//

import UIKit

/// A6 · Mis ventas (vendedor) y A7 · Ventas del equipo (supervisor), con anulación (A8).
/// Vista: la consulta, los filtros y la anulación están en VentasViewModel.
final class VentasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    private let viewModel: VentasViewModel
    private let tabla = UITableView(frame: .zero, style: .plain)
    private let cabecera = UIStackView()
    private let indicadores = Estilo.etiqueta(.subheadline, negrita: true)
    private let periodo = UISegmentedControl(items: PeriodoVentas.allCases.map { $0.titulo })
    private let chipsScroll = UIScrollView()
    private let chipsPila = UIStackView()

    init(modo: VentasViewModel.Modo) {
        self.viewModel = VentasViewModel(modo: modo)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) no se usa") }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let buscador = UISearchController(searchResultsController: nil)     // búsqueda por cliente
        buscador.searchResultsUpdater = self
        buscador.obscuresBackgroundDuringPresentation = false
        buscador.searchBar.placeholder = "Buscar por cliente"
        navigationItem.searchController = buscador
        navigationItem.hidesSearchBarWhenScrolling = false

        cabecera.axis = .vertical; cabecera.spacing = 8
        cabecera.translatesAutoresizingMaskIntoConstraints = false
        cabecera.isLayoutMarginsRelativeArrangement = true
        cabecera.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)

        if viewModel.modo == .vendedor {                                    // ① indicadores propios
            indicadores.numberOfLines = 0
            cabecera.addArrangedSubview(Estilo.tarjeta(indicadores))
        }
        periodo.selectedSegmentIndex = 0                                    // ② Todas / Hoy / Mes
        periodo.addAction(UIAction { [weak self] _ in
            guard let self = self, let p = PeriodoVentas(rawValue: self.periodo.selectedSegmentIndex) else { return }
            self.viewModel.periodo = p
        }, for: .valueChanged)
        cabecera.addArrangedSubview(periodo)

        if viewModel.modo == .supervisor {                                  // ① chips por vendedor
            chipsScroll.showsHorizontalScrollIndicator = false
            chipsPila.axis = .horizontal; chipsPila.spacing = 8
            chipsPila.translatesAutoresizingMaskIntoConstraints = false
            chipsScroll.addSubview(chipsPila)
            chipsScroll.heightAnchor.constraint(equalToConstant: 40).isActive = true
            NSLayoutConstraint.activate([
                chipsPila.topAnchor.constraint(equalTo: chipsScroll.contentLayoutGuide.topAnchor),
                chipsPila.bottomAnchor.constraint(equalTo: chipsScroll.contentLayoutGuide.bottomAnchor),
                chipsPila.leadingAnchor.constraint(equalTo: chipsScroll.contentLayoutGuide.leadingAnchor),
                chipsPila.trailingAnchor.constraint(equalTo: chipsScroll.contentLayoutGuide.trailingAnchor),
                chipsPila.heightAnchor.constraint(equalTo: chipsScroll.frameLayoutGuide.heightAnchor),
            ])
            cabecera.addArrangedSubview(chipsScroll)
        }

        tabla.translatesAutoresizingMaskIntoConstraints = false
        tabla.dataSource = self; tabla.delegate = self
        tabla.rowHeight = UITableView.automaticDimension
        tabla.estimatedRowHeight = 76
        tabla.register(VentaCell.self, forCellReuseIdentifier: "v")
        view.addSubview(cabecera); view.addSubview(tabla)
        NSLayoutConstraint.activate([
            cabecera.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cabecera.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cabecera.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabla.topAnchor.constraint(equalTo: cabecera.bottomAnchor),
            tabla.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabla.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabla.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        if viewModel.modo == .supervisor {                                  // ④ nota de la relación
            let nota = Estilo.etiqueta(.footnote, color: .secondaryLabel)
            nota.text = "Cada venta guarda quién la registró (relación venta ▸ vendedor)."
            nota.textAlignment = .center
            nota.numberOfLines = 0
            nota.translatesAutoresizingMaskIntoConstraints = false
            let pie = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 56))
            pie.addSubview(nota)
            NSLayoutConstraint.activate([
                nota.leadingAnchor.constraint(equalTo: pie.leadingAnchor, constant: 16),
                nota.trailingAnchor.constraint(equalTo: pie.trailingAnchor, constant: -16),
                nota.centerYAnchor.constraint(equalTo: pie.centerYAnchor),
            ])
            tabla.tableFooterView = pie
        }

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
        tabla.backgroundView = viewModel.filas.isEmpty ? fondoVacio("No hay ventas para mostrar") : nil
        tabla.reloadData()
        indicadores.text = viewModel.indicadores
        guard viewModel.modo == .supervisor else { return }
        chipsPila.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let opciones: [Int?] = [nil] + viewModel.nombresVendedores.indices.map { Optional($0) }
        for i in opciones {
            var c: UIButton.Configuration = (i == viewModel.vendedorSeleccionado) ? .filled() : .tinted()
            c.title = i.map { viewModel.nombresVendedores[$0] } ?? "Todos"
            c.cornerStyle = .capsule
            chipsPila.addArrangedSubview(UIButton(configuration: c, primaryAction: UIAction { [weak self] _ in
                self?.viewModel.seleccionarVendedor(i)
            }))
        }
    }

    // MARK: Tabla

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { viewModel.filas.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "v", for: indexPath) as! VentaCell
        celda.configurar(viewModel.filas[indexPath.row])
        return celda
    }

    // ③ Deslizar para Anular (solo supervisor; una venta anulada no tiene botón)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard viewModel.puedeAnular(en: indexPath.row) else { return nil }
        let anular = UIContextualAction(style: .destructive, title: "Anular") { [weak self] _, _, hecho in
            self?.pedirMotivo(en: indexPath.row)
            hecho(true)
        }
        return UISwipeActionsConfiguration(actions: [anular])
    }

    // MARK: A8 · Anular con motivo obligatorio

    private func pedirMotivo(en indice: Int) {
        let alert = UIAlertController(title: "Anular venta", message: viewModel.resumenAnulacion(en: indice), preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Motivo (obligatorio)" }
        let anular = UIAlertAction(title: "Anular", style: .destructive) { [weak self, weak alert] _ in
            let motivo = alert?.textFields?.first?.text ?? ""
            if let error = self?.viewModel.anular(en: indice, motivo: motivo) {
                self?.mostrarAlerta("No se pudo anular", error)
            }
        }
        anular.isEnabled = false      // deshabilitado mientras el motivo esté vacío
        alert.textFields?.first?.addAction(UIAction { [weak alert] _ in
            let texto = (alert?.textFields?.first?.text ?? "").trimmingCharacters(in: .whitespaces)
            anular.isEnabled = !texto.isEmpty
        }, for: .editingChanged)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel) { [weak self] _ in self?.tabla.reloadData() })
        alert.addAction(anular)
        present(alert, animated: true)
    }
}

/// Fila de venta: anulada se muestra tachada y con etiqueta, sin botón.
final class VentaCell: UITableViewCell {
    private let cliente = Estilo.etiqueta(.headline)
    private let detalle = Estilo.etiqueta(.subheadline, color: .secondaryLabel)
    private let extra = Estilo.etiqueta(.caption1, color: .secondaryLabel)
    private let total = Estilo.etiqueta(.headline)
    private let etiqueta = Estilo.etiqueta(.caption1, color: .systemRed, negrita: true)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        let izquierda = UIStackView(arrangedSubviews: [cliente, detalle, extra]); izquierda.axis = .vertical; izquierda.spacing = 2
        let derecha = UIStackView(arrangedSubviews: [total, etiqueta]); derecha.axis = .vertical; derecha.alignment = .trailing; derecha.spacing = 2
        izquierda.translatesAutoresizingMaskIntoConstraints = false
        derecha.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(izquierda); contentView.addSubview(derecha)
        derecha.setContentHuggingPriority(.required, for: .horizontal)
        derecha.setContentCompressionResistancePriority(.required, for: .horizontal)
        NSLayoutConstraint.activate([
            izquierda.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            izquierda.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            izquierda.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            izquierda.trailingAnchor.constraint(equalTo: derecha.leadingAnchor, constant: -12),
            derecha.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            derecha.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) no se usa") }

    func configurar(_ fila: VentaFila) {
        detalle.text = fila.detalle
        extra.text = fila.extra
        extra.isHidden = (fila.extra == nil)
        let tachado: [NSAttributedString.Key: Any] = fila.anulada
            ? [.strikethroughStyle: NSUnderlineStyle.single.rawValue, .foregroundColor: UIColor.secondaryLabel] : [:]
        cliente.attributedText = NSAttributedString(string: fila.cliente, attributes: tachado)
        total.attributedText = NSAttributedString(string: fila.total, attributes: tachado)
        etiqueta.text = fila.anulada ? "ANULADA" : nil
        etiqueta.isHidden = !fila.anulada
    }
}
