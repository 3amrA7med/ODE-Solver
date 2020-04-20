######################### SEND THE ENCODED PACKETS TO THE DECODER ON THE I/O MODULE ##############################
## Add the Waves for Simulation ##
delete wave *
add wave -unsigned *
add wave -unsigned /ODE_Solver_Chip/Memory/Memory

## Send CLK & RST to the Chip ##
force -deposit /CLK 1 0, 0 50 -r 100
force -deposit /RST 1
run 100
force -deposit /RST 0

## Send Start Loading to the Chip ##
force -deposit /INT 1
force -deposit /Load_Process 1
run 100
force -deposit /INT 0
force -deposit /Load_Process 0

## Define Encode Data function that will take the Input Json File, Encode the Date and Put it in the Packets File ##
proc Encode_Data {} {
    set output [exec python Encode_Data.py]
    puts $output
}

## Execute the Encoding Script ##
Encode_Data

## Read The Packets File To Send Them to the I/O Module on the Chip ##
set packets_file [open Packets.txt]; list
set packets_input [read $packets_file]; list
set packets_lines [split $packets_input "\n"]; list
set packets_Iterator 0; list

## Read The [Done Loading] Signal From The Chip to Indicate the Loading Process is Done ## 
set Done_Loading [examine -binary sim:/ODE_Solver_Chip/Done_Loading]; list

## While the Loading Process isn't Done ##
while { $Done_Loading == 0 } {
	## Read The [Done Processing Current Packet] Signal From The Chip To Indicate if the I/O Module ##
	## is Ready To Receive Another Signal Or Not ##
	set Done_Processing_Current_Packet [examine -binary sim:/ODE_Solver_Chip/Done_Processing_Current_Packet]; list

	## If the I/O Module is Ready => Send another 32 bits on the BUS between us ##
	if {$Done_Processing_Current_Packet == 1} {
		force -freeze sim:/ODE_Solver_Chip/CPU_Bus [lindex $packets_lines $packets_Iterator] 0
		incr packets_Iterator
	}

	run 100
	## Read Done Loading Signal Again ##
	set Done_Loading [examine -binary sim:/ODE_Solver_Chip/Done_Loading]; list
}

## Close Files
close $packets_file

################################# CHECK IF THE RESULTS IS READY THEN SENT IT BACK ######################################
## Delete previous waves and add Results Sender module##
delete wave *
add wave -unsigned *
add wave -unsigned /ODE_Solver_Chip/IO/RS/*

## Read Done Processing signal which indicates that the chip has done the processing and the results are ready ##
set Done_Processing [examine -binary sim:/ODE_Solver_Chip/Done_Processing]; string length $Done_Processing

while { $Done_Processing == 0 } {
run 100
set Done_Processing [examine -binary sim:/ODE_Solver_Chip/IO/RS/Done_Processing]; string length $Done_Processing
}

## After receiving Done Processing signal force send enable to start the Results Sender module ##
force -freeze sim:/ODE_Solver_Chip/IO/RS/Sending_Enable 1

## Run the module 2 clock cycles in order to read the number of t and number of x variables ##
run 200

## in this file we will write the data coming from the bus ##
set file [open "binary.txt" w+]

## Define print results function that will take the binary txt file and produce a readable file ##
proc print_results {} {
    set output [exec python print_results.py]
    puts $output
}

set _64data_Enable [examine -binary sim:/ODE_Solver_Chip/IO/RS/_64data_Enable]; string length $_64data_Enable
set num_of_X [examine -binary sim:/ODE_Solver_Chip/IO/RS/num_of_X]; string length $num_of_X
set num_of_T [examine -binary sim:/ODE_Solver_Chip/IO/RS/num_of_T]; string length $num_of_T

## Put these 3 numbers in the beginning of the file, will be used in the print_results.py
puts $file $_64data_Enable
puts $file $num_of_T
puts $file $num_of_X

set CPU_Bus [examine -binary sim:/ODE_Solver_Chip/IO/RS/CPU_Bus]; string length $CPU_Bus
set Done_Sending [examine -binary sim:/ODE_Solver_Chip/IO/RS/Done_Sending]; string length $Done_Sending

## Set "a" variable to 0 ##
set a 0

## Loop until reading results is done, a!= 100 is a timeout in case in any failure
while { $Done_Sending !=1 && $a!=100 } {
	## read 64 bit data enable ##
	set _64data_Enable [examine -binary sim:/ODE_Solver_Chip/IO/RS/_64data_Enable]; string length $_64data_Enable
	
	## IF the data coming from cpu is 32 bits and we are in the first clock cycle, then skip a clock cycle ##
	if {$_64data_Enable  == 0 && $a == 1} {
	run 100
	set CPU_Bus [examine -binary sim:/ODE_Solver_Chip/IO/RS/CPU_Bus]; string length $CPU_Bus
	}

	## Put the data coming from the bus in the binary file
	puts $file $CPU_Bus
	incr a
	run 100
	set CPU_Bus [examine -binary sim:/ODE_Solver_Chip/IO/RS/CPU_Bus]; string length $CPU_Bus
	set Done_Sending [examine -binary sim:/ODE_Solver_Chip/IO/RS/Done_Sending]; string length $Done_Sending
}

## When done sending is set we read the last data on the bus then we close. ##
set CPU_Bus [examine -binary sim:/ODE_Solver_Chip/IO/RS/CPU_Bus]; string length $CPU_Bus
puts $file $CPU_Bus
close $file

## take the binary file produced and generate a readable Results.txt file ##
print_results