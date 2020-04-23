vsim -gui work.Interpolation_Ram
add wave -position insertpoint sim:/Interpolation_Ram/*
force -freeze sim:/Interpolation_Ram/Interpolation_Enable 0 0
force -freeze sim:/Interpolation_Ram/CLK 1 0, 0 {50 ps} -r 100
force -freeze sim:/Interpolation_Ram/RST 0 0
force -freeze sim:/Interpolation_Ram/Interpolation_RAM_WR_Address 0000000000001 0
force -freeze sim:/Interpolation_Ram/Interpolation_RAM_WR_Data 1 0
force -freeze sim:/Interpolation_Ram/Interpolation_RAM_WR_Data 1111111100000000000000000000000000000000000000000000000000000010 0
force -freeze sim:/Interpolation_Ram/Interpolation_Memory_WR_Enable Hi1 0
run
force -freeze sim:/Interpolation_Ram/Interpolation_RAM_WR_Address 0000000000010 0
force -freeze sim:/Interpolation_Ram/Interpolation_RAM_WR_Data 1111111100000000000000000000000000000000000000000000000000000011 0
run
force -freeze sim:/Interpolation_Ram/Interpolation_RAM_WR_Address 0000000000000 0
force -freeze sim:/Interpolation_Ram/Interpolation_RAM_WR_Data 0000000000000000000000000000000000000000000000000000000000000111 0
run
force -freeze sim:/Interpolation_Ram/Interpolation_RAM_WR_Address 0000000000011 0
force -freeze sim:/Interpolation_Ram/Interpolation_RAM_WR_Data 0000000000000000000000000000000000000000000000000000000000000001 0
run
force -freeze sim:/Interpolation_Ram/Interpolation_RAM_WR_Address 0000000000100 0
force -freeze sim:/Interpolation_Ram/Interpolation_RAM_WR_Data 0000000000000000000000000000000000000000000000000000000000000010 0
run
force -freeze sim:/Interpolation_Ram/Interpolation_RAM_WR_Address 0000000000101 0
force -freeze sim:/Interpolation_Ram/Interpolation_RAM_WR_Data 0000000000000000000000000000000000000000000000000000000000000011 0
run
force -freeze sim:/Interpolation_Ram/Interpolation_RAM_WR_Address 0000000000110 0
force -freeze sim:/Interpolation_Ram/Interpolation_RAM_WR_Data 0000000000000000000000000000000000000000000000000000000000000101 0
run
force -freeze sim:/Interpolation_Ram/Interpolation_RAM_WR_Address 0000000001000 0
force -freeze sim:/Interpolation_Ram/Interpolation_RAM_WR_Data 0000000000000000000000000000000000000000000000000000000000000011 0
run
force -freeze sim:/Interpolation_Ram/Interpolation_RAM_WR_Address 0000000001001 0
force -freeze sim:/Interpolation_Ram/Interpolation_RAM_WR_Data 0000000000000000000000000000000000000000000000000000000000000101 0
run
force -freeze sim:/Interpolation_Ram/Interpolation_Memory_WR_Enable Hi0 0
force -freeze sim:/Interpolation_Ram/Interpolation_Intialize St1 0
run
force -freeze sim:/Interpolation_Ram/Interpolation_Intialize St0 0
