import UIKit

class DetalleCulturaViewController: UIViewController {

    var cultura: Cultura?

    @IBOutlet weak var imagenView: UIImageView!
    @IBOutlet weak var tarjetaView: UIView!
    @IBOutlet weak var contenidoStack: UIStackView!
    @IBOutlet weak var filaRegion: UIStackView!
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var regionChip: EtiquetaConRelleno!
    @IBOutlet weak var descripcionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        aplicarEstilo()
        mostrarCultura()
    }

    // Detalles visuales que el Storyboard no cubre
    private func aplicarEstilo() {
        tarjetaView.layer.cornerRadius = 24
        tarjetaView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        nombreLabel.font = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: .systemFont(ofSize: 34, weight: .bold))
        nombreLabel.accessibilityTraits = .header
        regionChip.textColor = .tintColor
        regionChip.backgroundColor = UIColor.tintColor.withAlphaComponent(0.12)
        regionChip.layer.cornerRadius = 14
        regionChip.clipsToBounds = true
        contenidoStack.setCustomSpacing(24, after: filaRegion)
        imagenView.isAccessibilityElement = true
        imagenView.accessibilityTraits = .image
    }

    private func mostrarCultura() {
        guard let cultura = cultura else { return }
        title = cultura.nombre
        imagenView.image = UIImage(named: cultura.imagen)
        imagenView.accessibilityLabel = "Imagen representativa de la cultura \(cultura.nombre)"
        nombreLabel.text = cultura.nombre
        regionChip.attributedText = chipRegion(cultura.region)

        let estilo = NSMutableParagraphStyle()
        estilo.lineSpacing = 5
        descripcionLabel.attributedText = NSAttributedString(
            string: cultura.descripcion,
            attributes: [.paragraphStyle: estilo, .font: UIFont.preferredFont(forTextStyle: .body), .foregroundColor: UIColor.label])
    }

    // Icono de mapa + región dentro de la etiqueta
    private func chipRegion(_ region: String) -> NSAttributedString {
        let icono = NSTextAttachment(image: UIImage(systemName: "mappin.and.ellipse")?.withTintColor(.tintColor) ?? UIImage())
        let texto = NSMutableAttributedString(attachment: icono)
        texto.append(NSAttributedString(string: " \(region)"))
        return texto
    }
}
