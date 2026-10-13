import UIKit

class PersonasTableViewCell: UITableViewCell {

    let PersonaImagen = UIImageView()
    let personaNombre = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        PersonaImagen.translatesAutoresizingMaskIntoConstraints = false
        PersonaImagen.contentMode = .scaleAspectFit
        personaNombre.translatesAutoresizingMaskIntoConstraints = false
        personaNombre.font = .preferredFont(forTextStyle: .title3)
        personaNombre.adjustsFontForContentSizeCategory = true

        contentView.addSubview(PersonaImagen)
        contentView.addSubview(personaNombre)
        NSLayoutConstraint.activate([
            PersonaImagen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            PersonaImagen.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            PersonaImagen.widthAnchor.constraint(equalToConstant: 64),
            PersonaImagen.heightAnchor.constraint(equalToConstant: 64),
            PersonaImagen.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            PersonaImagen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            personaNombre.leadingAnchor.constraint(equalTo: PersonaImagen.trailingAnchor, constant: 16),
            personaNombre.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            personaNombre.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) no se usa: la celda se crea por código")
    }
}
