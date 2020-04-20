## Delete previous waves and add Results Sender module##
delete wave *
add wave -unsigned *
add wave -unsigned /ODE_Solver_Chip/IO/RS/*

## Read Done Processing signal which indicates that the chip has done the processing and the results are ready ##
set Done_Processing [examine -binary sim:/ODE_Solver_Chip/Done_Processing]; string length $Done_Processing

## a variable is just used to simulate the done processing signal as it will force it to 1 after 3 iterations ##
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

## After receiving Done Processing signal force send enable to start the Results Sender module ##
force -freeze sim:/ODE_Solver_Chip/IO/RS/Sending_Enable 1

## Run the module to clock cycle in order to read the number of t and number of x variables
run 200

## in this file we will write the data coming from the bus ##
set file [open "../python-code/binary.txt" w+]


## Define print results function that will take the binary txt file and produce a readable file ##
proc print_results {} {
    set output [exec python ../python-code/print_results.py]
    puts $output
}

set _64data [examine -binary sim:/ODE_Solver_Chip/IO/RS/_64data]; string length $_64data
set num_of_X [examine -binary sim:/ODE_Solver_Chip/IO/RS/num_of_X]; string length $num_of_X
set num_of_T [examine -binary sim:/ODE_Solver_Chip/IO/RS/num_of_T]; string length $num_of_T

## Put these 3 numbers in the beginning of the file, will be used in the print_results.py
puts $file $_64data
puts $file $num_of_T
puts $file $num_of_X

set CPU_Bus [examine -binary sim:/ODE_Solver_Chip/IO/RS/CPU_Bus]; string length $CPU_Bus
set Done_Sending [examine -binary sim:/ODE_Solver_Chip/IO/RS/Done_Sending]; string length $Done_Sending

## Set "a" variable to 0 ##
set a 0

## Loop until reading results is done, a!= 100 is a timeout in case in any failure
while { $Done_Sending !=1 && $a!=100 } {
	## read 64 bit data, 1 => 64, 0 =>32 ##
	set _64data [examine -binary sim:/ODE_Solver_Chip/IO/RS/_64data]; string length $_64data

	## IF the data coming from cpu is 32 bits and we are in the first clock cycle, then skip a clock cycle ##
	if {$_64data  == 0 && $a == 1} {
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
