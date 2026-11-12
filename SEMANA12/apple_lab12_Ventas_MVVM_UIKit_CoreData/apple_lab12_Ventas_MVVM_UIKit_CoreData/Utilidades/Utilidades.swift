//
//  Utilidades.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (UIKit + Core Data)
//

import UIKit

extension Double {
    /// Formato de moneda: S/ 1,234.50
    var moneda: String {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.locale = Locale(identifier: "en_US")
        f.minimumFractionDigits = 2
        f.maximumFractionDigits = 2
        return "S/ " + (f.string(from: NSNumber(value: self)) ?? String(format: "%.2f", self))
    }
}

extension Date {
    private static var calendario: Calendar { Calendar.current }
    var inicioDelDia: Date { Date.calendario.startOfDay(for: self) }
    var inicioDelMes: Date {
        let c = Date.calendario.dateComponents([.year, .month], from: self)
        return Date.calendario.date(from: c) ?? self
    }
    func sumando(dias: Int) -> Date { Date.calendario.date(byAdding: .day, value: dias, to: self) ?? self }

    var texto: String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "es_PE")
        f.dateFormat = "dd/MM/yyyy HH:mm"
        return f.string(from: self)
    }

    var diaCorto: String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "es_PE")
        f.dateFormat = "EEE"
        return f.string(from: self).capitalized
    }
}

extension UIViewController {
    func mostrarAlerta(_ titulo: String, _ mensaje: String, alAceptar: (() -> Void)? = nil) {
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default) { _ in alAceptar?() })
        present(alert, animated: true)
    }
}

enum Estilo {
    static func etiqueta(_ estilo: UIFont.TextStyle, color: UIColor = .label, negrita: Bool = false, lineas: Int = 0) -> UILabel {
        let l = UILabel()
        var fuente = UIFont.preferredFont(forTextStyle: estilo)
        if negrita, let d = fuente.fontDescriptor.withSymbolicTraits(.traitBold) { fuente = UIFont(descriptor: d, size: 0) }
        l.font = fuente
        l.adjustsFontForContentSizeCategory = true
        l.textColor = color
        l.numberOfLines = lineas
        return l
    }

    /// Color del stock según el nivel que decide el ViewModel: verde, ámbar o rojo.
    static func color(_ nivel: NivelStock) -> UIColor {
        switch nivel {
        case .bajo: return .systemRed
        case .medio: return .systemOrange
        case .alto: return .systemGreen
        }
    }

    static func color(_ tendencia: Tendencia) -> UIColor {
        switch tendencia {
        case .sube: return .systemGreen
        case .baja: return .systemRed
        case .neutra: return .secondaryLabel
        }
    }

    static func colorCategoria(_ c: CategoriaCliente) -> UIColor {
        switch c {
        case .regular: return .secondaryLabel
        case .frecuente: return .systemBlue
        case .vip: return .systemPurple
        }
    }

    /// Tarjeta con fondo secundario y esquinas redondeadas.
    static func tarjeta(_ contenido: UIView) -> UIView {
        let v = UIView()
        v.backgroundColor = .secondarySystemBackground
        v.layer.cornerRadius = 12
        contenido.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(contenido)
        NSLayoutConstraint.activate([
            contenido.topAnchor.constraint(equalTo: v.topAnchor, constant: 12),
            contenido.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -12),
            contenido.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 14),
            contenido.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -14),
        ])
        return v
    }
}

/// Mensaje centrado cuando una lista está vacía.
func fondoVacio(_ texto: String) -> UIView {
    let l = Estilo.etiqueta(.body, color: .secondaryLabel)
    l.text = texto
    l.textAlignment = .center
    l.numberOfLines = 0
    return l
}
