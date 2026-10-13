import UIKit

class CulturasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    let culturas = Cultura.todas

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Culturas del Perú"
        view.backgroundColor = .systemBackground

        tableView.translatesAutoresizingMaskIntoConstraints = false
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda")
            ?? UITableViewCell(style: .default, reuseIdentifier: "celda")
        let cultura = culturas[indexPath.row]
        cell.textLabel?.text = cultura.nombre
        cell.imageView?.image = UIImage(named: cultura.imagen)
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    // Se instancia el detalle, se le pasa la cultura por una propiedad y se hace push en el UINavigationController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detalle = DetalleCulturaViewController()
        detalle.cultura = culturas[indexPath.row]
        navigationController?.pushViewController(detalle, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
