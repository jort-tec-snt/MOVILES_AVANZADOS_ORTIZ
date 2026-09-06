import Foundation

//Modelo de Datos

struct Estacion {
    let nombre: String
    let ubicacion: String
    let latitud: Double
    let longitud: Double
}

struct LineaMetro {
    let codigo: String;
    let nombre: String;
    let estado: String;
    let origen: String;
    let destino: String;
    let estaciones: [Estacion];
}

// bd mock de la linea de metro

let redMetro: [String: LineaMetro] = [

    // ============================================================
    // LÍNEA 1
    // ============================================================

    "L1": LineaMetro(
        codigo: "L1",
        nombre: "Línea 1 (Verde)",
        estado: "100% Operativa",
        origen: "Villa el Salvador",
        destino: "Bayóvar",
        estaciones: [
            Estacion(
                nombre: "Villa el Salvador",
                ubicacion: "Av. Separadora Industrial con Av. Juan Velasco Alvarado",
                latitud: -12.2071,
                longitud: -76.9424),
            Estacion(
                nombre: "Parque Industrial",
                ubicacion: "Av. Separadora Industrial con Av. El Sol",
                latitud: -12.1972,
                longitud: -76.9419),
            Estacion(
                nombre: "Pumacahua",
                ubicacion: "Av. Unión con Pumacahua (SJM)",
                latitud: -12.1818,
                longitud: -76.9463),
            Estacion(
                nombre: "Villa María",
                ubicacion: "Av. Pachacútec con Av. José Carlos Mariátegui",
                latitud: -12.1706,
                longitud: -76.9535),
            Estacion(
                nombre: "María Auxiliadora",
                ubicacion: "Av. Pachacútec con Av. Manco Cápac",
                latitud: -12.1611,
                longitud: -76.9603),
            Estacion(
                nombre: "San Juan",
                ubicacion: "Av. Los Héroes con Av. Canevaro",
                latitud: -12.1523,
                longitud: -76.9688),
            Estacion(
                nombre: "Atocongo",
                ubicacion: "Av. Los Héroes (Óvalo Atocongo)",
                latitud: -12.1444,
                longitud: -76.9788),
            Estacion(
                nombre: "Jorge Chávez",
                ubicacion: "Av. Tomás Marsano con Av. Jorge Chávez",
                latitud: -12.1384,
                longitud: -76.9912),
            Estacion(
                nombre: "Ayacucho",
                ubicacion: "Av. Tomás Marsano con Av. Ayacucho",
                latitud: -12.1328,
                longitud: -76.9984),
            Estacion(
                nombre: "Cabitos",
                ubicacion: "Av. Aviación (Óvalo Higuereta)",
                latitud: -12.1245,
                longitud: -77.0022),
            Estacion(
                nombre: "Angamos",
                ubicacion: "Av. Aviación con Av. Angamos Este",
                latitud: -12.1114,
                longitud: -77.0033),
            Estacion(
                nombre: "San Borja Sur",
                ubicacion: "Av. Aviación con Av. San Borja Sur",
                latitud: -12.1021,
                longitud: -77.0042),
            Estacion(
                nombre: "La Cultura",
                ubicacion: "Av. Aviación con Av. Javier Prado Este",
                latitud: -12.0872,
                longitud: -77.0053),
            Estacion(
                nombre: "Nicolás Arriola",
                ubicacion: "Av. Aviación con Av. Nicolás Arriola",
                latitud: -12.0792,
                longitud: -77.0062),
            Estacion(
                nombre: "Gamarra",
                ubicacion: "Av. Aviación con Jr. Hipólito Unanue (La Victoria)",
                latitud: -12.0687,
                longitud: -77.0145),
            Estacion(
                nombre: "Miguel Grau",
                ubicacion: "Av. Miguel Grau con Av. Aviación",
                latitud: -12.0575,
                longitud: -77.0152),
            Estacion(
                nombre: "El Ángel",
                ubicacion: "Av. Locumba (Cerca al Cementerio El Ángel)",
                latitud: -12.0468,
                longitud: -77.0089),
            Estacion(
                nombre: "Presbítero Maestro",
                ubicacion: "Av. Locumba (Cerca al Cementerio Presbítero Maestro)",
                latitud: -12.0425,
                longitud: -77.0021),
            Estacion(
                nombre: "Caja de Agua",
                ubicacion: "Av. Próceres de la Independencia (Entrada SJL)",
                latitud: -12.0298,
                longitud: -77.0118),
            Estacion(
                nombre: "Pirámide del Sol",
                ubicacion: "Av. Próceres de la Independencia con Av. Pirámide del Sol",
                latitud: -12.0211,
                longitud: -77.0055),
            Estacion(
                nombre: "Los Jardines",
                ubicacion: "Av. Próceres de la Independencia con Av. Los Jardines",
                latitud: -12.0098,
                longitud: -76.9989),
            Estacion(
                nombre: "Los Postes",
                ubicacion: "Av. Próceres de la Independencia con Av. Los Postes",
                latitud: -11.9995,
                longitud: -76.9914),
            Estacion(
                nombre: "San Carlos",
                ubicacion: "Av. Próceres de la Independencia con Av. El Sol",
                latitud: -11.9892,
                longitud: -76.9835),
            Estacion(
                nombre: "San Martín",
                ubicacion: "Av. Próceres de la Independencia con Av. Canto Grande",
                latitud: -11.9798,
                longitud: -76.9792),
            Estacion(
                nombre: "Santa Rosa",
                ubicacion: "Av. Fernando Wiesse con Av. Santa Rosa",
                latitud: -11.9685,
                longitud: -76.9744),
            Estacion(
                nombre: "Bayóvar",
                ubicacion: "Av. Fernando Wiesse con Av. Héroes de la Cenepa",
                latitud: -11.9472,
                longitud: -76.9691)
        ]
    ),

    // ============================================================
    // LÍNEA 2
    // ============================================================

    "L2": LineaMetro(
        codigo: "L2",
        nombre: "Línea 2 (Amarilla)",
        estado: "En Construcción / Tramo 1A en servicio",
        origen: "Puerto del Callao",
        destino: "Municipalidad de Ate",
        estaciones: [
            Estacion(
                nombre: "Puerto del Callao",
                     ubicacion: "Av. Guardia Chalaca con Plaza Garibaldi",
                     latitud: -12.0581,
                     longitud: -77.1472),
            Estacion(
                nombre: "Buenos Aires",
                ubicacion: "Av. Óscar R. Benavides con Av. Guardia Chalaca",
                latitud: -12.0592,
                longitud: -77.1351),
            Estacion(
                nombre: "Juan Pablo II",
                ubicacion: "Av. Óscar R. Benavides con Av. Juan Pablo II",
                latitud: -12.0569,
                longitud: -77.1235),
            Estacion(
                nombre: "Insurgentes",
                ubicacion: "Av. Óscar R. Benavides con Av. Insurgentes",
                latitud: -12.0578,
                longitud: -77.1118),
            Estacion(
                nombre: "Carmen de la Legua",
                ubicacion: "Av. Óscar R. Benavides con Av. Faucett",
                latitud: -12.0565,
                longitud: -77.0991),
            Estacion(
                nombre: "Óscar R. Benavides",
                ubicacion: "Av. Óscar R. Benavides con Av. Gmo. Dansey",
                latitud: -12.0551,
                longitud: -77.0862),
            Estacion(
                nombre: "San Marcos",
                ubicacion: "Av. Amézaga (Frente a la Univ. San Marcos)",
                latitud: -12.0568,
                longitud: -77.0722),
            Estacion(
                nombre: "Elio",
                ubicacion: "Av. Venezuela con Jr. República de Ecuador",
                latitud: -12.0572,
                longitud: -77.0655),
            Estacion(
                nombre: "La Alborada",
                ubicacion: "Av. Venezuela con Av. La Alborada",
                latitud: -12.0583,
                longitud: -77.0581),
            Estacion(
                nombre: "Tingo María",
                ubicacion: "Av. Venezuela con Av. Tingo María",
                latitud: -12.0594,
                longitud: -77.0512),
            Estacion(
                nombre: "Parque Murillo",
                ubicacion: "Av. Arica con Av. Aguarico (Breña)",
                latitud: -12.0589,
                longitud: -77.0428),
            Estacion(
                nombre: "Plaza Bolognesi",
                ubicacion: "Av. Arica con Jr. Iquique (Plaza Bolognesi)",
                latitud: -12.0581,
                longitud: -77.0361),
            Estacion(
                nombre: "Estación Central",
                ubicacion: "Paseo de los Héroes Navales (Debajo de Av. Grau)",
                latitud: -12.0555,
                longitud: -77.0345),
            Estacion(
                nombre: "Cangallo",
                ubicacion: "Av. 28 de Julio con Jr. Cangallo",
                latitud: -12.0621,
                longitud: -77.0211),
            Estacion(
                nombre: "Plaza Manco Cápac",
                ubicacion: "Av. 28 de Julio (Plaza Manco Cápac)",
                latitud: -12.0645,
                longitud: -77.0189),
            Estacion(
                nombre: "28 de Julio",
                ubicacion: "Av. 28 de Julio con Av. Aviación (Interconexión L1)",
                latitud: -12.0662,
                longitud: -77.0146),
            Estacion(
                nombre: "Nicolás Ayllón",
                ubicacion: "Av. Nicolás Ayllón con Av. Pablo Patrón",
                latitud: -12.0651,
                longitud: -76.9998),
            Estacion(
                nombre: "Circunvalación",
                ubicacion: "Av. Nicolás Ayllón con Av. Circunvalación",
                latitud: -12.0632,
                longitud: -76.9885),
            Estacion(
                nombre: "Nicolás Arriola",
                ubicacion: "Av. Nicolás Ayllón con Av. Nicolás Arriola",
                latitud: -12.0648,
                longitud: -76.9812),
            Estacion(
                nombre: "Evitamiento",
                ubicacion: "Carretera Central con Vía de Evitamiento",
                latitud: -12.0531,
                longitud: -76.9698),
            Estacion(
                nombre: "Óvalo Santa Anita",
                ubicacion: "Carretera Central (Óvalo Santa Anita)",
                latitud: -12.0455,
                longitud: -76.9602),
            Estacion(
                nombre: "Colectora Industrial",
                ubicacion: "Carretera Central con Av. Colectora Industrial",
                latitud: -12.0402,
                longitud: -76.9515),
            Estacion(
                nombre: "La Cultura",
                ubicacion: "Carretera Central con Av. Hermilio Valdizán",
                latitud: -12.0351,
                longitud: -76.9421),
            Estacion(
                nombre: "Mercado Santa Anita",
                ubicacion: "Carretera Central (Frente al Mercado Mayorista)",
                latitud: -12.0315,
                longitud: -76.9348),
            Estacion(
                nombre: "Vista Alegre",
                ubicacion: "Carretera Central con Av. Vista Alegre",
                latitud: -12.0272,
                longitud: -76.9242),
            Estacion(
                nombre: "Prolongación Javier Prado",
                ubicacion: "Carretera Central con Av. Prol. Javier Prado",
                latitud: -12.0221,
                longitud: -76.9118),
            Estacion(
                nombre: "Municipalidad de Ate",
                ubicacion: "Carretera Central (Plaza de Armas de Ate)",
                latitud: -12.0182,
                longitud: -76.9015)
        ]
    ),

    // ============================================================
    // LÍNEA 3
    // ============================================================

    "L3": LineaMetro(
        codigo: "L3",
        nombre: "Línea 3 (Cian)",
        estado: "Proyecto / Expediente Técnico",
        origen: "Comas (El Álamo)",
        destino: "Surco",
        estaciones: [
            Estacion(
                nombre: "Comas",
                ubicacion: "Av. Chillón Trapiche con Av. Micaela Bastidas (El Álamo)",
                latitud: -11.9168,
                longitud: -77.0425),
            Estacion(
                nombre: "Huandoy",
                ubicacion: "Panamericana Norte con Av. Huandoy",
                latitud: -11.9285,
                longitud: -77.0498),
            Estacion(
                nombre: "22 de Agosto",
                ubicacion: "Panamericana Norte con Av. 22 de Agosto",
                latitud: -11.9392,
                longitud: -77.0551),
            Estacion(
                nombre: "Universidad",
                ubicacion: "Panamericana Norte con Av. Universitaria",
                latitud: -11.9515,
                longitud: -77.0594),
            Estacion(
                nombre: "Carlos Izaguirre",
                ubicacion: "Panamericana Norte con Av. Carlos Izaguirre",
                latitud: -11.9912,
                longitud: -77.0621),
            Estacion(
                nombre: "Tomás Valle",
                ubicacion: "Panamericana Norte con Av. Tomás Valle",
                latitud: -12.0062,
                longitud: -77.0612),
            Estacion(
                nombre: "Bartolomé de las Casas",
                ubicacion: "Panamericana Norte con Av. Bartolomé de las Casas",
                latitud: -12.0195,
                longitud: -77.0558),
            Estacion(
                nombre: "José Granda",
                ubicacion: "Av. Zarumilla con Av. José Granda",
                latitud: -12.0289,
                longitud: -77.0489),
            Estacion(
                nombre: "Caquetá",
                ubicacion: "Av. Caquetá con Vía de Evitamiento",
                latitud: -12.0335,
                longitud: -77.0412),
            Estacion(
                nombre: "Pizarro",
                ubicacion: "Prol. Tacna con Av. Pizarro (Rímac)",
                latitud: -12.0381,
                longitud: -77.0348),
            Estacion(
                nombre: "Tacna",
                ubicacion: "Av. Tacna con Av. Nicolás de Piérola",
                latitud: -12.0468,
                longitud: -77.0382),
            Estacion(
                nombre: "Estación Central",
                ubicacion: "Interconexión con Línea 2 y Metropolitano",
                latitud: -12.0555,
                longitud: -77.0345),
            Estacion(
                nombre: "Plaza Bolognesi",
                ubicacion: "Interconexión con Línea 2",
                latitud: -12.0581,
                longitud: -77.0361),
            Estacion(
                nombre: "Estadio Nacional",
                ubicacion: "Av. Paseo de la República (Frente al Estadio)",
                latitud: -12.0665,
                longitud: -77.0332),
            Estacion(
                nombre: "Alejandro Tirado",
                ubicacion: "Av. Arequipa con Av. Alejandro Tirado",
                latitud: -12.0712,
                longitud: -77.0355),
            Estacion(
                nombre: "México",
                ubicacion: "Av. Arequipa con Av. México",
                latitud: -12.0791,
                longitud: -77.0361),
            Estacion(
                nombre: "Manuel Candamo",
                ubicacion: "Av. Arequipa con Av. Manuel Candamo",
                latitud: -12.0845,
                longitud: -77.0364),
            Estacion(
                nombre: "Javier Prado",
                ubicacion: "Av. Arequipa con Av. Javier Prado",
                latitud: -12.0955,
                longitud: -77.0368),
            Estacion(
                nombre: "Conde de Lince",
                ubicacion: "Av. Arequipa con Av. Dos de Mayo",
                latitud: -12.0911,
                longitud: -77.0365),
            Estacion(
                nombre: "Andrés Reyes",
                ubicacion: "Av. Paseo de la República con Av. Andrés Reyes",
                latitud: -12.0942,
                longitud: -77.0321),
            Estacion(
                nombre: "Benavides",
                ubicacion: "Av. Larco con Av. Alfredo Benavides (Miraflores)",
                latitud: -12.1265,
                longitud: -77.0298),
            Estacion(
                nombre: "Cabitos",
                ubicacion: "Interconexión con Línea 1 (Óvalo Higuereta)",
                latitud: -12.1245,
                longitud: -77.0022),
            Estacion(
                nombre: "Surco",
                ubicacion: "Av. Tomás Marsano con Av. Próceres",
                latitud: -12.1412,
                longitud: -76.9915)
        ]
    ),

    // ============================================================
    // LÍNEA 4
    // ============================================================

    "L4": LineaMetro(
        codigo: "L4",
        nombre: "Línea 4 (Roja)",
        estado: "Ramal Faucett en Construcción / Tramo Principal en Proyecto",
        origen: "Gambetta",
        destino: "Cincuentenario",
        estaciones: [
            Estacion(
                nombre: "Gambetta",
                ubicacion: "Av. Elmer Faucett con Av. Néstor Gambetta",
                latitud: -11.9615,
                longitud: -77.1212),
            Estacion(
                nombre: "Cantolao",
                ubicacion: "Av. Elmer Faucett con Av. Alejandro Bocanegra",
                latitud: -11.9752,
                longitud: -77.1165),
            Estacion(
                nombre: "Bocanegra",
                ubicacion: "Av. Elmer Faucett con Av. Quilca",
                latitud: -12.0121,
                longitud: -77.1105),
            Estacion(
                nombre: "Aeropuerto",
                ubicacion: "Av. Elmer Faucett (Frente al Aeropuerto Jorge Chávez)",
                latitud: -12.0215,
                longitud: -77.1082),
            Estacion(
                nombre: "El Muelle",
                ubicacion: "Av. Elmer Faucett con Av. El Muelle",
                latitud: -12.0312,
                longitud: -77.1041),
            Estacion(
                nombre: "Morales Duárez",
                ubicacion: "Av. Elmer Faucett con Av. Morales Duárez",
                latitud: -12.0421,
                longitud: -77.1012),
            Estacion(
                nombre: "Carmen de la Legua",
                ubicacion: "Interconexión con Línea 2 (Faucett con Colonial)",
                latitud: -12.0565,
                longitud: -77.0991),
            Estacion(
                nombre: "Elmer Faucett",
                ubicacion: "Av. Elmer Faucett con Av. Venezuela",
                latitud: -12.0655,
                longitud: -77.0915),
            Estacion(
                nombre: "Arica",
                ubicacion: "Av. La Marina con Av. Arica",
                latitud: -12.0711,
                longitud: -77.0882),
            Estacion(
                nombre: "La Marina",
                ubicacion: "Av. La Marina con Av. Universitaria",
                latitud: -12.0734,
                longitud: -77.0805),
            Estacion(
                nombre: "San Marcos",
                ubicacion: "Av. La Marina con Av. Carlos Izaguirre",
                latitud: -12.0755,
                longitud: -77.0721),
            Estacion(
                nombre: "Universitaria",
                ubicacion: "Av. Faustino Sánchez Carrión con Av. Universitaria",
                latitud: -12.0812,
                longitud: -77.0655),
            Estacion(
                nombre: "Brasil",
                ubicacion: "Av. Faustino Sánchez Carrión con Av. Brasil",
                latitud: -12.0885,
                longitud: -77.0542),
            Estacion(
                nombre: "Salaverry",
                ubicacion: "Av. Felipe Salaverry con Av. J. Aliaga",
                latitud: -12.0935,
                longitud: -77.0498),
            Estacion(
                nombre: "Arequipa",
                ubicacion: "Av. Javier Prado Oeste con Av. Arequipa",
                latitud: -12.0955,
                longitud: -77.0368),
            Estacion(
                nombre: "La Cultura",
                ubicacion: "Interconexión con Línea 1 (Aviación con Javier Prado)",
                latitud: -12.0872,
                longitud: -77.0053),
            Estacion(
                nombre: "Cincuentenario",
                ubicacion: "Av. Javier Prado Este con Av. Circunvalación",
                latitud: -12.0815,
                longitud: -76.9798)
        ]
    ),

    // ============================================================
    // LÍNEA 5
    // ============================================================

    "L5": LineaMetro(
        codigo: "L5",
        nombre: "Línea 5 (Magenta)",
        estado: "Planificación / Proyecto Red Básica (Horizonte 2045)",
        origen: "Barranco (Sáenz Peña)",
        destino: "Chorrillos (Los Cóndores)",
        estaciones: [
            Estacion(
                nombre: "Sáenz Peña",
                ubicacion: "Av. Grau con Av. Sáenz Peña (Barranco)",
                latitud: -12.1486,
                longitud: -77.0219),
            Estacion(
                nombre: "Alejandro Iglesias",
                ubicacion: "Av. Alejandro Iglesias con Av. Escuela Militar",
                latitud: -12.1583,
                longitud: -77.0231),
            Estacion(
                nombre: "Matellini",
                ubicacion: "Av. Ariosto Matellini con Av. Paseo de la República",
                latitud: -12.1678,
                longitud: -77.0189),
            Estacion(
                nombre: "Los Cóndores",
                ubicacion: "Av. Defensores del Morro con Av. Confraternidad",
                latitud: -12.1812,
                longitud: -77.0125)
        ]
    ),

    // ============================================================
    // LÍNEA 6
    // ============================================================

    "L6": LineaMetro(
        codigo: "L6",
        nombre: "Línea 6 (Naranja)",
        estado: "Planificación / Proyecto Red Básica (Horizonte 2045)",
        origen: "Independencia (Naranjal)",
        destino: "Surco / La Molina (Primavera)",
        estaciones: [
            Estacion(
                nombre: "Naranjal",
                ubicacion: "Av. Túpac Amaru (Conexión Metropolitano)",
                latitud: -11.9801,
                longitud: -77.0592),
            Estacion(
                nombre: "Antúnez de Mayolo",
                ubicacion: "Av. Universitaria con Av. Antúnez de Mayolo",
                latitud: -11.9925,
                longitud: -77.0784),
            Estacion(
                nombre: "La Marina",
                ubicacion: "Av. Universitaria con Av. La Marina",
                latitud: -12.0734,
                longitud: -77.0805),
            Estacion(
                nombre: "Ejército",
                ubicacion: "Av. Pérez Araníbar (Ex Ejército) - San Isidro",
                latitud: -12.1121,
                longitud: -77.0510),
            Estacion(
                nombre: "Cruces Angamos",
                ubicacion: "Av. Angamos con Av. Arequipa",
                latitud: -12.1114,
                longitud: -77.0302),
            Estacion(
                nombre: "Primavera",
                ubicacion: "Av. Primavera - San Borja / Surco",
                latitud: -12.1068,
                longitud: -76.9842)
        ]
    )
]

