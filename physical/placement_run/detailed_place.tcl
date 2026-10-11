# Standalone global-placement experiment
cd "$::env(HOME)/Desktop/OpenROAD/test"

source helpers.tcl
source flow_helpers.tcl
source sky130hd/sky130hd.vars

set synth_verilog "$::env(HOME)/Desktop/Digital-Lock-Controller/synthesis/digital_lock_controller_mapped.v"
set design "digital_lock_controller"
set top_module "digital_lock_controller"
set sdc_file "$::env(HOME)/Desktop/Digital-Lock-Controller/synthesis/sta/digital_lock.sdc"
set die_area {0 0 300 300}
set core_area {10 10 290 290}

read_db "$::env(HOME)/Desktop/Digital-Lock-Controller/physical/placement_run/digital_lock_controller_global_place.odb"
read_lef $tech_lef
read_liberty $liberty_file

# Detailed placement stage
source $layer_rc_file
set_wire_rc -signal -layer $wire_rc_layer
set_wire_rc -clock -layer $wire_rc_layer_clk
set_dont_use $dont_use
estimate_parasitics -placement
repair_design -slew_margin $slew_margin -cap_margin $cap_margin
repair_tie_fanout -separation $tie_separation $tielo_port
repair_tie_fanout -separation $tie_separation $tiehi_port
set_placement_padding -global -left $detail_place_pad -right $detail_place_pad
detailed_placement
report_worst_slack -min -digits 3
report_worst_slack -max -digits 3
write_db "$::env(HOME)/Desktop/Digital-Lock-Controller/physical/placement_run/digital_lock_controller_detailed_place.odb"
write_def "$::env(HOME)/Desktop/Digital-Lock-Controller/physical/placement_run/digital_lock_controller_detailed_place.def"
