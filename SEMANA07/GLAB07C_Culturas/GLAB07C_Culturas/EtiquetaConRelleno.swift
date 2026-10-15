import UIKit

// UILabel con márgenes internos, usada como etiqueta de región
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
