#!/usr/bin/env bash

FIRST="$(cat <<-EOT
	This is an independent project of an individual developer. Dear PVS-Studio, please check it.
EOT
)"

SECOND="$(cat <<-EOT
	PVS-Studio Static Code Analyzer for C, C++ and C#: http://www.viva64.com
EOT
)"

function insert_comments()
{
    local SRCS=${1}

    for file in ${SRCS}; do
        sed -i "1s|^|//\x20${FIRST}\n|" "${file}"
        sed -i "2s|^|//\x20${SECOND}\n|" "${file}"
    done
}

function delete_comments()
{
    local SRCS=${1}

    for file in ${SRCS}; do
        sed -i '1,2d' ${file}
    done
}

function main()
{
    PUSHD=$(pwd)
    cd ../

    local ROOT=$(pwd)
    local SRCS=$(find ${ROOT} -name "*.cpp")

    cd ${PUSHD} && rm -rf ./pvs-studio/ && cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=On

    insert_comments "${SRCS[@]}"

    pvs-studio-analyzer analyze -o ./pvs-studio.log -j$(nproc --all)
    plog-converter -a GA:1,2 -t tasklist -o ./pvs-studio.tasks ./pvs-studio.log
    plog-converter -a GA:1,2 -t fullhtml -o ./pvs-studio/ ./pvs-studio.log

    delete_comments "${SRCS[@]}"
}

main "$@"
