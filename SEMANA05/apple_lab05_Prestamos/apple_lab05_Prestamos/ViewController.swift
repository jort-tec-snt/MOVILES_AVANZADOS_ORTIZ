import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var capitalTextField: UITextField!
    @IBOutlet weak var annualRateTextField: UITextField!
    @IBOutlet weak var yearsTextField: UITextField!
    @IBOutlet weak var monthlyPaymentLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func CalcularPrestamo(_ sender: Any) {
        let p = Double(capitalTextField.text ?? "") ?? 0
        let annualRate = Double(annualRateTextField.text ?? "") ?? 0
        let years = Double(yearsTextField.text ?? "") ?? 0

        let r = (annualRate / 100) / 12
        let n = years * 12

        let factor = pow(1 + r, n)
        let monthlyPayment = p * (r * factor / (factor - 1))

        monthlyPaymentLabel.text = "Cuota mensual: S/ \(String(format: "%.2f", monthlyPayment))"
    }
}
