vsim -gui work.Division_CLHA
add wave -position insertpoint  \
sim:/Division_CLHA/sign \
sim:/Division_CLHA/second_operand_number \
sim:/Division_CLHA/reset \
sim:/Division_CLHA/ready \
sim:/Division_CLHA/Q \
sim:/Division_CLHA/overFlow \
sim:/Division_CLHA/number_of_bits_in_dividend \
sim:/Division_CLHA/negated_second_operand_number \
sim:/Division_CLHA/divisor \
sim:/Division_CLHA/dividend \
sim:/Division_CLHA/divideByZero \
sim:/Division_CLHA/clk


force -freeze sim:/Division_CLHA/dividend 0000000000111000 0
force -freeze sim:/Division_CLHA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CLHA/divisor 0000000000010000 0
force -freeze sim:/Division_CLHA/reset 1 0
run
force -freeze sim:/Division_CLHA/reset 0 0
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


force -freeze sim:/Division_CLHA/dividend 0000000001001001 0
force -freeze sim:/Division_CLHA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CLHA/divisor 0000000000010000 0
force -freeze sim:/Division_CLHA/reset 1 0
run
force -freeze sim:/Division_CLHA/reset 0 0
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

 
force -freeze sim:/Division_CLHA/dividend 0000101000111010 0
force -freeze sim:/Division_CLHA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CLHA/divisor 0000000000111000 0
force -freeze sim:/Division_CLHA/reset 1 0
run
force -freeze sim:/Division_CLHA/reset 0 0
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

force -freeze sim:/Division_CLHA/dividend 1111111111100000 0
force -freeze sim:/Division_CLHA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CLHA/divisor 0000000000001001 0
force -freeze sim:/Division_CLHA/reset 1 0
run
force -freeze sim:/Division_CLHA/reset 0 0
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


force -freeze sim:/Division_CLHA/dividend 0000000000111000 0
force -freeze sim:/Division_CLHA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CLHA/divisor 0000000000111000 0
force -freeze sim:/Division_CLHA/reset 1 0
run
force -freeze sim:/Division_CLHA/reset 0 0
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


force -freeze sim:/Division_CLHA/dividend 0000000000111000 0
force -freeze sim:/Division_CLHA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CLHA/divisor 0000000000001000 0
force -freeze sim:/Division_CLHA/reset 1 0
run
force -freeze sim:/Division_CLHA/reset 0 0
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
 
force -freeze sim:/Division_CLHA/dividend 1111111111111000 0
force -freeze sim:/Division_CLHA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CLHA/divisor 0000000000111000 0
force -freeze sim:/Division_CLHA/reset 1 0
run
force -freeze sim:/Division_CLHA/reset 0 0
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


force -freeze sim:/Division_CLHA/dividend 0000000001110000 0
force -freeze sim:/Division_CLHA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CLHA/divisor 0000000000111000 0
force -freeze sim:/Division_CLHA/reset 1 0
run
force -freeze sim:/Division_CLHA/reset 0 0
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

force -freeze sim:/Division_CLHA/dividend 1111111111001000 0
force -freeze sim:/Division_CLHA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CLHA/divisor 1111111111001000 0
force -freeze sim:/Division_CLHA/reset 1 0
run
force -freeze sim:/Division_CLHA/reset 0 0
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

force -freeze sim:/Division_CLHA/dividend 0100000000000000 0
force -freeze sim:/Division_CLHA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CLHA/divisor 0000001010000000 0
force -freeze sim:/Division_CLHA/reset 1 0
run
force -freeze sim:/Division_CLHA/reset 0 0
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


force -freeze sim:/Division_CLHA/dividend 0100000000000000 0
force -freeze sim:/Division_CLHA/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Division_CLHA/divisor 0000000000000000 0
force -freeze sim:/Division_CLHA/reset 1 0
run
force -freeze sim:/Division_CLHA/reset 0 0
run
run
run
run
