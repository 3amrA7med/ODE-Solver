vsim -gui work.Division_CSA_tb
add wave -position insertpoint  \
sim:/Division_CSA_tb/reset \
sim:/Division_CSA_tb/ready \
sim:/Division_CSA_tb/Q \
sim:/Division_CSA_tb/overFlow \
sim:/Division_CSA_tb/divisor \
sim:/Division_CSA_tb/dividend \
sim:/Division_CSA_tb/divideByZero \
sim:/Division_CSA_tb/clk
run 22ns  
