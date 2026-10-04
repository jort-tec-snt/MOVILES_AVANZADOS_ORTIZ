// xcode: set sdk=iOS

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tfApellido: UITextField!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfDni: UITextField!
    @IBOutlet weak var cardCliente: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark

        let cobre = UIColor(red: 0.925, green: 0.733, blue: 0.486, alpha: 1)
        let texto = UIColor(red: 0.961, green: 0.945, blue: 0.910, alpha: 1)
        let secundario = UIColor(red: 0.753, green: 0.722, blue: 0.675, alpha: 1)
        let barra = UINavigationBarAppearance()
        barra.configureWithOpaqueBackground()
        barra.backgroundColor = UIColor(red: 0.082, green: 0.106, blue: 0.122, alpha: 1)
        barra.titleTextAttributes = [.foregroundColor: texto]
        barra.largeTitleTextAttributes = [.foregroundColor: texto]
        barra.shadowColor = cobre.withAlphaComponent(0.3)
        navigationItem.standardAppearance = barra
        navigationItem.scrollEdgeAppearance = barra
        navigationItem.compactAppearance = barra
        navigationItem.leftBarButtonItem?.tintColor = cobre
        navigationItem.rightBarButtonItem?.tintColor = cobre
        let barButtonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: cobre,
            .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
        ]
        navigationItem.leftBarButtonItem?.setTitleTextAttributes(barButtonAttributes, for: .normal)
        navigationItem.leftBarButtonItem?.setTitleTextAttributes(barButtonAttributes, for: .highlighted)
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(barButtonAttributes, for: .normal)

        cardCliente.layer.borderColor = cobre.withAlphaComponent(0.35).cgColor
        [tfApellido, tfNombre, tfDni].forEach { campo in
            campo?.layer.cornerRadius = 10
            campo?.layer.borderWidth = 1
            campo?.layer.borderColor = cobre.withAlphaComponent(0.3).cgColor
            campo?.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 1))
            campo?.leftViewMode = .always
            campo?.tintColor = cobre
            campo?.attributedPlaceholder = NSAttributedString(
                string: campo?.placeholder ?? "",
                attributes: [.foregroundColor: secundario]
            )
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor(red: 0.925, green: 0.733, blue: 0.486, alpha: 1)
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
