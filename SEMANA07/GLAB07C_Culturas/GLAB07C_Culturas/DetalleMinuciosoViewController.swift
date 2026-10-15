import UIKit

// Detalle de Nazca e Inca: todo el diseño y el texto están en Main.storyboard.
// Solo entrega la cultura a la pantalla de lugares turísticos.
class DetalleMinuciosoViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "verLugares",
              let lugares = segue.destination as? LugaresViewController else { return }
        lugares.cultura = navigationItem.title ?? ""
    }
}
