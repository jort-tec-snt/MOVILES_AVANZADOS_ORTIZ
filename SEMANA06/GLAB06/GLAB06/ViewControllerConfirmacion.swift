// xcode: set sdk=iOS

import UIKit

class ViewControllerConfirmacion: UIViewController {
    @IBOutlet weak var tfApellido: UILabel!
    @IBOutlet weak var tfNombre: UILabel!
    @IBOutlet weak var tfDni: UILabel!
    @IBOutlet weak var cardConfirmacion: UIView!

    var pCliente: ClienteModel = ClienteModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        let cobre = UIColor(red: 0.843, green: 0.631, blue: 0.416, alpha: 1)
        cardConfirmacion.layer.borderColor = cobre.withAlphaComponent(0.35).cgColor

        tfApellido.text = pCliente.Apellido
        tfNombre.text = pCliente.Nombre
        tfDni.text = pCliente.Dni
    }
}
