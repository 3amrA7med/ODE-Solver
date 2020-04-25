vsim work.Coordinator_Module
# vsim work.Coordinator_Module
# Start time: 18:24:44 on Apr 15,2020
# Loading work.Coordinator_Module
# Loading work.Step_Module
# Loading work.RAM2
add wave -position insertpoint  \
sim:/Coordinator_Module/Step/CLK \
sim:/Coordinator_Module/Step/count \
sim:/Coordinator_Module/Step/Temp \
sim:/Coordinator_Module/Step/hstate \
sim:/Coordinator_Module/Step/M \
sim:/Coordinator_Module/Step/N \
sim:/Coordinator_Module/Step/RST \
sim:/Coordinator_Module/Step/State \
sim:/Coordinator_Module/Step/NextState \
sim:/Coordinator_Module/Step/RAM_Address_RD_A
add wave -position end  sim:/Coordinator_Module/Step/RAM_Address_RD_B
add wave -position end  sim:/Coordinator_Module/Step/RAM_Data_RD_A
add wave -position end  sim:/Coordinator_Module/Step/RAM_Data_RD_B
add wave -position end  sim:/Coordinator_Module/Step/Step_Memory_WR_Enable
add wave -position end  sim:/Coordinator_Module/Step/RAM_Address_WR
add wave -position end  sim:/Coordinator_Module/Step/RAM_Data_WR
add wave -position 16  sim:/Coordinator_Module/Step/hnew
add wave -position 16  sim:/Coordinator_Module/Step/htemp
add wave -position end  sim:/Coordinator_Module/Step/Euler_Enable
add wave -position end  sim:/Coordinator_Module/Step/Euler_End
add wave -position end  sim:/Coordinator_Module/Step/X_process_ADD
add wave -position end  sim:/Coordinator_Module/Step/Xn0_ADD
add wave -position end  sim:/Coordinator_Module/Step/Errortemp

add wave -position end  sim:/Coordinator_Module/Step/adder_out1
add wave -position end  sim:/Coordinator_Module/Step/adder_out2
add wave -position end  sim:/Coordinator_Module/Step/out



add wave -position 24  sim:/Coordinator_Module/Step/flag
add wave -position end  sim:/Coordinator_Module/Step/first_operand
add wave -position end  sim:/Coordinator_Module/Step/second_operand
add wave -position end  sim:/Coordinator_Module/Step/mult_enable
add wave -position end  sim:/Coordinator_Module/Step/mult_overflow

add wave -position end  sim:/Coordinator_Module/Step/adder_enable1
add wave -position end  sim:/Coordinator_Module/Step/in11
add wave -position end  sim:/Coordinator_Module/Step/in21
add wave -position end  sim:/Coordinator_Module/Step/sub1


add wave -position end  sim:/Coordinator_Module/Step/adder_enable2
add wave -position end  sim:/Coordinator_Module/Step/in12
add wave -position end  sim:/Coordinator_Module/Step/in22
add wave -position end  sim:/Coordinator_Module/Step/sub2

add wave -position end  sim:/Coordinator_Module/Step/CLK
add wave -position end  sim:/Coordinator_Module/Step/reset
add wave -position end  sim:/Coordinator_Module/Step/dividend
add wave -position end  sim:/Coordinator_Module/Step/divisor
add wave -position end  sim:/Coordinator_Module/Step/Q
add wave -position end  sim:/Coordinator_Module/Step/ready
add wave -position end  sim:/Coordinator_Module/Step/div_overflow
add wave -position end  sim:/Coordinator_Module/Step/divideByZero

force -freeze sim:/Coordinator_Module/RST 1 0
force -freeze sim:/Coordinator_Module/CLK 1 0, 0 {50 ps} -r 100
run 50 ps
force -freeze sim:/Coordinator_Module/RST 0 0


# load n , m ,mode ,tolerance ,h temp , h init
mem load -filltype value -filldata 10 -fillradix symbolic /Coordinator_Module/Memory/Memory(0)
mem load -filltype value -filldata 11 -fillradix symbolic /Coordinator_Module/Memory/Memory(1)
mem load -filltype value -filldata 01 -fillradix symbolic /Coordinator_Module/Memory/Memory(2)
mem load -filltype value -filldata 11 -fillradix symbolic /Coordinator_Module/Memory/Memory(3)
mem load -filltype value -filldata 10 -fillradix symbolic /Coordinator_Module/Memory/Memory(4)
mem load -filltype value -filldata 10 -fillradix symbolic /Coordinator_Module/Memory/Memory(5)

# load x process -> (xn+1)0
mem load -filltype value -filldata 100 -fillradix symbolic /Coordinator_Module/Memory/Memory(56)
mem load -filltype value -filldata 101 -fillradix symbolic /Coordinator_Module/Memory/Memory(57)

# load x init -> (xn+1)1
mem load -filltype value -filldata 110 -fillradix symbolic /Coordinator_Module/Memory/Memory(6)
mem load -filltype value -filldata 111 -fillradix symbolic /Coordinator_Module/Memory/Memory(7)

run 200 ps
force -freeze sim:/Coordinator_Module/Step/Euler_End 1 0
run 100 ps
force -freeze sim:/Coordinator_Module/Step/Euler_End 0 0
run 200 ps

run 1 ns
run 1 ns
run 700 ps
# division end
run 200ps
force -freeze sim:/Coordinator_Module/Step/Euler_End 1 0
run 100 ps
force -freeze sim:/Coordinator_Module/Step/Euler_End 0 0
run 200 ps
force -freeze sim:/Coordinator_Module/Step/Euler_End 1 0
run 100 ps
force -freeze sim:/Coordinator_Module/Step/Euler_End 0 0
run 200 ps
run 1 ns
run 3 ns


# at Compare stage in case not to calculate new h uncomment next line
#force -freeze sim:/Coordinator_Module/Step/Errortemp 000000000000000000000000000000000000000000000000000000000000010 0
run 1 ns

