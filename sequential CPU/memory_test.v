`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:11:44 02/21/2019
// Design Name:   memory
// Module Name:   C:/Users/152/Desktop/proj4/memory_test.v
// Project Name:  proj4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module memory_test;

	// Inputs
	reg [63:0] maddr;
	reg wenable;
	reg [63:0] wdata;
	reg renable;
	reg [63:0] iaddr;
	reg clock;

	// Outputs
	wire [63:0] valM;
	wire m_ok;
	wire [79:0] instr;
	wire i_ok;

	// Instantiate the Unit Under Test (UUT)
	memory uut (
		.maddr(maddr), 
		.wenable(wenable), 
		.wdata(wdata), 
		.renable(renable), 
		.valM(valM), 
		.m_ok(m_ok), 
		.iaddr(iaddr), 
		.instr(instr), 
		.i_ok(i_ok), 
		.clock(clock)
	);

  integer i;
 
 initial begin
  
 end

	initial begin
		// Initialize Inputs
		maddr = 0;
		wenable = 0;
		wdata = 0;
		renable = 1;
		iaddr = 0;
		clock = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		  
		  // initialization
		wenable = 0;
		for (i = 0; i < 256; i = i + 1) begin
			maddr <= i;
			iaddr <= i;
			# 50;
		end
				  
		// Add stimulus here
        #50
        wenable = 0;
        maddr = 8;
        # 50;
        maddr = 9;
        # 50;
        maddr = 10;
        # 50; maddr = 11;
        # 50; maddr = 12;
        # 50; maddr = 13;
        # 50; maddr = 14;
        # 50; maddr = 15;
        # 50; maddr = 16;
        # 50; iaddr = 0;
        # 50; iaddr = 1;
        # 50; iaddr = 2;
        # 50; iaddr = 3;
        # 50; iaddr = 4;
        # 50; iaddr = 5;
        # 50; iaddr = 6;
        # 50; iaddr = 7;
        # 50; iaddr = 8;
        # 50; iaddr = 9;
        # 50; iaddr = 10;
        # 50; iaddr = 11;
        # 50; iaddr = 12;
        #50;
		  

		  
        $finish;
	end
    
    always 
        #5 clock=~clock;
endmodule

