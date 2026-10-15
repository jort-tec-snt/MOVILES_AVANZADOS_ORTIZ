import UIKit

// Lista de culturas: el diseño de las 6 filas y los segues están en Main.storyboard.
// Aquí se guarda la información de cada fila para entregarla al detalle básico.
class CulturasViewController: UITableViewController {

    let culturas = [
        (nombre: "Caral", region: "Valle de Supe, Lima", imagen: "caral"),
        (nombre: "Chavín", region: "Áncash", imagen: "chavin"),
        (nombre: "Paracas", region: "Ica", imagen: "paracas"),
        (nombre: "Nazca", region: "Ica", imagen: "nazca"),
        (nombre: "Moche", region: "La Libertad y Lambayeque", imagen: "moche"),
        (nombre: "Inca", region: "Cusco", imagen: "inca")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // quita el espacio de cabecera que UIKit agrega a las tablas estáticas
        tableView.sectionHeaderTopPadding = 0
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }

    // Segue "verDetalle" (Caral, Chavín, Paracas y Moche): pasa la cultura de la fila elegida.
    // Nazca e Inca tienen su propio detalle diseñado en el Storyboard (segues verNazca y verInca).
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
