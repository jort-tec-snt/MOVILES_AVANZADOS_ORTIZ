import SwiftUI

// Estilo de la pantalla: colores, espacios y modificadores reutilizables.
// Solo modificadores de apariencia; los controles siguen siendo los de la guía.
enum Estilo {
    static let espacio: CGFloat = 16
    static let radio: CGFloat = 16

    // Colores del sistema: se adaptan solos a modo claro y oscuro.
    static let fondoPantalla = Color(UIColor.systemGroupedBackground)
    static let fondoTarjeta = Color(UIColor.secondarySystemGroupedBackground)
    static let linea = Color.secondary.opacity(0.30)

    // Acentos de cada bloque (decorativos; el título siempre dice qué bloque es).
    static let acentoRemuneraciones = Color(UIColor.systemGreen)
    static let acentoDescuentos = Color(UIColor.systemRed)
    static let acentoEmpleador = Color(UIColor.systemBlue)

    // Azul de marca: encabezado, botón y resumen del neto (texto blanco encima).
    static let degradado = LinearGradient(
        colors: [
            Color(red: 0.07, green: 0.20, blue: 0.50),
            Color(red: 0.10, green: 0.38, blue: 0.62)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

// Tarjeta con esquinas redondeadas y sombra suave.
struct Tarjeta: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(Estilo.espacio)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Estilo.fondoTarjeta)
            .clipShape(RoundedRectangle(cornerRadius: Estilo.radio, style: .continuous))
            .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 2)
    }
}

extension View {
    func tarjeta() -> some View {
        modifier(Tarjeta())
    }

    // Aspecto de un campo: fondo, borde fino y altura táctil de 48 pt.
    func aspectoCampo() -> some View {
        self
            .padding(.horizontal, 12)
            .frame(minHeight: 48)
            .background(Estilo.fondoPantalla)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Estilo.linea, lineWidth: 1)
            )
    }
}

// Botón principal: ancho completo, 52 pt de alto, degradado azul.
struct BotonPrincipal: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 52)
            .background(Estilo.degradado)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .opacity(configuration.isPressed ? 0.85 : 1)
    }
}

extension Decimal {
    // 0.8714 -> "87.1%"
    func formatoPorcentaje(decimales: Int) -> String {
        let formato = NumberFormatter()
        formato.locale = Locale(identifier: "en_US")
        formato.numberStyle = .decimal
        formato.minimumFractionDigits = decimales
        formato.maximumFractionDigits = decimales
        let texto = formato.string(from: (self * 100) as NSDecimalNumber) ?? "0"
        return texto + "%"
    }
}
