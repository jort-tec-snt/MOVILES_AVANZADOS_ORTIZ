import UIKit

class CulturasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    let culturas = Cultura.todas

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Culturas del Perú"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CulturaTableViewCell.self, forCellReuseIdentifier: CulturaTableViewCell.identificador)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return culturas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CulturaTableViewCell.identificador, for: indexPath) as! CulturaTableViewCell
        cell.configurar(con: culturas[indexPath.row])
        return cell
    }

    // Se instancia el detalle, se le pasa la cultura por una propiedad y se hace push en el UINavigationController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detalle = DetalleCulturaViewController()
        detalle.cultura = culturas[indexPath.row]
        navigationController?.pushViewController(detalle, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
