## Define Random Json function that will generate JSON file with Random Data ##
proc Random_JSON {} {
    set output [exec python Random_JSON.py]
    puts $output
}

## Define Encode Data function that will take the Input Json File, Encode the Date and Put it in the Packets File ##
proc Encode_Data {} {
    set output [exec python Encoder.py]
    puts $output
}

## Call python Scripts to Generate Random JSON file and Encode it to Packets
Random_JSON
Encode_Data

## Read The Packets File To Send Them to the I/O Module on the Chip 
set packets_file [open Packets.txt]; list
set packets_input [read $packets_file]; list
set packets_lines [split $packets_input "\n"]; list
set packets_Iterator 0; list

## Read The Original Elements File To Compare Them with the Decoded Data from the I/O Module 
set original_data_file [open OriginalElements.txt]; list
set original_data_input [read $original_data_file]; list
set original_data_lines [split $original_data_input "\n"]; list
set original_data_Iterator 0; list

## Variable To Calculate Number of False Decoded Data 
set Fasle_Values 0 ; list



## Add the Waves for Simulation
delete wave *
## ADD IO Module Waves
add wave -unsigned /ODE_Solver_Chip/IO/RAM_Address_WR  
add wave -unsigned /ODE_Solver_Chip/IO/RAM_Data_WR      
add wave -unsigned /ODE_Solver_Chip/IO/RAM_Address_RD_A 
add wave -unsigned /ODE_Solver_Chip/IO/RAM_Address_RD_B 
add wave -unsigned /ODE_Solver_Chip/IO/IO_Memory_WR_Enable
add wave -unsigned /ODE_Solver_Chip/IO/Done_Processing 

## ADD ODE SOLVER Module Waves
add wave -unsigned *

## ADD Memory
add wave -unsigned /ODE_Solver_Chip/Memory/Memory

## ADD Decoder Module Waves
add wave -unsigned /ODE_Solver_Chip/IO/DR/RST
add wave -unsigned /ODE_Solver_Chip/IO/DR/CLK
add wave -unsigned /ODE_Solver_Chip/IO/DR/CPU_Bus
add wave -unsigned /ODE_Solver_Chip/IO/DR/Loading_Enable
add wave -unsigned /ODE_Solver_Chip/IO/DR/Done_Element
add wave -unsigned /ODE_Solver_Chip/IO/DR/Done_Loading
add wave -unsigned /ODE_Solver_Chip/IO/DR/RAM_Address
add wave -unsigned /ODE_Solver_Chip/IO/DR/RAM_Data
add wave -unsigned /ODE_Solver_Chip/IO/DR/Done_Processing_Current_Packet
add wave -unsigned /ODE_Solver_Chip/IO/DR/Data_Size
add wave -unsigned /ODE_Solver_Chip/IO/DR/PacketSize
add wave -unsigned /ODE_Solver_Chip/IO/DR/RowsCount
add wave -unsigned /ODE_Solver_Chip/IO/DR/RowsNum
add wave -unsigned /ODE_Solver_Chip/IO/DR/InitCount
add wave -unsigned /ODE_Solver_Chip/IO/DR/Small_Packet_Indication_Bit_Location
add wave -unsigned /ODE_Solver_Chip/IO/DR/N_Indication_Bit
add wave -unsigned /ODE_Solver_Chip/IO/DR/N
add wave -unsigned /ODE_Solver_Chip/IO/DR/Start_Bit
add wave -unsigned /ODE_Solver_Chip/IO/DR/Row_Done_Bit
add wave -unsigned /ODE_Solver_Chip/IO/DR/Data_Bit
add wave -unsigned /ODE_Solver_Chip/IO/DR/N_Indication_Bit
add wave -unsigned /ODE_Solver_Chip/IO/DR/Update_Address_Indication_Bit
add wave -unsigned /ODE_Solver_Chip/IO/DR/Done_Element_Delayed
add wave -unsigned /ODE_Solver_Chip/IO/DR/Row_Done_Bit_Delayed
add wave -unsigned /ODE_Solver_Chip/IO/DR/Relative_Address


## Send CLK & RST to the Chip 
force -deposit /CLK 1 0, 0 50 -r 100
force -deposit /RST 1
run 100
force -deposit /RST 0

## Send Start Loading to the Chip
force -deposit /INT 1
force -deposit /Load_Process 1
#run 100
force -deposit /INT 0
force -deposit /Load_Process 0


## Read The [Done Loading] Signal From The Chip to Indicate the Loading Process is Done  
set Done_Loading [examine -binary sim:/ODE_Solver_Chip/Done_Loading]; list

## While the Loading Process isn't Done
while { $Done_Loading == 0 } {
	## Read The [Done Processing Current Packet] Signal From The Chip To Indicate if the I/O Module
	## is Ready To Receive Another Signal Or Not
	set Done_Processing_Current_Packet [examine -binary sim:/ODE_Solver_Chip/Done_Processing_Current_Packet]; list

	## Read The [Done Element] Signal From The Chip To Indicate if the I/O Module
	## has Decoded Some Element So Now We Can Compare it with the Original Elements before Encoding
	set Done_Element [examine -binary sim:/ODE_Solver_Chip/IO/DR/Done_Element]; list
	
	## If the I/O Module is Ready => Send another 32 bits on the BUS between us 
	if {$Done_Processing_Current_Packet == 1} {
		force -freeze sim:/ODE_Solver_Chip/CPU_Bus [lindex $packets_lines $packets_Iterator] 0
		incr packets_Iterator
	}

	## If Some Element has been Decoded => Compare It with the Original Data before Encoding
	if {$Done_Element == 1} {
		set Original_Element [lindex $original_data_lines $original_data_Iterator]; list
		set Decoded_Element [examine -binary sim:/ODE_Solver_Chip/IO/DR/RAM_Data]; list

		## Neglect The Last Line in The File => Empty Line
		if {$Original_Element != "" } {
			puts $Original_Element; 
			puts $Decoded_Element;
			if {$Original_Element == $Decoded_Element} {
				puts "Equal";
			} else {
				incr Fasle_Values
			}
		}
		incr original_data_Iterator;
	}
	
	run 100

	## Read Done Loading Signal Again
	set Done_Loading [examine -binary sim:/ODE_Solver_Chip/Done_Loading]; list
}

if {$Fasle_Values == 0} {
		puts "All Data are Decoded Successfully";
	}

## Close Files
close $packets_file
close $original_data_file 