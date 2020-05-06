#!/bin/bash


extract_data () {
# procs, threads, run
    ( echo -n "$1,$2,$3"; grep "rating of" run_$3/*.o* | awk -F "=" '{ print $2 }' ) >> ../../data_tmp.csv
}

extract_data_kernel () {
# procs, threads, run, kernel_name
    ( echo -n "$1,$2,$3,$4"; grep "GLOP" run_$3/*.o* | grep $4 | awk -F "=" '{ print $2 }' ) >> ../../data_tmp_kernels.csv
}
iterate_dirs () {
    cd $dir
    for i in {1..5}
    do
#echo "$i,$j," > tmp
#grep -e 'Copy:' -e 'Scale' -e 'Add' -e 'Triad' run_$j/*.out | awk '{ print $1, $2, $3, $4, $5 }' | sed "s/://g" | sed "s/ /,/g" >> tmp
#awk 'NR%2{printf "%s ",$0;next;}1' tmp >> data_nobinding.csv
        extract_data $procs $threads $i
        extract_data_kernel $procs $threads $i 'DDOT'
        extract_data_kernel $procs $threads $i 'WAXPBY'
        extract_data_kernel $procs $threads $i 'SpMV'
        extract_data_kernel $procs $threads $i 'MG'
    done
    cd ..
}


cd timing

for dir in $( ls )
do
    procs=$( echo $dir | cut -f 2 -d '_' )
    threads=$( echo $dir | cut -f 4 -d '_' )

    echo "procs $procs threads $threads"
    iterate_dirs
done
cd ..
( echo "procs, threads, runs, GFlops"; cat data_tmp.csv ) > data_glops_rating.csv
( echo "procs, threads, runs, kernel, GFlops"; cat data_tmp_kernels.csv ) > data_glops_kernels.csv
rm data_tmp*
