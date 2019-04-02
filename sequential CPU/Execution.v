`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:14:36 02/22/2019 
// Design Name: 
// Module Name:    Execution 
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
module Execution(
	input [3:0] icode,
	input [3:0] ifun,
	input [63:0] valC,
	input [63:0] valB,
	input [63:0] valA,
	input clock,
	input enable,
	input button,
	output wire [63:0] valE,
	output Cnd,
	output wire [3:0] Anode_Activate,
	output wire [6:0] LED_out
    );
	 
`include "cpu_definitions.v"

	wire[15:0] BCD;

	wire [2:0] new_cc;
	wire [3:0] cc;


	wire [3:0] alufun;
	assign alufun = (icode == IOPQ) ? ifun : ALUADD; 
	wire set_cc;
	assign set_cc = (enable && (icode == IOPQ || icode == IBTN));

	reg [63:0] aluA, aluB;
	
	always @* begin
		if (icode == IRRMOVQ || icode==IOPQ)
			aluA <= valA;
		else if (icode == IIRMOVQ || icode == IRMMOVQ || icode == IMRMOVQ)
			aluA <= valC;
		else if (icode == ICALL || icode == IPUSHQ)
			aluA <= -8;
		else
			aluA <= 8;
			
		if (icode == IRRMOVQ || icode == IIRMOVQ)
			aluB <= 0;
		else
			aluB <= valB;
	end

alu alu (
    .aluA(aluA), 
    .aluB(aluB), 
    .alufun(alufun), 
    .valE(valE), 
    .cc_out(new_cc)
    );

cc cc_inst (
    .cc(cc), 
    .new_cc({ icode== IBTN && button,new_cc}), 
    .set_cc(set_cc), 
    .reset(1'h0), 
    .clock(clock)
    );

cond cond (
    .ifun(ifun), 
    .CC(cc), 
    .Cnd(Cnd)
    );

Display_Reg Disp_ins (
    .clock(clock), 
    .we(icode == IDISP && enable), 
    .num(valA[13:0]), 
    .BCD(BCD)
    );

seven_segment_display display_ins (
    .clk_fast(clock), 
    .BCD(BCD), 
    .Anode_Activate(Anode_Activate), 
    .LED_out(LED_out)
    );
endmodule
