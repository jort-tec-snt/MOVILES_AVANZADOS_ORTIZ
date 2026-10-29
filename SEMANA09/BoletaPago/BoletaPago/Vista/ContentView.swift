import SwiftUI
import UIKit

// Una pantalla y los controles de la guía. El cálculo vive en el modelo.
struct ContentView: View {
    @State private var sueldo = ""
    @State private var dias = ""
    @State private var tieneHijos = false
    @State private var sistema = SistemaPension.onp
    @State private var afp = "AFP Ejemplo"
    @State private var horasExtras25 = ""
    @State private var horasExtras35 = ""
    @State private var adelantos = ""
    @State private var mensajeError: String?
    @State private var boleta: Boleta?

    var body: some View {
        ScrollView {
            VStack(spacing: Estilo.espacio) {
                encabezado

                seccion("Datos del mes") {
                    campo("Sueldo básico", prefijo: "S/", texto: $sueldo)
                    campo("Días laborados (1 a 30)", prefijo: nil, texto: $dias, entero: true)
                    etiqueta("¿Tiene hijos?")
                    Picker("¿Tiene hijos?", selection: $tieneHijos) {
                        Text("No").tag(false)
                        Text("Sí").tag(true)
                    }
                    .pickerStyle(.segmented)
                    .accessibilityIdentifier("hijos")
                }

                seccion("Sistema de pensiones") {
                    Picker("Sistema de pensiones", selection: $sistema) {
                        Text("ONP").tag(SistemaPension.onp)
                        Text("AFP").tag(SistemaPension.afp)
                    }
                    .pickerStyle(.segmented)
                    .accessibilityIdentifier("pension")

                    // Solo aparece si eligió AFP
                    if sistema == .afp {
                        etiqueta("AFP")
                        Picker("AFP", selection: $afp) {
                            Text("AFP Ejemplo").tag("AFP Ejemplo")
                            Text("Habitat").tag("Habitat")
                            Text("Integra").tag("Integra")
                            Text("Prima").tag("Prima")
                            Text("Profuturo").tag("Profuturo")
                        }
                        .pickerStyle(.menu)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .aspectoCampo()
                        .accessibilityIdentifier("afp")
                        Text("Comisión sobre flujo. AFP Ejemplo corresponde a los casos de la guía.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    } else {
                        Text("ONP: 13% del total de remuneraciones.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }

                seccion("Pagos adicionales") {
                    campo("Horas extras al 25%", prefijo: nil, texto: $horasExtras25)
                    campo("Horas extras al 35%", prefijo: nil, texto: $horasExtras35)
                    campo("Adelantos", prefijo: "S/", texto: $adelantos)
                }

                Button("Calcular boleta") { calcular() }
                    .buttonStyle(BotonPrincipal())
                    .accessibilityIdentifier("calcular")

                if let mensajeError = mensajeError {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Revisa los datos")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Text(mensajeError)
                            .font(.subheadline)
                            .accessibilityIdentifier("error-validacion")
                    }
                    .foregroundStyle(Color(UIColor.systemRed))
                    .padding(Estilo.espacio)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(UIColor.systemRed).opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }

                if let boleta = boleta {
                    BoletaView(boleta: boleta)
                }
            }
            .padding(Estilo.espacio)
        }
        .scrollDismissesKeyboard(.interactively)
        .clipped()
        .background(Estilo.fondoPantalla.ignoresSafeArea())
    }

    // MARK: - Piezas de la pantalla

    private var encabezado: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("BOLETA DE EJEMPLO")
                .font(.caption2)
                .fontWeight(.bold)
                .tracking(1)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Color.white.opacity(0.2))
                .clipShape(Capsule())
            Text("Boleta de pago")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Datos ficticios · Montos en soles")
                .font(.subheadline)
                .opacity(0.9)
        }
        .foregroundStyle(.white)
        .padding(Estilo.espacio * 1.25)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Estilo.degradado)
        .clipShape(RoundedRectangle(cornerRadius: Estilo.radio, style: .continuous))
    }

    private func seccion<Contenido: View>(_ titulo: String, @ViewBuilder contenido: () -> Contenido) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(titulo).font(.headline)
            contenido()
        }
        .tarjeta()
    }

    private func etiqueta(_ titulo: String) -> some View {
        Text(titulo)
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundStyle(.secondary)
    }

    private func campo(_ nombre: String, prefijo: String?, texto: Binding<String>, entero: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            etiqueta(nombre)
            HStack(spacing: 8) {
                if let prefijo = prefijo {
                    Text(prefijo).foregroundStyle(.secondary)
                }
                TextField("0", text: texto)
                    .keyboardType(entero ? .numberPad : .decimalPad)
                    .accessibilityLabel(nombre)
                    .accessibilityIdentifier(nombre)
            }
            .aspectoCampo()
        }
    }

    // MARK: - Acción

    private func calcular() {
        // El teclado decimal no tiene Return: se cierra al calcular para leer la boleta.
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        let formulario = FormularioBoleta(
            sueldo: sueldo, dias: dias, tieneHijos: tieneHijos,
            sistema: sistema, afp: afp, horasExtras25: horasExtras25,
            horasExtras35: horasExtras35, adelantos: adelantos
        )
        switch formulario.validar() {
        case .failure(let error):
            mensajeError = error.mensaje
            boleta = nil
        case .success(let datos):
            mensajeError = nil
            let nueva = Boleta(datos: datos)
            nueva.calcular()
            boleta = nueva
        }
    }
}

#Preview("Claro") { ContentView() }

#Preview("Oscuro, texto grande") {
    ContentView()
        .preferredColorScheme(.dark)
        .dynamicTypeSize(.xxxLarge)
}
