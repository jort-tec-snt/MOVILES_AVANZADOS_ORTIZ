// xcode: set sdk=iOS

import UIKit

class ViewControllerConfirmacion: UIViewController {
    @IBOutlet weak var tfApellido: UILabel!
    @IBOutlet weak var tfNombre: UILabel!
    @IBOutlet weak var tfDni: UILabel!

    var pCliente: ClienteModel = ClienteModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        tfApellido.text = pCliente.Apellido
        tfNombre.text = pCliente.Nombre
        tfDni.text = pCliente.Dni
    }
}
