vsim -gui work.Division_CSA
add wave -position insertpoint  \
sim:/Division_CSA/sign \
sim:/Division_CSA/second_operand_number \
sim:/Division_CSA/reset \
sim:/Division_CSA/ready \
sim:/Division_CSA/Q \
sim:/Division_CSA/overFlow \
sim:/Division_CSA/number_of_bits_in_dividend \
sim:/Division_CSA/negated_second_operand_number \
sim:/Division_CSA/divisor \
sim:/Division_CSA/dividend \
sim:/Division_CSA/divideByZero \
sim:/Division_CSA/clk


force -freeze sim:/Division_CSA/dividend 0000000000111000 0
force -freeze sim:/Division_CSA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CSA/divisor 0000000000010000 0
force -freeze sim:/Division_CSA/reset 1 0
run
force -freeze sim:/Division_CSA/reset 0 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run


force -freeze sim:/Division_CSA/dividend 0000000001001001 0
force -freeze sim:/Division_CSA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CSA/divisor 0000000000010000 0
force -freeze sim:/Division_CSA/reset 1 0
run
force -freeze sim:/Division_CSA/reset 0 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run

 
force -freeze sim:/Division_CSA/dividend 0000101000111010 0
force -freeze sim:/Division_CSA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CSA/divisor 0000000000111000 0
force -freeze sim:/Division_CSA/reset 1 0
run
force -freeze sim:/Division_CSA/reset 0 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run

force -freeze sim:/Division_CSA/dividend 1111111111100000 0
force -freeze sim:/Division_CSA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CSA/divisor 0000000000001001 0
force -freeze sim:/Division_CSA/reset 1 0
run
force -freeze sim:/Division_CSA/reset 0 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run


force -freeze sim:/Division_CSA/dividend 0000000000111000 0
force -freeze sim:/Division_CSA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CSA/divisor 0000000000111000 0
force -freeze sim:/Division_CSA/reset 1 0
run
force -freeze sim:/Division_CSA/reset 0 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run


force -freeze sim:/Division_CSA/dividend 0000000000111000 0
force -freeze sim:/Division_CSA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CSA/divisor 0000000000001000 0
force -freeze sim:/Division_CSA/reset 1 0
run
force -freeze sim:/Division_CSA/reset 0 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
 
force -freeze sim:/Division_CSA/dividend 1111111111111000 0
force -freeze sim:/Division_CSA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CSA/divisor 0000000000111000 0
force -freeze sim:/Division_CSA/reset 1 0
run
force -freeze sim:/Division_CSA/reset 0 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run


force -freeze sim:/Division_CSA/dividend 0000000001110000 0
force -freeze sim:/Division_CSA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CSA/divisor 0000000000111000 0
force -freeze sim:/Division_CSA/reset 1 0
run
force -freeze sim:/Division_CSA/reset 0 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run

force -freeze sim:/Division_CSA/dividend 1111111111001000 0
force -freeze sim:/Division_CSA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CSA/divisor 1111111111001000 0
force -freeze sim:/Division_CSA/reset 1 0
run
force -freeze sim:/Division_CSA/reset 0 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run

force -freeze sim:/Division_CSA/dividend 0100000000000000 0
force -freeze sim:/Division_CSA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CSA/divisor 0000001010000000 0
force -freeze sim:/Division_CSA/reset 1 0
run
force -freeze sim:/Division_CSA/reset 0 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run


force -freeze sim:/Division_CSA/dividend 0100000000000000 0
force -freeze sim:/Division_CSA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CSA/divisor 0000000000000000 0
force -freeze sim:/Division_CSA/reset 1 0
run
force -freeze sim:/Division_CSA/reset 0 0
run
run
run
run
