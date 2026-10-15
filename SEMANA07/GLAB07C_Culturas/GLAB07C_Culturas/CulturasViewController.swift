import UIKit

class CulturasViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let culturas = Cultura.todas

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let seleccion = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: seleccion, animated: animated)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return culturas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "culturaCell", for: indexPath) as! CulturaTableViewCell
        cell.configurar(con: culturas[indexPath.row])
        return cell
    }

    // Segue "verDetalle" (celda → detalle): aquí se entrega la cultura elegida a la pantalla destino
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "verDetalle",
              let celda = sender as? UITableViewCell,
              let indice = tableView.indexPath(for: celda),
              let detalle = segue.destination as? DetalleCulturaViewController else { return }
        detalle.cultura = culturas[indice.row]
    }
}
