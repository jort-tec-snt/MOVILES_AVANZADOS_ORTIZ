import UIKit

class DetalleCulturaViewController: UIViewController {

    var cultura: Cultura?

    private let imagenView = UIImageView()
    private let nombreLabel = UILabel()
    private let regionChip = EtiquetaConRelleno()
    private let acercaLabel = UILabel()
    private let descripcionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        construirInterfaz()
        mostrarCultura()
    }

    private func construirInterfaz() {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.alwaysBounceVertical = true
        view.addSubview(scroll)

        // imagen grande arriba
        imagenView.translatesAutoresizingMaskIntoConstraints = false
        imagenView.contentMode = .scaleAspectFill
        imagenView.clipsToBounds = true
        imagenView.backgroundColor = .secondarySystemFill
        imagenView.isAccessibilityElement = true
        imagenView.accessibilityTraits = .image

        // tarjeta de contenido que se superpone a la imagen
        let tarjeta = UIView()
        tarjeta.translatesAutoresizingMaskIntoConstraints = false
        tarjeta.backgroundColor = .systemBackground
        tarjeta.layer.cornerRadius = 24
        tarjeta.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        nombreLabel.font = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: .systemFont(ofSize: 34, weight: .bold))
        nombreLabel.numberOfLines = 0
        nombreLabel.accessibilityTraits = .header

        regionChip.font = .preferredFont(forTextStyle: .subheadline)
        regionChip.textColor = .tintColor
        regionChip.backgroundColor = UIColor.tintColor.withAlphaComponent(0.12)
        regionChip.layer.cornerRadius = 14
        regionChip.clipsToBounds = true
        regionChip.numberOfLines = 0

        acercaLabel.font = .preferredFont(forTextStyle: .headline)
        acercaLabel.text = "Acerca de esta cultura"

        descripcionLabel.font = .preferredFont(forTextStyle: .body)
        descripcionLabel.textColor = .label
        descripcionLabel.numberOfLines = 0

        [nombreLabel, regionChip, acercaLabel, descripcionLabel].forEach { $0.adjustsFontForContentSizeCategory = true }

        // la etiqueta de región va en una fila para que no se estire a todo el ancho
        let filaRegion = UIStackView(arrangedSubviews: [regionChip, UIView()])
        filaRegion.axis = .horizontal

        let pila = UIStackView(arrangedSubviews: [nombreLabel, filaRegion, acercaLabel, descripcionLabel])
        pila.axis = .vertical
        pila.spacing = 14
        pila.setCustomSpacing(24, after: filaRegion)
        pila.translatesAutoresizingMaskIntoConstraints = false

        scroll.addSubview(imagenView)
        scroll.addSubview(tarjeta)
        tarjeta.addSubview(pila)

        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            imagenView.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            imagenView.leadingAnchor.constraint(equalTo: scroll.frameLayoutGuide.leadingAnchor),
            imagenView.trailingAnchor.constraint(equalTo: scroll.frameLayoutGuide.trailingAnchor),
            imagenView.heightAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor, multiplier: 0.75),

            tarjeta.topAnchor.constraint(equalTo: imagenView.bottomAnchor, constant: -28),
            tarjeta.leadingAnchor.constraint(equalTo: scroll.frameLayoutGuide.leadingAnchor),
            tarjeta.trailingAnchor.constraint(equalTo: scroll.frameLayoutGuide.trailingAnchor),
            tarjeta.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
            tarjeta.heightAnchor.constraint(greaterThanOrEqualTo: scroll.frameLayoutGuide.heightAnchor, multiplier: 0.5),

            pila.topAnchor.constraint(equalTo: tarjeta.topAnchor, constant: 24),
            pila.leadingAnchor.constraint(equalTo: tarjeta.leadingAnchor, constant: 20),
            pila.trailingAnchor.constraint(equalTo: tarjeta.trailingAnchor, constant: -20),
            pila.bottomAnchor.constraint(lessThanOrEqualTo: tarjeta.bottomAnchor, constant: -32)
        ])
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

    // "📍 Región" con icono de mapa y un poco de relleno
    private func chipRegion(_ region: String) -> NSAttributedString {
        let icono = NSTextAttachment(image: UIImage(systemName: "mappin.and.ellipse")?.withTintColor(.tintColor) ?? UIImage())
        let texto = NSMutableAttributedString()
        texto.append(NSAttributedString(attachment: icono))
        texto.append(NSAttributedString(string: " \(region)"))
        return texto
    }
}

// UILabel con márgenes internos para la etiqueta de región
class EtiquetaConRelleno: UILabel {
    private let relleno = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: relleno))
    }

    override var intrinsicContentSize: CGSize {
        let base = super.intrinsicContentSize
        return CGSize(width: base.width + relleno.left + relleno.right, height: base.height + relleno.top + relleno.bottom)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let base = super.sizeThatFits(CGSize(width: size.width - relleno.left - relleno.right, height: size.height))
        return CGSize(width: base.width + relleno.left + relleno.right, height: base.height + relleno.top + relleno.bottom)
    }
}
