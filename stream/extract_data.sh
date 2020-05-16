#!/bin/bash


extract_data () {
    echo "$1,$2," > tmp
    grep "$3" run_$2/*.o* | awk '{ print $1, $2, $3, $4, $5 }' | sed "s/://g" | sed "s/ /,/g" >> tmp
    awk 'NR%2{printf "%s ",$0;next;}1' tmp >> ../data_${name}_$k.csv

}

iterate_dirs () {
    i=1
    max_nodes=16
    while [ $i -le $max_nodes ]
    do
        cd threads_$i
        for j in {1..5}
        do
#echo "$i,$j," > tmp
#grep -e 'Copy:' -e 'Scale' -e 'Add' -e 'Triad' run_$j/*.out | awk '{ print $1, $2, $3, $4, $5 }' | sed "s/://g" | sed "s/ /,/g" >> tmp
#awk 'NR%2{printf "%s ",$0;next;}1' tmp >> data_nobinding.csv
            extract_data $i $j Copy:
            extract_data $i $j Scale:
            extract_data $i $j Add:
            extract_data $i $j Triad:
            echo "procs $i, run $j"
        done
        rm tmp
        cd ..
        ((i<<=1))
    done
}

if [ $# -lt 1 ]; then 
    echo "USAGE: ./extract_data.sh <binding>\n
                binding: 0 deactivated, 1 activated"
    exit 1;
fi 


i=1
max_nodes=16

if [ $1 -eq 1 ]; then

#    ./rename.sh

    cd binding
    for k in `ls`
    do
        cd $k
        name=binding
        iterate_dirs
        cd ..
    done
else 
    cd no_binding
    name=no_binding
    iterate_dirs
fi

