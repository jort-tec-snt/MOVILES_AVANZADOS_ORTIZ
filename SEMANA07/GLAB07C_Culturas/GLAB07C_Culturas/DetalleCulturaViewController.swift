import UIKit

class DetalleCulturaViewController: UIViewController {

    var cultura: Cultura?

    private let imagenView = UIImageView()
    private let nombreLabel = UILabel()
    private let regionLabel = UILabel()
    private let descripcionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never

        imagenView.contentMode = .scaleAspectFit
        nombreLabel.font = .preferredFont(forTextStyle: .largeTitle)
        regionLabel.font = .preferredFont(forTextStyle: .headline)
        regionLabel.textColor = .secondaryLabel
        descripcionLabel.font = .preferredFont(forTextStyle: .body)
        descripcionLabel.numberOfLines = 0
        [nombreLabel, regionLabel, descripcionLabel].forEach { $0.adjustsFontForContentSizeCategory = true }

        let pila = UIStackView(arrangedSubviews: [imagenView, nombreLabel, regionLabel, descripcionLabel])
        pila.axis = .vertical
        pila.spacing = 12
        pila.translatesAutoresizingMaskIntoConstraints = false

        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(pila)
        view.addSubview(scroll)
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pila.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor, constant: 16),
            pila.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor, constant: -16),
            pila.leadingAnchor.constraint(equalTo: scroll.frameLayoutGuide.leadingAnchor, constant: 20),
            pila.trailingAnchor.constraint(equalTo: scroll.frameLayoutGuide.trailingAnchor, constant: -20),
            imagenView.heightAnchor.constraint(equalToConstant: 220)
        ])

        guard let cultura = cultura else { return }
        title = cultura.nombre
        imagenView.image = UIImage(named: cultura.imagen)
        nombreLabel.text = cultura.nombre
        regionLabel.text = "Región: \(cultura.region)"
        descripcionLabel.text = cultura.descripcion
    }
}
