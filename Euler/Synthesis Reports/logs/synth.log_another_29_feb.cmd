#--------------------------------------------------------------------
#         date     : Sat Feb 29 23:19:50 EET 2020
#         ppid/pid : 20794/20804
#         hostname : localhost.localdomain
#         arch/os  : x86_64/Linux-3.10.0-1062.12.1.el7.x86_64 
#         install  : /home/vlsi/Installation/Oasys/Oasys-RTL-2019.2.R1
#         currdir  : /home/vlsi/Desktop/oasys_rtl_qs_ekit
#         logfile  : /home/vlsi/Desktop/oasys_rtl_qs_ekit/output/logs/synth.log_another_29_feb.log
#         tmpdir   : /tmp/oasys.20794/
#--------------------------------------------------------------------
# Starting Interactive Session
source 1_read_design.tcl
ls
source scripts/1_read_design.tcl
#    source scripts/init_design.tcl
#        source /home/vlsi/Desktop/oasys_rtl_qs_ekit/scripts/demo_chip_design_files.tcl
source scripts/init_design
source scripts/init_design.tcl
#    source /home/vlsi/Desktop/oasys_rtl_qs_ekit/scripts/demo_chip_design_files.tcl
source scripts/0_adder_init_design.tcl
#    source /home/vlsi/Desktop/oasys_rtl_qs_ekit/scripts/demo_adder_design_files.tcl
source scripts/1_read_design.tcl
#    source /home/vlsi/Desktop/oasys_rtl_qs_ekit/scripts/read_tech_libs.tcl
check_library
synthesize -module ripple_adder
read_sdc -verbose $demo_adder_sdc_files
report_design_metrics
group_path -name I2R -from [all_inputs]
group_path -name I2O   -from [all_inputs] -to [all_outputs]
group_path -name R2O  -to  [all_outputs]
optimize -virtual
report_design_metrics
write_design ${odb_dir}/2_virtual_adder.odb
report_timing
report_path_groups
report_timing -help
man report_timing
report_timing -net
report_timing -from i*
report_timing -from i* -hierarchical
optimize -place
report_timing -from i* -hierarchical
report_timing 
report_path_groups
report_design_metrics
report_power
write_verilog testAdder.v
write_sdc  testAdder.sdc

man write_sdf
report_delay
report_delay -from i* -to o_result[0]
report_delay -delay_type typ -from i* -to o_result[0]
mn report_delay
man report_delay
report_delay -help
report_delay -delay_type i* -from i* -to o_result[0]
report_delay -delay_type net -from i* -to o_result[0]
report_delay -delay_type net -from i_add1 -to o_result[0]
report_delay -delay_type net -from i_add1[0] -to o_result[0]
report_delay -delay_type net 
report_delay -delay_type net -from iadd1[0]
report_delay -delay_type net -from [get_ports iadd1[0]]
start_gui
# Starting Gui Interactive Session
synthesize -module carry_lookahead_adder 
delete_design ripple_adder
delete_design  ripple_adder
delete_design -help
delete_design
check_library
read_verilog full_adder
read_verilog full_adder.v
read_verilog CLA_generic.v
synthesize -module carry_lookahead_adder 
optimize
