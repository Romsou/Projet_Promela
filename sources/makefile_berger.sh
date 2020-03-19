#!/usr/bin/env bash

compile() {
    spin -a berger.pml
    gcc -DNOREDUCE pan.c -o pan
    ./pan -a -i
}

clean() {
    rm pan*
    rm berger.pml.trail
    rm _spin_nvr.tmp
}

test() {
    [ ! -f "berger.pml.trail" ] && echo "No trail" && exit 2
    spin -p -t berger.pml
}

for param in $@; do
    case $param in
        -c) compile ;;
        -cl) clean ;;
        -t) test ;;
        *) exit 1;;
    esac
done

exit 0
