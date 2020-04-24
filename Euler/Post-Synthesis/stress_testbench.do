vlog *.v
quit -sim
vsim work.System
radix -unsigned
add wave *
force -freeze System/CLK 0 1, 1 {50 ps} -r 100
force System/INT 0
force System/PROCESS 0
run 100 ps


################################################## Testcase: 0 ##################################################
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 18599 -fillradix unsigned /System/Memory/Memory(4)

#Set A Matrix
mem load -filltype value -filldata 49575 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 33157 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 46883 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 54719 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 23802 -fillradix unsigned /System/Memory/Memory(11)
mem load -filltype value -filldata 60486 -fillradix unsigned /System/Memory/Memory(12)
mem load -filltype value -filldata 63611 -fillradix unsigned /System/Memory/Memory(13)
mem load -filltype value -filldata 10567 -fillradix unsigned /System/Memory/Memory(14)
mem load -filltype value -filldata 4175 -fillradix unsigned /System/Memory/Memory(15)
mem load -filltype value -filldata 21659 -fillradix unsigned /System/Memory/Memory(16)
mem load -filltype value -filldata 8960 -fillradix unsigned /System/Memory/Memory(17)
mem load -filltype value -filldata 4124 -fillradix unsigned /System/Memory/Memory(18)
mem load -filltype value -filldata 32031 -fillradix unsigned /System/Memory/Memory(19)
mem load -filltype value -filldata 36456 -fillradix unsigned /System/Memory/Memory(20)
mem load -filltype value -filldata 47341 -fillradix unsigned /System/Memory/Memory(21)
mem load -filltype value -filldata 49902 -fillradix unsigned /System/Memory/Memory(22)
mem load -filltype value -filldata 8772 -fillradix unsigned /System/Memory/Memory(23)
mem load -filltype value -filldata 56047 -fillradix unsigned /System/Memory/Memory(24)
mem load -filltype value -filldata 58986 -fillradix unsigned /System/Memory/Memory(25)
mem load -filltype value -filldata 37533 -fillradix unsigned /System/Memory/Memory(26)
mem load -filltype value -filldata 4411 -fillradix unsigned /System/Memory/Memory(27)
mem load -filltype value -filldata 6083 -fillradix unsigned /System/Memory/Memory(28)
mem load -filltype value -filldata 56403 -fillradix unsigned /System/Memory/Memory(29)
mem load -filltype value -filldata 2119 -fillradix unsigned /System/Memory/Memory(30)
mem load -filltype value -filldata 17571 -fillradix unsigned /System/Memory/Memory(31)
mem load -filltype value -filldata 61643 -fillradix unsigned /System/Memory/Memory(32)
mem load -filltype value -filldata 17325 -fillradix unsigned /System/Memory/Memory(33)
mem load -filltype value -filldata 725 -fillradix unsigned /System/Memory/Memory(34)
mem load -filltype value -filldata 55555 -fillradix unsigned /System/Memory/Memory(35)
mem load -filltype value -filldata 50136 -fillradix unsigned /System/Memory/Memory(36)
mem load -filltype value -filldata 47692 -fillradix unsigned /System/Memory/Memory(37)
mem load -filltype value -filldata 57596 -fillradix unsigned /System/Memory/Memory(38)
mem load -filltype value -filldata 13117 -fillradix unsigned /System/Memory/Memory(39)
mem load -filltype value -filldata 28046 -fillradix unsigned /System/Memory/Memory(40)
mem load -filltype value -filldata 63457 -fillradix unsigned /System/Memory/Memory(41)
mem load -filltype value -filldata 1996 -fillradix unsigned /System/Memory/Memory(42)
mem load -filltype value -filldata 24713 -fillradix unsigned /System/Memory/Memory(43)
mem load -filltype value -filldata 25564 -fillradix unsigned /System/Memory/Memory(44)
mem load -filltype value -filldata 3679 -fillradix unsigned /System/Memory/Memory(45)
mem load -filltype value -filldata 18495 -fillradix unsigned /System/Memory/Memory(46)
mem load -filltype value -filldata 48324 -fillradix unsigned /System/Memory/Memory(47)
mem load -filltype value -filldata 5462 -fillradix unsigned /System/Memory/Memory(48)
mem load -filltype value -filldata 2440 -fillradix unsigned /System/Memory/Memory(49)
mem load -filltype value -filldata 26328 -fillradix unsigned /System/Memory/Memory(50)
mem load -filltype value -filldata 50934 -fillradix unsigned /System/Memory/Memory(51)
mem load -filltype value -filldata 61856 -fillradix unsigned /System/Memory/Memory(52)
mem load -filltype value -filldata 1798 -fillradix unsigned /System/Memory/Memory(53)
mem load -filltype value -filldata 385 -fillradix unsigned /System/Memory/Memory(54)
mem load -filltype value -filldata 21197 -fillradix unsigned /System/Memory/Memory(55)
mem load -filltype value -filldata 14549 -fillradix unsigned /System/Memory/Memory(56)
mem load -filltype value -filldata 45690 -fillradix unsigned /System/Memory/Memory(57)
mem load -filltype value -filldata 20655 -fillradix unsigned /System/Memory/Memory(58)
mem load -filltype value -filldata 65409 -fillradix unsigned /System/Memory/Memory(59)
mem load -filltype value -filldata 42373 -fillradix unsigned /System/Memory/Memory(60)
mem load -filltype value -filldata 2206 -fillradix unsigned /System/Memory/Memory(61)
mem load -filltype value -filldata 60654 -fillradix unsigned /System/Memory/Memory(62)
mem load -filltype value -filldata 48792 -fillradix unsigned /System/Memory/Memory(63)
mem load -filltype value -filldata 27534 -fillradix unsigned /System/Memory/Memory(64)
mem load -filltype value -filldata 24043 -fillradix unsigned /System/Memory/Memory(65)
mem load -filltype value -filldata 9452 -fillradix unsigned /System/Memory/Memory(66)
mem load -filltype value -filldata 55418 -fillradix unsigned /System/Memory/Memory(67)
mem load -filltype value -filldata 64982 -fillradix unsigned /System/Memory/Memory(68)
mem load -filltype value -filldata 62992 -fillradix unsigned /System/Memory/Memory(69)
mem load -filltype value -filldata 46611 -fillradix unsigned /System/Memory/Memory(70)
mem load -filltype value -filldata 11779 -fillradix unsigned /System/Memory/Memory(71)
mem load -filltype value -filldata 11818 -fillradix unsigned /System/Memory/Memory(72)
mem load -filltype value -filldata 3605 -fillradix unsigned /System/Memory/Memory(73)
mem load -filltype value -filldata 6303 -fillradix unsigned /System/Memory/Memory(74)
mem load -filltype value -filldata 43900 -fillradix unsigned /System/Memory/Memory(75)
mem load -filltype value -filldata 59467 -fillradix unsigned /System/Memory/Memory(76)
mem load -filltype value -filldata 32648 -fillradix unsigned /System/Memory/Memory(77)
mem load -filltype value -filldata 52800 -fillradix unsigned /System/Memory/Memory(78)
mem load -filltype value -filldata 41546 -fillradix unsigned /System/Memory/Memory(79)
mem load -filltype value -filldata 4911 -fillradix unsigned /System/Memory/Memory(80)
mem load -filltype value -filldata 10587 -fillradix unsigned /System/Memory/Memory(81)
mem load -filltype value -filldata 47629 -fillradix unsigned /System/Memory/Memory(82)
mem load -filltype value -filldata 30439 -fillradix unsigned /System/Memory/Memory(83)
mem load -filltype value -filldata 17889 -fillradix unsigned /System/Memory/Memory(84)
mem load -filltype value -filldata 29581 -fillradix unsigned /System/Memory/Memory(85)
mem load -filltype value -filldata 9788 -fillradix unsigned /System/Memory/Memory(86)
mem load -filltype value -filldata 17884 -fillradix unsigned /System/Memory/Memory(87)

