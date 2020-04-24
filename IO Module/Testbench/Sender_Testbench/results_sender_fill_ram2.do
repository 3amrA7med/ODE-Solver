delete wave *
add wave sim:/ODE_Solver_Chip/Memory/*
add wave sim:/ODE_Solver_Chip/IO/RS/*

force -freeze sim:/ODE_Solver_Chip/Memory/CLK 1 0, 0 {50 ps} -r 100
force -freeze sim:/ODE_Solver_Chip/RST 1 0
run
force -freeze sim:/ODE_Solver_Chip/RST 0
run  
force -freeze sim:/ODE_Solver_Chip/Memory/WR_Enable 1 0
force -freeze sim:/ODE_Solver_Chip/Memory/address_WR 0000000000001 0
force -freeze sim:/ODE_Solver_Chip/Memory/dataIn 10#3 0
run
force -freeze sim:/ODE_Solver_Chip/Memory/WR_Enable 1 0
force -freeze sim:/ODE_Solver_Chip/Memory/address_WR 0000000000010 0
force -freeze sim:/ODE_Solver_Chip/Memory/dataIn 10#4 0
run
force -freeze sim:/ODE_Solver_Chip/Memory/WR_Enable 1 0
force -freeze sim:/ODE_Solver_Chip/Memory/address_WR 0000000000011 0
force -freeze sim:/ODE_Solver_Chip/Memory/dataIn 10#5 0
run
force -freeze sim:/ODE_Solver_Chip/Memory/WR_Enable 1 0
force -freeze sim:/ODE_Solver_Chip/Memory/address_WR 0000000000100 0
force -freeze sim:/ODE_Solver_Chip/Memory/dataIn 10#6 0
run
force -freeze sim:/ODE_Solver_Chip/Memory/WR_Enable 1 0
force -freeze sim:/ODE_Solver_Chip/Memory/address_WR 0000000000101 0
force -freeze sim:/ODE_Solver_Chip/Memory/dataIn 10#7 0
run
force -freeze sim:/ODE_Solver_Chip/Memory/WR_Enable 1 0
force -freeze sim:/ODE_Solver_Chip/Memory/address_WR 0000000000110 0
force -freeze sim:/ODE_Solver_Chip/Memory/dataIn 10#8 0
run
force -freeze sim:/ODE_Solver_Chip/Memory/WR_Enable 1 0
force -freeze sim:/ODE_Solver_Chip/Memory/address_WR 0000000001010 0
force -freeze sim:/ODE_Solver_Chip/Memory/dataIn 10#9 0
run
force -freeze sim:/ODE_Solver_Chip/Memory/WR_Enable 1 0
force -freeze sim:/ODE_Solver_Chip/Memory/address_WR 0000000001011 0
force -freeze sim:/ODE_Solver_Chip/Memory/dataIn 10#10 0
run
force -freeze sim:/ODE_Solver_Chip/Memory/WR_Enable 1 0
force -freeze sim:/ODE_Solver_Chip/Memory/address_WR 0000000001100 0
force -freeze sim:/ODE_Solver_Chip/Memory/dataIn 10#11 0
run
force -freeze sim:/ODE_Solver_Chip/Memory/WR_Enable 1 0
force -freeze sim:/ODE_Solver_Chip/Memory/address_WR 0000000001101 0
force -freeze sim:/ODE_Solver_Chip/Memory/dataIn 10#12 0
run
force -freeze sim:/ODE_Solver_Chip/Memory/WR_Enable 1 0
force -freeze sim:/ODE_Solver_Chip/Memory/address_WR 0000000001110 0
force -freeze sim:/ODE_Solver_Chip/Memory/dataIn 10#19 0
run
force -freeze sim:/ODE_Solver_Chip/Memory/WR_Enable 1 0
force -freeze sim:/ODE_Solver_Chip/Memory/address_WR 0000000001111 0
force -freeze sim:/ODE_Solver_Chip/Memory/dataIn 10#188 0
run
force -freeze sim:/ODE_Solver_Chip/Memory/WR_Enable 1 0
force -freeze sim:/ODE_Solver_Chip/Memory/address_WR 0000000010000 0
force -freeze sim:/ODE_Solver_Chip/Memory/dataIn 10#18 0
run
force -freeze sim:/ODE_Solver_Chip/Memory/WR_Enable 1 0
force -freeze sim:/ODE_Solver_Chip/Memory/address_WR 0000000010001 0
force -freeze sim:/ODE_Solver_Chip/Memory/dataIn 10#17 0
run
force -freeze sim:/ODE_Solver_Chip/Memory/WR_Enable 1 0
force -freeze sim:/ODE_Solver_Chip/Memory/address_WR 0000000010010 0
force -freeze sim:/ODE_Solver_Chip/Memory/dataIn 10#16 0
run
force -freeze sim:/ODE_Solver_Chip/Memory/WR_Enable 1 0
force -freeze sim:/ODE_Solver_Chip/Memory/address_WR 0000000010011 0
force -freeze sim:/ODE_Solver_Chip/Memory/dataIn 10#12 0
run
force -freeze sim:/ODE_Solver_Chip/Memory/WR_Enable 1 0
force -freeze sim:/ODE_Solver_Chip/Memory/address_WR 0000000010100 0
force -freeze sim:/ODE_Solver_Chip/Memory/dataIn 10#13 0
run
force -freeze sim:/ODE_Solver_Chip/Memory/WR_Enable 1 0
force -freeze sim:/ODE_Solver_Chip/Memory/address_WR 0000000010101 0
force -freeze sim:/ODE_Solver_Chip/Memory/dataIn 10#11 0
run
force -freeze sim:/ODE_Solver_Chip/Memory/WR_Enable 1 0
force -freeze sim:/ODE_Solver_Chip/Memory/address_WR 0000000010110 0
force -freeze sim:/ODE_Solver_Chip/Memory/dataIn 10#99 0
run
force -freeze sim:/ODE_Solver_Chip/Memory/WR_Enable 0
force -freeze sim:/ODE_Solver_Chip/Done_Processing 1 0