`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:18:00 12/14/2017 
// Design Name: 
// Module Name:    allModulesMain 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module allModulesMain(
	input clk,
	input btnC,
	input btnU,
	output hs, vs,
	output r0, r1, r2, g0, g1, g2, b0, b1,
	output An0,
	output An1,
	output An2,
	output An3,
	output Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp,
	output St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar
	);
	
	wire w1;
	wire[9:0] w2, w3;
	wire[15:0] w4;
	wire [6:0] out;
	wire [3:0] a;
	wire [7:0] rgb;
	wire scen;
	//w1 = bright, w2= hCount, w3 = vCount, w4 = score;
	ee201_debouncer(.CLK(clk), .RESET(btnC), .PB(btnU), .DPB(), .SCEN(scen), .MCEN(), .CCEN());
	DisplayController dc(clk, hs, vs, w1, w2, w3);
	vgaBitChange vbc(clk, w1, scen, w2, w3, rgb, w4);
	counterVerilog cv(clk, w4, a, out);
	
	assign Dp = 1;
	assign Ca = out[6];
	assign Cb = out[5];
	assign Cc = out[4];
	assign Cd = out[3];
	assign Ce = out[2];
	assign Cf = out[1];
	assign Cg = out[0];
	assign An0 = a[0];
	assign An1 = a[1];
	assign An2 = a[2];
	assign An3 = a[3];
	
	assign r0 = rgb[7];
	assign r1 = rgb[6];
	assign r2 = rgb[5];
	assign g0 = rgb[4];
	assign g1 = rgb[3];
	assign g2 = rgb[2];
	assign b0 = rgb[1];
	assign b1 = rgb[0];
	
	assign 	{St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar} = {5'b11111};

endmodule
