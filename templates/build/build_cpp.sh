#!/bin/bash

BUILD_DIR="build"

usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -b, --build       Nur Build ausführen"
    echo "  -t, --test        Build und Tests ausführen"
    echo "  -h, --help        Zeigt diese Hilfe an"
    exit 1
}

# Funktion für den Build
run_build() {
    echo "Starte den Build-Prozess..."
    if [ ! -d "$BUILD_DIR" ]; then
        mkdir "$BUILD_DIR"
    fi
    cd "$BUILD_DIR" || exit 1

    # Führe CMake und Build aus
    cmake ..
    if [ $? -ne 0 ]; then
        echo "Fehler bei CMake."
        exit 1
    fi

    make -j$(nproc)
    if [ $? -ne 0 ]; then
        echo "Fehler beim Build."
        exit 1
    fi
    echo "Build erfolgreich abgeschlossen."
    cd - || exit 1
}

run_tests() {
    echo "Starte Tests mit CTest..."
    cd "$BUILD_DIR" || exit 1

    ctest --output-on-failure
    if [ $? -ne 0 ]; then
        echo "Einige Tests sind fehlgeschlagen."
        exit 1
    fi
    echo "Tests erfolgreich abgeschlossen."
    cd - || exit 1
}

if [ $# -eq 0 ]; then
    usage
fi

BUILD_ONLY=false
RUN_TESTS=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -b|--build)
            BUILD_ONLY=true
            shift
            ;;
        -t|--test)
            BUILD_ONLY=true
            RUN_TESTS=true
            shift
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Unbekannte Option: $1"
            usage
            ;;
    esac
done

if [ "$BUILD_ONLY" = true ]; then
    run_build
fi

if [ "$RUN_TESTS" = true ]; then
    run_tests
fi
