#!/bin/bash

# Carga las funciones de los otros integrantes.
directorio=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd) || exit 1

source "$directorio/validaciones.sh" || exit 1
source "$directorio/busqueda.sh" || exit 1

# Valida antes de utilizar los argumentos.
validar_argumentos "$@" || exit 1

palabra="$1"
carpeta="${2:-/}"

buscar_archivos "$palabra" "$carpeta"

