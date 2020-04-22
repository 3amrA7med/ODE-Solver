vlog *.v
quit -sim
vsim work.Euler
radix -unsigned
add wave *
force -freeze CLK 0 1, 1 {50 ps} -r 100
force INT 0
force PROCESS 0
run 100 ps


################################################## Testcase: 0 ##################################################
mem load -filltype value -filldata 4 -fillradix unsigned /Euler/Memory/Memory(0)
mem load -filltype value -filldata 3 -fillradix unsigned /Euler/Memory/Memory(1)
mem load -filltype value -filldata 2 -fillradix unsigned /Euler/Memory/Memory(4)

#Set A Matrix
mem load -filltype value -filldata 5473 -fillradix unsigned /Euler/Memory/Memory(7)
mem load -filltype value -filldata 1 -fillradix unsigned /Euler/Memory/Memory(8)
mem load -filltype value -filldata 2602 -fillradix unsigned /Euler/Memory/Memory(9)
mem load -filltype value -filldata 5974 -fillradix unsigned /Euler/Memory/Memory(10)
mem load -filltype value -filldata 191 -fillradix unsigned /Euler/Memory/Memory(11)
mem load -filltype value -filldata 4408 -fillradix unsigned /Euler/Memory/Memory(12)
mem load -filltype value -filldata 3868 -fillradix unsigned /Euler/Memory/Memory(13)
mem load -filltype value -filldata 3912 -fillradix unsigned /Euler/Memory/Memory(14)
mem load -filltype value -filldata 920 -fillradix unsigned /Euler/Memory/Memory(15)
mem load -filltype value -filldata 6964 -fillradix unsigned /Euler/Memory/Memory(16)
mem load -filltype value -filldata 7645 -fillradix unsigned /Euler/Memory/Memory(17)
mem load -filltype value -filldata 386 -fillradix unsigned /Euler/Memory/Memory(18)
mem load -filltype value -filldata 2041 -fillradix unsigned /Euler/Memory/Memory(19)
mem load -filltype value -filldata 1387 -fillradix unsigned /Euler/Memory/Memory(20)
mem load -filltype value -filldata 1036 -fillradix unsigned /Euler/Memory/Memory(21)
mem load -filltype value -filldata 5236 -fillradix unsigned /Euler/Memory/Memory(22)

#Set X Matrix
mem load -filltype value -filldata 6744 -fillradix unsigned /Euler/Memory/Memory(5207)
mem load -filltype value -filldata 2234 -fillradix unsigned /Euler/Memory/Memory(5208)
mem load -filltype value -filldata 1928 -fillradix unsigned /Euler/Memory/Memory(5209)
mem load -filltype value -filldata 6090 -fillradix unsigned /Euler/Memory/Memory(5210)

#Set B Matrix
mem load -filltype value -filldata 1761 -fillradix unsigned /Euler/Memory/Memory(2507)
mem load -filltype value -filldata 9 -fillradix unsigned /Euler/Memory/Memory(2508)
mem load -filltype value -filldata 642 -fillradix unsigned /Euler/Memory/Memory(2509)
mem load -filltype value -filldata 1470 -fillradix unsigned /Euler/Memory/Memory(2510)
mem load -filltype value -filldata 6451 -fillradix unsigned /Euler/Memory/Memory(2511)
mem load -filltype value -filldata 4186 -fillradix unsigned /Euler/Memory/Memory(2512)
mem load -filltype value -filldata 3273 -fillradix unsigned /Euler/Memory/Memory(2513)
mem load -filltype value -filldata 3919 -fillradix unsigned /Euler/Memory/Memory(2514)
mem load -filltype value -filldata 7276 -fillradix unsigned /Euler/Memory/Memory(2515)
mem load -filltype value -filldata 3387 -fillradix unsigned /Euler/Memory/Memory(2516)
mem load -filltype value -filldata 7160 -fillradix unsigned /Euler/Memory/Memory(2517)
mem load -filltype value -filldata 3737 -fillradix unsigned /Euler/Memory/Memory(2518)

#Set U Matrix
mem load -filltype value -filldata 7657 -fillradix unsigned /Euler/Memory/Memory(5257)
mem load -filltype value -filldata 3067 -fillradix unsigned /Euler/Memory/Memory(5258)
mem load -filltype value -filldata 8003 -fillradix unsigned /Euler/Memory/Memory(5259)
force INT 1
run 200 ps
force PROCESS 1
run 400 ps
force Interpolate_DONE 1
run 200 ps
force Interpolate_DONE 0
run 1150 ps
run 100 ps
run 1600 ps
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 71192} {
error "Test0: Failed, XNew[0] != 71192"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 67524} {
error "Test0: Failed, XNew[1] != 67524"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 7396} {
error "Test0: Failed, XNew[2] != 7396"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 6162} {
error "Test0: Failed, XNew[3] != 6162"
}
puts "Test 0 Passed!"
run 250 ps
force INT 0
force PROCESS 0
run 100 ps


