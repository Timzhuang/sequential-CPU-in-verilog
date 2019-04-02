`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:01:09 02/22/2019 
// Design Name: 
// Module Name:    cond 
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
module cond(
	input [3:0] ifun,
	input [3:0] CC,
	output reg Cnd
    );
	 
`include "cpu_definitions.v"

	always @* begin
		case (ifun)
			C_YES: 	Cnd <= 1;
			C_LE:		Cnd <= (CC[SF]^CC[OF])|CC[ZF];
			C_L:		Cnd <= (CC[SF]^CC[OF]);
			C_E:		Cnd <= CC[ZF];
			C_NE:		Cnd <= ~CC[ZF];
			C_GE:		Cnd <= ~(CC[SF]^CC[OF]);
			C_B:		Cnd <= (CC[BF]);
			default: Cnd <= ~((CC[SF]^CC[OF])|CC[ZF]);
		endcase
	end
endmodule
