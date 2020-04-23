vsim work.test
# vsim work.test 
# Start time: 19:03:08 on Apr 21,2020
# Loading work.test
# Loading work.Division_CLHA
# Loading work.carry_lookahead_adder_16bit
# Loading work.carry_lookahead_adder_4bit
add wave -position end  sim:/test/clk
add wave -position end  sim:/test/rst
add wave -position end  sim:/test/State
add wave -position end  sim:/test/reset
add wave -position end  sim:/test/dividend
add wave -position end  sim:/test/divisor
add wave -position end  sim:/test/Q
add wave -position end  sim:/test/Result
add wave -position end  sim:/test/ready
add wave -position end  sim:/test/overFlow
add wave -position end  sim:/test/divideByZero
force -freeze sim:/test/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/test/rst 1 0
run 100 ps
force -freeze sim:/test/rst 0 0

