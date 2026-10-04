# Control de entrega y verificación - Semana 06

**Rama final:** `con-ia`

**Proyecto:** `SEMANA06/GLAB06/GLAB06.xcodeproj`
**Interfaz principal:** `GLAB06/Base.lproj/Main.storyboard`

## Requisitos verificados

- [x] UIKit y Storyboard real enlazado desde `Info.plist`.
- [x] `UINavigationController` como raíz; Pantalla 1 y Pantalla 2 conectadas con segue `Show`.
- [x] `ClienteModel`, formulario de apellido, nombre y DNI, y presentación modal de `ViewControllerConfirmacion`.
- [x] Rediseño visual con Auto Layout, tarjetas, `UIStackView`, SF Symbols y colores semánticos.
- [x] Nueva Venta con cinco `UITextField` y botón Calcular.
- [x] `VentaModel: NSObject` con seis propiedades `Double`.
- [x] Resultado con seis valores monetarios `UILabel`, formato `String(format: "S/. %.2f", valor)`.
- [x] Segue `Show` con identifier `showResultado` y transferencia mediante `prepare(for:sender:)`.
- [x] Fórmulas de subtotal, IGV de 18 %, base, intereses, total y cuota.
- [x] Validación de precio, cantidad y meses mayores que cero; tasa no negativa.
- [x] `README.md` y `PROMPTS.md` actualizados; conclusiones académicas incluidas.
- [x] Compilación CLI con `** BUILD SUCCEEDED **`.
- [x] Inicio de la app y captura de Pantalla 1 en el iPhone 17e autorizado (`AEA85E68-4EB4-4FDD-8291-2BBBC84B33F4`).

## Caso numérico de control

Para Laptop, precio unitario 3500, cantidad 1, 12 meses e interés mensual de 1 %:

| Valor | Resultado |
|---|---:|
| Subtotal | S/. 3500.00 |
| IGV | S/. 630.00 |
| Monto base | S/. 4130.00 |
| Intereses totales | S/. 495.60 |
| Total a pagar | S/. 4625.60 |
| Cuota mensual | S/. 385.47 |

## Pendiente real

El catálogo `Assets.xcassets/AppIcon.appiconset` solo contiene `Contents.json`, sin imagen personalizada. Se requiere un recurso gráfico del proyecto para completar el icono. No se hizo push.

La captura se guardó temporalmente fuera del repositorio. No se registró una prueba interactiva completa de navegación; se verificaron las conexiones y escenas mediante Storyboard, compilación y auditoría de código.
