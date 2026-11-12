//
//  SceneDelegate.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (UIKit + Core Data)
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        Navegacion.window = window
        // Pantalla inicial: siempre el login (la sesión vive solo mientras la app está abierta)
        Navegacion.mostrarLogin()
        window.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

/// Cambia la pantalla raíz: login o app con pestañas según el rol.
enum Navegacion {
    static weak var window: UIWindow?

    static func mostrarLogin() {
        cambiarRaiz(UINavigationController(rootViewController: LoginViewController()))
    }

    static func mostrarApp() {
        cambiarRaiz(MainTabBarController())
    }

    private static func cambiarRaiz(_ vc: UIViewController) {
        guard let window = window else { return }
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {
            window.rootViewController = vc
        }
    }
}
