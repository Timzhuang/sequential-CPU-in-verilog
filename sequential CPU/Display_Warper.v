`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:04:34 02/24/2019 
// Design Name: 
// Module Name:    Display_Warper 
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
module Display_Reg(
	 input clock,
	 input we,
	 input [13:0] num,
	 output reg [15:0] BCD
    );
	 
		wire [15:0] next_BCD;
	 
		assign next_BCD[3:0]=num%10;
		assign next_BCD[7:4]=(num/10)%10;
		assign next_BCD[11:8]=(num/100)%10;
		assign next_BCD[15:12]=(num/1000)%10;
	 
	initial 
		BCD=0;
		
	always @(posedge clock)
		if (we) begin 
			BCD<=next_BCD;
		end

endmodule
