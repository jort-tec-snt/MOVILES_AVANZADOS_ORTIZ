import Foundation

class ClienteModel: NSObject {
    var Codigo: Int32
    var Apellido: String
    var Nombre: String
    var Dni: String

    override init() {
        Codigo = 0
        Apellido = ""
        Nombre = ""
        Dni = ""
        super.init()
    }

    init(
        pCodigo: Int32,
        pApellido: String,
        pNombre: String,
        pDni: String
    ) {
        Codigo = pCodigo
        Apellido = pApellido
        Nombre = pNombre
        Dni = pDni
        super.init()
    }
}