#Set X Matrix
mem load -filltype value -filldata 17247 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 3662 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 59962 -fillradix unsigned /System/Memory/Memory(5209)
mem load -filltype value -filldata 29189 -fillradix unsigned /System/Memory/Memory(5210)
mem load -filltype value -filldata 23782 -fillradix unsigned /System/Memory/Memory(5211)
mem load -filltype value -filldata 43611 -fillradix unsigned /System/Memory/Memory(5212)
mem load -filltype value -filldata 4250 -fillradix unsigned /System/Memory/Memory(5213)
mem load -filltype value -filldata 3871 -fillradix unsigned /System/Memory/Memory(5214)
mem load -filltype value -filldata 36150 -fillradix unsigned /System/Memory/Memory(5215)

#Set B Matrix
mem load -filltype value -filldata 16426 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 41586 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 10252 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 52315 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 10173 -fillradix unsigned /System/Memory/Memory(2511)
mem load -filltype value -filldata 38329 -fillradix unsigned /System/Memory/Memory(2512)
mem load -filltype value -filldata 61488 -fillradix unsigned /System/Memory/Memory(2513)
mem load -filltype value -filldata 47181 -fillradix unsigned /System/Memory/Memory(2514)
mem load -filltype value -filldata 23295 -fillradix unsigned /System/Memory/Memory(2515)
mem load -filltype value -filldata 1080 -fillradix unsigned /System/Memory/Memory(2516)
mem load -filltype value -filldata 52860 -fillradix unsigned /System/Memory/Memory(2517)
mem load -filltype value -filldata 9995 -fillradix unsigned /System/Memory/Memory(2518)
mem load -filltype value -filldata 54211 -fillradix unsigned /System/Memory/Memory(2519)
mem load -filltype value -filldata 37626 -fillradix unsigned /System/Memory/Memory(2520)
mem load -filltype value -filldata 10677 -fillradix unsigned /System/Memory/Memory(2521)
mem load -filltype value -filldata 41454 -fillradix unsigned /System/Memory/Memory(2522)
mem load -filltype value -filldata 60055 -fillradix unsigned /System/Memory/Memory(2523)
mem load -filltype value -filldata 17101 -fillradix unsigned /System/Memory/Memory(2524)
mem load -filltype value -filldata 1608 -fillradix unsigned /System/Memory/Memory(2525)
mem load -filltype value -filldata 38488 -fillradix unsigned /System/Memory/Memory(2526)
mem load -filltype value -filldata 46000 -fillradix unsigned /System/Memory/Memory(2527)
mem load -filltype value -filldata 2396 -fillradix unsigned /System/Memory/Memory(2528)
mem load -filltype value -filldata 28016 -fillradix unsigned /System/Memory/Memory(2529)
mem load -filltype value -filldata 24234 -fillradix unsigned /System/Memory/Memory(2530)
mem load -filltype value -filldata 23201 -fillradix unsigned /System/Memory/Memory(2531)
mem load -filltype value -filldata 20116 -fillradix unsigned /System/Memory/Memory(2532)
mem load -filltype value -filldata 44417 -fillradix unsigned /System/Memory/Memory(2533)
mem load -filltype value -filldata 59569 -fillradix unsigned /System/Memory/Memory(2534)
mem load -filltype value -filldata 43997 -fillradix unsigned /System/Memory/Memory(2535)
mem load -filltype value -filldata 26075 -fillradix unsigned /System/Memory/Memory(2536)
mem load -filltype value -filldata 13429 -fillradix unsigned /System/Memory/Memory(2537)
mem load -filltype value -filldata 49308 -fillradix unsigned /System/Memory/Memory(2538)
mem load -filltype value -filldata 34294 -fillradix unsigned /System/Memory/Memory(2539)
mem load -filltype value -filldata 44408 -fillradix unsigned /System/Memory/Memory(2540)
mem load -filltype value -filldata 21804 -fillradix unsigned /System/Memory/Memory(2541)
mem load -filltype value -filldata 44233 -fillradix unsigned /System/Memory/Memory(2542)

