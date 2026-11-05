//
//  Alumno.swift
//  apple_lab11_02_SwiftUI_SwiftData
//
//  Created by Jeronimo Ortiz on 5/11/26.
//

import Foundation
import SwiftData

// Indicamos que esta clase representa una entidad persistente en la base de datos
@Model
class Alumno {
    var idAlumno: UUID      // Identificador único del alumno
    var apellido: String
    var nombre: String
    var dni: String
    var curso: Curso?       // Relación: un alumno pertenece a un curso (opcional)

    // Constructor que inicializa un nuevo objeto Alumno con los datos proporcionados
    init(idAlumno: UUID = UUID(), apellido: String, nombre: String, dni: String) {
        self.idAlumno = idAlumno
        self.apellido = apellido
        self.nombre = nombre
        self.dni = dni
    }
}
