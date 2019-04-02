`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:52:52 02/22/2019 
// Design Name: 
// Module Name:    Memory_Access 
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
module Memory_Access(
    output reg [63:0] mem_addr,
	 output reg [63:0] mem_data,
	 output reg read_enable,
	 output reg write_enable,
    input enable,
    input [3:0] icode,
    input [63:0] valE,
    input [63:0] valA,
    input [63:0] valP
    );
`include "cpu_definitions.v"

always @* begin
	if(icode==ICALL)
		mem_data <=valP;
	else
		mem_data <= valA;

	if (icode==IRMMOVQ || icode ==IPUSHQ || icode==ICALL || icode==IMRMOVQ)
		mem_addr<=valE;
	else
		mem_addr<=valA;
	
	if (!enable)
		read_enable <=0;
	else if (icode==IMRMOVQ || icode==IPOPQ || icode==IRET)
		read_enable<=1;
	else
		read_enable<=0;
	
	if (!enable)
		write_enable <=0;
	else if (icode== IRMMOVQ || icode == IPUSHQ || icode == ICALL)
		write_enable <=1;
	else
		write_enable <=0;
			
end

endmodule