#Set U Matrix
mem load -filltype value -filldata 61127 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 11507 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 1182 -fillradix unsigned /System/Memory/Memory(5259)
mem load -filltype value -filldata 60592 -fillradix unsigned /System/Memory/Memory(5260)
force System/INT 1
run 200 ps
force System/PROCESS 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 3550 ps
run 100 ps
run 8100 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 64350} {
error "Test0: Failed, XNew[0] != 64350"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 59379} {
error "Test0: Failed, XNew[1] != 59379"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 61213} {
error "Test0: Failed, XNew[2] != 61213"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 61794} {
error "Test0: Failed, XNew[3] != 61794"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 64843} {
error "Test0: Failed, XNew[4] != 64843"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 60538} {
error "Test0: Failed, XNew[5] != 60538"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 62161} {
error "Test0: Failed, XNew[6] != 62161"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 61146} {
error "Test0: Failed, XNew[7] != 61146"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 61554} {
error "Test0: Failed, XNew[8] != 61554"
}
puts "Test 0 Passed!"
run 250 ps
force System/INT 0
force System/PROCESS 0
run 100 ps


################################################## Testcase: 1 ##################################################
mem load -filltype value -filldata 7 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 9 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 9816 -fillradix unsigned /System/Memory/Memory(4)

#Set A Matrix
mem load -filltype value -filldata 51461 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 16446 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 14871 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 13898 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 58347 -fillradix unsigned /System/Memory/Memory(11)
mem load -filltype value -filldata 15806 -fillradix unsigned /System/Memory/Memory(12)
mem load -filltype value -filldata 16835 -fillradix unsigned /System/Memory/Memory(13)
mem load -filltype value -filldata 10976 -fillradix unsigned /System/Memory/Memory(14)
mem load -filltype value -filldata 27819 -fillradix unsigned /System/Memory/Memory(15)
mem load -filltype value -filldata 51408 -fillradix unsigned /System/Memory/Memory(16)
mem load -filltype value -filldata 49891 -fillradix unsigned /System/Memory/Memory(17)
mem load -filltype value -filldata 31824 -fillradix unsigned /System/Memory/Memory(18)
mem load -filltype value -filldata 19428 -fillradix unsigned /System/Memory/Memory(19)
mem load -filltype value -filldata 22498 -fillradix unsigned /System/Memory/Memory(20)
mem load -filltype value -filldata 55859 -fillradix unsigned /System/Memory/Memory(21)
mem load -filltype value -filldata 23985 -fillradix unsigned /System/Memory/Memory(22)
mem load -filltype value -filldata 47235 -fillradix unsigned /System/Memory/Memory(23)
mem load -filltype value -filldata 51474 -fillradix unsigned /System/Memory/Memory(24)
mem load -filltype value -filldata 19474 -fillradix unsigned /System/Memory/Memory(25)
mem load -filltype value -filldata 47969 -fillradix unsigned /System/Memory/Memory(26)
mem load -filltype value -filldata 452 -fillradix unsigned /System/Memory/Memory(27)
mem load -filltype value -filldata 23143 -fillradix unsigned /System/Memory/Memory(28)
mem load -filltype value -filldata 34158 -fillradix unsigned /System/Memory/Memory(29)
mem load -filltype value -filldata 47135 -fillradix unsigned /System/Memory/Memory(30)
mem load -filltype value -filldata 62001 -fillradix unsigned /System/Memory/Memory(31)
mem load -filltype value -filldata 30968 -fillradix unsigned /System/Memory/Memory(32)
mem load -filltype value -filldata 63819 -fillradix unsigned /System/Memory/Memory(33)
mem load -filltype value -filldata 24529 -fillradix unsigned /System/Memory/Memory(34)
mem load -filltype value -filldata 30750 -fillradix unsigned /System/Memory/Memory(35)
mem load -filltype value -filldata 27656 -fillradix unsigned /System/Memory/Memory(36)
mem load -filltype value -filldata 58746 -fillradix unsigned /System/Memory/Memory(37)
mem load -filltype value -filldata 19664 -fillradix unsigned /System/Memory/Memory(38)
mem load -filltype value -filldata 39052 -fillradix unsigned /System/Memory/Memory(39)
mem load -filltype value -filldata 7742 -fillradix unsigned /System/Memory/Memory(40)
mem load -filltype value -filldata 55536 -fillradix unsigned /System/Memory/Memory(41)
mem load -filltype value -filldata 29107 -fillradix unsigned /System/Memory/Memory(42)
mem load -filltype value -filldata 51920 -fillradix unsigned /System/Memory/Memory(43)
mem load -filltype value -filldata 58774 -fillradix unsigned /System/Memory/Memory(44)
mem load -filltype value -filldata 17632 -fillradix unsigned /System/Memory/Memory(45)
mem load -filltype value -filldata 12269 -fillradix unsigned /System/Memory/Memory(46)
mem load -filltype value -filldata 31467 -fillradix unsigned /System/Memory/Memory(47)
mem load -filltype value -filldata 6489 -fillradix unsigned /System/Memory/Memory(48)
mem load -filltype value -filldata 26850 -fillradix unsigned /System/Memory/Memory(49)
mem load -filltype value -filldata 45084 -fillradix unsigned /System/Memory/Memory(50)
mem load -filltype value -filldata 61004 -fillradix unsigned /System/Memory/Memory(51)
mem load -filltype value -filldata 5992 -fillradix unsigned /System/Memory/Memory(52)
mem load -filltype value -filldata 7198 -fillradix unsigned /System/Memory/Memory(53)
mem load -filltype value -filldata 36117 -fillradix unsigned /System/Memory/Memory(54)
mem load -filltype value -filldata 31411 -fillradix unsigned /System/Memory/Memory(55)

