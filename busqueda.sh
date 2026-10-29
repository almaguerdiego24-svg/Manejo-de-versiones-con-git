#!/usr/bin/env bash
# busqueda.sh
# Define la funcion buscar_archivos. Este archivo se carga con:
#   source busqueda.sh
# No ejecuta ninguna busqueda al cargarse.
#
# Uso: buscar_archivos "texto" "carpeta"
# Muestra la ruta absoluta de cada archivo regular que contiene el texto.

buscar_archivos() {
  if [ "$#" -ne 2 ]; then
    printf '%s\n' "buscar_archivos: se requieren 2 argumentos: texto y carpeta" >&2
    return 2
  fi

  local texto="$1"
  local carpeta="$2"
  local carpeta_abs

  if [ -z "$texto" ]; then
    printf '%s\n' "buscar_archivos: el texto a buscar no puede estar vacio" >&2
    return 2
  fi

  if [ ! -d "$carpeta" ]; then
    printf '%s\n' "buscar_archivos: la carpeta no existe: $carpeta" >&2
    return 2
  fi

  # Ruta absoluta calculada en una subshell: no cambia el directorio del programa principal
  carpeta_abs=$(CDPATH= cd -P -- "$carpeta" 2>/dev/null && pwd -P) || {
    printf '%s\n' "buscar_archivos: no se puede acceder a la carpeta: $carpeta" >&2
    return 2
  }

  # -type f: solo archivos regulares (evita dispositivos, tuberias y sockets)
  # -F: busqueda literal   -e: permite textos que empiezan con guion
  # -l: solo nombres de archivo   -s: omite archivos sin permiso
  find "$carpeta_abs" -type f -exec grep -lsF -e "$texto" -- {} + 2>/dev/null

  return 0
}
