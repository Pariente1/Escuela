// Artículo de la tienda: nombre, precio y stock disponible.
struct Articulo {
    let nombre: String
    let precio: Int
    var stock: Int
}

// Catálogo inicial de la boutique.
var articulos = [
    Articulo(nombre: "Zapatos", precio: 250, stock: 150),
    Articulo(nombre: "Playeras", precio: 100, stock: 700),
    Articulo(nombre: "Pantalones", precio: 200, stock: 20),
    Articulo(nombre: "Sombreros", precio: 300, stock: 100)
]

func mostrarArticulos() {
    print("------ Artículos ------")
    for (indice, articulo) in articulos.enumerated() {
        print("_______________")
        print("Opción: \(indice + 1)")
        print("Artículo: \(articulo.nombre)")
        print("Precio: \(articulo.precio)")
        print("Stock: \(articulo.stock)")
    }
    print("_______________")
}

func leerEntero(_ mensaje: String) -> Int? {
    print(mensaje)
    guard let texto = readLine() else { return nil }

    let partes = texto.split(whereSeparator: { $0.isWhitespace })
    guard partes.count == 1 else { return nil }
    return Int(partes[0])
}

func comprar() {
    guard let numero = leerEntero("Ingrese el número de artículo a comprar: "),
          numero >= 1, numero <= articulos.count else {
        print("Artículo no válido")
        return
    }

    let indice = numero - 1
    guard articulos[indice].stock > 0 else {
        print("Artículo agotado. No hay stock disponible")
        return
    }

    guard let cantidad = leerEntero("Ingrese la cantidad de artículos que desea comprar: "),
          cantidad > 0 else {
        print("Cantidad no válida")
        return
    }

    guard cantidad <= articulos[indice].stock else {
        print("No hay suficiente stock, lo sentimos")
        return
    }

    articulos[indice].stock -= cantidad
    let total = articulos[indice].precio * cantidad

    print("==============================")
    print("Usted ha comprado \(numero). \(articulos[indice].nombre) X \(cantidad)")
    print("Total: \(total)")
}

tiendaLoop: while true {
    mostrarArticulos()
    print("1. Comprar artículo")
    print("2. Salir")

    guard let opcion = leerEntero("Seleccione una opción: ") else {
        print("Entrada no válida")
        continue
    }

    switch opcion {
    case 1:
        comprar()
    case 2:
        print("Gracias por su visita")
        break tiendaLoop
    default:
        print("Opción no válida")
    }
}
