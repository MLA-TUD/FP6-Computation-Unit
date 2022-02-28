#!/bin/bash

abort() #is executed on an error so the script stops
{
    echo "An error occurred. Exiting..."
   # exit 1
}

trap 'abort' 0

set -e # exit on error flag

for file in $(find . -name "*.vhd") #handle all package files
do
echo "start package file anaysis"
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

done
for file in $(find . -name "*.vhdl") #handle all paramter files
do
#if [[$file == *.vhdl ]]; then
# echo "Vhdl file found"
#else
# continue
#fi
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
unit=${unit##*/}
 echo "unit is $unit"
if ghdl -e $unit ; then
    echo "Build ok"
else
    echo "Build failed"
   # exit 1
fi
done
for file in "$@"
do
unittb=${file%.vhdl}
unittb=${unittb##*/}
if ghdl -r $unittb --vcd=$unittb.vcd ; then
    echo "Testbench dump ok"
else
    echo "Testbench dump failed"
   # exit 1
fi
done
echo "start gtkwave..."
gtkwave $unittb.vcd  --rcvar 'do_initial_zoom_fit yes' &

trap : 0
