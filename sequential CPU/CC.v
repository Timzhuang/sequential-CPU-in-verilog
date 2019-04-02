`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:52:41 02/22/2019 
// Design Name: 
// Module Name:    CC 
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
module cc(cc, new_cc, set_cc, reset, clock);

	output [3:0] cc;
	input [3:0] new_cc;
	input set_cc;
	input reset;
	input clock;

	reg [3:0] cc_reg;
	assign cc = cc_reg;

	initial
		cc_reg<=0;

	always @(posedge clock) begin
		if (reset)
			cc_reg <= 0;
		else if (set_cc)
			cc_reg <= new_cc;
	end
endmodule
