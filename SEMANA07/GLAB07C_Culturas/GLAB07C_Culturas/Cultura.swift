import UIKit

struct Cultura {
    let nombre: String
    let region: String
    let descripcion: String
    let imagen: String   // nombre del recurso en Assets

    static let todas: [Cultura] = [
        Cultura(nombre: "Caral", region: "Valle de Supe, Lima",
                descripcion: "Considerada la civilización más antigua de América (c. 3000 a.C.). Destacó por su arquitectura monumental de pirámides y plazas circulares.",
                imagen: "caral"),
        Cultura(nombre: "Chavín", region: "Áncash",
                descripcion: "Cultura de los Andes centrales (c. 900 a.C.) con centro ceremonial en Chavín de Huántar, conocida por su arte lítico y sus galerías subterráneas.",
                imagen: "chavin"),
        Cultura(nombre: "Paracas", region: "Ica",
                descripcion: "Famosa por sus mantos bordados de gran complejidad y por sus fardos funerarios hallados en la península de Paracas.",
                imagen: "paracas"),
        Cultura(nombre: "Nazca", region: "Ica",
                descripcion: "Creadora de las líneas y geoglifos de la pampa de Nazca, además de una cerámica policroma y un ingenioso sistema de acueductos.",
                imagen: "nazca"),
        Cultura(nombre: "Moche", region: "La Libertad y Lambayeque",
                descripcion: "Cultura de la costa norte, destacada por su orfebrería, su cerámica retrato y monumentos como las Huacas del Sol y de la Luna.",
                imagen: "moche"),
        Cultura(nombre: "Inca", region: "Cusco",
                descripcion: "Mayor imperio de la América precolombina (s. XV–XVI). Se destacó por su ingeniería, sus caminos (Qhapaq Ñan) y ciudades como Machu Picchu.",
                imagen: "inca")
    ]
}