#Set X Matrix
mem load -filltype value -filldata 34272 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 18988 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 57845 -fillradix unsigned /System/Memory/Memory(5209)
mem load -filltype value -filldata 57369 -fillradix unsigned /System/Memory/Memory(5210)
mem load -filltype value -filldata 36065 -fillradix unsigned /System/Memory/Memory(5211)
mem load -filltype value -filldata 31940 -fillradix unsigned /System/Memory/Memory(5212)
mem load -filltype value -filldata 36796 -fillradix unsigned /System/Memory/Memory(5213)

#Set B Matrix
mem load -filltype value -filldata 63265 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 36398 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 43065 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 35000 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 18349 -fillradix unsigned /System/Memory/Memory(2511)
mem load -filltype value -filldata 4573 -fillradix unsigned /System/Memory/Memory(2512)
mem load -filltype value -filldata 36821 -fillradix unsigned /System/Memory/Memory(2513)
mem load -filltype value -filldata 10672 -fillradix unsigned /System/Memory/Memory(2514)
mem load -filltype value -filldata 60439 -fillradix unsigned /System/Memory/Memory(2515)
mem load -filltype value -filldata 55628 -fillradix unsigned /System/Memory/Memory(2516)
mem load -filltype value -filldata 44881 -fillradix unsigned /System/Memory/Memory(2517)
mem load -filltype value -filldata 64907 -fillradix unsigned /System/Memory/Memory(2518)
mem load -filltype value -filldata 39310 -fillradix unsigned /System/Memory/Memory(2519)
mem load -filltype value -filldata 31032 -fillradix unsigned /System/Memory/Memory(2520)
mem load -filltype value -filldata 32682 -fillradix unsigned /System/Memory/Memory(2521)
mem load -filltype value -filldata 20998 -fillradix unsigned /System/Memory/Memory(2522)
mem load -filltype value -filldata 45107 -fillradix unsigned /System/Memory/Memory(2523)
mem load -filltype value -filldata 54160 -fillradix unsigned /System/Memory/Memory(2524)
mem load -filltype value -filldata 4164 -fillradix unsigned /System/Memory/Memory(2525)
mem load -filltype value -filldata 21149 -fillradix unsigned /System/Memory/Memory(2526)
mem load -filltype value -filldata 14994 -fillradix unsigned /System/Memory/Memory(2527)
mem load -filltype value -filldata 25217 -fillradix unsigned /System/Memory/Memory(2528)
mem load -filltype value -filldata 49563 -fillradix unsigned /System/Memory/Memory(2529)
mem load -filltype value -filldata 2124 -fillradix unsigned /System/Memory/Memory(2530)
mem load -filltype value -filldata 52730 -fillradix unsigned /System/Memory/Memory(2531)
mem load -filltype value -filldata 56358 -fillradix unsigned /System/Memory/Memory(2532)
mem load -filltype value -filldata 40717 -fillradix unsigned /System/Memory/Memory(2533)
mem load -filltype value -filldata 25940 -fillradix unsigned /System/Memory/Memory(2534)
mem load -filltype value -filldata 38832 -fillradix unsigned /System/Memory/Memory(2535)
mem load -filltype value -filldata 16993 -fillradix unsigned /System/Memory/Memory(2536)
mem load -filltype value -filldata 42123 -fillradix unsigned /System/Memory/Memory(2537)
mem load -filltype value -filldata 7346 -fillradix unsigned /System/Memory/Memory(2538)
mem load -filltype value -filldata 38387 -fillradix unsigned /System/Memory/Memory(2539)
mem load -filltype value -filldata 65306 -fillradix unsigned /System/Memory/Memory(2540)
mem load -filltype value -filldata 14494 -fillradix unsigned /System/Memory/Memory(2541)
mem load -filltype value -filldata 7300 -fillradix unsigned /System/Memory/Memory(2542)
mem load -filltype value -filldata 28983 -fillradix unsigned /System/Memory/Memory(2543)
mem load -filltype value -filldata 21315 -fillradix unsigned /System/Memory/Memory(2544)
mem load -filltype value -filldata 27478 -fillradix unsigned /System/Memory/Memory(2545)
mem load -filltype value -filldata 6892 -fillradix unsigned /System/Memory/Memory(2546)
mem load -filltype value -filldata 21851 -fillradix unsigned /System/Memory/Memory(2547)
mem load -filltype value -filldata 1682 -fillradix unsigned /System/Memory/Memory(2548)
mem load -filltype value -filldata 6069 -fillradix unsigned /System/Memory/Memory(2549)
mem load -filltype value -filldata 7483 -fillradix unsigned /System/Memory/Memory(2550)
mem load -filltype value -filldata 16136 -fillradix unsigned /System/Memory/Memory(2551)
mem load -filltype value -filldata 9705 -fillradix unsigned /System/Memory/Memory(2552)
mem load -filltype value -filldata 47100 -fillradix unsigned /System/Memory/Memory(2553)
mem load -filltype value -filldata 45338 -fillradix unsigned /System/Memory/Memory(2554)
mem load -filltype value -filldata 30304 -fillradix unsigned /System/Memory/Memory(2555)
mem load -filltype value -filldata 43484 -fillradix unsigned /System/Memory/Memory(2556)
mem load -filltype value -filldata 58005 -fillradix unsigned /System/Memory/Memory(2557)
mem load -filltype value -filldata 12358 -fillradix unsigned /System/Memory/Memory(2558)
mem load -filltype value -filldata 53324 -fillradix unsigned /System/Memory/Memory(2559)
mem load -filltype value -filldata 45593 -fillradix unsigned /System/Memory/Memory(2560)
mem load -filltype value -filldata 23397 -fillradix unsigned /System/Memory/Memory(2561)
mem load -filltype value -filldata 30216 -fillradix unsigned /System/Memory/Memory(2562)
mem load -filltype value -filldata 11888 -fillradix unsigned /System/Memory/Memory(2563)
mem load -filltype value -filldata 10917 -fillradix unsigned /System/Memory/Memory(2564)
mem load -filltype value -filldata 38971 -fillradix unsigned /System/Memory/Memory(2565)
mem load -filltype value -filldata 50699 -fillradix unsigned /System/Memory/Memory(2566)
mem load -filltype value -filldata 33508 -fillradix unsigned /System/Memory/Memory(2567)
mem load -filltype value -filldata 34920 -fillradix unsigned /System/Memory/Memory(2568)
mem load -filltype value -filldata 19656 -fillradix unsigned /System/Memory/Memory(2569)

