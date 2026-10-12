# Requires a successfully routed ODB and genuine extracted routed SPEF.
set project_root "$::env(PROJECT_ROOT)"
if {![info exists ::env(ROUTED_SPEF)] || $::env(ROUTED_SPEF) eq ""} {
  error "Set ROUTED_SPEF to the actual extracted post-route SPEF."
}
if {![file exists $::env(ROUTED_SPEF)]} {
  error "ROUTED_SPEF does not exist: $::env(ROUTED_SPEF)"
}
set routed_db "$project_root/physical/detailed_route/digital_lock_controller_detailed_route.odb"
if {![file exists $routed_db]} { error "Missing detailed-route ODB: $routed_db" }
source helpers.tcl
source flow_helpers.tcl
source sky130hd/sky130hd.vars
read_lef $tech_lef
read_lef $std_cell_lef
read_liberty $liberty_file
read_db $routed_db
read_sdc "$project_root/synthesis/sta/digital_lock.sdc"
source $layer_rc_file
set_wire_rc -signal -layer $wire_rc_layer
set_wire_rc -clock -layer $wire_rc_layer_clk
read_spef $::env(ROUTED_SPEF)
set_propagated_clock [all_clocks]
puts "===== ROUTED SETUP ====="
report_checks -path_delay max -format full_clock_expanded -digits 3
report_worst_slack -max
report_tns
puts "===== ROUTED HOLD ====="
report_checks -path_delay min -format full_clock_expanded -digits 3
report_worst_slack -min
exit
