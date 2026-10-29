#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Uso: $0 \"palabra o frase\" \"carpeta\"" >&2
    exit 1
fi

texto="$1"
carpeta="$2"

if [ -z "$texto" ]; then
    echo "Error: la palabra o frase no puede estar vacia." >&2
    exit 1
fi

if [ ! -d "$carpeta" ]; then
    echo "Error: la carpeta no existe." >&2
    exit 1
fi

carpeta_abs=$(CDPATH= cd -- "$carpeta" && pwd -P) || exit 1

# La variable de entorno permite pasar el texto literalmente a awk.
export BUSCADOR_TEXTO="$texto"

while IFS= read -r -d '' archivo; do
    [ -r "$archivo" ] || continue

    cantidad=$(awk '
        BEGIN {
            texto = ENVIRON["BUSCADOR_TEXTO"]
            total = 0
        }
        {
            resto = $0
            while ((posicion = index(resto, texto)) > 0) {
                total++
                resto = substr(resto, posicion + length(texto))
            }
        }
        END {
            print total
        }
    ' "$archivo" 2>/dev/null) || continue

    if [ "$cantidad" -gt 0 ]; then
        printf '%s | Apariciones: %s\n' "$archivo" "$cantidad"
    fi
done < <(find "$carpeta_abs" -type f -print0 2>/dev/null)