#Set U Matrix
mem load -filltype value -filldata 33962 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 41564 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 22764 -fillradix unsigned /System/Memory/Memory(5259)
mem load -filltype value -filldata 24680 -fillradix unsigned /System/Memory/Memory(5260)
mem load -filltype value -filldata 43095 -fillradix unsigned /System/Memory/Memory(5261)
mem load -filltype value -filldata 6934 -fillradix unsigned /System/Memory/Memory(5262)
mem load -filltype value -filldata 17654 -fillradix unsigned /System/Memory/Memory(5263)
mem load -filltype value -filldata 46044 -fillradix unsigned /System/Memory/Memory(5264)
mem load -filltype value -filldata 29309 -fillradix unsigned /System/Memory/Memory(5265)
force System/INT 1
run 200 ps
force System/PROCESS 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 6250 ps
run 100 ps
run 4900 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 59940} {
error "Test1: Failed, XNew[0] != 59940"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 59012} {
error "Test1: Failed, XNew[1] != 59012"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 59497} {
error "Test1: Failed, XNew[2] != 59497"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 59985} {
error "Test1: Failed, XNew[3] != 59985"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 64556} {
error "Test1: Failed, XNew[4] != 64556"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 59700} {
error "Test1: Failed, XNew[5] != 59700"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 64428} {
error "Test1: Failed, XNew[6] != 64428"
}
puts "Test 1 Passed!"
run 250 ps
force System/INT 0
force System/PROCESS 0
run 100 ps