################################################## Testcase: 1 ##################################################
mem load -filltype value -filldata 4 -fillradix unsigned /Euler/Memory/Memory(0)
mem load -filltype value -filldata 4 -fillradix unsigned /Euler/Memory/Memory(1)
mem load -filltype value -filldata 4 -fillradix unsigned /Euler/Memory/Memory(4)

#Set A Matrix
mem load -filltype value -filldata 2820 -fillradix unsigned /Euler/Memory/Memory(7)
mem load -filltype value -filldata 3553 -fillradix unsigned /Euler/Memory/Memory(8)
mem load -filltype value -filldata 2450 -fillradix unsigned /Euler/Memory/Memory(9)
mem load -filltype value -filldata 5601 -fillradix unsigned /Euler/Memory/Memory(10)
mem load -filltype value -filldata 6842 -fillradix unsigned /Euler/Memory/Memory(11)
mem load -filltype value -filldata 2499 -fillradix unsigned /Euler/Memory/Memory(12)
mem load -filltype value -filldata 201 -fillradix unsigned /Euler/Memory/Memory(13)
mem load -filltype value -filldata 72 -fillradix unsigned /Euler/Memory/Memory(14)
mem load -filltype value -filldata 4938 -fillradix unsigned /Euler/Memory/Memory(15)
mem load -filltype value -filldata 3700 -fillradix unsigned /Euler/Memory/Memory(16)
mem load -filltype value -filldata 4889 -fillradix unsigned /Euler/Memory/Memory(17)
mem load -filltype value -filldata 5886 -fillradix unsigned /Euler/Memory/Memory(18)
mem load -filltype value -filldata 6910 -fillradix unsigned /Euler/Memory/Memory(19)
mem load -filltype value -filldata 3507 -fillradix unsigned /Euler/Memory/Memory(20)
mem load -filltype value -filldata 5212 -fillradix unsigned /Euler/Memory/Memory(21)
mem load -filltype value -filldata 7004 -fillradix unsigned /Euler/Memory/Memory(22)

#Set X Matrix
mem load -filltype value -filldata 999 -fillradix unsigned /Euler/Memory/Memory(5207)
mem load -filltype value -filldata 6150 -fillradix unsigned /Euler/Memory/Memory(5208)
mem load -filltype value -filldata 5018 -fillradix unsigned /Euler/Memory/Memory(5209)
mem load -filltype value -filldata 3642 -fillradix unsigned /Euler/Memory/Memory(5210)

#Set B Matrix
mem load -filltype value -filldata 2866 -fillradix unsigned /Euler/Memory/Memory(2507)
mem load -filltype value -filldata 2774 -fillradix unsigned /Euler/Memory/Memory(2508)
mem load -filltype value -filldata 2654 -fillradix unsigned /Euler/Memory/Memory(2509)
mem load -filltype value -filldata 6133 -fillradix unsigned /Euler/Memory/Memory(2510)
mem load -filltype value -filldata 7535 -fillradix unsigned /Euler/Memory/Memory(2511)
mem load -filltype value -filldata 3659 -fillradix unsigned /Euler/Memory/Memory(2512)
mem load -filltype value -filldata 4031 -fillradix unsigned /Euler/Memory/Memory(2513)
mem load -filltype value -filldata 1679 -fillradix unsigned /Euler/Memory/Memory(2514)
mem load -filltype value -filldata 1483 -fillradix unsigned /Euler/Memory/Memory(2515)
mem load -filltype value -filldata 7000 -fillradix unsigned /Euler/Memory/Memory(2516)
mem load -filltype value -filldata 5938 -fillradix unsigned /Euler/Memory/Memory(2517)
mem load -filltype value -filldata 7572 -fillradix unsigned /Euler/Memory/Memory(2518)
mem load -filltype value -filldata 567 -fillradix unsigned /Euler/Memory/Memory(2519)
mem load -filltype value -filldata 7738 -fillradix unsigned /Euler/Memory/Memory(2520)
mem load -filltype value -filldata 5800 -fillradix unsigned /Euler/Memory/Memory(2521)
mem load -filltype value -filldata 6598 -fillradix unsigned /Euler/Memory/Memory(2522)

