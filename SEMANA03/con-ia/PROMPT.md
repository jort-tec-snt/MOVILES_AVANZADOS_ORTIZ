# EJERCICIO06 - GESTION DE NOTAS 
[CONTEXTO]
Soy estudiante del curso Programación en Móviles Avanzado (Semana 03) y estoy aprendiendo el uso de colecciones en Swift.

[TAREA]
Desarrolla un programa interactivo en consola usando readLine() que:
1. Pida N alumnos con su nombre y exactamente 3 notas cada uno.
2. Almacene los datos en un diccionario de tipo [String: [Double]].
3. Calcule el promedio por alumno y lo clasifique usando switch (18-20: Excelente, 15-17.99: Bueno, 13-14.99: Aprobado, <13: Desaprobado).
4. Muestre estadísticas generales: promedio del salón, nota más alta, nota más baja y porcentaje de aprobados.
5. Imprima un ranking de alumnos ordenado de mayor a menor promedio.

[RESTRICCIONES]
- Usa únicamente temas de las Semanas 1 a 3 (Arrays, Diccionarios, Sets, Tuplas, Bucle for, switch).
- NO utilices struct, class ni orientación a objetos.

[FORMATO]
Código Swift completo y ejecutable en Playground.

[EJEMPLO DE SALIDA DENTRO DEL CÓDIGO]
Entrada: 2 alumnos ("Ana" con 15.0, 18.0, 16.0 y "Juan" con 10.0, 12.0, 11.0).
Resultado esperado: "Ana - Promedio: 16.33 | Clasificación: Bueno", con sus respectivas estadísticas y el ranking.

# EJERCICIO07 - Inventario con Menu

[CONTEXTO]
Soy estudiante de desarrollo móvil iOS y necesito implementar un sistema de control de inventario utilizando arrays paralelos en Swift.

[TAREA]
Crea un programa en consola que:
1. Solicite registrar N productos iniciales pidiendo: nombre, precio unitario y cantidad en stock.
2. Guarde los datos en tres arrays paralelos: nombres: [String], precios: [Double] y stocks: [Int].
3. Presente un menú interactivo mediante un bucle while que permita:
   - Opción 1: Ver inventario general con precios y stock.
   - Opción 2: Buscar un producto por nombre y mostrar su detalle.
   - Opción 3: Mostrar alertas de productos con stock bajo (< 5 unidades).
   - Opción 4: Calcular el valor total financiero del inventario (precio * stock).
   - Opción 5: Salir del programa.

[RESTRICCIONES]
- Usa exclusivamente sintaxis de las Semanas 1 a 3 (Arrays paralelos, bucle while, switch, readLine()).
- NO uses struct, class ni diccionarios complejos para representar los productos.

[FORMATO]
Código Swift estructurado y ejecutable en Playground de Xcode.

[EJEMPLO DE ESTRUCTURA]
Menú desplegado en consola:
1) Ver inventario
2) Buscar producto
3) Stock bajo (< 5)
4) Valor total
5) Salir
Seleccione una opción (1-5):
