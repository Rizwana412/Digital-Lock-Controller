# Digital Lock Controller - OpenROAD configuration

source "helpers.tcl"
source "flow_helpers.tcl"
source "sky130hd/sky130hd.vars"

set synth_verilog "$::env(HOME)/Desktop/Digital-Lock-Controller/synthesis/digital_lock_controller_mapped.v"
set design "digital_lock_controller"
set top_module "digital_lock_controller"
set sdc_file "$::env(HOME)/Desktop/Digital-Lock-Controller/synthesis/sta/digital_lock.sdc"

# Provisional floorplan dimensions, in microns
set die_area {0 0 300 300}
set core_area {10 10 290 290}

include -echo "flow.tcl"
