`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:56:56 02/21/2019 
// Design Name: 
// Module Name:    register_file 
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
module register_file(dstE, valE, dstM, valM, srcA, valA, srcB, valB, reset, clock);
    input [ 3:0] dstE;
    input [63:0] valE;
    input [ 3:0] dstM;
    input [63:0] valM;
    input [ 3:0] srcA;
    output [63:0] valA;
    input [ 3:0] srcB;
    output [63:0] valB;
    input reset; // Set registers to 0
    input clock;
    reg [63:0] rf [14:0];
    reg [4:0] i;
	 	 
    always @ (posedge clock)
     if (reset)
       begin
          for (i=0;i<15;i=i+1)
            rf[i] <= 0;
       end
     else begin 
     
        if (dstE!=15)
            rf[dstE] <= valE;
        if (dstM!=15)
            rf[dstM] <= valM;
     end
     
     assign valA= (srcA != 15)? rf[srcA]:0;
     assign valB=(srcB != 15)? rf[srcB]:0;
endmodule
