//
//  SeleccionViewController.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (UIKit + Core Data)
//

import UIKit

/// Lista simple para elegir un cliente o un producto.
final class SeleccionViewController: UITableViewController {
    private let items: [(titulo: String, detalle: String)]
    private let alElegir: (Int) -> Void

    init(titulo: String, items: [(titulo: String, detalle: String)], alElegir: @escaping (Int) -> Void) {
        self.items = items
        self.alElegir = alElegir
        super.init(style: .plain)
        self.title = titulo
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) no se usa") }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = items.isEmpty ? fondoVacio("No hay elementos para elegir") : nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { items.count }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "s") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "s")
        var cfg = celda.defaultContentConfiguration()
        cfg.text = items[indexPath.row].titulo
        cfg.secondaryText = items[indexPath.row].detalle
        celda.contentConfiguration = cfg
        return celda
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alElegir(indexPath.row)
        navigationController?.popViewController(animated: true)
    }
}