################################################## Testcase: 2 ##################################################
mem load -filltype value -filldata 3 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 4 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 19086 -fillradix unsigned /System/Memory/Memory(4)

#Set A Matrix
mem load -filltype value -filldata 61790 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 8256 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 29127 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 4583 -fillradix unsigned /System/Memory/Memory(10)
mem load -filltype value -filldata 27846 -fillradix unsigned /System/Memory/Memory(11)
mem load -filltype value -filldata 19528 -fillradix unsigned /System/Memory/Memory(12)
mem load -filltype value -filldata 42145 -fillradix unsigned /System/Memory/Memory(13)
mem load -filltype value -filldata 29347 -fillradix unsigned /System/Memory/Memory(14)
mem load -filltype value -filldata 61819 -fillradix unsigned /System/Memory/Memory(15)

#Set X Matrix
mem load -filltype value -filldata 39299 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 23018 -fillradix unsigned /System/Memory/Memory(5208)
mem load -filltype value -filldata 10086 -fillradix unsigned /System/Memory/Memory(5209)

#Set B Matrix
mem load -filltype value -filldata 22473 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 51675 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 47986 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 52663 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 544 -fillradix unsigned /System/Memory/Memory(2511)
mem load -filltype value -filldata 46669 -fillradix unsigned /System/Memory/Memory(2512)
mem load -filltype value -filldata 54694 -fillradix unsigned /System/Memory/Memory(2513)
mem load -filltype value -filldata 45382 -fillradix unsigned /System/Memory/Memory(2514)
mem load -filltype value -filldata 10307 -fillradix unsigned /System/Memory/Memory(2515)
mem load -filltype value -filldata 6323 -fillradix unsigned /System/Memory/Memory(2516)
mem load -filltype value -filldata 38736 -fillradix unsigned /System/Memory/Memory(2517)
mem load -filltype value -filldata 30706 -fillradix unsigned /System/Memory/Memory(2518)

