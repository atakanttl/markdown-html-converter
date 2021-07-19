#!/bin/bash

read -r -d '' HELP << EOF
compandoc
--------------------------
Program to compile .md files to .html files inside a directory and its children.
compandoc uses 'pandoc' for compilation.
Arguments:
    html <directory>    : Compile to html
    clean <directory>   : Remove the compiled HTML files (*.md.html) inside the directory and its children
    help                : Show this help text
Note: You should only call the path to the file as the directory, file name excluded, as this script compiles the entire directory instead of a specific file.
EOF

COMMAND="${1}"

if [[ "${#}" -ne 2 || "${COMMAND}" == 'help' ]]
then
    echo "${HELP}"
    exit 0
fi

DIRECTORY="${2}"

if [[ ! -d "${DIRECTORY}" ]]
then
    echo "Cannot find directory ${2}" >&2
    exit 1
fi

REALPATH="$(cd ${DIRECTORY} && pwd)"

# Script directory check with symbolic link support
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  TARGET="$(readlink "$SOURCE")"
  if [[ $TARGET == /* ]]; then
    SOURCE="$TARGET"
  else
    SCRIPT_DIR="$( dirname "$SOURCE" )"
    SOURCE="$SCRIPT_DIR/$TARGET" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  fi
done
SCRIPT_DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

# Deal with files contain spaces
OIFS="$IFS"
IFS=$'\n'

make-html() {
    for file in $(find ${REALPATH} -name '*.md')
    do
        FILE_NAME_FULL="${file}"
        FILE_NAME_BASE="$(basename ${file})"
        echo "Compiling: ${FILE_NAME_BASE}"
        pandoc -s -f markdown -t html5 -o "${FILE_NAME_FULL}.html" ${FILE_NAME_FULL} -c ${SCRIPT_DIR}/COMPANDOC.css
    done
    exit 0
}

cleanup() {
    for file in $(find ${REALPATH} -name '*.md.html')
    do
        FILE_NAME_FULL="${file}"
        FILE_NAME_BASE=$(basename ${file})
        echo "Removing: ${FILE_NAME_BASE}"
        rm -f ${FILE_NAME_FULL}
    done
    exit 0
}

case "${COMMAND}" in
    html)
        make-html
        ;;
    clean)
        cleanup
        ;;
    help)
        echo "${HELP}"
        exit 0
        ;;
    *)
        echo "Invalid option. Type 'compandoc help' for available commands."
        exit 1
        ;;
esac