#!/bin/bash


extract_data () {
# nodes, procs, run
    grep WR00 run_$3/*.o* | awk '{ print $2, $3, $4, $5, $6, $7 }' | sed -e "s/8000/$1,$2,$3/" -e "s/ /,/g" >> ../../data_tmp.csv

}

iterate_dirs () {
    cd $dir
    for j in {1..5}
    do
        extract_data $node $proc $j
    done
    cd ..
    pwd
}


cd timing

for dir in $( ls )
do
    node=$( echo $dir | cut -f 2 -d '_' )
    proc=$( echo $dir | cut -f 4 -d '_' )

    echo "node $node proc $proc"
    iterate_dirs
done
cd ..

( echo "Nodes, procs, runs, NB, P, Q, time, GFlops"; cat data_tmp.csv ) > data_hpl.csv
rm data_tmp.csv
