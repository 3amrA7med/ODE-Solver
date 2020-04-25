# Testbench for Step module

vsim work.Coordinator_Module

radix -unsigned

add wave *

set n 8

set m 9

set mode 1

set l 3

set h_temp 32829

set h_init 32829

set x_process 6

set x_init 56

set x_n+1_0 106

set cur 0





# Answers

set Error 24796

set hnew 24583





force -freeze sim:/Coordinator_Module/Euler_End 0 0

force -freeze sim:/Coordinator_Module/CLK 1 0, 0 {50 ps} -r 100

force -freeze sim:/Coordinator_Module/RST 1 0

run 250 ps

force -freeze sim:/Coordinator_Module/RST St0 0





mem load -filltype value -filldata $n -fillradix unsigned /Coordinator_Module/Memory/Memory(0)

mem load -filltype value -filldata $m -fillradix unsigned /Coordinator_Module/Memory/Memory(1)

mem load -filltype value -filldata $mode -fillradix unsigned /Coordinator_Module/Memory/Memory(2)

mem load -filltype value -filldata $l -fillradix unsigned /Coordinator_Module/Memory/Memory(3)

mem load -filltype value -filldata $h_temp -fillradix unsigned /Coordinator_Module/Memory/Memory(4)

mem load -filltype value -filldata $h_init -fillradix unsigned /Coordinator_Module/Memory/Memory(5)

mem load -filltype value -filldata { 16409 } -fillradix unsigned /Coordinator_Module/Memory/Memory([expr $cur + $x_process])

mem load -filltype value -filldata { 24613 } -fillradix unsigned /Coordinator_Module/Memory/Memory([expr $cur + $x_init])

incr cur;

mem load -filltype value -filldata { 24599 } -fillradix unsigned /Coordinator_Module/Memory/Memory([expr $cur + $x_process])

mem load -filltype value -filldata { 16427 } -fillradix unsigned /Coordinator_Module/Memory/Memory([expr $cur + $x_init])

incr cur;

mem load -filltype value -filldata { 16414 } -fillradix unsigned /Coordinator_Module/Memory/Memory([expr $cur + $x_process])

mem load -filltype value -filldata { 8198 } -fillradix unsigned /Coordinator_Module/Memory/Memory([expr $cur + $x_init])

incr cur;

mem load -filltype value -filldata { 24662 } -fillradix unsigned /Coordinator_Module/Memory/Memory([expr $cur + $x_process])

mem load -filltype value -filldata { 16418 } -fillradix unsigned /Coordinator_Module/Memory/Memory([expr $cur + $x_init])

incr cur;

mem load -filltype value -filldata { 24653 } -fillradix unsigned /Coordinator_Module/Memory/Memory([expr $cur + $x_process])

mem load -filltype value -filldata { 8212 } -fillradix unsigned /Coordinator_Module/Memory/Memory([expr $cur + $x_init])

incr cur;

mem load -filltype value -filldata { 16392 } -fillradix unsigned /Coordinator_Module/Memory/Memory([expr $cur + $x_process])

mem load -filltype value -filldata { 24663 } -fillradix unsigned /Coordinator_Module/Memory/Memory([expr $cur + $x_init])

incr cur;

mem load -filltype value -filldata { 16402 } -fillradix unsigned /Coordinator_Module/Memory/Memory([expr $cur + $x_process])

mem load -filltype value -filldata { 8203 } -fillradix unsigned /Coordinator_Module/Memory/Memory([expr $cur + $x_init])

incr cur;

mem load -filltype value -filldata { 8200 } -fillradix unsigned /Coordinator_Module/Memory/Memory([expr $cur + $x_process])

mem load -filltype value -filldata { 3 } -fillradix unsigned /Coordinator_Module/Memory/Memory([expr $cur + $x_init])

incr cur;

run 200 ps

force -freeze sim:/Coordinator_Module/Step/Euler_End 1 0

run 100 ps

force -freeze sim:/Coordinator_Module/Step/Euler_End 0 0

run 200 ps

for {set i 0} {$i < [expr $n]} {incr i} {

run 500 ps }

run 2 ns

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

run 500 ps }

run 100 ps

run 3 ns

set val [examine /Coordinator_Module/Error_Flag ]

if {$val == 1} {

error "Test0: Error in Chip Error_Flag = 1 "}


set val [examine /Coordinator_Module/Memory/Memory(4) ]

if {$val != $hnew} {

error "Test1: Failed, h_temp != $hnew }

set val [examine /Coordinator_Module/Memory/Memory(5) ]

if {$val != $hnew} {

error "Test2: Failed, h_init != $hnew }

puts "All tests Passed Successfully!";
