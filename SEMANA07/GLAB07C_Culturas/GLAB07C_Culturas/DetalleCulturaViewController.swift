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

    // Información detallada de cada cultura, buscada por nombre
    let informacion: [String: (periodo: String, descripcion: String, aportes: [String], sitios: [String])] = [
        "Caral": (periodo: "c. 3000 – 1800 a.C.",
                  descripcion: "Considerada la civilización más antigua de América (c. 3000 a.C.). Destacó por su arquitectura monumental de pirámides y plazas circulares.",
                  aportes: [], sitios: []),
        "Chavín": (periodo: "c. 900 – 200 a.C.",
                   descripcion: "Cultura de los Andes centrales (c. 900 a.C.) con centro ceremonial en Chavín de Huántar, conocida por su arte lítico y sus galerías subterráneas.",
                   aportes: [], sitios: []),
        "Paracas": (periodo: "c. 700 a.C. – 200 d.C.",
                    descripcion: "Famosa por sus mantos bordados de gran complejidad y por sus fardos funerarios hallados en la península de Paracas.",
                    aportes: [], sitios: []),
        "Nazca": (periodo: "c. 100 a.C. – 800 d.C.",
                  descripcion: "Creadora de las líneas y geoglifos de la pampa de Nazca, además de una cerámica policroma y un ingenioso sistema de acueductos.",
                  aportes: ["Geoglifos: figuras gigantes como el colibrí, el mono y la araña, visibles desde el aire",
                            "Puquios: acueductos subterráneos en espiral para aprovechar el agua del desierto",
                            "Cerámica policroma con motivos de animales y seres míticos"],
                  sitios: ["Líneas y geoglifos de Nazca y Pampas de Jumana",
                           "Cahuachi, centro ceremonial",
                           "Acueductos de Cantalloc"]),
        "Moche": (periodo: "c. 100 – 800 d.C.",
                  descripcion: "Cultura de la costa norte, destacada por su orfebrería, su cerámica retrato y monumentos como las Huacas del Sol y de la Luna.",
                  aportes: [], sitios: []),
        "Inca": (periodo: "c. 1200 – 1533 d.C.",
                 descripcion: "Mayor imperio de la América precolombina (s. XV–XVI). Se destacó por su ingeniería, sus caminos (Qhapaq Ñan) y ciudades como Machu Picchu.",
                 aportes: ["Qhapaq Ñan: red de caminos que unía el imperio por los Andes",
                           "Andenes: terrazas agrícolas para cultivar en las laderas",
                           "Quipu: sistema de registro con cuerdas anudadas",
                           "Arquitectura en piedra encajada sin mortero"],
                 sitios: ["Machu Picchu", "Sacsayhuamán", "Ollantaytambo", "Coricancha, en Cusco"])
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
        [acercaLabel, aportesTitulo, sitiosTitulo].forEach { $0?.textColor = acento }

        guard let info = informacion[nombre] else { return }
        periodoLabel.text = info.periodo
        descripcionLabel.attributedText = texto(info.descripcion)
        aportesLista.attributedText = viñetas(info.aportes)
        sitiosLista.attributedText = viñetas(info.sitios)
        // las secciones sin datos no se muestran
        aportesStack.isHidden = info.aportes.isEmpty
        sitiosStack.isHidden = info.sitios.isEmpty
    }

    // Párrafo con interlineado más cómodo
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
