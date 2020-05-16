#set term latex
#set output "plot.tex"
#set size 1,1

set term png
set output "kernels_grafica.png"

set datafile separator ","


set ylabel "GFlops"
set xlabel "Ranks x threads" 

#set key outside 
#set key bottom center

plot "< grep 'DDOT' data_resum_kernels.csv" using 3:xticlabel(2) with linespoints title "DDOT", \
         "< grep WAXPBY data_resum_kernels.csv" using 3:xticlabel(2) with linespoints title "WAXPBY", \
         "< grep SpMV data_resum_kernels.csv" using 3:xticlabel(2) with linespoints title "SpMV", \
         "< grep MG data_resum_kernels.csv" using 3:xticlabel(2) with linespoints title "MG" 
