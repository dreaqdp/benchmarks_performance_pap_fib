#!/bin/bash

source ~/.bashrc

max_nodes=16

mkdir binding
cd binding

for k in {1..3}
do
    i=1
    if [ $k -eq 1 ]
    then
        mkdir one_same_numa
        cd one_same_numa
    elif [ $k -eq 2 ]
    then
        mkdir one_diff_numa
        cd one_diff_numa
    else
        mkdir two_same_numa
        cd two_same_numa
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

            qsub -l execution2 ../../../../submit-stream-binding.sh $i $k

            cd ..
        done

        cd ..
        ((i<<=1))
    done
    cd ..
done
