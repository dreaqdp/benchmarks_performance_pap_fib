#set term latex
#set output "plot.tex"
#set size 1,1

set term png
set output "global_grafica.png"

set datafile separator ","

#set title "GLOPS HPCG"

set ylabel "GFlops"
#set xlabel "Hora" offset 0,-1.5
set xlabel "Ranks x threads" 


#set xtics rotate by 45 offset -3,-2.2

#set key outside 
#set key bottom center

plot "data_resum_global.csv" using 2:xticlabel(1) with linespoints title "Avg GFlops"
#plot  using 1:2:xticlabel(1) with linespoints title "Un-niced user", \
    ""              using 1:3 with linespoints title "kernel", \
    ""              using 1:4 with linespoints title "niced user"