#Set U Matrix
mem load -filltype value -filldata 3182 -fillradix unsigned /Euler/Memory/Memory(5257)
mem load -filltype value -filldata 4253 -fillradix unsigned /Euler/Memory/Memory(5258)
mem load -filltype value -filldata 3369 -fillradix unsigned /Euler/Memory/Memory(5259)
mem load -filltype value -filldata 7463 -fillradix unsigned /Euler/Memory/Memory(5260)
force INT 1
run 200 ps
force PROCESS 1
run 400 ps
force Interpolate_DONE 1
run 200 ps
force Interpolate_DONE 0
run 1550 ps
run 100 ps
run 1600 ps
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 6931} {
error "Test1: Failed, XNew[0] != 6931"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 67282} {
error "Test1: Failed, XNew[1] != 67282"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 7914} {
error "Test1: Failed, XNew[2] != 7914"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 6562} {
error "Test1: Failed, XNew[3] != 6562"
}
puts "Test 1 Passed!"
run 250 ps
force INT 0
force PROCESS 0
run 100 ps


################################################## Testcase: 2 ##################################################
mem load -filltype value -filldata 3 -fillradix unsigned /Euler/Memory/Memory(0)
mem load -filltype value -filldata 5 -fillradix unsigned /Euler/Memory/Memory(1)
mem load -filltype value -filldata 10 -fillradix unsigned /Euler/Memory/Memory(4)

#Set A Matrix
mem load -filltype value -filldata 1812 -fillradix unsigned /Euler/Memory/Memory(7)
mem load -filltype value -filldata 3592 -fillradix unsigned /Euler/Memory/Memory(8)
mem load -filltype value -filldata 6757 -fillradix unsigned /Euler/Memory/Memory(9)
mem load -filltype value -filldata 5475 -fillradix unsigned /Euler/Memory/Memory(10)
mem load -filltype value -filldata 3491 -fillradix unsigned /Euler/Memory/Memory(11)
mem load -filltype value -filldata 7836 -fillradix unsigned /Euler/Memory/Memory(12)
mem load -filltype value -filldata 6963 -fillradix unsigned /Euler/Memory/Memory(13)
mem load -filltype value -filldata 3560 -fillradix unsigned /Euler/Memory/Memory(14)
mem load -filltype value -filldata 4675 -fillradix unsigned /Euler/Memory/Memory(15)

#Set X Matrix
mem load -filltype value -filldata 4126 -fillradix unsigned /Euler/Memory/Memory(5207)
mem load -filltype value -filldata 943 -fillradix unsigned /Euler/Memory/Memory(5208)
mem load -filltype value -filldata 4446 -fillradix unsigned /Euler/Memory/Memory(5209)

#Set B Matrix
mem load -filltype value -filldata 6360 -fillradix unsigned /Euler/Memory/Memory(2507)
mem load -filltype value -filldata 3530 -fillradix unsigned /Euler/Memory/Memory(2508)
mem load -filltype value -filldata 5407 -fillradix unsigned /Euler/Memory/Memory(2509)
mem load -filltype value -filldata 7625 -fillradix unsigned /Euler/Memory/Memory(2510)
mem load -filltype value -filldata 7441 -fillradix unsigned /Euler/Memory/Memory(2511)
mem load -filltype value -filldata 3640 -fillradix unsigned /Euler/Memory/Memory(2512)
mem load -filltype value -filldata 4020 -fillradix unsigned /Euler/Memory/Memory(2513)
mem load -filltype value -filldata 5865 -fillradix unsigned /Euler/Memory/Memory(2514)
mem load -filltype value -filldata 7111 -fillradix unsigned /Euler/Memory/Memory(2515)
mem load -filltype value -filldata 2922 -fillradix unsigned /Euler/Memory/Memory(2516)
mem load -filltype value -filldata 334 -fillradix unsigned /Euler/Memory/Memory(2517)
mem load -filltype value -filldata 1915 -fillradix unsigned /Euler/Memory/Memory(2518)
mem load -filltype value -filldata 7238 -fillradix unsigned /Euler/Memory/Memory(2519)
mem load -filltype value -filldata 4208 -fillradix unsigned /Euler/Memory/Memory(2520)
mem load -filltype value -filldata 1957 -fillradix unsigned /Euler/Memory/Memory(2521)

