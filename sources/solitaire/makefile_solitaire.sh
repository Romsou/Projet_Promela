#!/usr/bin/env bash

file=generated_solitaire.pml

compile() {
    spin -a ${file}
    gcc -DNOREDUCE -DMA=272 -DMEMLIM=4096 -DVECTORSZ=2048 pan.c -o pan
    ./pan -a -i
}

clean() {
    rm pan*
    rm ${file}.trail
    rm _spin_nvr.tmp
}

test() {
    [ ! -f "${file}.trail" ] && echo "No trail file found" > /dev/stderr && exit 2
    spin -p -t ${file}
}

generate() {
    cd boards
    if [ -f /usr/bin/python3 ]; then
        /usr/bin/python3 board_generator.py
    elif [ ! -z "$(find /usr/bin -name python3.\[0-9])" ]; then
        $(find /usr/bin -name python3.\[0-9]) board_generator.py
    else
        echo "You need python 3 or above to run the script"
    fi
    cd ..
}

MSC() {
    [ ! -f "${file}.trail" ] && echo "No trail file found" > /dev/stderr && exit 2
    spin -c -t ${file}
}

help() {
    echo "Usage: $0 [-c] [-t] [-m] [-d]"
    echo
    echo "-c    Produce the verifier and compile pan before attempting to generate a trail"
    echo "-t    Replay the trail with spin -p -t ${file}"
    echo "-g    Generate a promela program by using the python script contained in boards"
    echo "-m    Print MSC (Message Sequence Chart)"
    echo "-d    Clean pan and trail files"
}

while getopts "ctmdg" option; do
        case $option in
            c) compile ;;
            t) test ;;
            g) generate;;
            d) clean ;;
            m) MSC ;;
            *) help ; exit 1 ;;
        esac
done

exit 0
