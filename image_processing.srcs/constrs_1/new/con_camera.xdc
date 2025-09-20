## This file is a general .xdc for the Nexys A7-100T
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project


set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { clk100 }]; 
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk100 }];

set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { config_finished }]; 
set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports { is_processing }]; 
set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { write_enable }]; 
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { method[0] }]; 
set_property -dict { PACKAGE_PIN U11   IOSTANDARD LVCMOS33 } [get_ports { method[1] }]; 
set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { method[2] }]; 
set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { btn }];

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets pclk_IBUF];
set_property -dict { PACKAGE_PIN J15    IOSTANDARD LVCMOS33 } [get_ports {mode}];
#set_property -dict { PACKAGE_PIN L16    IOSTANDARD LVCMOS33 } [get_ports {mode[1]}];
#set_property -dict { PACKAGE_PIN M13    IOSTANDARD LVCMOS33 } [get_ports {mode[2]}];
#set_property -dict { PACKAGE_PIN M13    IOSTANDARD LVCMOS33 } [get_ports {selected_kernel[2]}];
#set_property -dict { PACKAGE_PIN R15    IOSTANDARD LVCMOS33 } [get_ports {start_process}];
set_property -dict { PACKAGE_PIN A11    IOSTANDARD LVCMOS33 } [get_ports {SPKOUT}];
set_property -dict { PACKAGE_PIN K1    IOSTANDARD LVCMOS33 } [get_ports { data[0] }];
set_property -dict { PACKAGE_PIN F6    IOSTANDARD LVCMOS33 } [get_ports { data[1] }];
set_property -dict { PACKAGE_PIN J2    IOSTANDARD LVCMOS33 } [get_ports { data[2] }]; 
set_property -dict { PACKAGE_PIN G6    IOSTANDARD LVCMOS33 } [get_ports { data[3] }];
set_property -dict { PACKAGE_PIN E7    IOSTANDARD LVCMOS33 } [get_ports { data[4] }]; 
set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { data[5] }]; 
set_property -dict { PACKAGE_PIN J4    IOSTANDARD LVCMOS33 } [get_ports { data[6] }]; 
set_property -dict { PACKAGE_PIN E6    IOSTANDARD LVCMOS33 } [get_ports { data[7] }]; 

set_property -dict { PACKAGE_PIN H4    IOSTANDARD LVCMOS33  } [get_ports { sioc }];
set_property -dict { PACKAGE_PIN H1    IOSTANDARD LVCMOS33  } [get_ports { siod }]; 
set_property -dict { PACKAGE_PIN G1    IOSTANDARD LVCMOS33 } [get_ports { vsync_t }]; 
set_property -dict { PACKAGE_PIN G3    IOSTANDARD LVCMOS33 } [get_ports { href }];
set_property -dict { PACKAGE_PIN H2    IOSTANDARD LVCMOS33 } [get_ports { pclk }];
set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { xclk }]; 
set_property -dict { PACKAGE_PIN G2    IOSTANDARD LVCMOS33 } [get_ports { reset }]; 
set_property -dict { PACKAGE_PIN F3    IOSTANDARD LVCMOS33 } [get_ports { pwdn }]; 
set_property -dict { PACKAGE_PIN A3    IOSTANDARD LVCMOS33 } [get_ports { vga_r[0] }]; 
set_property -dict { PACKAGE_PIN B4    IOSTANDARD LVCMOS33 } [get_ports { vga_r[1] }]; 
set_property -dict { PACKAGE_PIN C5    IOSTANDARD LVCMOS33 } [get_ports { vga_r[2] }]; 
set_property -dict { PACKAGE_PIN A4    IOSTANDARD LVCMOS33 } [get_ports { vga_r[3] }]; 

set_property -dict { PACKAGE_PIN C6    IOSTANDARD LVCMOS33 } [get_ports { vga_g[0] }]; 
set_property -dict { PACKAGE_PIN A5    IOSTANDARD LVCMOS33 } [get_ports { vga_g[1] }];
set_property -dict { PACKAGE_PIN B6    IOSTANDARD LVCMOS33 } [get_ports { vga_g[2] }]; 
set_property -dict { PACKAGE_PIN A6    IOSTANDARD LVCMOS33 } [get_ports { vga_g[3] }];

set_property -dict { PACKAGE_PIN B7    IOSTANDARD LVCMOS33 } [get_ports { vga_b[0] }]; 
set_property -dict { PACKAGE_PIN C7    IOSTANDARD LVCMOS33 } [get_ports { vga_b[1] }]; 
set_property -dict { PACKAGE_PIN D7    IOSTANDARD LVCMOS33 } [get_ports { vga_b[2] }]; 
set_property -dict { PACKAGE_PIN D8    IOSTANDARD LVCMOS33 } [get_ports { vga_b[3] }]; 

set_property -dict { PACKAGE_PIN B11   IOSTANDARD LVCMOS33 } [get_ports { vga_hsync }]; 
set_property -dict { PACKAGE_PIN B12   IOSTANDARD LVCMOS33 } [get_ports { vga_vsync }];