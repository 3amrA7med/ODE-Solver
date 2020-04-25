vlog *.v
quit -sim
vsim work.System
radix -unsigned
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(0)
add wave -r /*
force -freeze System/CLK 0 1, 1 {50 ps} -r 100
force System/INT 0
force System/RST 1
force System/Interpolate_DONE 0
run 200 ps
force System/RST 0


################################################## Testcase: 0 ##################################################
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(8)

#Set X Matrix
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5208)

#Set B Matrix
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2509)

#Set U Matrix
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5259)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 150 ps
run 100 ps
run 100 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 687} {
error "Test0: Failed, XNew[0] != 687"
}
puts "Test 0 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 1 ##################################################
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(11)

#Set X Matrix
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5209)

#Set B Matrix
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2511)

#Set U Matrix
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(5258)
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
if {$val != 264} {
error "Test1: Failed, XNew[0] != 264"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 620} {
error "Test1: Failed, XNew[1] != 620"
}
puts "Test 1 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 2 ##################################################
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(11)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(12)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(13)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(14)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(15)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(16)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(17)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(18)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(19)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(20)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(21)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(22)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(23)

#Set X Matrix
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(5209)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5210)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5211)

#Set B Matrix
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2511)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2512)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(2513)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2514)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2515)

#Set U Matrix
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5259)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 750 ps
run 100 ps
run 1600 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 360} {
error "Test2: Failed, XNew[0] != 360"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 290} {
error "Test2: Failed, XNew[1] != 290"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 92} {
error "Test2: Failed, XNew[2] != 92"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 196} {
error "Test2: Failed, XNew[3] != 196"
}
puts "Test 2 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 3 ##################################################
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(11)

#Set X Matrix
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5209)

#Set B Matrix
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2511)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(2512)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2513)

#Set U Matrix
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(5258)
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
if {$val != 788} {
error "Test3: Failed, XNew[0] != 788"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 452} {
error "Test3: Failed, XNew[1] != 452"
}
puts "Test 3 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 4 ##################################################
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(11)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(12)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(13)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(14)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(15)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(16)

#Set X Matrix
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5209)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5210)

#Set B Matrix
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(2511)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(2512)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(2513)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(2514)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(2515)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2516)

#Set U Matrix
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(5259)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5260)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 850 ps
run 100 ps
run 900 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 272} {
error "Test4: Failed, XNew[0] != 272"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 331} {
error "Test4: Failed, XNew[1] != 331"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 437} {
error "Test4: Failed, XNew[2] != 437"
}
puts "Test 4 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 5 ##################################################
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(11)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(12)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(13)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(14)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(15)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(16)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(17)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(18)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(19)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(20)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(21)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(22)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(23)

#Set X Matrix
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(5209)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(5210)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5211)

#Set B Matrix
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2511)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(2512)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2513)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(2514)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(2515)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2516)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2517)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(2518)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(2519)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2520)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(2521)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2522)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2523)

#Set U Matrix
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(5258)
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
if {$val != 361} {
error "Test5: Failed, XNew[0] != 361"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 339} {
error "Test5: Failed, XNew[1] != 339"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 321} {
error "Test5: Failed, XNew[2] != 321"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 280} {
error "Test5: Failed, XNew[3] != 280"
}
puts "Test 5 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 6 ##################################################
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(8)

#Set X Matrix
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5208)

#Set B Matrix
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2510)

#Set U Matrix
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(5259)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5260)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 250 ps
run 100 ps
run 100 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 221} {
error "Test6: Failed, XNew[0] != 221"
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
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(11)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(12)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(13)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(14)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(15)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(16)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(17)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(18)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(19)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(20)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(21)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(22)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(23)

#Set X Matrix
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(5209)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(5210)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5211)

#Set B Matrix
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2511)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2512)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2513)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2514)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(2515)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(2516)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2517)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(2518)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(2519)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2520)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(2521)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(2522)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2523)

#Set U Matrix
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(5259)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(5260)
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
if {$val != 2159} {
error "Test7: Failed, XNew[0] != 2159"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 940} {
error "Test7: Failed, XNew[1] != 940"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 1444} {
error "Test7: Failed, XNew[2] != 1444"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 2077} {
error "Test7: Failed, XNew[3] != 2077"
}
puts "Test 7 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 8 ##################################################
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(11)

#Set X Matrix
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5209)

#Set B Matrix
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2509)

#Set U Matrix
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(5257)
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
if {$val != 23} {
error "Test8: Failed, XNew[0] != 23"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 22} {
error "Test8: Failed, XNew[1] != 22"
}
puts "Test 8 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 9 ##################################################
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(11)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(12)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(13)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(14)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(15)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(16)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(17)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(18)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(19)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(20)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(21)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(22)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(23)

#Set X Matrix
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5209)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(5210)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5211)

#Set B Matrix
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(2511)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2512)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(2513)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2514)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(2515)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(2516)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2517)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2518)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2519)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2520)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2521)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2522)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2523)

#Set U Matrix
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(5257)
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
if {$val != 108} {
error "Test9: Failed, XNew[0] != 108"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 281} {
error "Test9: Failed, XNew[1] != 281"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 320} {
error "Test9: Failed, XNew[2] != 320"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 544} {
error "Test9: Failed, XNew[3] != 544"
}
puts "Test 9 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 10 ##################################################
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(11)

#Set X Matrix
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5209)

#Set B Matrix
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2509)

#Set U Matrix
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(5257)
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
if {$val != 816} {
error "Test10: Failed, XNew[0] != 816"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 729} {
error "Test10: Failed, XNew[1] != 729"
}
puts "Test 10 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 11 ##################################################
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(8)

#Set X Matrix
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5208)

#Set B Matrix
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2511)

#Set U Matrix
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(5259)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(5260)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5261)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 350 ps
run 100 ps
run 100 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 519} {
error "Test11: Failed, XNew[0] != 519"
}
puts "Test 11 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 12 ##################################################
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(8)

#Set X Matrix
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5208)

#Set B Matrix
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2510)

#Set U Matrix
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(5259)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5260)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 250 ps
run 100 ps
run 100 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 343} {
error "Test12: Failed, XNew[0] != 343"
}
puts "Test 12 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 13 ##################################################
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(11)

#Set X Matrix
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5209)

#Set B Matrix
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2511)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2512)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(2513)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(2514)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2515)

#Set U Matrix
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(5259)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(5260)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5261)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 750 ps
run 100 ps
run 400 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 619} {
error "Test13: Failed, XNew[0] != 619"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 507} {
error "Test13: Failed, XNew[1] != 507"
}
puts "Test 13 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 14 ##################################################
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(11)

#Set X Matrix
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5209)

#Set B Matrix
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2511)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2512)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2513)

#Set U Matrix
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5259)
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
if {$val != 540} {
error "Test14: Failed, XNew[0] != 540"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 875} {
error "Test14: Failed, XNew[1] != 875"
}
puts "Test 14 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 15 ##################################################
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(11)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(12)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(13)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(14)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(15)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(16)

#Set X Matrix
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(5209)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5210)

#Set B Matrix
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2511)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(2512)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2513)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2514)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2515)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2516)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(2517)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(2518)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2519)

#Set U Matrix
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(5259)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(5260)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5261)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 1150 ps
run 100 ps
run 900 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 1250} {
error "Test15: Failed, XNew[0] != 1250"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 980} {
error "Test15: Failed, XNew[1] != 980"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 1362} {
error "Test15: Failed, XNew[2] != 1362"
}
puts "Test 15 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 16 ##################################################
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(8)

#Set X Matrix
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5208)

#Set B Matrix
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2509)

#Set U Matrix
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5259)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 150 ps
run 100 ps
run 100 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 217} {
error "Test16: Failed, XNew[0] != 217"
}
puts "Test 16 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 17 ##################################################
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(11)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(12)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(13)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(14)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(15)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(16)

#Set X Matrix
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(5209)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5210)

#Set B Matrix
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(2511)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2512)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2513)

#Set U Matrix
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5259)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 550 ps
run 100 ps
run 900 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 974} {
error "Test17: Failed, XNew[0] != 974"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 746} {
error "Test17: Failed, XNew[1] != 746"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 1141} {
error "Test17: Failed, XNew[2] != 1141"
}
puts "Test 17 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 18 ##################################################
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(11)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(12)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(13)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(14)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(15)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(16)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(17)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(18)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(19)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(20)
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(21)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(22)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(23)

#Set X Matrix
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(5209)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(5210)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5211)

#Set B Matrix
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2511)

#Set U Matrix
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(5257)
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
if {$val != 1366} {
error "Test18: Failed, XNew[0] != 1366"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 1109} {
error "Test18: Failed, XNew[1] != 1109"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 1292} {
error "Test18: Failed, XNew[2] != 1292"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 318} {
error "Test18: Failed, XNew[3] != 318"
}
puts "Test 18 Passed!"
run 250 ps
force System/INT 0
run 100 ps


################################################## Testcase: 19 ##################################################
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(5457)

#Set A Matrix
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(8)

#Set X Matrix
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5208)

#Set B Matrix
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(2509)

#Set U Matrix
mem load -filltype value -filldata 5 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 6 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 0 -fillradix unsigned /System/Memory/Memory(5259)
force System/INT 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 150 ps
run 100 ps
run 100 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 791} {
error "Test19: Failed, XNew[0] != 791"
}
puts "Test 19 Passed!"
run 250 ps
force System/INT 0
run 100 ps
puts "All tests Passed Successfully!"
