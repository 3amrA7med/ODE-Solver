#--------------------------------------------------------------------
#         date     : Sat Feb 29 16:38:59 EET 2020
#         ppid/pid : 14940/14950
#         hostname : localhost.localdomain
#         arch/os  : x86_64/Linux-3.10.0-1062.12.1.el7.x86_64 
#         install  : /home/vlsi/Installation/Oasys/Oasys-RTL-2019.2.R1
#         currdir  : /home/vlsi/Desktop/oasys_rtl_qs_ekit
#         logfile  : /home/vlsi/Desktop/oasys_rtl_qs_ekit/output/logs/synth.log_29_feb.log
#         tmpdir   : /tmp/oasys.14940/
#--------------------------------------------------------------------
# Starting Gui Interactive Session
# Finished Gui Interactive Session
# Starting Interactive Session
start_gui
# Starting Gui Interactive Session
config::loadConfig config::input
source /home/vlsi/Desktop/oasys_rtl_qs_ekit/scripts/1_adderCofiguration
config::loadConfig config::input
man set_clock_gating_options
man report_timing | more
man report_timing
set_input_delay 0.01 {i_add2[9] i_add2[8] i_add2[7] i_add2[6] i_add2[5] i_add2[4] i_add2[3] i_add2[2] i_add2[15] i_add2[14] i_add2[13] i_add2[12] i_add2[11] i_add2[10] i_add2[1] i_add2[0]}
set_input_delay 0.02 -rise {i_add1[9] i_add1[8] i_add1[7] i_add1[6] i_add1[5] i_add1[4] i_add1[3] i_add1[2] i_add1[15] i_add1[14] i_add1[13] i_add1[12] i_add1[11] i_add1[10] i_add1[1] i_add1[0]}
set_input_delay 0.01 -fall {i_add1[9] i_add1[8] i_add1[7] i_add1[6] i_add1[5] i_add1[4] i_add1[3] i_add1[2] i_add1[15] i_add1[14] i_add1[13] i_add1[12] i_add1[11] i_add1[10] i_add1[1] i_add1[0]}
optimize
report_timing
report_design_metric
report_timing
optimize -virtual
report_timing
report_endpoints
# Finished Gui Interactive Session
man get_ports
man report_timing
exit
#--------------------------------------------------------------------
# End Session at Sat Feb 29 23:18:38 EET 2020                      
#--------------------------------------------------------------------
