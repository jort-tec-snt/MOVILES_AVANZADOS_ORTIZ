import UIKit

// Lista de culturas: las celdas, imágenes y segues están diseñados en Main.storyboard
class CulturasViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // quita el espacio de cabecera que UIKit agrega a las tablas estáticas
        tableView.sectionHeaderTopPadding = 0
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}
