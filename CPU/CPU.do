delete wave *
add wave -unsigned *
add wave -unsigned /ODE_Solver_Chip/Memory/Memory
#add wave -unsigned /ODE_Solver_Chip/IO/DR/*

force -deposit /CLK 1 0, 0 50 -r 100
force -deposit /RST 1
run 100
force -deposit /RST 0

force -deposit /INT 1
force -deposit /Load_Process 1
run 100
force -deposit /INT 0
force -deposit /Load_Process 0

set file [open BinaryData.txt]; string length $file
set input [read $file]; string length $input
set lines [split $input "\n"]; string length $lines
set size [llength $lines]; string length $size
set a 0
set Done_Loading [examine -binary sim:/ODE_Solver_Chip/Done_Loading]; string length $Done_Loading

while { $Done_Loading == 0 } {
	set Done_Packet [examine -binary sim:/ODE_Solver_Chip/Done_Reading_Packet]; string length $Done_Packet
	set Done_Loading [examine -binary sim:/ODE_Solver_Chip/Done_Loading]; string length $Done_Loading
	if {$Done_Packet == 1} {
		force -freeze sim:/ODE_Solver_Chip/CPU_Bus [lindex $lines $a] 0
		incr a
	} 
	run 100
}
close $file


