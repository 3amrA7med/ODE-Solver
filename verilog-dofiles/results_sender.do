## Delete previous waves and add Results Sender module##
delete wave *
add wave -unsigned /ODE_Solver_Chip/IO/RS/*

## Read Done Processing signal which indicates that the chip has done the processing and the results are ready ##
set Done_Processing [examine -binary sim:/ODE_Solver_Chip/Done_Processing]; list

while { $Done_Processing == 0 } {
set Done_Processing [examine -binary sim:/ODE_Solver_Chip/IO/RS/Done_Processing]; list
run 100
}

## After receiving Done Processing signal force send enable to start the Results Sender module ##
force -freeze sim:/ODE_Solver_Chip/IO/RS/Sending_Enable 1

puts "Start sending the results"

## Run the module to clock cycle in order to read the number of t and number of x variables
run 200

## in this file we will write the data coming from the bus ##
set file [open "../python-code/binary.txt" w+]; list

## in this file we will read the correct data to compare it with the data coming from cpu bus ##
set output_file [open "../verilog-dofiles/correct_output.txt" r]; list
set correct_output [read $output_file]; list
set output [split $correct_output "\n"]; list
set output_Iterator 0; list

## Define print results function that will take the binary txt file and produce a readable file ##
proc print_results {} {
    set output [exec python ../python-code/print_results.py]
    puts $output
}

set _64data [examine -binary sim:/ODE_Solver_Chip/IO/RS/_64data]; list
set num_of_X [examine -binary sim:/ODE_Solver_Chip/IO/RS/num_of_X]; list
set num_of_T [examine -binary sim:/ODE_Solver_Chip/IO/RS/num_of_T]; list

## Check if the data is 64 bit or 32 bit ##
set out [lindex $correct_output $output_Iterator]; list
set failed 0; list
if { $_64data != $out } {
    puts "Test Failed : Data size is wrong"
    incr failed; list
} else {
	puts "Test Passed: Data size is correct"
}
incr output_Iterator; list

## Check if the number of t and number of x is correct ##
set out [lindex $correct_output $output_Iterator]; list
if { $num_of_T != $out } {
    puts "Test Failed : Number of T is wrong"
    incr failed; list
} else {
	puts "Test Passed: Number of T is correct"
}
incr output_Iterator; list

set out [lindex $correct_output $output_Iterator]; list
if { $num_of_X != $out } {
    puts "Test Failed : Number of X is wrong"
    incr failed; list
} else {
	puts "Test Passed: Number of X is correct"
}
incr output_Iterator; list

## Put these 3 numbers in the beginning of the file, will be used in the print_results.py
puts $file $_64data
puts $file $num_of_T
puts $file $num_of_X

set CPU_Bus [examine -binary sim:/ODE_Solver_Chip/IO/RS/CPU_Bus]; list
set Done_Sending [examine -binary sim:/ODE_Solver_Chip/IO/RS/Done_Sending]; list

## Set "a" variable to 0 ##
set loop_index 0; list

## Loop until reading results is done, a!= 100 is a timeout in case in any failure
while { $Done_Sending !=1 && $loop_index!=100 } {
	## read 64 bit data, 1 => 64, 0 =>32 ##
	set _64data [examine -binary sim:/ODE_Solver_Chip/IO/RS/_64data]; list

	## IF the data coming from cpu is 32 bits and we are in the first clock cycle, then skip a clock cycle ##
	if {$_64data  == 0 && $loop_index == 1} {
	run 100
	set CPU_Bus [examine -binary sim:/ODE_Solver_Chip/IO/RS/CPU_Bus]; list
	}
	## Put the data coming from the bus in the binary file
	puts $file $CPU_Bus
	## This part compare the correct output and the output coming from the ram ##
	set out [lindex $correct_output $output_Iterator]; list
	if { $CPU_Bus != $out } {
    	puts "Test Failed : Data coming from CPU Bus is wrong, Data should be:"
		puts $out
		puts "but it is :"
		puts $CPU_Bus 
    	incr failed; list
	} else {
		puts "Test Passed:  Data coming from CPU Bus is correct"
	}
	incr output_Iterator; list

	## Run the code one clock cycle and read new bus and done signal values. ##
	incr loop_index
	run 100
	set CPU_Bus [examine -binary sim:/ODE_Solver_Chip/IO/RS/CPU_Bus]; list
	set Done_Sending [examine -binary sim:/ODE_Solver_Chip/IO/RS/Done_Sending]; list
}

## When done sending is set we read the last data on the bus then we close. ##
set CPU_Bus [examine -binary sim:/ODE_Solver_Chip/IO/RS/CPU_Bus]; list
puts $file $CPU_Bus 
close $file


## Show the number of failed cases id there is any ##
if { $failed != 0 } {
	puts "Number of failed tests:"
	puts $failed
} else {
	puts "All tests passed, Save results in file"
	## take the binary file produced and generate a readable Results.txt file, only if tests passed ##
	print_results
}

puts "Reseting the program."
## After finishing the program deactivate sending ##
force -freeze sim:/ODE_Solver_Chip/IO/RS/Sending_Enable 0
force -freeze sim:/ODE_Solver_Chip/RST St1 0
run 100
force -freeze sim:/ODE_Solver_Chip/RST St0 0
run 100
