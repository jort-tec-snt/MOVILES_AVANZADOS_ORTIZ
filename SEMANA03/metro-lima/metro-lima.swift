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
    let estaciones: [String];
}

