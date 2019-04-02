`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:43:05 02/04/2019 
// Design Name: 
// Module Name:    seven_segment_display 
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
module seven_segment_display(
    input clk_fast,
    input [15:0] BCD,
    output reg [3:0] Anode_Activate,
    output reg [6:0] LED_out
    );

reg [1:0] LED_activating_counter;
reg [3:0] LED_BCD;


reg [10:0] counter;
wire clock_slow=counter[10];


wire blink_off_current_digit;

assign blink_off_current_digit=0;

initial begin
	LED_activating_counter=0;
	counter = 0;
end

always @(posedge clk_fast) begin
	counter = counter + 1;
end

always @(posedge clock_slow) begin
	case (LED_activating_counter)
	2'b11: begin
		Anode_Activate = (blink_off_current_digit)? 4'b1111:4'b0111; 
		LED_BCD = BCD[15:12];
	end
	2'b10: begin
		Anode_Activate = (blink_off_current_digit)? 4'b1111:4'b1011; 
		LED_BCD = BCD[11:8];
	end
	2'b01: begin
		Anode_Activate =(blink_off_current_digit)? 4'b1111:4'b1101; 
		LED_BCD = BCD[7:4];
	end
	2'b00: begin
		Anode_Activate = (blink_off_current_digit)? 4'b1111:4'b1110; 
		LED_BCD = BCD[3:0];
	end
	endcase
	
	LED_activating_counter=1+LED_activating_counter;	
end

always @(*) begin
	case(LED_BCD)
	4'b0000: LED_out = 7'b0000001; // "0"     
	4'b0001: LED_out = 7'b1001111; // "1" 
	4'b0010: LED_out = 7'b0010010; // "2" 
	4'b0011: LED_out = 7'b0000110; // "3" 
	4'b0100: LED_out = 7'b1001100; // "4" 
	4'b0101: LED_out = 7'b0100100; // "5" 
	4'b0110: LED_out = 7'b0100000; // "6" 
	4'b0111: LED_out = 7'b0001111; // "7" 
	4'b1000: LED_out = 7'b0000000; // "8"     
	4'b1001: LED_out = 7'b0000100; // "9" 
	default: LED_out = 7'b0011111; // "empty"
	endcase
end
endmodule