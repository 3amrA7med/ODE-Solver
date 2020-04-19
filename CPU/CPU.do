## Add the Waves for Simulation
delete wave *
add wave -unsigned *
add wave -unsigned /ODE_Solver_Chip/Memory/Memory

## Send CLK & RST to the Chip 
force -deposit /CLK 1 0, 0 50 -r 100
force -deposit /RST 1
run 100
force -deposit /RST 0

## Send Start Loading to the Chip
force -deposit /INT 1
force -deposit /Load_Process 1
run 100
force -deposit /INT 0
force -deposit /Load_Process 0

## Read The Packets File To Send Them to the I/O Module on the Chip 
set packets_file [open Packets.txt]; list
set packets_input [read $packets_file]; list
set packets_lines [split $packets_input "\n"]; list
set packets_Iterator 0; list

## Read The [Done Loading] Signal From The Chip to Indicate the Loading Process is Done  
set Done_Loading [examine -binary sim:/ODE_Solver_Chip/Done_Loading]; list

## While the Loading Process isn't Done
while { $Done_Loading == 0 } {
	## Read The [Done Processing Current Packet] Signal From The Chip To Indicate if the I/O Module
	## is Ready To Receive Another Signal Or Not
	set Done_Processing_Current_Packet [examine -binary sim:/ODE_Solver_Chip/Done_Processing_Current_Packet]; list

	## If the I/O Module is Ready => Send another 32 bits on the BUS between us 
	if {$Done_Processing_Current_Packet == 1} {
		force -freeze sim:/ODE_Solver_Chip/CPU_Bus [lindex $packets_lines $packets_Iterator] 0
		incr packets_Iterator
	}

	run 100
	## Read Done Loading Signal Again
	set Done_Loading [examine -binary sim:/ODE_Solver_Chip/Done_Loading]; list
}

## Close Files
close $packets_file
 