#set term latex
#set output "plot.tex"
#set size 1,1

set term png
set output "stream_binding_one_diff_grafica.png"

set datafile separator ","

#set title "GLOPS HPCG"

set ylabel "GFlops"
#set xlabel "Hora" offset 0,-1.5
set xlabel "Threads" 


#set xtics rotate by 45 offset -3,-1.2
#set xtics rotate by 45 offset -3,-2.2

set key inside 
set key bottom right

plot "< grep 'Copy' data_binding_one_diff_resum.csv" using 3:xticlabel(1) with linespoints title "Copy",\
    "< grep Scale data_binding_one_diff_resum.csv" using 3:xticlabel(1) with linespoints title "Scale", \
    "< grep Add data_binding_one_diff_resum.csv" using 3:xticlabel(1) with linespoints title "Add", \
    "< grep Triad data_binding_one_diff_resum.csv" using 3:xticlabel(1) with linespoints title "Triad"


#plot  using 1:2:xticlabel(1) with linespoints title "Un-niced user", \
    ""              using 1:3 with linespoints title "kernel", \
    ""              using 1:4 with linespoints title "niced user"
