vsim -gui work.Division_LHA_tb
add wave -position insertpoint  \
sim:/Division_LHA_tb/reset \
sim:/Division_LHA_tb/ready \
sim:/Division_LHA_tb/Q \
sim:/Division_LHA_tb/overFlow \
sim:/Division_LHA_tb/divisor \
sim:/Division_LHA_tb/dividend \
sim:/Division_LHA_tb/divideByZero \
sim:/Division_LHA_tb/clk
run 22ns