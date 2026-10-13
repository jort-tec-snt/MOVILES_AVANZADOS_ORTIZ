import UIKit

class CulturaTableViewCell: UITableViewCell {

    static let identificador = "culturaCell"

    private let miniatura = UIImageView()
    private let nombreLabel = UILabel()
    private let regionLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator

        miniatura.translatesAutoresizingMaskIntoConstraints = false
        miniatura.contentMode = .scaleAspectFill
        miniatura.clipsToBounds = true
        miniatura.layer.cornerRadius = 12
        miniatura.backgroundColor = .secondarySystemFill

        nombreLabel.font = .preferredFont(forTextStyle: .headline)
        regionLabel.font = .preferredFont(forTextStyle: .subheadline)
        regionLabel.textColor = .secondaryLabel
        [nombreLabel, regionLabel].forEach { $0.adjustsFontForContentSizeCategory = true }

        let textos = UIStackView(arrangedSubviews: [nombreLabel, regionLabel])
        textos.axis = .vertical
        textos.spacing = 2
        textos.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(miniatura)
        contentView.addSubview(textos)
        NSLayoutConstraint.activate([
            miniatura.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            miniatura.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            miniatura.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            miniatura.widthAnchor.constraint(equalToConstant: 88),
            miniatura.heightAnchor.constraint(equalToConstant: 66),
            textos.leadingAnchor.constraint(equalTo: miniatura.trailingAnchor, constant: 14),
            textos.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            textos.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) no se usa: la celda se crea por código")
    }

    func configurar(con cultura: Cultura) {
        nombreLabel.text = cultura.nombre
        regionLabel.text = cultura.region
        miniatura.image = UIImage(named: cultura.imagen)
        accessibilityLabel = "\(cultura.nombre), \(cultura.region)"
    }
}
