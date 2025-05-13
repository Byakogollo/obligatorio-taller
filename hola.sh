#!/bin/sh

# Función para mostrar el menu
mostrar_menu() {
  echo ""
  echo "======= MENU PRINCIPAL ======="
  echo "1 -> Muestra en pantalla resumen de las carpetas ordenadas de mayor tamaño a menor"
  echo "2 -> Renombrar todos los archivos a bck"
  echo "3 -> Muestra un resumen del estado del disco duro"
  echo "4 -> Buscar palabras en los archivos de una carpeta"
  echo "5 -> Mostrar reporte del sistema"
  echo "6 -> URL"
  echo "7 -> Insertar ruta"
  echo "8 -> Salir"
}

opcion2() {
  echo "Directorio:"
  read ruta
  [ "$ruta" = "menu" ] && return
  [ -d "$ruta" ] || { echo "Ruta inválida"; return; }
  for f in "$ruta"/*; do [ -f "$f" ] && mv "$f" "$f.bck"; done
  echo "Archivos renombrados."
}

opcion3() {
  echo "===== ESTADO DEL DISCO ====="
  df -h
}


opcion4() {
  echo "Ingresá la palabra a buscar (o escribi 'menu' para volver):"
  read palabra
  [ "$palabra" = "menu" ] && return

  echo "Ingresa el directorio donde buscar (o escribi 'menu' para volver):"
  read ruta
  [ "$ruta" = "menu" ] && return

  if [ -d "$ruta" ]; then
    echo "Buscando '$palabra' en '$ruta'..."
    grep -rnw "$ruta" -e "$palabra"
  else
    echo "La ruta '$ruta' no es un directorio valido."
  fi
}


opcion5() {
  echo "===== REPORTE DEL SISTEMA ====="
  echo "Usuario........: $(whoami)"
  echo "Fecha actual...: $(date)"
  echo "La PC fue encendida....: $(uptime -s)"
  echo "Nombre del host.......: $(hostname)"
  echo "Directorio......: $(pwd)"
}

# Función para validar si el input es un número del 1 al 8
es_valido() {
  case $1 in
    1|2|3|4|5|6|7|8) return 0 ;;
    *) return 1 ;;
  esac
}

# Bucle principal del programa
while true; do
  mostrar_menu
  echo "Elegí una opción (1-8):"
  read seleccion

  if es_valido "$seleccion"; then
    case $seleccion in
      1)
        echo "Opción 1 aún no implementada."
        ;;
      2)
        opcion2
        ;;
      3)
        opcion3
        ;;
      4)
        opcion4
        ;;
      5)
        opcion5
        ;;
      6)
        echo "Opción 6 aún no implementada."
        ;;
      7)
        echo "Opción 7 aún no implementada."
        ;;
      8)
        echo "Saliendo del programa. ¡Hasta luego!"
        break
        ;;
    esac
  else
    echo "Entrada inválida. Por favor ingresá un número del 1 al 8."
  fi
done
