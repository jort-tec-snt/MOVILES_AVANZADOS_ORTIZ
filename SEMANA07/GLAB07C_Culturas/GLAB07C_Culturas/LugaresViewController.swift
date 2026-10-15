import UIKit

// Lugares turísticos de la zona de cada cultura: el diseño de la pantalla y de la celda
// está en Main.storyboard; aquí se guarda la información y se carga según la cultura recibida.
// Un lugar turístico; "queVer" e "imagen" son opcionales (solo algunos lugares los tienen)
struct Lugar {
    let nombre: String
    let ubicacion: String
    let descripcion: String
    var queVer: [String] = []
    var imagen = ""   // nombre de la foto en Assets (vacío si aún no tiene)
}

class LugaresViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    // Cultura elegida, recibida desde el detalle por el segue "verLugares"
    var cultura = ""

    let lugares: [String: [Lugar]] = [
        "Caral": [
            Lugar(nombre: "Ciudad Sagrada de Caral", ubicacion: "Supe, Barranca, Lima", descripcion: "Centro urbano más antiguo de América, con pirámides y plazas circulares. Patrimonio Mundial de la UNESCO."),
            Lugar(nombre: "Centro Arqueológico Vichama", ubicacion: "Végueta, Huaura, Lima", descripcion: "Sitio costero de la tradición Caral, con vista al mar."),
            Lugar(nombre: "Reserva Nacional Lomas de Lachay", ubicacion: "Huaura y Huaral, Lima", descripcion: "Lomas costeras que reverdecen en invierno, ideales para caminatas y observar flora y fauna.")
        ],
        "Chavín": [
            Lugar(nombre: "Chavín de Huántar", ubicacion: "Huari, Áncash", descripcion: "Centro ceremonial con galerías subterráneas y el famoso Lanzón. Patrimonio Mundial de la UNESCO."),
            Lugar(nombre: "Museo Nacional Chavín", ubicacion: "Chavín de Huántar, Áncash", descripcion: "Exhibe esculturas líticas halladas en el sitio."),
            Lugar(nombre: "Parque Nacional Huascarán", ubicacion: "Huaraz, Áncash", descripcion: "Nevados, lagunas y valles andinos. Patrimonio Natural de la UNESCO.")
        ],
        "Paracas": [
            Lugar(nombre: "Reserva Nacional de Paracas", ubicacion: "Paracas, Pisco, Ica", descripcion: "Desierto y mar con playas, acantilados y gran variedad de aves."),
            Lugar(nombre: "Islas Ballestas", ubicacion: "Paracas, Pisco, Ica", descripcion: "Islotes con lobos marinos, pingüinos de Humboldt y aves guaneras; se visitan en lancha."),
            Lugar(nombre: "El Candelabro", ubicacion: "Península de Paracas, Pisco, Ica", descripcion: "Geoglifo gigante grabado en una colina frente al mar.")
        ],
        "Nazca": [
            Lugar(nombre: "Líneas y geoglifos de Nazca", ubicacion: "Nazca, Ica", descripcion: "Figuras gigantes trazadas en el desierto, visibles desde miradores y sobrevuelos. Patrimonio Mundial de la UNESCO.", imagen: "lugar_lineas_nazca"),
            Lugar(nombre: "Acueductos de Cantalloc", ubicacion: "Nazca, Ica", descripcion: "Puquios: galerías en espiral que todavía conducen agua.", imagen: "lugar_cantalloc"),
            Lugar(nombre: "Cementerio de Chauchilla", ubicacion: "Nazca, Ica", descripcion: "Tumbas con momias y cerámica expuestas en el desierto.", imagen: "lugar_chauchilla")
        ],
        "Moche": [
            Lugar(nombre: "Huacas del Sol y de la Luna", ubicacion: "Moche, Trujillo, La Libertad", descripcion: "Templos de adobe con murales polícromos de la cultura Moche."),
            Lugar(nombre: "Complejo Arqueológico El Brujo", ubicacion: "Magdalena de Cao, Ascope, La Libertad", descripcion: "Conjunto con la Huaca Cao Viejo, donde se halló a la Señora de Cao."),
            Lugar(nombre: "Museo Tumbas Reales de Sipán", ubicacion: "Lambayeque", descripcion: "Exhibe el tesoro del Señor de Sipán, gobernante moche.")
        ],
        "Inca": [
            Lugar(nombre: "Machu Picchu", ubicacion: "Machupicchu, Urubamba, Cusco", descripcion: "Ciudadela inca sobre la montaña, una de las siete maravillas del mundo moderno.", queVer: ["Intihuatana, el reloj solar ritual", "Templo del Sol", "Plaza Sagrada y Templo de las Tres Ventanas", "Huayna Picchu, la montaña que domina la ciudadela"], imagen: "lugar_machupicchu"),
            Lugar(nombre: "Sacsayhuamán", ubicacion: "Cusco", descripcion: "Fortaleza de enormes bloques de piedra sobre la ciudad.", queVer: ["Muros en zigzag de bloques gigantes", "Explanada donde se celebra el Inti Raymi", "El Rodadero, roca tallada con forma de toboganes"], imagen: "lugar_sacsayhuaman"),
            Lugar(nombre: "Valle Sagrado de los Incas", ubicacion: "Urubamba y Calca, Cusco", descripcion: "Valle con Pisac, Ollantaytambo y Moray, terrazas agrícolas incas.", queVer: ["Pisac: mercado y terrazas", "Ollantaytambo: fortaleza y templo", "Moray: terrazas circulares de cultivo", "Salineras de Maras"], imagen: "lugar_valle_sagrado"),
            Lugar(nombre: "Qorikancha", ubicacion: "Cusco", descripcion: "Antiguo templo del Sol, base del convento de Santo Domingo.", queVer: ["Muros de piedra pulida inca bajo el convento", "Recintos dedicados al Sol, la Luna y el Rayo", "Claustro de Santo Domingo"], imagen: "lugar_qorikancha")
        ]
    ]

    var lista: [Lugar] {
        return lugares[cultura] ?? []
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lugares de \(cultura)"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 110
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista.count
    }

    // Elementos de la celda prototipo por tag: 1 miniatura, 2 nombre, 3 ubicación, 4 descripción
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lugarCell", for: indexPath)
        let lugar = lista[indexPath.row]
        let acento = UIColor(named: "Acento" + cultura.folding(options: .diacriticInsensitive, locale: nil))
        if let miniatura = cell.viewWithTag(1) as? UIImageView {
            // con foto: se llena la miniatura; sin foto: icono de ubicación con el color de la cultura
            if let foto = UIImage(named: lugar.imagen) {
                miniatura.image = foto
                miniatura.contentMode = .scaleAspectFill
            } else {
                miniatura.image = UIImage(systemName: "mappin.circle.fill")
                miniatura.contentMode = .scaleAspectFit
                miniatura.tintColor = acento
            }
        }
        (cell.viewWithTag(2) as? UILabel)?.text = lugar.nombre
        (cell.viewWithTag(3) as? UILabel)?.text = lugar.ubicacion
        (cell.viewWithTag(4) as? UILabel)?.text = lugar.descripcion
        return cell
    }

    // Segue "verLugar": entrega el lugar elegido y su cultura al detalle del lugar
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "verLugar",
              let celda = sender as? UITableViewCell,
              let fila = tableView.indexPath(for: celda),
              let detalle = segue.destination as? LugarDetalleViewController else { return }
        detalle.lugar = lista[fila.row]
        detalle.cultura = cultura
    }
}
