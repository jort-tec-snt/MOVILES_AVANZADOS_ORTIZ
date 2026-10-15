import UIKit

// Detalle de cultura: el diseño está en Main.storyboard (una sola escena);
// aquí se cargan los datos de la cultura recibida y su color desde Assets.
class DetalleCulturaViewController: UIViewController {

    // Datos que llegan desde la lista por el segue
    var nombre = ""
    var region = ""
    var imagen = ""

    @IBOutlet weak var imagenView: UIImageView!
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var chipView: UIView!
    @IBOutlet weak var periodoStack: UIStackView!
    @IBOutlet weak var periodoLabel: UILabel!
    @IBOutlet weak var acercaLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    @IBOutlet weak var aportesStack: UIStackView!
    @IBOutlet weak var aportesTitulo: UILabel!
    @IBOutlet weak var aportesLista: UILabel!
    @IBOutlet weak var sitiosStack: UIStackView!
    @IBOutlet weak var sitiosTitulo: UILabel!
    @IBOutlet weak var sitiosLista: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = nombre
        imagenView.image = UIImage(named: imagen)
        nombreLabel.text = nombre
        regionLabel.text = region

        // color con nombre de Assets: AcentoCaral, AcentoChavin, ...
        let sinTildes = nombre.folding(options: .diacriticInsensitive, locale: nil)
        let acento = UIColor(named: "Acento" + sinTildes) ?? .tintColor
        chipView.backgroundColor = acento
        [acercaLabel, aportesTitulo, sitiosTitulo].forEach { $0?.textColor = acento }

        // la información detallada se carga en el siguiente paso
        [periodoStack, aportesStack, sitiosStack].forEach { $0?.isHidden = true }
        acercaLabel.isHidden = true
        descripcionLabel.isHidden = true
    }
}
