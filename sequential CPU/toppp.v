`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:15:22 02/21/2019 
// Design Name: 
// Module Name:    toppp 
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
module top(
input clock_in,
input button,
output wire [7:0] RIP_out,
output wire [3:0] Anode_Activate,
output wire [6:0] LED_out
    );
`include "cpu_definitions.v"

	reg [63:0] RIP;
	assign RIP_out= RIP[7:0];

	reg [3:0] state;
	

	wire [79:0] instruction;
	wire [63:0] valP,valC,valA,valB,valM, valE, mem_addr, mem_data;
	wire [3:0] rA, rB, ifun, icode;
	wire Cnd, mem_write, mem_read;
	wire [63:0] new_pc;
	wire [15:0] BCD;

	reg[4:0] delay;
	reg[3:0] count;
	wire clock;
	assign clock=count[0];//NOT SURE
	reg reset_register;

	initial begin
		state = state_init;
		RIP = 0;
		delay = 0;
		count=0;
		reset_register=1;
	end

	always @(posedge clock_in)
		count = count +1;

	always @ (posedge clock) begin
		delay = delay +1;
		if (delay == 10 && state == state_init) begin
			state<= state_fetch;
			reset_register<=0;
		end
		case (state)
			state_fetch: state <= state_decode;
			state_decode: state <= (icode==IHALT)? state_halted : state_execution;
			state_execution: state <= state_memory;
			state_memory: state <= state_wait_memory;
			state_wait_memory: state <= state_writeback;
			state_writeback: state <= state_pc;
			state_pc: begin
				state <= state_wait_pc;
				RIP <= new_pc;
			end
			state_wait_pc: state <= state_fetch;
		endcase
	end

	Fetch fetch_ins (
		.valP(valP), 
		.valC(valC), 
		.rA(rA), 
		.rB(rB), 
		.ifun(ifun), 
		.icode(icode), 
		.instruction(instruction), 
		.pc(RIP)
	);

	Execution Execution_ins (
		.icode(icode), 
		.ifun(ifun), 
		.valC(valC), 
		.valB(valB), 
		.valA(valA), 
		.clock(clock), 
		.button(button),
		.enable(state == state_execution), 
		.valE(valE), 
		.Cnd(Cnd),
		.Anode_Activate(Anode_Activate), 
		.LED_out(LED_out)
	);



	Decode_WriteBack decode_writeback_ins (
		.write_enable(state==state_writeback),
		.read_enable(state==state_decode),
		.valA(valA), 
		.valB(valB), 
		.valM(valM), 
		.valE(valE), 
		.rA(rA), 
		.rB(rB), 
		.icode(icode), 
		.Cnd(Cnd), 
		.clock(clock),
		.reset (reset_register)
	);

	Memory_Access memory_access_ins (
		.mem_addr(mem_addr), 
		.mem_data(mem_data), 
		.read_enable(mem_read), 
		.write_enable(mem_write), 
		.enable(state==state_memory|| state == state_wait_memory), 
		.icode(icode), 
		.valE(valE), 
		.valA(valA), 
		.valP(valP)
	);

	memory mem_ins (
		.maddr(mem_addr), 
		.wenable(mem_write), 
		.wdata(mem_data), 
		.renable(mem_read), 
		.valM(valM), 
		.iaddr(RIP), 
		.instr(instruction), 
		.clock(clock)
	);

	Update_PC update_pc_ins (
		.PC_out(new_pc), 
		.icode(icode), 
		.Cnd(Cnd), 
		.valC(valC), 
		.valM(valM), 
		.valP(valP)
	);
endmodule
