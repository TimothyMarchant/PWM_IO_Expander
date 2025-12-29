create_clock -period 40 -name MainCLK [get_ports {MainCLK}]
create_clock -period 30 -name SCLK [get_ports {SCLK}]
set_clock_groups -exclusive -group {MainCLK} -group {SLCK}

set_output_delay -clock clk 1 [ all_outputs ]
set_input_delay -clock clk 1 [ all_inputs ]