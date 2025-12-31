create_clock -period 40 -name MainCLK [get_ports {MainCLK}]
create_clock -period 40 -name CLK
create_clock -period 20 -name SCLK [get_ports {SCLK}]
set_clock_groups -exclusive -group {MainCLK CLK} -group {SCLK}
