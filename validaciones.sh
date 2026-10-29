
#!/bin/bash

# Funcion para validar los argumentos del buscador

validar_argumentos() {

    # Aceptar solamente 1 o 2 argumentos
    if [ $# -lt 1 ] || [ $# -gt 2 ]; then
        echo "Error: debes escribir 1 o 2 argumentos." >&2
        return 1
    fi

    # Verificar que la palabra no este vacia
    if [ -z "$1" ]; then
        echo "Error: la palabra no puede estar vacia." >&2
        return 1
    fi

    # Validar la carpeta cuando se proporciona
    if [ $# -eq 2 ]; then

        if [ -z "$2" ]; then
            echo "Error: la trayectoria esta vacia." >&2
            return 1
        fi

        if [ ! -d "$2" ]; then
            echo "Error: la carpeta no existe." >&2
            return 1
        fi

    fi

    return 0
}

