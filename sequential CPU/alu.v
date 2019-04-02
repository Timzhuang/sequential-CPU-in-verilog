`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:32:21 02/22/2019 
// Design Name: 
// Module Name:    alu 
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
module alu(aluA, aluB, alufun, valE, cc_out);
	input [63:0] aluA,aluB;
	input [3:0] alufun;
	output reg [63:0] valE;
	output reg [2:0] cc_out;
	`include "cpu_definitions.v"
	
	always @* begin
		case (alufun)
			ALUMUL: valE<=aluA*aluB;
			ALUSUB: valE<=aluB-aluA;
			ALUAND: valE<=aluB&aluA;
			ALUXOR: valE<=aluB^aluA;
			default: valE <= aluB+aluA;
		endcase
	end

	always @* begin
		cc_out[SF] <= valE[63];
		cc_out[ZF] <= (|valE)==0;
		if (alufun==ALUADD && (aluA[63] == aluB[63]) && (aluA[63] != valE[63]))
			cc_out[OF] <= 1;
		else if (alufun == ALUSUB && (aluA[63]!=aluB[63]) && (aluB[63] !=valE[63]))
			cc_out[OF] <= 1;
		else
			cc_out[OF] <=0;
	end

endmodule
