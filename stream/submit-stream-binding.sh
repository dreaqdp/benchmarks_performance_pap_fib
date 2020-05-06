#!/bin/bash
# following option makes sure the job will run in the current directory
#$ -cwd
# following option makes sure the job has the same environmnent variables as the submission shell
#$ -V
# following option to change shell
#$ -S /bin/bash

USAGE="\n USAGE: ./submit-stream.sh numthreads numa_config\n
        numthreads    -> Number of threads\n
        numa_config   -> 0 (one same numa), 1 (one diff numa), 2 (two same numa)"

if (test $# -lt 2 || test $# -gt 2)
then
        echo -e $USAGE
        exit 0
fi

if [ $2 -eq 1 ]
then
    n_nodes=0
    n_mem=0
elif [ $2 -eq 2]
then
    n_nodes=0
    n_mem=1
else
    n_nodes=0,1
    n_mem=0,1
fi

export OMP_NUM_THREADS=$1

numactl -N $n_nodes -m $n_mem ../../../../stream

