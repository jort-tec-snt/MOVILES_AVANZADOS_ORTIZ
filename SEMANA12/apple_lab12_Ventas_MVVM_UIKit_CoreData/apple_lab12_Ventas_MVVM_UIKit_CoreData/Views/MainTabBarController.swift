//
//  MainTabBarController.swift
//  apple_lab12_Ventas_MVVM_UIKit_CoreData
//
//  Grupo A · Ventas (UIKit + Core Data)
//

import UIKit

/// Pestañas según el rol de la sesión.
/// Vendedor: Productos, Clientes, Venta, Mis ventas, Cuenta.
/// Supervisor: Resumen, Ventas, Productos, Clientes, Cuenta.
final class MainTabBarController: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)
        if Sesion.shared.esSupervisor {
            viewControllers = [
                pestaña(ResumenViewController(), "Resumen", "chart.bar.xaxis"),
                pestaña(VentasViewController(modo: .supervisor), "Ventas", "list.bullet.rectangle"),
                pestaña(ProductosViewController(), "Productos", "shippingbox"),
                pestaña(ClientesViewController(), "Clientes", "person.2"),
                pestaña(CuentaViewController(), "Cuenta", "person.crop.circle"),
            ]
        } else {
            viewControllers = [
                pestaña(ProductosViewController(), "Productos", "shippingbox"),
                pestaña(ClientesViewController(), "Clientes", "person.2"),
                pestaña(NuevaVentaViewController(), "Venta", "cart"),
                pestaña(VentasViewController(modo: .vendedor), "Mis ventas", "receipt"),
                pestaña(CuentaViewController(), "Cuenta", "person.crop.circle"),
            ]
        }
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) no se usa") }

    private func pestaña(_ vc: UIViewController, _ titulo: String, _ icono: String) -> UINavigationController {
        vc.title = titulo
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem = UITabBarItem(title: titulo, image: UIImage(systemName: icono), selectedImage: nil)
        return nav
    }
}
