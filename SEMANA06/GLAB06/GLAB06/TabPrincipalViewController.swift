// Desarrollado por: Jeronimo Ortiz
import UIKit

// Barra de pestañas principal: une la tienda con las pantallas de las prácticas anteriores
class TabPrincipalViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        let apariencia = UITabBarAppearance()
        apariencia.configureWithOpaqueBackground()
        apariencia.backgroundColor = UIColor(red: 0.082, green: 0.106, blue: 0.122, alpha: 1)
        tabBar.standardAppearance = apariencia
        tabBar.scrollEdgeAppearance = apariencia
        tabBar.tintColor = UIColor(red: 0.925, green: 0.733, blue: 0.486, alpha: 1)
        tabBar.unselectedItemTintColor = UIColor(red: 0.753, green: 0.722, blue: 0.675, alpha: 1)
    }
}
