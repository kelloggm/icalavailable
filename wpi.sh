#!/bin/sh

# This script runs the WPI loop for icalavailable

WPITEMPDIR=/tmp/icalavailable-wpi

# This is the output directory when running via the gradle plugin
WPIOUTDIR=~/.gradle/workers/build/whole-program-inference

rm -rf ${WPITEMPDIR}
mkdir ${WPITEMPDIR}

while : ; do
    echo "entering a new iteration"
    ./gradlew clean
    ./gradlew compileJava
    [[ $(diff -r ${WPITEMPDIR} ${WPIOUTDIR}) ]] || break
    rm -rf ${WPITEMPDIR}
    mv ${WPIOUTDIR} ${WPITEMPDIR}
done
