//
//  FormularioBase.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (UIKit + Core Data)
//

import UIKit

/// Base para pantallas con formulario: scroll + pila vertical, con teclado que no tapa los campos.
class FormularioBase: UIViewController {
    let scroll = UIScrollView()
    let pila = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.keyboardDismissMode = .interactive
        scroll.alwaysBounceVertical = true
        view.addSubview(scroll)

        pila.axis = .vertical
        pila.spacing = 14
        pila.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(pila)

        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),
            pila.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor, constant: 24),
            pila.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor, constant: -24),
            pila.leadingAnchor.constraint(equalTo: scroll.frameLayoutGuide.leadingAnchor, constant: 24),
            pila.trailingAnchor.constraint(equalTo: scroll.frameLayoutGuide.trailingAnchor, constant: -24),
        ])
    }

    @discardableResult
    func campo(_ placeholder: String, texto: String? = nil, seguro: Bool = false,
               teclado: UIKeyboardType = .default, mayusculas: UITextAutocapitalizationType = .none) -> UITextField {
        let f = UITextField()
        f.placeholder = placeholder
        f.text = texto
        f.borderStyle = .roundedRect
        f.font = .preferredFont(forTextStyle: .body)
        f.adjustsFontForContentSizeCategory = true
        f.isSecureTextEntry = seguro
        f.keyboardType = teclado
        f.autocapitalizationType = mayusculas
        f.autocorrectionType = .no
        f.spellCheckingType = .no
        f.accessibilityLabel = placeholder
        f.heightAnchor.constraint(greaterThanOrEqualToConstant: 48).isActive = true
        pila.addArrangedSubview(f)
        return f
    }

    /// Mensaje de error / aviso (oculto hasta que haya texto).
    @discardableResult
    func mensaje(color: UIColor = .systemRed) -> UILabel {
        let l = Estilo.etiqueta(.footnote, color: color)
        l.isHidden = true
        pila.addArrangedSubview(l)
        return l
    }

    func mostrar(_ l: UILabel, _ texto: String?) {
        l.text = texto
        l.isHidden = (texto == nil)
    }

    @discardableResult
    func boton(_ titulo: String, relleno: Bool = true, accion: @escaping () -> Void) -> UIButton {
        var c: UIButton.Configuration = relleno ? .filled() : .plain()
        c.title = titulo
        c.cornerStyle = .large
        c.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16)
        let b = UIButton(configuration: c, primaryAction: UIAction { _ in accion() })
        b.heightAnchor.constraint(greaterThanOrEqualToConstant: 48).isActive = true
        pila.addArrangedSubview(b)
        return b
    }
}
