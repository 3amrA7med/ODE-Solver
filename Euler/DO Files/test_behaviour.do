#vlog *.v

quit -sim

vsim work.System

radix -unsigned

add wave /System/Main/*

#for {set i 0} {$i < 3500} {incr i} {
#    mem load -filltype value -filldata $i -fillradix unsigned /System/Memory/Memory($i)
#}

force -freeze CLK 0 1, 1 {50 ps} -r 100
force RST 1
force INT 0
force Interpolate_DONE 0
run 200 ps
force RST 0
force INT 1
run 400 ps
force Interpolate_DONE 1
run
force Interpolate_DONE 0
run 3700 ps


force INT 1
run 200 ps
force PROCESS 1
run 400ps
force Interpolate_DONE 1
run 200ps
force Interpolate_DONE 0
run 3700ps