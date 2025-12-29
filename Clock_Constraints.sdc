create_clock -period 20 -name MainCLK [get_ports {MainCLK}]
create_clock -period 30 -name shift_CLK [get_ports {shift_register_CLK}]
set_clock_groups -exclusive -group {MainCLK} -group {shift_CLK}

set_output_delay -clock clk 5 [ all_outputs ]
set_input_delay -clock clk 5 [ all_inputs ]