//RF01 - CATALOGO GENERAL

/// Muestra todas las líneas registradas en la red.
func ejecutarRF01_Catalogo() {

    print("\n==================================================")
    print("   [RF01] CATÁLOGO GENERAL DE LA RED METRO")
    print("==================================================")

    for (codigo, linea) in redMetro.sorted(by: { $0.key < $1.key }) {

        print("""
        • [\(codigo)] \(linea.nombre)
          ├── Estado: \(linea.estado)
          ├── Origen: \(linea.origen)
          ├── Destino: \(linea.destino)
          └── Estaciones: \(linea.estaciones.count)
        --------------------------------------------------
        """)
    }
}

ejecutarRF01_Catalogo()

// RF02 - DETALLE DE ESTACIONES
/// Permite consultar las estaciones pertenecientes a una línea.
func ejecutarRF02_DetalleEstaciones() {

    print("\nIngrese el código de la línea:", terminator: " ")

    let entrada = (readLine() ?? "")
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .uppercased()

    guard let linea = redMetro[entrada] else {
        print("\n⚠️ La línea '\(entrada)' no existe en la red.")
        return
    }

    print("\n==================================================")
    print("   [RF02] ESTACIONES DE \(linea.nombre.uppercased())")
    print("==================================================")

    for (index, estacion) in linea.estaciones.enumerated() {

        print("""
        \(String(format: "%02d", index + 1)). \(estacion.nombre)
            📍 \(estacion.ubicacion)
        """)
    }

    print("--------------------------------------------------")
    print("Total de estaciones: \(linea.estaciones.count)")
}

ejecutarRF02_DetalleEstaciones()
