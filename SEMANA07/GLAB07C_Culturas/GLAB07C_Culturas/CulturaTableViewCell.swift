import UIKit

// Celda prototipo del Storyboard (identificador "culturaCell")
class CulturaTableViewCell: UITableViewCell {

    @IBOutlet weak var miniatura: UIImageView!
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        miniatura.layer.cornerRadius = 12
        miniatura.clipsToBounds = true
    }

    func configurar(con cultura: Cultura) {
        nombreLabel.text = cultura.nombre
        regionLabel.text = cultura.region
        miniatura.image = UIImage(named: cultura.imagen)
        accessibilityLabel = "\(cultura.nombre), \(cultura.region)"
    }
}
