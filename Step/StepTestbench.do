# Testbench for Step module

vsim work.Coordinator_Module

radix -unsigned

add wave *
#add wave -position end  sim:/Coordinator_Module/Step/State

set n 2
set m 3
set mode 1
set l 3
set h_temp 2
set h_init 2
set x_process 6
set x_init 56
set x_n+1_0 106

set cur 4;


#Answers
set Error 4
set hnew 24597


force -freeze sim:/Coordinator_Module/RST 1 0
force -freeze sim:/Coordinator_Module/CLK 1 0, 0 {50 ps} -r 100
run 50 ps
force -freeze sim:/Coordinator_Module/RST 0 0


mem load -filltype value -filldata $n -fillradix unsigned /Coordinator_Module/Memory/Memory(0)
mem load -filltype value -filldata $m -fillradix unsigned /Coordinator_Module/Memory/Memory(1)
mem load -filltype value -filldata $mode -fillradix unsigned /Coordinator_Module/Memory/Memory(2)
mem load -filltype value -filldata $l -fillradix unsigned /Coordinator_Module/Memory/Memory(3)
mem load -filltype value -filldata $h_temp -fillradix unsigned /Coordinator_Module/Memory/Memory(4)
mem load -filltype value -filldata $h_init -fillradix unsigned /Coordinator_Module/Memory/Memory(5)


#Set X init x init -> (xn+1)1
for {set i 0} {$i < [expr $n]} {incr i} {
    mem load -filltype value -filldata $cur -fillradix unsigned /Coordinator_Module/Memory/Memory([expr $i+$x_init])
    incr cur;
}

#Set X process   x process -> (xn+1)0
for {set i 0} {$i < [expr $n]} {incr i} {
    mem load -filltype value -filldata $cur -fillradix unsigned /Coordinator_Module/Memory/Memory([expr $i+$x_process])
    incr cur;
}


run 200 ps
force -freeze sim:/Coordinator_Module/Step/Euler_End 1 0
run 100 ps
force -freeze sim:/Coordinator_Module/Step/Euler_End 0 0
run 200 ps

for {set i 0} {$i < [expr $n]} {incr i} {
    run 400 ps
}

run 2 ns
# division end
run 200 ps
force -freeze sim:/Coordinator_Module/Step/Euler_End 1 0
run 100 ps
force -freeze sim:/Coordinator_Module/Step/Euler_End 0 0
run 200 ps
force -freeze sim:/Coordinator_Module/Step/Euler_End 1 0
run 100 ps
force -freeze sim:/Coordinator_Module/Step/Euler_End 0 0
run 200 ps

for {set i 0} {$i < [expr $n]} {incr i} {
    run 400 ps
}

 # Compare stage
run 100 ps

run 3 ns

set val [examine /Coordinator_Module/Step/Errortemp ]
if {$val != $Error} {
    error "Test1: Failed, Errortemp != $Error"
}

set val [examine /Coordinator_Module/Memory/Memory(4) ]
if {$val != $hnew} {
    error "Test2: Failed, h_temp != $hnew"
}

set val [examine /Coordinator_Module/Memory/Memory(5) ]
if {$val != $hnew} {
    error "Test3: Failed, h_init != $hnew"
}


puts "All tests Passed Successfully!";