#Set U Matrix
mem load -filltype value -filldata 8139 -fillradix unsigned /Euler/Memory/Memory(5257)
mem load -filltype value -filldata 7353 -fillradix unsigned /Euler/Memory/Memory(5258)
mem load -filltype value -filldata 6797 -fillradix unsigned /Euler/Memory/Memory(5259)
mem load -filltype value -filldata 6822 -fillradix unsigned /Euler/Memory/Memory(5260)
mem load -filltype value -filldata 2271 -fillradix unsigned /Euler/Memory/Memory(5261)
force INT 1
run 200 ps
force PROCESS 1
run 400 ps
force Interpolate_DONE 1
run 200 ps
force Interpolate_DONE 0
run 1450 ps
run 100 ps
run 900 ps
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 5086} {
error "Test2: Failed, XNew[0] != 5086"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 2223} {
error "Test2: Failed, XNew[1] != 2223"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 69522} {
error "Test2: Failed, XNew[2] != 69522"
}
puts "Test 2 Passed!"
run 250 ps
force INT 0
force PROCESS 0
run 100 ps


################################################## Testcase: 3 ##################################################
mem load -filltype value -filldata 1 -fillradix unsigned /Euler/Memory/Memory(0)
mem load -filltype value -filldata 4 -fillradix unsigned /Euler/Memory/Memory(1)
mem load -filltype value -filldata 4 -fillradix unsigned /Euler/Memory/Memory(4)

#Set A Matrix
mem load -filltype value -filldata 6060 -fillradix unsigned /Euler/Memory/Memory(7)

#Set X Matrix
mem load -filltype value -filldata 4395 -fillradix unsigned /Euler/Memory/Memory(5207)

#Set B Matrix
mem load -filltype value -filldata 5347 -fillradix unsigned /Euler/Memory/Memory(2507)
mem load -filltype value -filldata 6831 -fillradix unsigned /Euler/Memory/Memory(2508)
mem load -filltype value -filldata 855 -fillradix unsigned /Euler/Memory/Memory(2509)
mem load -filltype value -filldata 4106 -fillradix unsigned /Euler/Memory/Memory(2510)

#Set U Matrix
mem load -filltype value -filldata 2782 -fillradix unsigned /Euler/Memory/Memory(5257)
mem load -filltype value -filldata 5056 -fillradix unsigned /Euler/Memory/Memory(5258)
mem load -filltype value -filldata 5920 -fillradix unsigned /Euler/Memory/Memory(5259)
mem load -filltype value -filldata 5073 -fillradix unsigned /Euler/Memory/Memory(5260)
force INT 1
run 200 ps
force PROCESS 1
run 400 ps
force Interpolate_DONE 1
run 200 ps
force Interpolate_DONE 0
run 350 ps
run 100 ps
run 100 ps
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 7499} {
error "Test3: Failed, XNew[0] != 7499"
}
puts "Test 3 Passed!"
run 250 ps
force INT 0
force PROCESS 0
run 100 ps


################################################## Testcase: 4 ##################################################
mem load -filltype value -filldata 4 -fillradix unsigned /Euler/Memory/Memory(0)
mem load -filltype value -filldata 2 -fillradix unsigned /Euler/Memory/Memory(1)
mem load -filltype value -filldata 7 -fillradix unsigned /Euler/Memory/Memory(4)

#Set A Matrix
mem load -filltype value -filldata 5069 -fillradix unsigned /Euler/Memory/Memory(7)
mem load -filltype value -filldata 1352 -fillradix unsigned /Euler/Memory/Memory(8)
mem load -filltype value -filldata 4243 -fillradix unsigned /Euler/Memory/Memory(9)
mem load -filltype value -filldata 673 -fillradix unsigned /Euler/Memory/Memory(10)
mem load -filltype value -filldata 6592 -fillradix unsigned /Euler/Memory/Memory(11)
mem load -filltype value -filldata 2498 -fillradix unsigned /Euler/Memory/Memory(12)
mem load -filltype value -filldata 3464 -fillradix unsigned /Euler/Memory/Memory(13)
mem load -filltype value -filldata 5253 -fillradix unsigned /Euler/Memory/Memory(14)
mem load -filltype value -filldata 7802 -fillradix unsigned /Euler/Memory/Memory(15)
mem load -filltype value -filldata 6828 -fillradix unsigned /Euler/Memory/Memory(16)
mem load -filltype value -filldata 199 -fillradix unsigned /Euler/Memory/Memory(17)
mem load -filltype value -filldata 7498 -fillradix unsigned /Euler/Memory/Memory(18)
mem load -filltype value -filldata 2862 -fillradix unsigned /Euler/Memory/Memory(19)
mem load -filltype value -filldata 252 -fillradix unsigned /Euler/Memory/Memory(20)
mem load -filltype value -filldata 7461 -fillradix unsigned /Euler/Memory/Memory(21)
mem load -filltype value -filldata 547 -fillradix unsigned /Euler/Memory/Memory(22)

