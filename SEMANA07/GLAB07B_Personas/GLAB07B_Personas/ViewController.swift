import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()

    var personasArreglo = ["Jaime Gomez", "Juan León", "Silvia Montoya", "Theobaldo Diaz", "Elliot Garamendi"]
    var personasImagenarreglo = ["persona1", "persona2", "persona3", "persona4", "persona5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Personas"
        view.backgroundColor = .systemBackground

        tableView.translatesAutoresizingMaskIntoConstraints = false
        // la celda personalizada se registra con el identificador "miCell"
        tableView.register(PersonasTableViewCell.self, forCellReuseIdentifier: "miCell")
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
        return personasArreglo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "miCell") as? PersonasTableViewCell
        cell?.personaNombre.text = "\(personasArreglo[indexPath.row])"
        cell?.PersonaImagen.image = UIImage(named: "\(personasImagenarreglo[indexPath.row])")
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alerta = UIAlertController(title: "El Docente que Selecciono es :",
                                       message: personasArreglo[indexPath.row],
                                       preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default))
        present(alerta, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
