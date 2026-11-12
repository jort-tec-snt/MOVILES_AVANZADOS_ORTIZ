//
//  ResumenViewController.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (MVVM · UIKit + Core Data)
//

import UIKit

/// A9 · Panel del supervisor (vista). Los números los calcula ResumenViewModel.
final class ResumenViewController: FormularioBase {
    private let viewModel: ResumenViewModel
    private let saludo = Estilo.etiqueta(.title2, negrita: true)
    private let rolLabel = Estilo.etiqueta(.subheadline, color: .secondaryLabel)
    private let hoyLabel = Estilo.etiqueta(.title2, negrita: true)
    private let ayerLabel = Estilo.etiqueta(.subheadline, color: .secondaryLabel)
    private let variacionLabel = Estilo.etiqueta(.subheadline, negrita: true)
    private let operacionesLabel = Estilo.etiqueta(.subheadline, color: .secondaryLabel)
    private let grafico = BarChartView()
    private let rankingPila = UIStackView()
    private let stockPila = UIStackView()

    init(viewModel: ResumenViewModel = ResumenViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) no se usa") }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Resumen"

        saludo.text = viewModel.saludo                                       // ① saludo con nombre y rol
        rolLabel.text = viewModel.rol
        pila.addArrangedSubview(saludo)
        pila.addArrangedSubview(rolLabel)
        pila.setCustomSpacing(16, after: rolLabel)

        // ② Indicadores con comparación contra el día anterior
        let titulo1 = Estilo.etiqueta(.footnote, color: .secondaryLabel); titulo1.text = "VENTAS DE HOY"
        let indicadores = UIStackView(arrangedSubviews: [titulo1, hoyLabel, ayerLabel, variacionLabel, operacionesLabel])
        indicadores.axis = .vertical; indicadores.spacing = 4
        pila.addArrangedSubview(Estilo.tarjeta(indicadores))

        // ③ Gráfico de barras de los últimos 7 días
        pila.addArrangedSubview(seccion("Últimos 7 días"))
        pila.addArrangedSubview(Estilo.tarjeta(grafico))

        // ④ Ranking de vendedores del mes
        pila.addArrangedSubview(seccion("Ranking de vendedores (mes)"))
        rankingPila.axis = .vertical; rankingPila.spacing = 8
        pila.addArrangedSubview(Estilo.tarjeta(rankingPila))

        // ⑤ Productos con stock bajo
        pila.addArrangedSubview(seccion("Productos con stock bajo"))
        stockPila.axis = .vertical; stockPila.spacing = 8
        pila.addArrangedSubview(Estilo.tarjeta(stockPila))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.cargar()
        pintar()
    }

    private func seccion(_ texto: String) -> UILabel {
        let l = Estilo.etiqueta(.headline); l.text = texto
        return l
    }

    private func pintar() {
        hoyLabel.text = viewModel.hoyTexto
        ayerLabel.text = viewModel.ayerTexto
        operacionesLabel.text = viewModel.operacionesTexto
        variacionLabel.text = viewModel.variacionTexto
        variacionLabel.textColor = Estilo.color(viewModel.tendencia)
        grafico.datos = viewModel.serie

        rankingPila.arrangedSubviews.forEach { $0.removeFromSuperview() }
        if viewModel.ranking.isEmpty { rankingPila.addArrangedSubview(texto("Aún no hay ventas este mes")) }
        for (i, r) in viewModel.ranking.enumerated() {
            rankingPila.addArrangedSubview(fila("\(i + 1). \(r.nombre)", r.monto, color: .label))
        }

        stockPila.arrangedSubviews.forEach { $0.removeFromSuperview() }
        if viewModel.stockBajo.isEmpty { stockPila.addArrangedSubview(texto("Todo el inventario está sobre el mínimo")) }
        for p in viewModel.stockBajo {
            stockPila.addArrangedSubview(fila(p.nombre, p.texto, color: Estilo.color(p.nivel)))
        }
    }

    private func texto(_ t: String) -> UILabel {
        let l = Estilo.etiqueta(.subheadline, color: .secondaryLabel); l.text = t
        return l
    }

    private func fila(_ izquierda: String, _ derecha: String, color: UIColor) -> UIStackView {
        let a = Estilo.etiqueta(.body); a.text = izquierda
        let b = Estilo.etiqueta(.body, color: color, negrita: true); b.text = derecha; b.textAlignment = .right
        b.setContentCompressionResistancePriority(.required, for: .horizontal)
        return UIStackView(arrangedSubviews: [a, b])
    }
}