#Set X Matrix
mem load -filltype value -filldata 3293 -fillradix unsigned /Euler/Memory/Memory(5207)
mem load -filltype value -filldata 2093 -fillradix unsigned /Euler/Memory/Memory(5208)
mem load -filltype value -filldata 3252 -fillradix unsigned /Euler/Memory/Memory(5209)
mem load -filltype value -filldata 3072 -fillradix unsigned /Euler/Memory/Memory(5210)

#Set B Matrix
mem load -filltype value -filldata 3255 -fillradix unsigned /Euler/Memory/Memory(2507)
mem load -filltype value -filldata 309 -fillradix unsigned /Euler/Memory/Memory(2508)
mem load -filltype value -filldata 5685 -fillradix unsigned /Euler/Memory/Memory(2509)
mem load -filltype value -filldata 5074 -fillradix unsigned /Euler/Memory/Memory(2510)
mem load -filltype value -filldata 4675 -fillradix unsigned /Euler/Memory/Memory(2511)
mem load -filltype value -filldata 2256 -fillradix unsigned /Euler/Memory/Memory(2512)
mem load -filltype value -filldata 5598 -fillradix unsigned /Euler/Memory/Memory(2513)
mem load -filltype value -filldata 4492 -fillradix unsigned /Euler/Memory/Memory(2514)

#Set U Matrix
mem load -filltype value -filldata 358 -fillradix unsigned /Euler/Memory/Memory(5257)
mem load -filltype value -filldata 125 -fillradix unsigned /Euler/Memory/Memory(5258)
force INT 1
run 200 ps
force PROCESS 1
run 400 ps
force Interpolate_DONE 1
run 200 ps
force Interpolate_DONE 0
run 750 ps
run 100 ps
run 1600 ps
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 4949} {
error "Test4: Failed, XNew[0] != 4949"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 5147} {
error "Test4: Failed, XNew[1] != 5147"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 7128} {
error "Test4: Failed, XNew[2] != 7128"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 66522} {
error "Test4: Failed, XNew[3] != 66522"
}
puts "Test 4 Passed!"
run 250 ps
force INT 0
force PROCESS 0
run 100 ps


################################################## Testcase: 5 ##################################################
mem load -filltype value -filldata 3 -fillradix unsigned /Euler/Memory/Memory(0)
mem load -filltype value -filldata 2 -fillradix unsigned /Euler/Memory/Memory(1)
mem load -filltype value -filldata 2 -fillradix unsigned /Euler/Memory/Memory(4)

#Set A Matrix
mem load -filltype value -filldata 3030 -fillradix unsigned /Euler/Memory/Memory(7)
mem load -filltype value -filldata 7285 -fillradix unsigned /Euler/Memory/Memory(8)
mem load -filltype value -filldata 1757 -fillradix unsigned /Euler/Memory/Memory(9)
mem load -filltype value -filldata 2288 -fillradix unsigned /Euler/Memory/Memory(10)
mem load -filltype value -filldata 7594 -fillradix unsigned /Euler/Memory/Memory(11)
mem load -filltype value -filldata 6658 -fillradix unsigned /Euler/Memory/Memory(12)
mem load -filltype value -filldata 5964 -fillradix unsigned /Euler/Memory/Memory(13)
mem load -filltype value -filldata 984 -fillradix unsigned /Euler/Memory/Memory(14)
mem load -filltype value -filldata 821 -fillradix unsigned /Euler/Memory/Memory(15)

#Set X Matrix
mem load -filltype value -filldata 3194 -fillradix unsigned /Euler/Memory/Memory(5207)
mem load -filltype value -filldata 8065 -fillradix unsigned /Euler/Memory/Memory(5208)
mem load -filltype value -filldata 6033 -fillradix unsigned /Euler/Memory/Memory(5209)

#Set B Matrix
mem load -filltype value -filldata 6822 -fillradix unsigned /Euler/Memory/Memory(2507)
mem load -filltype value -filldata 7737 -fillradix unsigned /Euler/Memory/Memory(2508)
mem load -filltype value -filldata 8149 -fillradix unsigned /Euler/Memory/Memory(2509)
mem load -filltype value -filldata 5642 -fillradix unsigned /Euler/Memory/Memory(2510)
mem load -filltype value -filldata 4886 -fillradix unsigned /Euler/Memory/Memory(2511)
mem load -filltype value -filldata 4857 -fillradix unsigned /Euler/Memory/Memory(2512)

