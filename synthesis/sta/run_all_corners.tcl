
# Multi-corner STA launcher
# Each corner is run in a separate OpenSTA process by the shell.
# This Tcl file is a placeholder for the host-side commands below.
puts "Use the three separate OpenSTA commands provided in the terminal steps."

# Multi-corner Static Timing Analysis for Digital Lock Controller
# Run inside the OpenSTA container.

set work_dir "/tmp/lock_sta"
set report_dir "$work_dir/reports"

file mkdir $report_dir

# --------------------------------------------------
# TT corner: Typical process, 25C, 1.80V
# --------------------------------------------------
puts "\n========== TT CORNER =========="

read_liberty "$work_dir/corners/sky130_fd_sc_hd__tt_025C_1v80.lib"
read_verilog "$work_dir/digital_lock_controller_mapped.v"
link_design digital_lock_controller
read_sdc "$work_dir/digital_lock.sdc"

report_checks -path_delay max -fields {slew capacitance input_pins} -digits 3 \
    > "$report_dir/tt_timing.txt"
report_checks -path_delay min -fields {slew capacitance input_pins} -digits 3 \
    >> "$report_dir/tt_timing.txt"
report_worst_slack -max >> "$report_dir/tt_timing.txt"
report_worst_slack -min >> "$report_dir/tt_timing.txt"
report_tns >> "$report_dir/tt_timing.txt"

# Reset the design before loading the next corner.
remove_design

# --------------------------------------------------
# SS corner: Slow process, -40C, 1.40V
# --------------------------------------------------
puts "\n========== SS CORNER =========="

read_liberty "$work_dir/corners/sky130_fd_sc_hd__ss_n40C_1v40.lib"
read_verilog "$work_dir/digital_lock_controller_mapped.v"
link_design digital_lock_controller
read_sdc "$work_dir/digital_lock.sdc"

report_checks -path_delay max -fields {slew capacitance input_pins} -digits 3 \
    > "$report_dir/ss_timing.txt"
report_checks -path_delay min -fields {slew capacitance input_pins} -digits 3 \
    >> "$report_dir/ss_timing.txt"
report_worst_slack -max >> "$report_dir/ss_timing.txt"
report_worst_slack -min >> "$report_dir/ss_timing.txt"
report_tns >> "$report_dir/ss_timing.txt"

remove_design

# --------------------------------------------------
# FF corner: Fast process, -40C, 1.95V
# --------------------------------------------------
puts "\n========== FF CORNER =========="

read_liberty "$work_dir/corners/sky130_fd_sc_hd__ff_n40C_1v95.lib"
read_verilog "$work_dir/digital_lock_controller_mapped.v"
link_design digital_lock_controller
read_sdc "$work_dir/digital_lock.sdc"

report_checks -path_delay max -fields {slew capacitance input_pins} -digits 3 \
    > "$report_dir/ff_timing.txt"
report_checks -path_delay min -fields {slew capacitance input_pins} -digits 3 \
    >> "$report_dir/ff_timing.txt"
report_worst_slack -max >> "$report_dir/ff_timing.txt"
report_worst_slack -min >> "$report_dir/ff_timing.txt"
report_tns >> "$report_dir/ff_timing.txt"

puts "\nAll three corner analyses completed."
puts "Reports saved in $report_dir"
