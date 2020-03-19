#!/usr/bin/env bash

file=solitaire.pml

compile() {
    spin -a ${file}
    gcc -DNOREDUCE pan.c -o pan
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

MSC() {
    [ ! -f "${file}.trail" ] && echo "No trail file found" > /dev/stderr && exit 2
    spin -c -t ${file}
}

help() {
    echo "Usage: $0 [-c] [-t] [-m] [-d]"
    echo
    echo "-c    Produce the verifier and compile pan before attempting to generate a trail"
    echo "-t    Replay the trail with spin -p -t ${file}"
    echo "-m    Print MSC (Message Sequence Chart)"
    echo "-d    Clean pan and trail files"
}

while getopts "ctmd" option; do
        case $option in
            c) compile ;;
            t) test ;;
            d) clean ;;
            m) MSC ;;
            *) help ; exit 1 ;;
        esac
done

exit 0