#Set U Matrix
mem load -filltype value -filldata 754 -fillradix unsigned /Euler/Memory/Memory(5257)
mem load -filltype value -filldata 403 -fillradix unsigned /Euler/Memory/Memory(5258)
force INT 1
run 200 ps
force PROCESS 1
run 400 ps
force Interpolate_DONE 1
run 200 ps
force Interpolate_DONE 0
run 550 ps
run 100 ps
run 900 ps
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 67076} {
error "Test5: Failed, XNew[0] != 67076"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 69129} {
error "Test5: Failed, XNew[1] != 69129"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 68937} {
error "Test5: Failed, XNew[2] != 68937"
}
puts "Test 5 Passed!"
run 250 ps
force INT 0
force PROCESS 0
run 100 ps


################################################## Testcase: 6 ##################################################
mem load -filltype value -filldata 4 -fillradix unsigned /Euler/Memory/Memory(0)
mem load -filltype value -filldata 1 -fillradix unsigned /Euler/Memory/Memory(1)
mem load -filltype value -filldata 9 -fillradix unsigned /Euler/Memory/Memory(4)

#Set A Matrix
mem load -filltype value -filldata 1990 -fillradix unsigned /Euler/Memory/Memory(7)
mem load -filltype value -filldata 7169 -fillradix unsigned /Euler/Memory/Memory(8)
mem load -filltype value -filldata 770 -fillradix unsigned /Euler/Memory/Memory(9)
mem load -filltype value -filldata 5159 -fillradix unsigned /Euler/Memory/Memory(10)
mem load -filltype value -filldata 2776 -fillradix unsigned /Euler/Memory/Memory(11)
mem load -filltype value -filldata 3240 -fillradix unsigned /Euler/Memory/Memory(12)
mem load -filltype value -filldata 1698 -fillradix unsigned /Euler/Memory/Memory(13)
mem load -filltype value -filldata 7607 -fillradix unsigned /Euler/Memory/Memory(14)
mem load -filltype value -filldata 2538 -fillradix unsigned /Euler/Memory/Memory(15)
mem load -filltype value -filldata 4920 -fillradix unsigned /Euler/Memory/Memory(16)
mem load -filltype value -filldata 32 -fillradix unsigned /Euler/Memory/Memory(17)
mem load -filltype value -filldata 2455 -fillradix unsigned /Euler/Memory/Memory(18)
mem load -filltype value -filldata 7399 -fillradix unsigned /Euler/Memory/Memory(19)
mem load -filltype value -filldata 3769 -fillradix unsigned /Euler/Memory/Memory(20)
mem load -filltype value -filldata 7674 -fillradix unsigned /Euler/Memory/Memory(21)
mem load -filltype value -filldata 5918 -fillradix unsigned /Euler/Memory/Memory(22)

#Set X Matrix
mem load -filltype value -filldata 7711 -fillradix unsigned /Euler/Memory/Memory(5207)
mem load -filltype value -filldata 5529 -fillradix unsigned /Euler/Memory/Memory(5208)
mem load -filltype value -filldata 1222 -fillradix unsigned /Euler/Memory/Memory(5209)
mem load -filltype value -filldata 4926 -fillradix unsigned /Euler/Memory/Memory(5210)

#Set B Matrix
mem load -filltype value -filldata 6401 -fillradix unsigned /Euler/Memory/Memory(2507)
mem load -filltype value -filldata 7681 -fillradix unsigned /Euler/Memory/Memory(2508)
mem load -filltype value -filldata 7802 -fillradix unsigned /Euler/Memory/Memory(2509)
mem load -filltype value -filldata 4087 -fillradix unsigned /Euler/Memory/Memory(2510)

#Set U Matrix
mem load -filltype value -filldata 4118 -fillradix unsigned /Euler/Memory/Memory(5257)
force INT 1
run 200 ps
force PROCESS 1
run 400 ps
force Interpolate_DONE 1
run 200 ps
force Interpolate_DONE 0
run 350 ps
run 100 ps
run 1600 ps
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 66046} {
error "Test6: Failed, XNew[0] != 66046"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 68861} {
error "Test6: Failed, XNew[1] != 68861"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 3138} {
error "Test6: Failed, XNew[2] != 3138"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 66498} {
error "Test6: Failed, XNew[3] != 66498"
}
puts "Test 6 Passed!"
run 250 ps
force INT 0
force PROCESS 0
run 100 ps


################################################## Testcase: 7 ##################################################
mem load -filltype value -filldata 3 -fillradix unsigned /Euler/Memory/Memory(0)
mem load -filltype value -filldata 5 -fillradix unsigned /Euler/Memory/Memory(1)
mem load -filltype value -filldata 8 -fillradix unsigned /Euler/Memory/Memory(4)

