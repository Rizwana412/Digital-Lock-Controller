# Detailed routing; run from OPENROAD_TEST so relative vars paths resolve.
# Known DRT-0073 pin-access failures must be fixed before this stage can pass.
set project_root "$::env(PROJECT_ROOT)"
source helpers.tcl
source flow_helpers.tcl
source sky130hd/sky130hd.vars
read_lef $tech_lef
read_lef $std_cell_lef
read_liberty $liberty_file
read_db "$project_root/physical/global_route/digital_lock_controller_global_route.odb"
read_sdc "$project_root/synthesis/sta/digital_lock.sdc"
source $layer_rc_file
set_wire_rc -signal -layer $wire_rc_layer
set_wire_rc -clock -layer $wire_rc_layer_clk
set_routing_layers -signal $global_routing_layers -clock $global_routing_clock_layers
set_dont_use $dont_use
set_propagated_clock [all_clocks]
estimate_parasitics -global_routing
read_guides "$project_root/physical/global_route/digital_lock_controller.route_guide"
pin_access -via_access_layer met1 -via_in_pin_bottom_layer met1 -via_in_pin_top_layer met5 -min_access_points 1 -verbose 2
detailed_route -min_access_points 1 \
  -output_drc "$project_root/physical/detailed_route/route_drc.rpt" \
  -output_maze "$project_root/physical/detailed_route/route_maze.log" \
  -verbose 0
write_guides "$project_root/physical/detailed_route/output_guide.mod"
write_db "$project_root/physical/detailed_route/digital_lock_controller_detailed_route.odb"
write_def "$project_root/physical/detailed_route/digital_lock_controller_detailed_route.def"
report_checks -path_delay min
report_checks -path_delay max
exit
