source "$::env(HOME)/Desktop/OpenROAD/test/helpers.tcl"
source "$::env(HOME)/Desktop/OpenROAD/test/flow_helpers.tcl"
source "$::env(HOME)/Desktop/OpenROAD/test/sky130hd/sky130hd.vars"

read_lef $tech_lef
read_lef $std_cell_lef
read_liberty $liberty_file

read_db "$::env(HOME)/Desktop/Digital-Lock-Controller/physical/global_route/digital_lock_controller_global_route.odb"
read_sdc "$::env(HOME)/Desktop/Digital-Lock-Controller/synthesis/sta/digital_lock.sdc"

source $layer_rc_file
set_wire_rc -signal -layer $wire_rc_layer
set_wire_rc -clock -layer $wire_rc_layer_clk
estimate_parasitics -global_routing
set_propagated_clock [all_clocks]

report_checks -path_delay max -format full_clock_expanded
report_checks -path_delay min -format full_clock_expanded
report_worst_slack -max
report_worst_slack -min
report_tns

exit
