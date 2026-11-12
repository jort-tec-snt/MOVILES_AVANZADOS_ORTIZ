//
//  BarChartView.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (UIKit + Core Data)
//

import UIKit

/// Gráfico de barras sencillo (últimos 7 días), dibujado con Core Graphics.
final class BarChartView: UIView {
    var datos: [(etiqueta: String, valor: Double)] = [] { didSet { setNeedsDisplay() } }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        isAccessibilityElement = true
        accessibilityLabel = "Gráfico de ventas de los últimos 7 días"
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) no se usa") }

    override var intrinsicContentSize: CGSize { CGSize(width: UIView.noIntrinsicMetric, height: 180) }

    override func draw(_ rect: CGRect) {
        guard !datos.isEmpty else { return }
        let alturaEtiqueta: CGFloat = 18, alturaValor: CGFloat = 14
        let areaBarras = bounds.height - alturaEtiqueta - alturaValor
        let maximo = max(datos.map { $0.valor }.max() ?? 0, 1)
        let ancho = bounds.width / CGFloat(datos.count)
        let atributos: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .caption2), .foregroundColor: UIColor.secondaryLabel]

        for (i, d) in datos.enumerated() {
            let alto = max(CGFloat(d.valor / maximo) * areaBarras, d.valor > 0 ? 3 : 1)
            let x = CGFloat(i) * ancho + ancho * 0.2
            let barra = CGRect(x: x, y: alturaValor + (areaBarras - alto), width: ancho * 0.6, height: alto)
            (d.valor > 0 ? UIColor.systemBlue : UIColor.tertiarySystemFill).setFill()
            UIBezierPath(roundedRect: barra, cornerRadius: 4).fill()

            let etiqueta = d.etiqueta as NSString
            let tam = etiqueta.size(withAttributes: atributos)
            etiqueta.draw(at: CGPoint(x: CGFloat(i) * ancho + (ancho - tam.width) / 2, y: bounds.height - alturaEtiqueta + 2), withAttributes: atributos)
            if d.valor > 0 {
                let valor = String(format: "%.0f", d.valor) as NSString
                let t = valor.size(withAttributes: atributos)
                valor.draw(at: CGPoint(x: CGFloat(i) * ancho + (ancho - t.width) / 2, y: barra.minY - 14), withAttributes: atributos)
            }
        }
        accessibilityValue = datos.map { "\($0.etiqueta): \($0.valor.moneda)" }.joined(separator: ", ")
    }
}
