#!/bin/bash

mostrar_menu_principal() {
    echo "Bienvenido a la guía rápida de metodologías de desarrollo de software."
    echo "Por favor, seleccione una opción:"
    echo "  -a: Metodologías ágiles"
    echo "  -t: Metodologías tradicionales"
}

mostrar_menu_agiles() {
    echo "Bienvenido a la guía rápida de Agile. Por favor, seleccione un tema:"
    echo "  1. SCRUM"
    echo "  2. X.P."
    echo "  3. Kanban"
    echo "  4. Crystal"
}

mostrar_menu_tradicionales() {
    echo "Bienvenido a la guía rápida de metodologías tradicionales. Por favor, seleccione un tema:"
    echo "  1. Cascada"
    echo "  2. Espiral"
    echo "  3. Modelo V"
}

mostrar_menu_opciones() {
    echo "Usted está en la sección $1, seleccione la opción que desea utilizar:"
    echo "  1. Agregar información"
    echo "  2. Buscar"
    echo "  3. Eliminar información"
    echo "  4. Leer base de información"
    echo "  5. Volver al menú anterior"
    echo "  6. Salir"
}

agregar_informacion() {
    echo "Ingrese el identificador del concepto:"
    read identificador
    echo "Ingrese la definición:"
    read definicion
    echo "[$identificador] .- $definicion" >> "$1.inf"
    echo "Información agregada correctamente."
}

buscar_informacion() {
    echo "Ingrese el concepto a buscar:"
    read concepto
    grep -i "\[$concepto\]" "$1.inf"
}

eliminar_informacion() {
    echo "Ingrese el concepto a eliminar:"
    read concepto
    sed -i "/\[$concepto\]/d" "$1.inf"
    echo "Información eliminada correctamente."
}

leer_base_informacion() {
    echo "Contenido del archivo $1.inf:"
    cat "$1.inf"
}

manejar_opcion() {
    case $1 in
        1) agregar_informacion "$2";;
        2) buscar_informacion "$2";;
        3) eliminar_informacion "$2";;
        4) leer_base_informacion "$2";;
        5) return;;
        6) exit;;
        *) echo "Opción no válida.";;
    esac
}

main() {
    if [ $# -ne 1 ]; then
        mostrar_menu_principal
        exit 1
    fi

    opcion=$1

    case $opcion in
        -a)
            mostrar_menu_agiles
            read tema
            case $tema in
                1) mostrar_menu_opciones "SCRUM";;
                2) mostrar_menu_opciones "X.P.";;
                3) mostrar_menu_opciones "Kanban";;
                4) mostrar_menu_opciones "Crystal";;
                *) echo "Opción no válida.";;
            esac
            ;;
        -t)
            mostrar_menu_tradicionales
            read tema
            case $tema in
                1) mostrar_menu_opciones "Cascada";;
                2) mostrar_menu_opciones "Espiral";;
                3) mostrar_menu_opciones "Modelo V";;
                *) echo "Opción no válida.";;
            esac
            ;;
        *) echo "Opción no válida.";;
    esac

    while true; do
        mostrar_menu_opciones "$tema"
        read opcion_sub
        manejar_opcion "$opcion_sub" "$tema"
    done
}

main "$@"

