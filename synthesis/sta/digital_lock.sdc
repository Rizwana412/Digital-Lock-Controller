create_clock -name clk -period 10.0 [get_ports clk]

set_input_delay -clock clk 0.0 [get_ports enter]
set_input_delay -clock clk 0.0 [get_ports digit]

set_output_delay -clock clk 0.0 [get_ports unlock]
set_output_delay -clock clk 0.0 [get_ports alarm]
