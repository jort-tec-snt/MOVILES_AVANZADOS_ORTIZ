class Cliente {
    let codigo: String
    let direccion: String
    let fechaDeRegistro: String
    let numeroCuenta: String
    let montoMinimoApertura: Double

    init(
        codigo: String,
        direccion: String,
        fechaDeRegistro: String,
        numeroCuenta: String,
        montoMinimoApertura: Double
    ) {
        self.codigo = codigo
        self.direccion = direccion
        self.fechaDeRegistro = fechaDeRegistro
        self.numeroCuenta = numeroCuenta
        self.montoMinimoApertura = montoMinimoApertura
    }

    func mostrarDatos() {
        print("Codigo: \(codigo)")
        print("Direccion: \(direccion)")
        print("Fecha de registro: \(fechaDeRegistro)")
        print("Numero de cuenta: \(numeroCuenta)")
        print("Monto minimo de apertura: S/ \(montoMinimoApertura)")
    }
}

class ClienteNatural: Cliente {
    let nombreCompleto: String
    let dni: String

    init(
        nombreCompleto: String,
        dni: String,
        codigo: String,
        direccion: String,
        fechaDeRegistro: String,
        numeroCuenta: String,
        montoMinimoApertura: Double
    ) {
        self.nombreCompleto = nombreCompleto
        self.dni = dni
        super.init(
            codigo: codigo,
            direccion: direccion,
            fechaDeRegistro: fechaDeRegistro,
            numeroCuenta: numeroCuenta,
            montoMinimoApertura: montoMinimoApertura
        )
    }

    override func mostrarDatos() {
        print("===== CLIENTE NATURAL =====")
        print("Nombre: \(nombreCompleto)")
        print("DNI: \(dni)")
        super.mostrarDatos()
    }
}

class ClienteJuridico: Cliente {
    let razonSocial: String
    let ruc: String
    let representanteLegal: String

    init(
        razonSocial: String,
        ruc: String,
        representanteLegal: String,
        codigo: String,
        direccion: String,
        fechaDeRegistro: String,
        numeroCuenta: String,
        montoMinimoApertura: Double
    ) {
        self.razonSocial = razonSocial
        self.ruc = ruc
        self.representanteLegal = representanteLegal
        super.init(
            codigo: codigo,
            direccion: direccion,
            fechaDeRegistro: fechaDeRegistro,
            numeroCuenta: numeroCuenta,
            montoMinimoApertura: montoMinimoApertura
        )
    }

    override func mostrarDatos() {
        print("===== CLIENTE JURIDICO =====")
        print("Razon social: \(razonSocial)")
        print("RUC: \(ruc)")
        print("Representante legal: \(representanteLegal)")
        super.mostrarDatos()
    }
}

let clientes: [Cliente] = [
    ClienteNatural(
        nombreCompleto: "Luis Ramirez Soto",
        dni: "45678912",
        codigo: "CN001",
        direccion: "Av. Los Heroes 123",
        fechaDeRegistro: "2026-09-14",
        numeroCuenta: "001-123456",
        montoMinimoApertura: 100.0
    ),
    ClienteJuridico(
        razonSocial: "Servicios Andinos SAC",
        ruc: "20601234567",
        representanteLegal: "Maria Lopez Vega",
        codigo: "CJ001",
        direccion: "Jr. Comercio 456",
        fechaDeRegistro: "2026-09-14",
        numeroCuenta: "002-987654",
        montoMinimoApertura: 1000.0
    )
]

for cliente in clientes {
    cliente.mostrarDatos()
    print("")
}
