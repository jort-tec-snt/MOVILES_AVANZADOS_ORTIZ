//
//  NuevaVentaViewController.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (MVVM · UIKit + Core Data)
//

import UIKit

/// A5 · Registrar venta (vista). Estado, cálculo y registro los resuelve NuevaVentaViewModel.
final class NuevaVentaViewController: FormularioBase {
    private let viewModel: NuevaVentaViewModel

    private var clienteBoton: UIButton!
    private var productoBoton: UIButton!
    private let stepper = UIStepper()
    private let cantidadLabel = Estilo.etiqueta(.headline)
    private let stockLabel = Estilo.etiqueta(.footnote, color: .secondaryLabel)
    private let categoriaLabel = Estilo.etiqueta(.footnote, color: .secondaryLabel)
    private let subtotalLabel = Estilo.etiqueta(.body)
    private let descuentoLabel = Estilo.etiqueta(.body)
    private let igvLabel = Estilo.etiqueta(.body)
    private let totalLabel = Estilo.etiqueta(.title3, negrita: true)

    init(viewModel: NuevaVentaViewModel = NuevaVentaViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) no se usa") }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Nueva venta"

        // ① Vendedor de la sesión (automático, no editable)
        let vendedor = Estilo.etiqueta(.subheadline, color: .secondaryLabel)
        vendedor.text = viewModel.vendedorTexto
        pila.addArrangedSubview(vendedor)

        clienteBoton = selector("Seleccionar cliente") { [weak self] in self?.elegirCliente() }       // ②
        pila.addArrangedSubview(categoriaLabel)
        productoBoton = selector("Seleccionar producto") { [weak self] in self?.elegirProducto() }    // ③

        // ④ Cantidad con stepper y stock disponible
        stepper.minimumValue = 1; stepper.maximumValue = 999; stepper.value = 1
        stepper.accessibilityLabel = "Cantidad"
        stepper.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.cambiarCantidad(Int(self.stepper.value))
        }, for: .valueChanged)
        let qEtiqueta = Estilo.etiqueta(.body); qEtiqueta.text = "Cantidad"
        let filaCantidad = UIStackView(arrangedSubviews: [qEtiqueta, UIView(), cantidadLabel, stepper])
        filaCantidad.spacing = 12; filaCantidad.alignment = .center
        pila.addArrangedSubview(filaCantidad)
        pila.addArrangedSubview(stockLabel)

        // ⑤ Resumen calculado
        func fila(_ titulo: String, _ valor: UILabel) -> UIStackView {
            let t = Estilo.etiqueta(.body, color: .secondaryLabel); t.text = titulo
            valor.textAlignment = .right
            return UIStackView(arrangedSubviews: [t, valor])
        }
        let resumen = UIStackView(arrangedSubviews: [fila("Subtotal", subtotalLabel), fila("Descuento", descuentoLabel),
                                                    fila("IGV (18 %)", igvLabel), fila("Total", totalLabel)])
        resumen.axis = .vertical; resumen.spacing = 8
        pila.addArrangedSubview(Estilo.tarjeta(resumen))

        boton("Registrar venta") { [weak self] in self?.registrar() }                                   // ⑥

        // Enlace con el ViewModel
        viewModel.onChange = { [weak self] in self?.actualizar() }
        actualizar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refrescar()
    }

    private func selector(_ titulo: String, accion: @escaping () -> Void) -> UIButton {
        var c = UIButton.Configuration.tinted()
        c.title = titulo
        c.cornerStyle = .large
        c.image = UIImage(systemName: "chevron.right")
        c.imagePlacement = .trailing
        c.imagePadding = 8
        c.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16)
        let b = UIButton(configuration: c, primaryAction: UIAction { _ in accion() })
        b.contentHorizontalAlignment = .leading
        pila.addArrangedSubview(b)
        return b
    }

    private func elegirCliente() {
        let opciones = viewModel.opcionesClientes()
        let vc = SeleccionViewController(titulo: "Cliente", items: opciones) { [weak self] i in
            self?.viewModel.elegirCliente(en: i)
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    private func elegirProducto() {
        let opciones = viewModel.opcionesProductos()
        let vc = SeleccionViewController(titulo: "Producto", items: opciones) { [weak self] i in
            self?.viewModel.elegirProducto(en: i)
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    /// La vista solo pinta lo que el ViewModel ya calculó.
    private func actualizar() {
        clienteBoton.configuration?.title = viewModel.clienteTexto
        productoBoton.configuration?.title = viewModel.productoTexto
        cantidadLabel.text = "\(viewModel.cantidad)"
        stepper.value = Double(viewModel.cantidad)
        stockLabel.text = viewModel.stockTexto
        categoriaLabel.text = viewModel.categoriaTexto
        categoriaLabel.isHidden = (viewModel.categoriaTexto == nil)
        let r = viewModel.resumen
        subtotalLabel.text = r.subtotal.moneda
        descuentoLabel.text = viewModel.descuentoTexto
        igvLabel.text = r.igv.moneda
        totalLabel.text = r.total.moneda
    }

    private func registrar() {
        switch viewModel.registrar() {
        case .registrada(let mensaje): mostrarAlerta("Venta registrada", mensaje)
        case .rechazada(let titulo, let mensaje): mostrarAlerta(titulo, mensaje)
        }
    }
}
