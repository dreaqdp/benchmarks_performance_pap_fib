#!/bin/bash
if [ $# -lt 1 ]; then 
    echo "USAGE: ./iterate.sh <binding>\n
                binding: 0 deactivated, 1 activated"
    exit 1;
fi 

source ~/.bashrc

i=1
max_nodes=16

if [ $1 ]; then
    mkdir binding
    cd binding
else 
    mkdir no_binding
    cd no_binding
fi


while [ $i -le $max_nodes ]
do
    name='threads_'$i
    mkdir $name
    cd $name

    for j in {1..5}
    do
        mkdir run_$j
        cd run_$j

if [ $1 ]; then
    qsub -l execution2 ../../../submit-stream-binding.sh $i
else 
    qsub -l execution2 ../../../submit-stream.sh $i
fi

        cd ..
    done

    cd ..
    ((i<<=1))
done
