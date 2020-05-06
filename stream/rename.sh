#!/bin/bash

if [ $# -lt 1 ]; then 
    echo "USAGE: ./iterate.sh <binding>\n
                binding: 0 deactivated, 1 activated"
    exit 1;
fi 

if [ $1 ]; then
    cd binding
else 
    cd no_binding
fi

max_nodes=16
i=1

while [ $i -le $max_nodes ]
do
    cd threads_$i
    for j in {1..5}
    do
        cd run_$j
        mv *.o* stream_${i}_${j}.out
        mv *.e* stream_${i}_${j}.err
        cd ..
    done
    cd ..
    ((i<<=1))

done
