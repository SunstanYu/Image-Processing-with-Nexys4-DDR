// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Sat May 27 20:29:10 2023
// Host        : Sunstan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/Code/VHDL/image_processing/image_processing.srcs/sources_1/ip/image1/image1_stub.v
// Design      : image1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2020.2" *)
module image1(clka, addra, douta, clkb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,addra[15:0],douta[11:0],clkb,addrb[15:0],doutb[11:0]" */;
  input clka;
  input [15:0]addra;
  output [11:0]douta;
  input clkb;
  input [15:0]addrb;
  output [11:0]doutb;
endmodule
