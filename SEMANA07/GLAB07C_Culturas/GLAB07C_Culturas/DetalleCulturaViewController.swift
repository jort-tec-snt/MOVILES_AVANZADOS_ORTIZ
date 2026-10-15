import UIKit

// Detalle básico: el diseño está en Main.storyboard (una escena);
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
    @IBOutlet weak var lugaresButton: UIButton!

    // Información de las culturas con detalle básico, buscada por nombre
    let informacion: [String: (periodo: String, descripcion: String)] = [
        "Caral": (periodo: "c. 3000 – 1800 a.C.",
                  descripcion: "Considerada la civilización más antigua de América (c. 3000 a.C.). Destacó por su arquitectura monumental de pirámides y plazas circulares."),
        "Chavín": (periodo: "c. 900 – 200 a.C.",
                   descripcion: "Cultura de los Andes centrales (c. 900 a.C.) con centro ceremonial en Chavín de Huántar, conocida por su arte lítico y sus galerías subterráneas."),
        "Paracas": (periodo: "c. 700 a.C. – 200 d.C.",
                    descripcion: "Famosa por sus mantos bordados de gran complejidad y por sus fardos funerarios hallados en la península de Paracas."),
        "Moche": (periodo: "c. 100 – 800 d.C.",
                  descripcion: "Cultura de la costa norte, destacada por su orfebrería, su cerámica retrato y monumentos como las Huacas del Sol y de la Luna.")
    ]

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
        acercaLabel.textColor = acento
        lugaresButton.configuration?.baseBackgroundColor = acento

        guard let info = informacion[nombre] else { return }
        periodoLabel.text = info.periodo
        descripcionLabel.attributedText = texto(info.descripcion)
    }

    // Segue "verLugares": pasa la cultura a la pantalla de lugares turísticos
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "verLugares",
              let lugares = segue.destination as? LugaresViewController else { return }
        lugares.cultura = nombre
    }

    // Párrafo con interlineado más cómodo
    private func texto(_ contenido: String) -> NSAttributedString {
        let estilo = NSMutableParagraphStyle()
        estilo.lineSpacing = 5
        return NSAttributedString(string: contenido, attributes: [.paragraphStyle: estilo, .font: UIFont.preferredFont(forTextStyle: .body), .foregroundColor: UIColor.label])
    }
}
