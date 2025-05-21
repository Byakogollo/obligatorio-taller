#!/bin/sh

mostrar_menu() {
  echo ""
  echo "======= MENU PRINCIPAL ======="
  echo "1 -> Muestra en pantalla resumen de las carpetas ordenadas de mayor tamaño a menor"
  echo "2 -> Renombrar todos los archivos a bck"
  echo "3 -> Muestra un resumen del estado del disco duro"
  echo "4 -> Buscar palabras en los archivos de una carpeta"
  echo "5 -> Mostrar reporte del sistema"
  echo "6 -> Ingrese una URL"
  echo "7 -> Insertar ruta para el resto de las opciones"
  echo "8 -> Salir"
}

opcion1(){

if [ -n "$ruta7" ]; then
    echo "Utilizando \"$ruta7\" como objetivo"
    echo "================================="
    carpeta="$ruta7"
else
    read -p "Ingrese ruta de la carpeta o ingrese '8' para volver: " carpeta

fi
  [ "$carpeta" = "8" ] && return
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


opcion2() {

  if [ -n "$ruta7" ]; then
    echo "Utilizando "$ruta7" como objetivo"
    echo "=======
    =========================="
    ruta="$ruta7"
  else
    read -p "Ingrese un directorio o ingrese 8 para volver " ruta
  fi
  [ "$ruta" = "8" ] && return
  [ -d "$ruta" ] || { echo "Ruta inválida"; return; }
  for f in "$ruta"/*; do [ -f "$f" ] && mv "$f" "$f.bck"; done
  echo "Archivos renombrados."
}

opcion3() {
  echo "===== ESTADO DEL DISCO ====="
  df -h
}

opcion4() {
  echo "Ingresá la palabra a buscar (o utiliza la opcion '8' para volver):"
  read palabra
  [ "$palabra" = "8" ] && return

  if [ -n "$ruta7" ]; then
    echo "Utilizando '$ruta7' como objetivo"
    echo "================================="
    ruta="$ruta7"    
    else
    echo "Ingresa el directorio donde buscar (o escribi 'menu' para volver):"
    read ruta
  fi
  [ "$ruta" = "8" ] && return
  if [ -d "$ruta" ]; then
    echo "Buscando '$palabra' en '$ruta'..."
    grep -rnw "$ruta" -e "$palabra"
  else
    echo "La ruta '$ruta' no es un directorio válido."
  fi
}

opcion5() {
  echo "===== REPORTE DEL SISTEMA ====="
  echo "Usuario........: $(whoami)"
  echo "Fecha actual...: $(date)"
  echo "La PC fue encendida....: $(uptime -p)"
  echo "Nombre del host.......: $(hostname)"
  echo "Directorio......: $(pwd)"
}

opcion6(){
  read -p "Ingrese la URL o ingrese 8 para volver: " url
  [ "$url" = "8" ] && return
  if [ -n "$ruta7" ]; then
    echo "Utilizando "$ruta7" como objetivo"
    echo "================================="
    destino="$ruta7"
  else
    read -p "Ingrese la carpeta de destino: " destino
  fi
  [ "$destino" = "8" ] && return
  archivo="$destino/website.txt"
  curl "$url" > "$archivo"
}


opcion7() {
    echo "Ingrese una ruta o ingrese 8 para volver:  "
    read ruta7
    [ "$ruta7" = "8" ] && return
  
    if [ -d "$ruta7" ]; then
        echo "Ruta guardada con éxito"
    else
        echo "El directorio no existe"
        read -p "Desea crear el directorio? (Y/N)" respuesta
          if [ "$respuesta" = "Y" ]; then
            mkdir "$ruta7"
              echo "El directorio ha sido creado y almacenado"
          fi             
    fi
    
}

es_valido() {
  case $1 in
    1|2|3|4|5|6|7|8) return 0 ;;
    *) return 1 ;;
  esac
}

while true; do  
  mostrar_menu
  echo "Elegí una opción (1-8):"
  read seleccion

  if es_valido "$seleccion"; then
    case $seleccion in
      1)
        opcion1
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
        opcion6
        ;;
      7)
        opcion7
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