#Set U Matrix
mem load -filltype value -filldata 19716 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 65422 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 56722 -fillradix unsigned /System/Memory/Memory(5259)
mem load -filltype value -filldata 53780 -fillradix unsigned /System/Memory/Memory(5260)
force System/INT 1
run 200 ps
force System/PROCESS 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 1150 ps
run 100 ps
run 900 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 63334} {
error "Test2: Failed, XNew[0] != 63334"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 63748} {
error "Test2: Failed, XNew[1] != 63748"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 60835} {
error "Test2: Failed, XNew[2] != 60835"
}
puts "Test 2 Passed!"
run 250 ps
force System/INT 0
force System/PROCESS 0
run 100 ps


################################################## Testcase: 3 ##################################################
mem load -filltype value -filldata 1 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 8 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 13980 -fillradix unsigned /System/Memory/Memory(4)

#Set A Matrix
mem load -filltype value -filldata 14245 -fillradix unsigned /System/Memory/Memory(7)

#Set X Matrix
mem load -filltype value -filldata 14175 -fillradix unsigned /System/Memory/Memory(5207)

#Set B Matrix
mem load -filltype value -filldata 17471 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 35275 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 43425 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 59570 -fillradix unsigned /System/Memory/Memory(2510)
mem load -filltype value -filldata 64021 -fillradix unsigned /System/Memory/Memory(2511)
mem load -filltype value -filldata 61912 -fillradix unsigned /System/Memory/Memory(2512)
mem load -filltype value -filldata 44222 -fillradix unsigned /System/Memory/Memory(2513)
mem load -filltype value -filldata 48308 -fillradix unsigned /System/Memory/Memory(2514)

