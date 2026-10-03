// xcode: set sdk=iOS

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tfApellido: UITextField!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfDni: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnContinuar(_ sender: Any) {
        let oCliente = ClienteModel(
            pCodigo: 0,
            pApellido: tfApellido.text ?? "",
            pNombre: tfNombre.text ?? "",
            pDni: tfDni.text ?? ""
        )

        let oStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let oPantalla2 = oStoryboard.instantiateViewController(
            withIdentifier: "ViewControllerConfirmacion"
        ) as! ViewControllerConfirmacion

        oPantalla2.pCliente = oCliente

        self.present(
            oPantalla2,
            animated: true,
            completion: nil
        )
    }
}
