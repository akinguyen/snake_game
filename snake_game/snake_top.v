`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:10:37 11/20/2019 
// Design Name: 
// Module Name:    snake_top 
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
module snake_top(clk, BtnL, BtnU, BtnD, BtnR, BtnC
    );
	input clk;
	input BtnL, BtnU, BtnD, BtnR, BtnC;	

	parameter [6:0] GROW = 5;
	reg [6:0] size;
	reg [6:0] snakeX[0:127];
	reg [6:0] snakeY[0:127];
	integer i;

	reg [27:0]	div_clk;
	always @ (posedge clk, posedge reset)  
	begin : CLOCK_DIVIDER
      if (reset)
			div_clk <= 0;
      else
			div_clk <= div_clk + 1'b1;
	end	
	
	
	
endmodule
