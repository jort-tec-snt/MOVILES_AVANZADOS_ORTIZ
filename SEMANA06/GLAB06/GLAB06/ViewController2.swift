import UIKit

class ViewController2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark

        let cobre = UIColor(red: 0.925, green: 0.733, blue: 0.486, alpha: 1)
        let texto = UIColor(red: 0.961, green: 0.945, blue: 0.910, alpha: 1)
        let barra = UINavigationBarAppearance()
        barra.configureWithOpaqueBackground()
        barra.backgroundColor = UIColor(red: 0.082, green: 0.106, blue: 0.122, alpha: 1)
        barra.titleTextAttributes = [.foregroundColor: texto]
        barra.shadowColor = cobre.withAlphaComponent(0.3)
        navigationItem.standardAppearance = barra
        navigationItem.scrollEdgeAppearance = barra
        navigationItem.compactAppearance = barra
        navigationController?.navigationBar.tintColor = cobre
    }
}
