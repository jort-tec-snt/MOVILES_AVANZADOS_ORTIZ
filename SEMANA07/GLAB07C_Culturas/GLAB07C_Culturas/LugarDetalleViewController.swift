import UIKit

// Detalle de un lugar turístico: el diseño está en Main.storyboard;
// aquí se cargan los datos del lugar recibido y el color de su cultura.
class LugarDetalleViewController: UIViewController {

    // Datos que llegan desde la lista de lugares por el segue "verLugar"
    var lugar: Lugar?
    var cultura = ""

    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var bannerImagen: UIImageView!
    @IBOutlet weak var bannerCapa: UIView!
    @IBOutlet weak var bannerIcono: UIImageView!
    @IBOutlet weak var culturaLabel: UILabel!
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var ubicacionLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    @IBOutlet weak var queVerStack: UIStackView!
    @IBOutlet weak var queVerTitulo: UILabel!
    @IBOutlet weak var queVerLista: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let lugar = lugar else { return }
        title = lugar.nombre
        culturaLabel.text = "Cultura \(cultura)"
        nombreLabel.text = lugar.nombre
        ubicacionLabel.text = lugar.ubicacion
        descripcionLabel.attributedText = texto(lugar.descripcion)

        // color con nombre de Assets según la cultura
        let acento = UIColor(named: "Acento" + cultura.folding(options: .diacriticInsensitive, locale: nil)) ?? .tintColor
        bannerView.backgroundColor = acento
        queVerTitulo.textColor = acento

        // con foto: se muestra la imagen con una capa oscura para leer el texto; sin foto: banda de color con icono
        let foto = UIImage(named: lugar.imagen)
        bannerImagen.image = foto
        bannerImagen.isHidden = foto == nil
        bannerCapa.isHidden = foto == nil
        bannerIcono.isHidden = foto != nil
        bannerImagen.accessibilityLabel = "Foto de \(lugar.nombre)"

        // la sección "Qué ver" solo aparece si el lugar tiene datos
        queVerStack.isHidden = lugar.queVer.isEmpty
        queVerLista.attributedText = viñetas(lugar.queVer)
    }

    private func texto(_ contenido: String) -> NSAttributedString {
        let estilo = NSMutableParagraphStyle()
        estilo.lineSpacing = 5
        return NSAttributedString(string: contenido, attributes: [.paragraphStyle: estilo, .font: UIFont.preferredFont(forTextStyle: .body), .foregroundColor: UIColor.label])
    }

    // Lista con viñetas y sangría francesa
    private func viñetas(_ elementos: [String]) -> NSAttributedString {
        let estilo = NSMutableParagraphStyle()
        estilo.headIndent = 16
        estilo.tabStops = [NSTextTab(textAlignment: .left, location: 16)]
        estilo.paragraphSpacing = 8
        return NSAttributedString(string: elementos.map { "•\t\($0)" }.joined(separator: "\n"),
                                  attributes: [.paragraphStyle: estilo, .font: UIFont.preferredFont(forTextStyle: .body), .foregroundColor: UIColor.label])
    }
}
