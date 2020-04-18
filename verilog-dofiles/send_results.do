delete wave *
add wave -unsigned *
add wave -unsigned /ODE_Solver_Chip/IO/RS/*

set Done_Processing [examine -binary sim:/ODE_Solver_Chip/Done_Processing]; string length $Done_Processing

set a 0
while { $Done_Processing == 0 } {

if{$a == 2}
{
	force -freeze sim:/ODE_Solver_Chip/Done_Processing 1
}
set Done_Processing [examine -binary sim:/ODE_Solver_Chip/IO/RS/Done_Processing]; string length $Done_Processing
run 100
incr a
}


force -freeze sim:/ODE_Solver_Chip/IO/RS/Sending_Enable 1
run 200
set a 0

set file [open "output.txt" w+]

set _64data_Enable [examine -binary sim:/ODE_Solver_Chip/IO/RS/_64data_Enable]; string length $_64data_Enable
set num_of_X [examine -binary sim:/ODE_Solver_Chip/IO/RS/num_of_X]; string length $num_of_X
set num_of_T [examine -binary sim:/ODE_Solver_Chip/IO/RS/num_of_T]; string length $num_of_T
puts $file $_64data_Enable
puts $file $num_of_T
puts $file $num_of_X

set CPU_Bus [examine -binary sim:/ODE_Solver_Chip/IO/RS/CPU_Bus]; string length $CPU_Bus
set Done_Sending [examine -binary sim:/ODE_Solver_Chip/IO/RS/Done_Sending]; string length $Done_Sending

while { $Done_Sending !=1 && $a!=100 } {
	
	set _64data_Enable [examine -binary sim:/ODE_Solver_Chip/IO/RS/_64data_Enable]; string length $_64data_Enable
	if {$_64data_Enable  == 0 && $a == 1} {
	run 100
	set CPU_Bus [examine -binary sim:/ODE_Solver_Chip/IO/RS/CPU_Bus]; string length $CPU_Bus
	} 
	
	puts $file $CPU_Bus
	incr a
	run 100
	set CPU_Bus [examine -binary sim:/ODE_Solver_Chip/IO/RS/CPU_Bus]; string length $CPU_Bus
	set Done_Sending [examine -binary sim:/ODE_Solver_Chip/IO/RS/Done_Sending]; string length $Done_Sending
}
set CPU_Bus [examine -binary sim:/ODE_Solver_Chip/IO/RS/CPU_Bus]; string length $CPU_Bus
puts $file $CPU_Bus 
close $file

