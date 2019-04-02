`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:28:54 02/20/2019
// Design Name:   bank
// Module Name:   /opt/152A/14.7/ISE_DS/proj4/bank_test.v
// Project Name:  proj4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: bank
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module bank_test;

	// Inputs
	reg clka;
	reg [0:0] wea;
	reg [9:0] addra;
	reg [7:0] dina;
	reg clkb;
	reg [0:0] web;
	reg [9:0] addrb;
	reg [7:0] dinb;

	// Outputs
	wire [7:0] douta;
	wire [7:0] doutb;

	// Instantiate the Unit Under Test (UUT)
	bank uut (
		.clka(clka), 
		.wea(wea), 
		.addra(addra), 
		.dina(dina), 
		.douta(douta), 
		.clkb(clkb), 
		.web(web), 
		.addrb(addrb), 
		.dinb(dinb), 
		.doutb(doutb)
	);

	initial begin
		// Initialize Inputs
		clka = 0;
		wea = 0;
		addra = 0;
		dina = 0;
		clkb = 0;
		web = 0;
		addrb = 0;
		dinb = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

