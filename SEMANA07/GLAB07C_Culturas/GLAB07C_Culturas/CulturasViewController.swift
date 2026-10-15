import UIKit

// Lista de culturas: el diseño (celda prototipo y segue) está en Main.storyboard;
// aquí se guarda la información de cada fila y se entrega la cultura elegida al detalle.
class CulturasViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    let culturas = [
        (nombre: "Caral", region: "Valle de Supe, Lima", imagen: "caral"),
        (nombre: "Chavín", region: "Áncash", imagen: "chavin"),
        (nombre: "Paracas", region: "Ica", imagen: "paracas"),
        (nombre: "Nazca", region: "Ica", imagen: "nazca"),
        (nombre: "Moche", region: "La Libertad y Lambayeque", imagen: "moche"),
        (nombre: "Inca", region: "Cusco", imagen: "inca")
    ]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let seleccion = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: seleccion, animated: animated)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return culturas.count
    }

    // Los elementos de la celda prototipo se identifican por su tag: 1 imagen, 2 nombre, 3 región
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "culturaCell", for: indexPath)
        let cultura = culturas[indexPath.row]
        (cell.viewWithTag(1) as? UIImageView)?.image = UIImage(named: cultura.imagen)
        (cell.viewWithTag(2) as? UILabel)?.text = cultura.nombre
        (cell.viewWithTag(3) as? UILabel)?.text = cultura.region
        return cell
    }

    // Segue "verDetalle": pasa la cultura de la fila elegida a la pantalla de detalle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "verDetalle",
              let celda = sender as? UITableViewCell,
              let fila = tableView.indexPath(for: celda),
              let detalle = segue.destination as? DetalleCulturaViewController else { return }
        let cultura = culturas[fila.row]
        detalle.nombre = cultura.nombre
        detalle.region = cultura.region
        detalle.imagen = cultura.imagen
    }
}
