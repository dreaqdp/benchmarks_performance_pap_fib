#!/bin/bash
if [ $# -lt 1 ]; then 
    echo "USAGE: ./iterate.sh <nodes>\n
                nodes: number of nodes"
    exit 1;
fi 

source ~/.bashrc

if [ $1 -eq 1 ]; then
    processes=(1 2 4 6 8)
#proc_N=(1 2 3 4 4)
else 
    processes=(2 4 8 12 16)
fi

mkdir timing
cd timing

for proc in ${processes[@]}
do
    echo "proc $proc"
    P=()
    Q=()
# Compute P values 
    for j in $( seq 1 $proc )
    do
        p_tmp=$(( $proc % $j))
        if [ $p_tmp -eq 0 ]
        then
            P+=($j)
        fi
    done
    echo "P ${P[@]}"

    N=${#P[*]}
    echo "N $N"
    n_tmp=$(( $N - 1 ))

# Save Q values, reverse of P 
    for j in $( seq $n_tmp -1 0 )
    do
        Q+=(${P[$j]})
    done
    echo "Q ${Q[@]}"

# prepare execution dirs

    mkdir nodes_${1}_procs_$proc
    cd nodes_${1}_procs_$proc

    for j in {1..5}
    do
        mkdir run_$j
        cd run_$j
        cp ../../../HPL.dat .
        sed -i -e "10s/1/$N/" -e '11s,1,'"${P[*]}"',' -e "12s/1/${Q[*]}/" HPL.dat
        qsub -pe mpich $1 -l execution2 ../../../submit-hpl.sh $1 $proc
        cd ..
    done

    cd ..
done
