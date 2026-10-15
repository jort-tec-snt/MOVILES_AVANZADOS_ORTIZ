import UIKit

struct Cultura {
    let nombre: String
    let region: String
    let periodo: String
    let descripcion: String
    let imagen: String   // nombre del recurso en Assets
    var aportes: [String] = []   // logros o rasgos más importantes
    var sitios: [String] = []    // lugares emblemáticos

    static let todas: [Cultura] = [
        Cultura(nombre: "Caral", region: "Valle de Supe, Lima",
                periodo: "c. 3000 – 1800 a.C.",
                descripcion: "Considerada la civilización más antigua de América (c. 3000 a.C.). Destacó por su arquitectura monumental de pirámides y plazas circulares.",
                imagen: "caral"),
        Cultura(nombre: "Chavín", region: "Áncash",
                periodo: "c. 900 – 200 a.C.",
                descripcion: "Cultura de los Andes centrales (c. 900 a.C.) con centro ceremonial en Chavín de Huántar, conocida por su arte lítico y sus galerías subterráneas.",
                imagen: "chavin"),
        Cultura(nombre: "Paracas", region: "Ica",
                periodo: "c. 700 a.C. – 200 d.C.",
                descripcion: "Famosa por sus mantos bordados de gran complejidad y por sus fardos funerarios hallados en la península de Paracas.",
                imagen: "paracas"),
        Cultura(nombre: "Nazca", region: "Ica",
                periodo: "c. 100 a.C. – 800 d.C.",
                descripcion: "Creadora de las líneas y geoglifos de la pampa de Nazca, además de una cerámica policroma y un ingenioso sistema de acueductos.",
                imagen: "nazca"),
        Cultura(nombre: "Moche", region: "La Libertad y Lambayeque",
                periodo: "c. 100 – 800 d.C.",
                descripcion: "Cultura de la costa norte, destacada por su orfebrería, su cerámica retrato y monumentos como las Huacas del Sol y de la Luna.",
                imagen: "moche"),
        Cultura(nombre: "Inca", region: "Cusco",
                periodo: "c. 1200 – 1533 d.C.",
                descripcion: "Mayor imperio de la América precolombina (s. XV–XVI). Se destacó por su ingeniería, sus caminos (Qhapaq Ñan) y ciudades como Machu Picchu.",
                imagen: "inca")
    ]
}
