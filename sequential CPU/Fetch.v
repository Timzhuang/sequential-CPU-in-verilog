`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:40:22 02/22/2019 
// Design Name: 
// Module Name:    Fetch 
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
module Fetch(
    output [63:0] valP,
    output [63:0] valC,
    output [3:0] rA,
    output [3:0] rB,
    output [3:0] ifun,
    output [3:0] icode,
    input [79:0] instruction,
	 input [63:0] pc
    );
	 
`include "cpu_definitions.v"
	
	wire need_regids,need_valC;
	
	assign icode = instruction [3:0];
	assign ifun = instruction [7:4];
	assign rA = instruction [11:8];
	assign rB = instruction [15:12];
	assign valC = need_regids ? instruction [79:16]:instruction [71:8];
	/*assign valC = need_regids ? {instruction [75:72],instruction [79:76],
				instruction [67:64],instruction [71:68],instruction [59:56],
				instruction [63:60],instruction [51:48],instruction [55:52],
				instruction [43:40],instruction [47:44],instruction [35:32],
				instruction [39:36],instruction [27:24],instruction [31:28],
				instruction [19:16],instruction [23:20]}:
				{instruction [67:64],instruction [71:68],instruction [59:56],
				instruction [63:60],instruction [51:48],instruction [55:52],
				instruction [43:40],instruction [47:44],instruction [35:32],
				instruction [39:36],instruction [27:24],instruction [31:28],
				instruction [19:16],instruction [23:20],instruction [11:8],
				instruction [15:12]};
	*/
	assign need_regids = (icode == IRRMOVQ || icode == IOPQ || icode == IPUSHQ || icode == IPOPQ || 
								icode == IIRMOVQ || icode == IRMMOVQ || icode == IMRMOVQ || icode == IDISP) ;
	assign need_valC = (icode == IIRMOVQ || icode == IRMMOVQ || icode == IMRMOVQ || icode == IJXX 
								|| icode == ICALL);
	assign valP = pc + 1 + 8*need_valC + need_regids;
	
endmodule
