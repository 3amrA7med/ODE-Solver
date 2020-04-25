#--------------------------------------------------------------------
#         date     : Sun Mar 01 06:33:44 EET 2020
#         ppid/pid : 25735/25745
#         hostname : localhost.localdomain
#         arch/os  : x86_64/Linux-3.10.0-1062.12.1.el7.x86_64 
#         install  : /home/vlsi/Installation/Oasys/Oasys-RTL-2019.2.R1
#         currdir  : /home/vlsi/Desktop/Lab2
#         logfile  : /home/vlsi/Desktop/Lab2/outputs/logs/synth.log_1_march.log
#         tmpdir   : /tmp/oasys.25735/
#--------------------------------------------------------------------
# Starting Interactive Session
source scripts/0_adder_init_design.tcl
source scripts/1_read_design.tcl
source scripts/2_synthesize_optimize.tcl
source scripts/3_export_design.tcl
unload -no_complaint
unload -nocomplain
reset
delete_design 
source scripts/0_adder_init_design.tcl
source scripts/1_read_design.tcl
report_units
restart
reset_upf
reset_parameter
reset -all
source scripts/0_adder_init_design.tcl
source scripts/1_read_design.tcl
source scripts/2_synthesize_optimize.tcl
source scripts/3_export_design.tcl
reset -all
source scripts/0_adder_init_design.tcl
source scripts/1_read_design.tcl
reset_upf
source scripts/1_read_design.tcl
delete_design
reset
reset_upf
source scripts/run.tcl
#    source scripts/0_adder_init_design.tcl
#    source scripts/1_read_design.tcl
#    source scripts/2_synthesize_optimize.tcl
#    source scripts/3_export_design.tcl
start_gui
# Starting Gui Interactive Session
# Finished Gui Interactive Session
exit
#--------------------------------------------------------------------
# End Session at Sun Mar 01 07:22:17 EET 2020                      
#--------------------------------------------------------------------
