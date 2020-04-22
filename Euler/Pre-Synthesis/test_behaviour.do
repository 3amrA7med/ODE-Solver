vlog *.v

quit -sim

vsim work.Euler

radix -unsigned

add wave *

for {set i 0} {$i < 3500} {incr i} {
    mem load -filltype value -filldata $i -fillradix unsigned /Euler/Memory/Memory($i)
}

force -freeze CLK 0 1, 1 {50 ps} -r 100
force INT 0
force PROCESS 0
run


force INT 1
run 200 ps
force PROCESS 1
run 400ps
force Interpolate_DONE 1
run 200ps
force Interpolate_DONE 0
run 3700ps