`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:15:38 12/14/2017 
// Design Name: 
// Module Name:    vgaBitChange 
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
module vgaBitChange(
	input clk,
	input bright,
	input btnC,
	input btnU,
	input btnD,
	input btnL,
	input btnR,
	input[9:0] hCount, vCount,
	output reg[7:0] rgb,
	output reg[15:0] score
   );
	
	parameter BLACK = 8'b000_000_00;
	parameter WHITE = 8'b111_111_11;
	parameter RED = 8'b111_000_00;
	parameter GREEN = 8'b000_111_00;
	//parameter BLUE = 8'b000_000_00;
	
	parameter [6:0] GROW = 4;
	
	reg [6:0] snakeX[0:127];
	reg [6:0] snakeY[0:127];
	reg [3:0] direction = 4'b0000; // up down left right
	reg [6:0] size;
	reg game_over;
	
	reg [6:0] foodX = 40;
	reg [6:0] foodY = 10;
	wire [6:0] rand_X;
	wire [6:0] rand_Y;
	
	integer i;

	initial begin
		snakeX[0] = 40; // initial head
		snakeY[0] = 30;
		size = 1;
		score = size;
		reset = 1'b0;
		game_over = 0;
		
		for(i = 1; i < 128; i = i + 1)
        begin
          // place the invisible snake parts outside the scanning area
          snakeX[i] <= 127; 
          snakeY[i] <= 127;
        end
		
	end
	
	always@ (posedge clk) // random food
		begin
			rand_X <= (3 * rand_X + 11) % 37;
			rand_Y <= (5 * rand_Y + 7) % 43;
		end
	
	always@ (posedge clk) // update direction
		begin
		if(reset) 
			direction = 4'b0000;
		else if(btnU)
			direction = 4'b1000;
		else if(btnD)
			direction = 4'b0100;
		else if(btnL)
			direction = 4'b0010;
		else if(btnR)
			direction = 4'b0001;
		end

	always@ (posedge clk) // detect death
		// wall
		if((snakeX[0] < 10'd144) || (snakeX[0] >= 10'd784) || (snakeY[0] < 0) || (snakeY[0] >= 10'd779)) begin
			game_over <= 1;
		end
		
		for(i = 1; i < size; i = i + 1) begin
			if(snakeX[0] == snakeX[i] && snakeY[0] == snakeY[i]) begin
				game_over <= 1;
			end
		end
		
	always@ (posedge clk) // detect grow
		if(snakeX[0] == foodX && snakeY[0] == foodY) begin
			size <= size + GROW;          
			foodX <= rand_X;
			foodY <= rand_Y;
			score <= size;
		end
	
	always@ (posedge clk) // move snake 
		if(game_over) begin
			
		end else begin
			for(i = 1; i < size; i = i + 1)
			  begin
				  snakeX[i] <= snakeX[i - 1];
				  snakeY[i] <= snakeY[i - 1];
				
			  end
			case(direction)
			  4'b0001: snakeX[0] <= (snakeX[0] + 1); // right
			  4'b0010: snakeX[0] <= (snakeX[0] - 1); // left
			  4'b0100: snakeY[0] <= (snakeY[0] + 1); // down
			  4'b1000: snakeY[0] <= (snakeY[0] - 1); // up
			endcase
		end
		
		
endmodule
