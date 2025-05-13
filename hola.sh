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

#Opcion1
opcion1(){

read -p "Ingrese ruta de la carpeta: " carpeta
archivos_directos=$(find "$carpeta" -maxdepth 1 -type f | wc -l)
archivos_subcarpetas=$(find "$carpeta" -mindepth 2 -type f | wc -l)
maxfile=$(ls -R -S "$carpeta" | head -n 1)
minfile=$(ls -R -S "$carpeta" | tail -n 1)

echo "resumen de la carpeta: $carpeta"
echo "archivos en la carpeta principal: $archivos_directos"
echo "archivos en subcarpetas: $archivos_subcarpetas"
echo "archivo mas grande: $maxfile"
echo "archivo mas pequenio: $minfile"   

}


#(opción 4)
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

#(opción 5)
opcion5() {
  echo "===== REPORTE DEL SISTEMA ====="
  echo "👤 Usuario actual........: $(whoami)"
  echo "🕓 Fecha y hora actual...: $(date)"
  echo "La PC fue encendida....: $(uptime -s)"
  echo "Nombre del host.......: $(hostname)"
  echo "📂 Directorio actual......: $(pwd)"
  echo "==============================="
}

opcion6(){

read -p "Ingrese la URL: " url
read -p "Ingrese la carpeta de destino: " destino

archivo ="$destino/website.txt"

curl "$url" > "$archivo"

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

  if [ "$seleccion" = "menu" ]; then
    continue
  fi

  if es_valido "$seleccion"; then
    case $seleccion in
      1)
        opcion1
        ;;
      2)
        echo "Opción 2 aún no implementada."
        ;;
      3)
        echo "Opción 3 aún no implementada."
        ;;
      4)
        opcion4
        ;;
      5)
        opcion5
        ;;
      6)
        opcion6
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
