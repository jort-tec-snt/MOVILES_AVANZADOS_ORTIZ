import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var capitalTextField: UITextField!
    @IBOutlet weak var annualRateTextField: UITextField!
    @IBOutlet weak var yearsTextField: UITextField!
    @IBOutlet weak var monthlyPaymentLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func CalcularPrestamo(_ sender: Any) {
        let capital = Double(capitalTextField.text ?? "") ?? 0
        let annualRate = Double(annualRateTextField.text ?? "") ?? 0
        let years = Double(yearsTextField.text ?? "") ?? 0

        if capital <= 0 || annualRate < 0 || years <= 0 {
            monthlyPaymentLabel.text = "Ingrese valores válidos."
            totalAmountLabel.text = "Monto total"
            return
        }

        let n = years * 12
        let r = (annualRate / 100) / 12

        let monthlyPayment: Double
        if r == 0 {
            monthlyPayment = capital / n
        } else {
            let factor = pow(1 + r, n)
            monthlyPayment = capital * (r * factor) / (factor - 1)
        }

        let totalAmount = monthlyPayment * n

        monthlyPaymentLabel.text = "Cuota mensual: S/ \(String(format: "%.2f", monthlyPayment))"
        totalAmountLabel.text = "Monto total: S/ \(String(format: "%.2f", totalAmount))"
    }
}
