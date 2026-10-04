read_liberty /work/synthesis/sky130hd_tt.lib
read_verilog /work/synthesis/digital_lock_controller_mapped.v
link_design digital_lock_controller
read_sdc /work/synthesis/sta/digital_lock.sdc

report_checks -path_delay max -fields {slew capacitance input_pins} -digits 3
report_checks -path_delay min -fields {slew capacitance input_pins} -digits 3

report_worst_slack -max
report_worst_slack -min

report_tns
