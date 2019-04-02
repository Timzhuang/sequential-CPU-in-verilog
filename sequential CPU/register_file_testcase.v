`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:15:46 02/21/2019
// Design Name:   register_file
// Module Name:   C:/Users/152/Desktop/proj4/register_file_testcase.v
// Project Name:  proj4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: register_file
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module register_file_testcase;

	// Inputs
	reg [3:0] dstE;
	reg [63:0] valE;
	reg [3:0] dstM;
	reg [63:0] valM;
	reg [3:0] srcA;
	reg [3:0] srcB;
	reg reset;
	reg clock;

	// Outputs
	wire [63:0] valA;
	wire [63:0] valB;

	// Instantiate the Unit Under Test (UUT)
	register_file uut (
		.dstE(dstE), 
		.valE(valE), 
		.dstM(dstM), 
		.valM(valM), 
		.srcA(srcA), 
		.valA(valA), 
		.srcB(srcB), 
		.valB(valB), 
		.reset(reset), 
		.clock(clock)
	);

	initial begin
		// Initialize Inputs
		dstE = 0;
		valE = 255;
		dstM = 1;
		valM = 127;
		srcA = 0;
		srcB = 1;
		reset = 0;
		clock = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
        #50 dstE = 2;
		valE = 65535;
        #50;
		// Add stimulus here
        $finish;
	end
    
    always 
        #5 clock=~clock;
endmodule