#Set A Matrix
mem load -filltype value -filldata 7605 -fillradix unsigned /Euler/Memory/Memory(7)
mem load -filltype value -filldata 890 -fillradix unsigned /Euler/Memory/Memory(8)
mem load -filltype value -filldata 3508 -fillradix unsigned /Euler/Memory/Memory(9)
mem load -filltype value -filldata 6858 -fillradix unsigned /Euler/Memory/Memory(10)
mem load -filltype value -filldata 388 -fillradix unsigned /Euler/Memory/Memory(11)
mem load -filltype value -filldata 7222 -fillradix unsigned /Euler/Memory/Memory(12)
mem load -filltype value -filldata 4306 -fillradix unsigned /Euler/Memory/Memory(13)
mem load -filltype value -filldata 2790 -fillradix unsigned /Euler/Memory/Memory(14)
mem load -filltype value -filldata 1698 -fillradix unsigned /Euler/Memory/Memory(15)

#Set X Matrix
mem load -filltype value -filldata 6584 -fillradix unsigned /Euler/Memory/Memory(5207)
mem load -filltype value -filldata 7284 -fillradix unsigned /Euler/Memory/Memory(5208)
mem load -filltype value -filldata 1667 -fillradix unsigned /Euler/Memory/Memory(5209)

#Set B Matrix
mem load -filltype value -filldata 6612 -fillradix unsigned /Euler/Memory/Memory(2507)
mem load -filltype value -filldata 6289 -fillradix unsigned /Euler/Memory/Memory(2508)
mem load -filltype value -filldata 3424 -fillradix unsigned /Euler/Memory/Memory(2509)
mem load -filltype value -filldata 7715 -fillradix unsigned /Euler/Memory/Memory(2510)
mem load -filltype value -filldata 5981 -fillradix unsigned /Euler/Memory/Memory(2511)
mem load -filltype value -filldata 4350 -fillradix unsigned /Euler/Memory/Memory(2512)
mem load -filltype value -filldata 6971 -fillradix unsigned /Euler/Memory/Memory(2513)
mem load -filltype value -filldata 5402 -fillradix unsigned /Euler/Memory/Memory(2514)
mem load -filltype value -filldata 3659 -fillradix unsigned /Euler/Memory/Memory(2515)
mem load -filltype value -filldata 2790 -fillradix unsigned /Euler/Memory/Memory(2516)
mem load -filltype value -filldata 289 -fillradix unsigned /Euler/Memory/Memory(2517)
mem load -filltype value -filldata 2149 -fillradix unsigned /Euler/Memory/Memory(2518)
mem load -filltype value -filldata 878 -fillradix unsigned /Euler/Memory/Memory(2519)
mem load -filltype value -filldata 2575 -fillradix unsigned /Euler/Memory/Memory(2520)
mem load -filltype value -filldata 3571 -fillradix unsigned /Euler/Memory/Memory(2521)

#Set U Matrix
mem load -filltype value -filldata 6483 -fillradix unsigned /Euler/Memory/Memory(5257)
mem load -filltype value -filldata 2180 -fillradix unsigned /Euler/Memory/Memory(5258)
mem load -filltype value -filldata 2348 -fillradix unsigned /Euler/Memory/Memory(5259)
mem load -filltype value -filldata 922 -fillradix unsigned /Euler/Memory/Memory(5260)
mem load -filltype value -filldata 3347 -fillradix unsigned /Euler/Memory/Memory(5261)
force INT 1
run 200 ps
force PROCESS 1
run 400 ps
force Interpolate_DONE 1
run 200 ps
force Interpolate_DONE 0
run 1450 ps
run 100 ps
run 900 ps
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 70976} {
error "Test7: Failed, XNew[0] != 70976"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 70900} {
error "Test7: Failed, XNew[1] != 70900"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 66787} {
error "Test7: Failed, XNew[2] != 66787"
}
puts "Test 7 Passed!"
run 250 ps
force INT 0
force PROCESS 0
run 100 ps


################################################## Testcase: 8 ##################################################
mem load -filltype value -filldata 2 -fillradix unsigned /Euler/Memory/Memory(0)
mem load -filltype value -filldata 1 -fillradix unsigned /Euler/Memory/Memory(1)
mem load -filltype value -filldata 10 -fillradix unsigned /Euler/Memory/Memory(4)