#Set U Matrix
mem load -filltype value -filldata 3103 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 15319 -fillradix unsigned /System/Memory/Memory(5258)
mem load -filltype value -filldata 33174 -fillradix unsigned /System/Memory/Memory(5259)
mem load -filltype value -filldata 16570 -fillradix unsigned /System/Memory/Memory(5260)
mem load -filltype value -filldata 10604 -fillradix unsigned /System/Memory/Memory(5261)
mem load -filltype value -filldata 28689 -fillradix unsigned /System/Memory/Memory(5262)
mem load -filltype value -filldata 54466 -fillradix unsigned /System/Memory/Memory(5263)
mem load -filltype value -filldata 37763 -fillradix unsigned /System/Memory/Memory(5264)
force System/INT 1
run 200 ps
force System/PROCESS 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 750 ps
run 100 ps
run 100 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 61528} {
error "Test3: Failed, XNew[0] != 61528"
}
puts "Test 3 Passed!"
run 250 ps
force System/INT 0
force System/PROCESS 0
run 100 ps


################################################## Testcase: 4 ##################################################
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(0)
mem load -filltype value -filldata 2 -fillradix unsigned /System/Memory/Memory(1)
mem load -filltype value -filldata 45377 -fillradix unsigned /System/Memory/Memory(4)

#Set A Matrix
mem load -filltype value -filldata 11874 -fillradix unsigned /System/Memory/Memory(7)
mem load -filltype value -filldata 18903 -fillradix unsigned /System/Memory/Memory(8)
mem load -filltype value -filldata 64084 -fillradix unsigned /System/Memory/Memory(9)
mem load -filltype value -filldata 54398 -fillradix unsigned /System/Memory/Memory(10)

#Set X Matrix
mem load -filltype value -filldata 2787 -fillradix unsigned /System/Memory/Memory(5207)
mem load -filltype value -filldata 55623 -fillradix unsigned /System/Memory/Memory(5208)

#Set B Matrix
mem load -filltype value -filldata 35311 -fillradix unsigned /System/Memory/Memory(2507)
mem load -filltype value -filldata 31146 -fillradix unsigned /System/Memory/Memory(2508)
mem load -filltype value -filldata 56168 -fillradix unsigned /System/Memory/Memory(2509)
mem load -filltype value -filldata 48532 -fillradix unsigned /System/Memory/Memory(2510)

#Set U Matrix
mem load -filltype value -filldata 38714 -fillradix unsigned /System/Memory/Memory(5257)
mem load -filltype value -filldata 12150 -fillradix unsigned /System/Memory/Memory(5258)
force System/INT 1
run 200 ps
force System/PROCESS 1
run 400 ps
force System/Interpolate_DONE 1
run 200 ps
force System/Interpolate_DONE 0
run 350 ps
run 100 ps
run 400 ps
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 50455} {
error "Test4: Failed, XNew[0] != 50455"
}
run 300 ps

set val [examine System/RAM_DATA_WR]
if {$val != 65346} {
error "Test4: Failed, XNew[1] != 65346"
}
puts "Test 4 Passed!"
run 250 ps
force System/INT 0
force System/PROCESS 0
run 100 ps
puts "All tests Passed Successfully!"
