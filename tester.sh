#!/usr/bin/env bash
clear
if [ -n "$1" ]; then
    classname="$1"
    classname="$(tr '[:lower:]' '[:upper:]' <<< ${classname:0:1})${classname:1}"

    /c/work/apps/jdk8u202-b08/bin/javac -classpath lib/junit-4.12.jar -d out src/exercices/${classname}.java 2> logs/checkmethod_output.txt
    if [[ $(< logs/checkmethod_output.txt) != "" ]]; then
        cat logs/checkmethod_output.txt
    else
        /c/work/apps/jdk8u202-b08/bin/javac -classpath lib/junit-4.12.jar -d out src/tests/MainTest.java
        /c/work/apps/jdk8u202-b08/bin/javac -classpath lib/junit-4.12.jar -d out src/tests/${classname}Test.java

        /c/work/apps/jdk8u202-b08/bin/java -classpath lib/junit-4.12.jar:lib/hamcrest-core-1.3.jar org.junit.runner.JUnitCore ${classname}Test
    fi
else
    echo "Please specify the class to test, e.g. : ./tester.sh PrimitiveTraining"
fi