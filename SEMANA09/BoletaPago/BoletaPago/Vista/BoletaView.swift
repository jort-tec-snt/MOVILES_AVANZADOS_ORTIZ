import SwiftUI

// Resultado: neto destacado arriba y la boleta con sus tres bloques, como en papel.
struct BoletaView: View {
    let boleta: Boleta

    var body: some View {
        VStack(spacing: Estilo.espacio) {
            resumenNeto

            VStack(alignment: .leading, spacing: 14) {
                Text("BOLETA DE EJEMPLO")
                    .font(.caption)
                    .fontWeight(.bold)
                    .tracking(1)
                    .foregroundStyle(.secondary)

                bloque("REMUNERACIONES", acento: Estilo.acentoRemuneraciones) {
                    fila(boleta.remuneraciones[0])
                    fila(boleta.remuneraciones[1])
                    fila(boleta.remuneraciones[2])
                    fila(boleta.remuneraciones[3])
                    total("Total remuneraciones", boleta.totalRemuneraciones, id: "total-remuneraciones")
                }

                bloque("RETENCIONES / DESCUENTOS", acento: Estilo.acentoDescuentos) {
                    fila(boleta.descuentos[0])
                    fila(boleta.descuentos[1])
                    fila(boleta.descuentos[2])
                    fila(boleta.descuentos[3])
                    fila(boleta.descuentos[4])
                    total("Total descuentos", boleta.totalDescuentos, id: "total-descuentos")
                }

                bloque("APORTACIONES DEL EMPLEADOR", acento: Estilo.acentoEmpleador) {
                    fila(boleta.aportaciones[0])
                    Text("Lo paga la empresa; no se resta al trabajador.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .tarjeta()
        }
        .padding(.top, 4)
    }

    // Tarjeta azul con el neto y qué parte de las remuneraciones llega al trabajador.
    private var resumenNeto: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("NETO A PAGAR")
                .font(.caption)
                .fontWeight(.semibold)
                .tracking(1)
                .opacity(0.85)

            Text("S/ " + boleta.netoAPagar.formatoSoles())
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .accessibilityIdentifier("neto")

            Text(textoPorcentaje)
                .font(.footnote)
                .opacity(0.9)
        }
        .foregroundStyle(.white)
        .padding(Estilo.espacio * 1.25)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Estilo.degradado)
        .clipShape(RoundedRectangle(cornerRadius: Estilo.radio, style: .continuous))
    }

    private var textoPorcentaje: String {
        if boleta.totalRemuneraciones <= 0 {
            return "Sin remuneraciones en el mes."
        }
        let fraccion = boleta.netoAPagar / boleta.totalRemuneraciones
        return "Llega al trabajador el " + fraccion.formatoPorcentaje(decimales: 1) + " de las remuneraciones."
    }

    // Un bloque de la boleta: línea fina arriba, título con franja de color y sus filas.
    private func bloque<Contenido: View>(_ titulo: String, acento: Color, @ViewBuilder contenido: () -> Contenido) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                acento
                    .frame(width: 4, height: 16)
                    .clipShape(RoundedRectangle(cornerRadius: 2))
                Text(titulo)
                    .font(.footnote)
                    .fontWeight(.bold)
                    .tracking(0.8)
                    .foregroundStyle(.secondary)
            }
            contenido()
        }
        .padding(.top, 14)
        .overlay(alignment: .top) {
            Estilo.linea.frame(height: 1)
        }
    }

    // Los conceptos que no aplican se muestran con 0.00 y más tenues, como en la boleta real.
    private func fila(_ concepto: Concepto) -> some View {
        HStack {
            Text(concepto.nombre).frame(maxWidth: .infinity, alignment: .leading)
            Text(concepto.monto.formatoSoles()).monospacedDigit()
                .accessibilityIdentifier("monto-" + concepto.nombre)
        }
        .foregroundStyle(concepto.monto == 0 ? Color.secondary : Color.primary)
    }

    private func total(_ nombre: String, _ monto: Decimal, id: String) -> some View {
        HStack {
            Text(nombre).frame(maxWidth: .infinity, alignment: .leading)
            Text("S/ " + monto.formatoSoles()).monospacedDigit()
                .accessibilityIdentifier(id)
        }
        .fontWeight(.bold)
        .padding(.top, 6)
        .overlay(alignment: .top) {
            Estilo.linea.frame(height: 1)
        }
    }
}

extension BoletaView {
    // Caso 3 de la guía, solo para las previews.
    static func ejemploCaso3() -> Boleta {
        let datos = DatosBoleta(
            sueldoBasico: 3000, diasLaborados: 30, tieneHijos: true,
            sistema: .afp, nombreAFP: "AFP Ejemplo",
            horasExtras25: 4, horasExtras35: 4, adelantos: 200
        )
        let boleta = Boleta(datos: datos)
        boleta.calcular()
        return boleta
    }
}

#Preview("Caso 3") {
    ScrollView {
        BoletaView(boleta: BoletaView.ejemploCaso3()).padding()
    }
    .background(Estilo.fondoPantalla)
}

#Preview("Caso 3 - oscuro, texto grande") {
    ScrollView {
        BoletaView(boleta: BoletaView.ejemploCaso3()).padding()
    }
    .background(Estilo.fondoPantalla)
    .preferredColorScheme(.dark)
    .dynamicTypeSize(.xxxLarge)
}
