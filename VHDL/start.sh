#!/bin/bash

abort() #is executed on an error so the script stops
{
    echo "An error occurred. Exiting..."
    exit 1
}

trap 'abort' 0

set -e # exit on error flag

for file in "$@" #handle all paramter files
do
echo "start hapra script..."
if ghdl -s $file ; then
    echo "Syntax ok"
else
    echo "Syntax failed"
    exit 1
fi
if ghdl -a $file ; then
    echo "Anaysis ok"
else
    echo "Anaysis failed"
    exit 1
fi
unit=${file%.vhdl}
 echo "unit is $unit"
if ghdl -e $unit ; then
    echo "Build ok"
else
    echo "Build failed"
    exit 1
fi
done
if ghdl -r $unit --vcd=$unit.vcd ; then
    echo "Testbench dump ok"
else
    echo "Testbench dump failed"
    exit 1
fi
echo "start gtkwave..."
gtkwave $unit.vcd  --rcvar 'do_initial_zoom_fit yes' &

trap : 0