#Set A Matrix
mem load -filltype value -filldata 1175 -fillradix unsigned /Euler/Memory/Memory(7)
mem load -filltype value -filldata 8167 -fillradix unsigned /Euler/Memory/Memory(8)
mem load -filltype value -filldata 855 -fillradix unsigned /Euler/Memory/Memory(9)
mem load -filltype value -filldata 4953 -fillradix unsigned /Euler/Memory/Memory(10)

#Set X Matrix
mem load -filltype value -filldata 2018 -fillradix unsigned /Euler/Memory/Memory(5207)
mem load -filltype value -filldata 1332 -fillradix unsigned /Euler/Memory/Memory(5208)

#Set B Matrix
mem load -filltype value -filldata 4953 -fillradix unsigned /Euler/Memory/Memory(2507)
mem load -filltype value -filldata 5901 -fillradix unsigned /Euler/Memory/Memory(2508)

#Set U Matrix
mem load -filltype value -filldata 3286 -fillradix unsigned /Euler/Memory/Memory(5257)
force INT 1
run 200 ps
force PROCESS 1
run 400 ps
force Interpolate_DONE 1
run 200 ps
force Interpolate_DONE 0
run 150 ps
run 100 ps
run 400 ps
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 5666} {
error "Test8: Failed, XNew[0] != 5666"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 66228} {
error "Test8: Failed, XNew[1] != 66228"
}
puts "Test 8 Passed!"
run 250 ps
force INT 0
force PROCESS 0
run 100 ps


################################################## Testcase: 9 ##################################################
mem load -filltype value -filldata 3 -fillradix unsigned /Euler/Memory/Memory(0)
mem load -filltype value -filldata 2 -fillradix unsigned /Euler/Memory/Memory(1)
mem load -filltype value -filldata 10 -fillradix unsigned /Euler/Memory/Memory(4)

#Set A Matrix
mem load -filltype value -filldata 6649 -fillradix unsigned /Euler/Memory/Memory(7)
mem load -filltype value -filldata 7310 -fillradix unsigned /Euler/Memory/Memory(8)
mem load -filltype value -filldata 5063 -fillradix unsigned /Euler/Memory/Memory(9)
mem load -filltype value -filldata 19 -fillradix unsigned /Euler/Memory/Memory(10)
mem load -filltype value -filldata 4290 -fillradix unsigned /Euler/Memory/Memory(11)
mem load -filltype value -filldata 7588 -fillradix unsigned /Euler/Memory/Memory(12)
mem load -filltype value -filldata 490 -fillradix unsigned /Euler/Memory/Memory(13)
mem load -filltype value -filldata 4982 -fillradix unsigned /Euler/Memory/Memory(14)
mem load -filltype value -filldata 3108 -fillradix unsigned /Euler/Memory/Memory(15)

#Set X Matrix
mem load -filltype value -filldata 1157 -fillradix unsigned /Euler/Memory/Memory(5207)
mem load -filltype value -filldata 410 -fillradix unsigned /Euler/Memory/Memory(5208)
mem load -filltype value -filldata 1189 -fillradix unsigned /Euler/Memory/Memory(5209)

#Set B Matrix
mem load -filltype value -filldata 163 -fillradix unsigned /Euler/Memory/Memory(2507)
mem load -filltype value -filldata 961 -fillradix unsigned /Euler/Memory/Memory(2508)
mem load -filltype value -filldata 7321 -fillradix unsigned /Euler/Memory/Memory(2509)
mem load -filltype value -filldata 2263 -fillradix unsigned /Euler/Memory/Memory(2510)
mem load -filltype value -filldata 6161 -fillradix unsigned /Euler/Memory/Memory(2511)
mem load -filltype value -filldata 5963 -fillradix unsigned /Euler/Memory/Memory(2512)

#Set U Matrix
mem load -filltype value -filldata 1937 -fillradix unsigned /Euler/Memory/Memory(5257)
mem load -filltype value -filldata 4605 -fillradix unsigned /Euler/Memory/Memory(5258)
force INT 1
run 200 ps
force PROCESS 1
run 400 ps
force Interpolate_DONE 1
run 200 ps
force Interpolate_DONE 0
run 550 ps
run 100 ps
run 900 ps
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 3997} {
error "Test9: Failed, XNew[0] != 3997"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 7624} {
error "Test9: Failed, XNew[1] != 7624"
}
run 300 ps

set val [examine RAM_DATA_WR]
if {$val != 3001} {
error "Test9: Failed, XNew[2] != 3001"
}
puts "Test 9 Passed!"
run 250 ps
force INT 0
force PROCESS 0
run 100 ps
puts "All tests Passed Successfully!"
