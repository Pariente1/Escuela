import Foundation

// Saldo de la cuenta en pesos enteros (se evita Double para no tener errores de redondeo con dinero)
var saldo = 0

// Muestra un mensaje, lee una línea y la devuelve sin espacios (nil si se acabó la entrada)
func leerLinea(_ mensaje: String) -> String? {
    print(mensaje, terminator: "")
    fflush(stdout)
    guard let texto = readLine() else { return nil }
    return texto.trimmingCharacters(in: .whitespacesAndNewlines)
}

// Pide un monto entero mayor que cero y repite la pregunta hasta que sea válido
func leerMonto(_ mensaje: String) -> Int? {
    while true {
        guard let texto = leerLinea(mensaje) else { return nil }
        if let monto = Int(texto), monto > 0 {
            return monto
        }
        print("Ingresa un numero entero mayor que cero")
    }
}

// Pide una respuesta s/S o n/N y repite la pregunta hasta que sea válida
func leerSiNo(_ mensaje: String) -> Bool {
    while true {
        guard let respuesta = leerLinea(mensaje)?.lowercased() else { return false }
        if respuesta == "s" { return true }
        if respuesta == "n" { return false }
        print("Responde con s/S o n/N")
    }
}

// Muestra las cuatro opciones del menú principal
func mostrarMenu() {
    print("1. Deposito")
    print("2. Retiro")
    print("3. Saldo")
    print("4. Salir")
    print("")
}

// Pregunta si el cliente quiere hacer otra operación (true = volver al menú)
func otraOperacion() -> Bool {
    return leerSiNo("Desea continuar con otra operacion s/S n/N: ")
}

// Opción 1: depósitos repetidos mientras el cliente responda "s"
func depositar() -> Bool {
    var otroDeposito = true
    while otroDeposito {
        guard let monto = leerMonto("Ingresa la cantidad a Depositar: ") else { return false }
        saldo += monto
        otroDeposito = leerSiNo("¿Deseas realizar otro deposito? s/S n/N: ")
    }
    return otraOperacion()
}

// Opción 2: retiros, solo si ya hay dinero en la cuenta
func retirar() -> Bool {
    if saldo == 0 {
        print("No cuentas con saldo")
        return leerSiNo("¿Deseas realizar otra operacion? s/S n/N: ")
    }

    var otroRetiro = true
    while otroRetiro {
        guard let monto = leerMonto("Ingresa cantidad a Retirar: ") else { return false }
        if monto > saldo {
            print("Saldo insuficiente")
        } else {
            saldo -= monto
        }
        otroRetiro = leerSiNo("¿Deseas realizar otro retiro? s/S n/N: ")
    }
    return otraOperacion()
}

// Opción 3: muestra el saldo actual
func consultarSaldo() -> Bool {
    print("Tu saldo actual es: \(saldo)")
    return otraOperacion()
}

// Programa principal: el menú se repite mientras la sesión siga activa
var sesionActiva = true

while sesionActiva {
    mostrarMenu()
    guard let texto = leerLinea("Elige el numero de la opción: ") else { break }
    let opcion = Int(texto) ?? 0

    switch opcion {
    case 1:
        sesionActiva = depositar()
    case 2:
        sesionActiva = retirar()
    case 3:
        sesionActiva = consultarSaldo()
    case 4:
        sesionActiva = false
    default:
        print("Opcion no valida")
    }
}

print("Cerrando sesion de cuenta, vuelva pronto...")
