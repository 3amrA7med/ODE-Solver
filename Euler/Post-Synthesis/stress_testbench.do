vlog *.v
quit -sim
vsim work.System
radix -unsigned
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(0)
add wave /System/Main/*
force -freeze System/CLK 0 1, 1 {50 ps} -r 100
force System/INT 0
force System/RST 1
force System/Interpolate_DONE 0
run 100 ps
force System/RST 0


################################################## Testcase: 0 ##################################################
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(11)

#Set X Matrix
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5209)

#Set B Matrix
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2511)

#Set U Matrix
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5259)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 350 ps
run 100 ps
run 400 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 96} {
error "Test0: Failed, XNew[0] != 96"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 114} {
error "Test0: Failed, XNew[1] != 114"
}
puts "Test 0 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 1 ##################################################
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(11)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(12)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(13)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(14)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(15)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(16)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(17)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(18)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(19)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(20)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(21)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(22)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(23)

#Set X Matrix
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(5209)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(5210)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5211)

#Set B Matrix
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2511)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(2512)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(2513)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2514)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(2515)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2516)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(2517)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2518)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(2519)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2520)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2521)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(2522)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2523)

#Set U Matrix
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5259)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(5260)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5261)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 1550 ps
run 100 ps
run 1600 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 156} {
error "Test1: Failed, XNew[0] != 156"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 64} {
error "Test1: Failed, XNew[1] != 64"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 135} {
error "Test1: Failed, XNew[2] != 135"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 126} {
error "Test1: Failed, XNew[3] != 126"
}
puts "Test 1 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 2 ##################################################
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(11)

#Set X Matrix
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5209)

#Set B Matrix
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2509)

#Set U Matrix
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5258)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 150 ps
run 100 ps
run 400 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 409} {
error "Test2: Failed, XNew[0] != 409"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 191} {
error "Test2: Failed, XNew[1] != 191"
}
puts "Test 2 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 3 ##################################################
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(8)

#Set X Matrix
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5208)

#Set B Matrix
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2508)

#Set U Matrix
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5258)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 50 ps
run 100 ps
run 100 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 74} {
error "Test3: Failed, XNew[0] != 74"
}
puts "Test 3 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 4 ##################################################
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(11)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(12)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(13)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(14)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(15)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(16)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(17)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(18)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(19)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(20)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(21)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(22)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(23)

#Set X Matrix
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(5209)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5210)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5211)

#Set B Matrix
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2511)

#Set U Matrix
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5258)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 350 ps
run 100 ps
run 1600 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 659} {
error "Test4: Failed, XNew[0] != 659"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 1050} {
error "Test4: Failed, XNew[1] != 1050"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 288} {
error "Test4: Failed, XNew[2] != 288"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 1358} {
error "Test4: Failed, XNew[3] != 1358"
}
puts "Test 4 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 5 ##################################################
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(11)

#Set X Matrix
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5209)

#Set B Matrix
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2511)

#Set U Matrix
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5259)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 350 ps
run 100 ps
run 400 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 167} {
error "Test5: Failed, XNew[0] != 167"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 139} {
error "Test5: Failed, XNew[1] != 139"
}
puts "Test 5 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 6 ##################################################
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(11)

#Set X Matrix
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5209)

#Set B Matrix
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2511)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2512)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2513)

#Set U Matrix
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(5259)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5260)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 550 ps
run 100 ps
run 400 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 731} {
error "Test6: Failed, XNew[0] != 731"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 1125} {
error "Test6: Failed, XNew[1] != 1125"
}
puts "Test 6 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 7 ##################################################
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(11)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(12)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(13)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(14)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(15)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(16)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(17)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(18)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(19)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(20)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(21)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(22)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(23)

#Set X Matrix
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(5209)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5210)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5211)

#Set B Matrix
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2511)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(2512)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2513)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(2514)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2515)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2516)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2517)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(2518)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2519)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2520)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2521)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2522)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2523)

#Set U Matrix
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(5259)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5260)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5261)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 1550 ps
run 100 ps
run 1600 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 1087} {
error "Test7: Failed, XNew[0] != 1087"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 1164} {
error "Test7: Failed, XNew[1] != 1164"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 940} {
error "Test7: Failed, XNew[2] != 940"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 602} {
error "Test7: Failed, XNew[3] != 602"
}
puts "Test 7 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 8 ##################################################
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(11)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(12)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(13)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(14)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(15)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(16)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(17)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(18)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(19)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(20)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(21)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(22)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(23)

#Set X Matrix
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(5209)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(5210)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5211)

#Set B Matrix
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2511)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(2512)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(2513)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2514)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2515)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2516)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2517)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2518)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(2519)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2520)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2521)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(2522)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2523)

#Set U Matrix
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5259)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(5260)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5261)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 1550 ps
run 100 ps
run 1600 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 1611} {
error "Test8: Failed, XNew[0] != 1611"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 1400} {
error "Test8: Failed, XNew[1] != 1400"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 981} {
error "Test8: Failed, XNew[2] != 981"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 1054} {
error "Test8: Failed, XNew[3] != 1054"
}
puts "Test 8 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 9 ##################################################
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(11)

#Set X Matrix
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5209)

#Set B Matrix
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(2511)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(2512)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2513)

#Set U Matrix
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(5259)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5260)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 550 ps
run 100 ps
run 400 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 310} {
error "Test9: Failed, XNew[0] != 310"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 460} {
error "Test9: Failed, XNew[1] != 460"
}
puts "Test 9 Passed!"
run 250 ps
force System/INT 0
run 100 ps
puts "All tests Passed Successfully!"
