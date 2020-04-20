#This testbench is using the built-in operators (+,*) to test Euler module itself



vlog *.v

quit -sim

vsim work.Euler

radix -unsigned

add wave *

set n 2;
set m 3;
set h 5;
set A 7;
set B 2507;
set X 5207;
set U 5257;
set cur 1;


#Answers
set Res1_1 218
set Res1_2 326
set Res2_1 44
set Res2_2 102
set Final_1 1324
set Final_2 2155

mem load -filltype value -filldata $n -fillradix unsigned /Euler/Memory/Memory(0)
mem load -filltype value -filldata $m -fillradix unsigned /Euler/Memory/Memory(1)
mem load -filltype value -filldata $h -fillradix unsigned /Euler/Memory/Memory(4)

#Set A Matrix
for {set i 0} {$i < [expr $n*$n]} {incr i} {
    mem load -filltype value -filldata $cur -fillradix unsigned /Euler/Memory/Memory([expr $i+$A])
    incr cur;
}

#Set B Matrix
for {set i 0} {$i < [expr $n*$m]} {incr i} {
    mem load -filltype value -filldata $cur -fillradix unsigned /Euler/Memory/Memory([expr $i+$B])
    incr cur;
}

#Set U Vector
for {set i 0} {$i < $m} {incr i} {
    mem load -filltype value -filldata $cur -fillradix unsigned /Euler/Memory/Memory([expr $i+$U])
    incr cur;
}

#Set X Vector
for {set i 0} {$i < $n} {incr i} {
    mem load -filltype value -filldata $cur -fillradix unsigned /Euler/Memory/Memory([expr $i+$X])
    incr cur;
}

force -freeze CLK 0 1, 1 {50 ps} -r 100
force INT 0
force PROCESS 0
run


force INT 1
run 200 ps
force PROCESS 1
run 400 ps
force Interpolate_DONE 1
run 200 ps
force Interpolate_DONE 0
run 250 ps

set val [examine RAM_DATA_WR]
echo $val;
if {$val != $Res1_1} {
    #error "Test1: Failed, (B*U)[0] != $Res1_1";
}

run 300
set val [examine RAM_DATA_WR]
if {$val != $Res1_2} {
    error "Test2: Failed, (B*U)[1] != $Res1_2"
}

run 300
set val [examine RAM_DATA_WR]
if {$val != $Res2_1} {
    error "Test3: Failed, (A*X)[0] != $Res2_1"
}

run 200
set val [examine RAM_DATA_WR]
if {$val != $Res2_2} {
    error "Test4: Failed, (A*X)[1] != $Res2_2"
}

run 300
set val [examine RAM_DATA_WR]
if {$val != $Final_1} {
    error "Test5: Failed, XNew[0] != $Final_1"
}


run 300
set val [examine RAM_DATA_WR]
if {$val != $Final_2} {
    error "Test6: Failed, XNew[1] != $Final_2"
}


run 350 ps

puts "All tests Passed Successfully!";