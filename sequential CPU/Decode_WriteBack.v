`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:19:29 02/22/2019 
// Design Name: 
// Module Name:    Decode_WriteBack 
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
module Decode_WriteBack(
    input  write_enable,
	 input  read_enable,
    output reg [63:0] valA,
    output reg [63:0] valB,
    input [63:0] valM,
    input [63:0] valE,
    input [3:0] rA,
    input [3:0] rB,
    input [3:0] icode,
    input Cnd,
	 input clock,
	 input reset
    );
	`include "cpu_definitions.v"

	reg [3:0] dstE,dstM,srcA,srcB;
	wire [63:0] valA_out, valB_out;
	
	always @ (posedge clock)
		if (read_enable) begin
			valA <= valA_out;
			valB <= valB_out;
		end
	
	
	register_file rf_ins (
		.dstE(dstE), 
		.valE(valE), 
		.dstM(dstM), 
		.valM(valM), 
		.srcA(srcA), 
		.valA(valA_out), 
		.srcB(srcB), 
		.valB(valB_out), 
		.reset(reset), 
		.clock(clock)
	);

	always @* begin
	
		if (icode==IRRMOVQ || icode==IRMMOVQ || icode==IOPQ || icode==IPUSHQ 
								 || icode == IDISP)
			srcA<=rA;
		else if (icode==IPOPQ || icode==IRET)
			srcA<=RRSP;
		else
			srcA<=RNONE;
			
		if (icode==IOPQ || icode==IRMMOVQ || icode==IMRMOVQ)
			srcB<=rB;
		else if (icode==IPUSHQ || icode==IPOPQ||icode==ICALL|| icode==IRET)
			srcB<=RRSP;
		else
			srcB<=RNONE;
			
		if (!write_enable)
			dstM<=RNONE;
		else if (icode==IMRMOVQ || icode==IPOPQ)
			dstM<=rA;
		else
			dstM<=RNONE;
		
		if (!write_enable)
			dstE<=RNONE;
		else if (icode==IRRMOVQ && Cnd)
			dstE<=rB;
		else if (icode == IIRMOVQ || icode==IOPQ)
			dstE<=rB;
		else if (icode==IPUSHQ || icode==IPOPQ || icode==ICALL || icode==IRET)
			dstE<=RRSP;
		else
			dstE<=RNONE;
			
	end
endmodule
