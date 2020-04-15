
delete wave *
add wave -unsigned *
add wave -unsigned /ODE_Solver_Chip/IO/RS/*

force -deposit /CLK 1 0, 0 50 -r 100

set CPU_Bus [examine -binary sim:/ODE_Solver_Chip/Results_Sender/CPU_Bus]; string length $CPU_Bus
set Done_Sending [examine -binary sim:/ODE_Solver_Chip/IO/RS/Done_Sending]; string length $Done_Sending
set Done_Processing [examine -binary sim:/ODE_Solver_Chip/Done_Processing]; string length $Done_Processing
set file [open "output.txt" w+]

set a 0
while { $Done_Processing == 0 } {

if {$a == 2}
{
	force -freeze sim:/ODE_Solver_Chip/Done_Processing 1
}
run 100
incr a
}


force -freeze sim:/ODE_Solver_Chip/IO/RS/Sending_Enable 1
run 300
set a 0
#Done_Sending
while { $a != 3  } {

	
	puts $file CPU_Bus 
	puts $file "\n"
	run 100
	incr a
}


close $file

