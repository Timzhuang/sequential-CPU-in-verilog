`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:30:09 02/20/2019 
// Design Name: 
// Module Name:    memory 
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
//32kB memory in total
//////////////////////////////////////////////////////////////////////////////////
module memory(maddr, wenable, wdata, renable, valM, m_ok,
iaddr, instr, i_ok, clock);

input [63:0] maddr; // Read/Write address
input wenable; // Write enable
input [63:0] wdata; // Write data
input renable; // Read enable
output reg [63:0] valM;// Read data
output m_ok; // Read & write addresses within range
input [63:0] iaddr; // Instruction address
output reg [79:0] instr; // 10 bytes of instruction
output i_ok; // Instruction address within range
input clock;

	// Inputs
	reg [15:0] wea;

	// Outputs
	reg [16*8-1:0] dinm;
	wire [16*8-1:0] doutm;
	wire [16*8-1:0] douti;

	//registered Output
	reg [63:0] rdata;

	reg [16*11-1:0] m_effective_addr;
	wire [3:0] m_bank_offset;
	assign m_bank_offset=maddr[3:0];
	wire [10:0] m_bank_addr;
	assign m_bank_addr = maddr [14:4];
	wire [10:0] m_bank_addr_inc;
	assign m_bank_addr_inc = m_bank_addr + 1;
	reg [16*11-1:0] i_effective_addr;
	wire [3:0] i_bank_offset;
	assign i_bank_offset=iaddr[3:0];
	wire [10:0] i_bank_addr;
	assign i_bank_addr = iaddr [14:4];
	wire [10:0] i_bank_addr_inc;
	assign i_bank_addr_inc = i_bank_addr + 1;
	
	always @ (posedge clock)
		if (renable)
			valM<=rdata;
	
	always @(*) begin
		dinm=0;
		dinm[63:0]=wdata;
		dinm = dinm << (m_bank_offset*8);
		if (m_bank_offset>8)
			dinm = dinm | (wdata >> (16-m_bank_offset)*8);
	end
	
	always @(*) begin
		case (m_bank_offset)
		0: begin 
			m_effective_addr = {16{m_bank_addr}};
			rdata = doutm[63:0];
			wea=0;
			wea[7:0]=wenable? 8'hFF:0;
		end
		1: begin 
			m_effective_addr= {{15{m_bank_addr}},{1{m_bank_addr_inc}}};
			rdata = doutm[71:8];
			wea=0;
			wea[8:1]=wenable? 8'hFF:0;
		end
		2: begin 
			m_effective_addr= {{14{m_bank_addr}},{2{m_bank_addr_inc}}};
			rdata = doutm[79:16];
			wea=0;
			wea[9:2]=wenable? 8'hFF:0;
		
		end
		3: begin 
			m_effective_addr= {{13{m_bank_addr}},{3{m_bank_addr_inc}}};
			rdata = doutm[87:24];
			wea=0;
			wea[10:3]=wenable? 8'hFF:0;
		end
		4: begin 
			m_effective_addr= {{12{m_bank_addr}},{4{m_bank_addr_inc}}};
			rdata = doutm[95:32];
			wea=0;
			wea[11:4]=wenable? 8'hFF:0;
		end
		5: begin 
			m_effective_addr= {{11{m_bank_addr}},{5{m_bank_addr_inc}}};
			rdata = doutm[103:40];
			wea=0;
			wea[12:5]=wenable? 8'hFF:0;
		
		end
		6: begin 
			m_effective_addr= {{10{m_bank_addr}},{6{m_bank_addr_inc}}};
			rdata = doutm[111:48];
			wea=0;
			wea[13:6]=wenable? 8'hFF:0;
		end
		7: begin 
			m_effective_addr= {{9{m_bank_addr}},{7{m_bank_addr_inc}}};
			rdata = doutm[119:56];
			wea=0;
			wea[14:7]=wenable? 8'hFF:0;
		end
		8: begin 
			m_effective_addr= {{8{m_bank_addr}},{8{m_bank_addr_inc}}};
			rdata = doutm[127:64];
			wea=0;
			wea[15:8]=wenable? 8'hFF:0;
		end
		9: begin 
			m_effective_addr= {{7{m_bank_addr}},{9{m_bank_addr_inc}}};
			rdata = {doutm[7:0],doutm[127:72]};
			wea=0;
			wea[15:9]=wenable? 8'hFF:0;
			wea[0]=wenable? 8'hFF:0;
		end
		10: begin 
			m_effective_addr= {{6{m_bank_addr}},{10{m_bank_addr_inc}}};
			rdata = {doutm[8*2-1:0],doutm[127:80]};
			wea=0;
			wea[15:10]=wenable? 8'hFF:0;
			wea[1:0]=wenable? 8'hFF:0;
		end
		11: begin 
			m_effective_addr= {{5{m_bank_addr}},{11{m_bank_addr_inc}}};
			rdata = {doutm[8*3-1:0],doutm[127:88]};
			wea=0;
			wea[15:11]=wenable? 8'hFF:0;
			wea[2:0]=wenable? 8'hFF:0;
		end
		12: begin 
			m_effective_addr= {{4{m_bank_addr}},{12{m_bank_addr_inc}}};
			rdata = {doutm[8*4-1:0],doutm[127:96]};
			wea=0;
			wea[15:12]=wenable? 8'hFF:0;
			wea[3:0]=wenable? 8'hFF:0;
		end
		13: begin 
			m_effective_addr= {{3{m_bank_addr}},{13{m_bank_addr_inc}}};
			rdata = {doutm[8*5-1:0],doutm[127:104]};
			wea=0;
			wea[15:13]=wenable? 8'hFF:0;
			wea[4:0]=wenable? 8'hFF:0;
		end
		14: begin 
			m_effective_addr= {{2{m_bank_addr}},{14{m_bank_addr_inc}}};
			rdata = {doutm[8*6-1:0],doutm[127:112]};
			wea=0;
			wea[15:14]=wenable? 8'hFF:0;
			wea[5:0]=wenable? 8'hFF:0;
		end
		15: begin 
			m_effective_addr= {{1{m_bank_addr}},{15{m_bank_addr_inc}}};
			rdata = {doutm[8*7-1:0],doutm[127:120]};
			wea=0;
			wea[15]=wenable? 8'hFF:0;
			wea[6:0]=wenable? 8'hFF:0;
		end
		endcase
	end
	
	always @(*) begin
		/*
		case (iaddr)
			0: instr=80'hff0f03;
			10: instr=80'h31f03;
			20: instr=80'h1006;
			22: instr=80'h07;
			default:
				instr=0;
		endcase
		*/
		
		case (i_bank_offset)
		0: begin 
			i_effective_addr = {16{i_bank_addr}};
			instr = douti[8*10-1:0];
		end
		1: begin 
			i_effective_addr= {{15{i_bank_addr}},{1{i_bank_addr_inc}}};
			instr = douti[8*11-1:8];
		end
		2: begin 
			i_effective_addr= {{14{i_bank_addr}},{2{i_bank_addr_inc}}};
			instr = douti[8*12-1:16];
		end
		3: begin 
			i_effective_addr= {{13{i_bank_addr}},{3{i_bank_addr_inc}}};
			instr = douti[8*13-1:24];
		end
		4: begin 
			i_effective_addr= {{12{i_bank_addr}},{4{i_bank_addr_inc}}};
			instr = douti[8*14-1:32];
		end
		5: begin 
			i_effective_addr= {{11{i_bank_addr}},{5{i_bank_addr_inc}}};
			instr = douti[8*15-1:40];
		end
		6: begin 
			i_effective_addr= {{10{i_bank_addr}},{6{i_bank_addr_inc}}};
			instr = douti[8*16-1:48];
		end
		7: begin 
			i_effective_addr= {{9{i_bank_addr}},{7{i_bank_addr_inc}}};
			instr = {douti[8*1-1:0],douti[8*16-1:8*7]};
		end
		8: begin 
			i_effective_addr= {{8{i_bank_addr}},{8{i_bank_addr_inc}}};
			instr = {douti[8*2-1:0],douti[8*16-1:8*8]};
		end
		9: begin 
			i_effective_addr= {{7{i_bank_addr}},{9{i_bank_addr_inc}}};
			instr = {douti[8*3-1:0],douti[8*16-1:8*9]};
		end
		10: begin 
			i_effective_addr= {{6{i_bank_addr}},{10{i_bank_addr_inc}}};
			instr = {douti[8*4-1:0],douti[8*16-1:8*10]};
		end
		11: begin 
			i_effective_addr= {{5{i_bank_addr}},{11{i_bank_addr_inc}}};
			instr = {douti[8*5-1:0],douti[8*16-1:8*11]};
		end
		12: begin 
			i_effective_addr= {{4{i_bank_addr}},{12{i_bank_addr_inc}}};
			instr = {douti[8*6-1:0],douti[127:96]};
		end
		13: begin 
			i_effective_addr= {{3{i_bank_addr}},{13{i_bank_addr_inc}}};
			instr = {douti[8*7-1:0],douti[127:104]};
		end
		14: begin 
			i_effective_addr= {{2{i_bank_addr}},{14{i_bank_addr_inc}}};
			instr = {douti[8*8-1:0],douti[127:112]};
		end
		15: begin 
			i_effective_addr= {{1{i_bank_addr}},{15{i_bank_addr_inc}}};
			instr = {douti[8*9-1:0],douti[127:120]};
		end
		endcase
	end
	/*
	bank banks[15:0] (
		.clka(clock), 
		.wea(wea), 
		.addra(m_effective_addr), 
		.dina(dinm), 
		.douta(doutm), 
		.clkb(clock), 
		.web(1'h0), 
		.addrb(i_effective_addr), 
		.dinb(8'h0), 
		.doutb(douti)
	);
	*/
	bank0 bank0 (
		.clka(clock), 
		.wea(wea[0]), 
		.addra(m_effective_addr[11*0+11-1:11*0]), 
		.dina(dinm[8*0+8-1:8*0]), 
		.douta(doutm[8*0+8-1:8*0]), 
		.clkb(clock), 
		.web(1'h0), 
		.addrb(i_effective_addr[11*0+11-1:11*0]), 
		.dinb(8'h0), 
		.doutb(douti[8*0+8-1:8*0])
	);
	bank1 bank1 (
		.clka(clock), 
		.wea(wea[1]), 
		.addra(m_effective_addr[11*1+11-1:11*1]), 
		.dina(dinm[8*1+8-1:8*1]), 
		.douta(doutm[8*1+8-1:8*1]), 
		.clkb(clock), 
		.web(1'h0), 
		.addrb(i_effective_addr[11*1+11-1:11*1]), 
		.dinb(8'h0), 
		.doutb(douti[8*1+8-1:8*1])
	);
	bank2 bank2 (
		.clka(clock), 
		.wea(wea[2]), 
		.addra(m_effective_addr[11*2+11-1:11*2]), 
		.dina(dinm[8*2+8-1:8*2]), 
		.douta(doutm[8*2+8-1:8*2]), 
		.clkb(clock), 
		.web(1'h0), 
		.addrb(i_effective_addr[11*2+11-1:11*2]), 
		.dinb(8'h0), 
		.doutb(douti[8*2+8-1:8*2])
	);
	bank3 bank3 (
		.clka(clock), 
		.wea(wea[3]), 
		.addra(m_effective_addr[11*3+11-1:11*3]), 
		.dina(dinm[8*3+8-1:8*3]), 
		.douta(doutm[8*3+8-1:8*3]), 
		.clkb(clock), 
		.web(1'h0), 
		.addrb(i_effective_addr[11*3+11-1:11*3]), 
		.dinb(8'h0), 
		.doutb(douti[8*3+8-1:8*3])
	);
	bank4 bank4 (
		.clka(clock), 
		.wea(wea[4]), 
		.addra(m_effective_addr[11*4+11-1:11*4]), 
		.dina(dinm[8*4+8-1:8*4]), 
		.douta(doutm[8*4+8-1:8*4]), 
		.clkb(clock), 
		.web(1'h0), 
		.addrb(i_effective_addr[11*4+11-1:11*4]), 
		.dinb(8'h0), 
		.doutb(douti[8*4+8-1:8*4])
	);
	bank5 bank5 (
		.clka(clock), 
		.wea(wea[5]), 
		.addra(m_effective_addr[11*5+11-1:11*5]), 
		.dina(dinm[8*5+8-1:8*5]), 
		.douta(doutm[8*5+8-1:8*5]), 
		.clkb(clock), 
		.web(1'h0), 
		.addrb(i_effective_addr[11*5+11-1:11*5]), 
		.dinb(8'h0), 
		.doutb(douti[8*5+8-1:8*5])
	);
	bank6 bank6 (
		.clka(clock), 
		.wea(wea[6]), 
		.addra(m_effective_addr[11*6+11-1:11*6]), 
		.dina(dinm[8*6+8-1:8*6]), 
		.douta(doutm[8*6+8-1:8*6]), 
		.clkb(clock), 
		.web(1'h0), 
		.addrb(i_effective_addr[11*6+11-1:11*6]), 
		.dinb(8'h0), 
		.doutb(douti[8*6+8-1:8*6])
	);
	bank7 bank7 (
		.clka(clock), 
		.wea(wea[7]), 
		.addra(m_effective_addr[11*7+11-1:11*7]), 
		.dina(dinm[8*7+8-1:8*7]), 
		.douta(doutm[8*7+8-1:8*7]), 
		.clkb(clock), 
		.web(1'h0), 
		.addrb(i_effective_addr[11*7+11-1:11*7]), 
		.dinb(8'h0), 
		.doutb(douti[8*7+8-1:8*7])
	);
	bank8 bank8 (
		.clka(clock), 
		.wea(wea[8]), 
		.addra(m_effective_addr[11*8+11-1:11*8]), 
		.dina(dinm[8*8+8-1:8*8]), 
		.douta(doutm[8*8+8-1:8*8]), 
		.clkb(clock), 
		.web(1'h0), 
		.addrb(i_effective_addr[11*8+11-1:11*8]), 
		.dinb(8'h0), 
		.doutb(douti[8*8+8-1:8*8])
	);
	bank9 bank9 (
		.clka(clock), 
		.wea(wea[9]), 
		.addra(m_effective_addr[11*9+11-1:11*9]), 
		.dina(dinm[8*9+8-1:8*9]), 
		.douta(doutm[8*9+8-1:8*9]), 
		.clkb(clock), 
		.web(1'h0), 
		.addrb(i_effective_addr[11*9+11-1:11*9]), 
		.dinb(8'h0), 
		.doutb(douti[8*9+8-1:8*9])
	);
	bank10 bank10 (
		.clka(clock), 
		.wea(wea[10]), 
		.addra(m_effective_addr[11*10+11-1:11*10]), 
		.dina(dinm[8*10+8-1:8*10]), 
		.douta(doutm[8*10+8-1:8*10]), 
		.clkb(clock), 
		.web(1'h0), 
		.addrb(i_effective_addr[11*10+11-1:11*10]), 
		.dinb(8'h0), 
		.doutb(douti[8*10+8-1:8*10])
	);
	bank11 bank11 (
		.clka(clock), 
		.wea(wea[11]), 
		.addra(m_effective_addr[11*11+11-1:11*11]), 
		.dina(dinm[8*11+8-1:8*11]), 
		.douta(doutm[8*11+8-1:8*11]), 
		.clkb(clock), 
		.web(1'h0), 
		.addrb(i_effective_addr[11*11+11-1:11*11]), 
		.dinb(8'h0), 
		.doutb(douti[8*11+8-1:8*11])
	);
	bank12 bank12 (
		.clka(clock), 
		.wea(wea[12]), 
		.addra(m_effective_addr[11*12+11-1:11*12]), 
		.dina(dinm[8*12+8-1:8*12]), 
		.douta(doutm[8*12+8-1:8*12]), 
		.clkb(clock), 
		.web(1'h0), 
		.addrb(i_effective_addr[11*12+11-1:11*12]), 
		.dinb(8'h0), 
		.doutb(douti[8*12+8-1:8*12])
	);
	bank13 bank13 (
		.clka(clock), 
		.wea(wea[13]), 
		.addra(m_effective_addr[11*13+11-1:11*13]), 
		.dina(dinm[8*13+8-1:8*13]), 
		.douta(doutm[8*13+8-1:8*13]), 
		.clkb(clock), 
		.web(1'h0), 
		.addrb(i_effective_addr[11*13+11-1:11*13]), 
		.dinb(8'h0), 
		.doutb(douti[8*13+8-1:8*13])
	);
	bank14 bank14 (
		.clka(clock), 
		.wea(wea[14]), 
		.addra(m_effective_addr[11*14+11-1:11*14]), 
		.dina(dinm[8*14+8-1:8*14]), 
		.douta(doutm[8*14+8-1:8*14]), 
		.clkb(clock), 
		.web(1'h0), 
		.addrb(i_effective_addr[11*14+11-1:11*14]), 
		.dinb(8'h0), 
		.doutb(douti[8*14+8-1:8*14])
	);
	bank15 bank15 (
		.clka(clock), 
		.wea(wea[15]), 
		.addra(m_effective_addr[11*15+11-1:11*15]), 
		.dina(dinm[8*15+8-1:8*15]), 
		.douta(doutm[8*15+8-1:8*15]), 
		.clkb(clock), 
		.web(1'h0), 
		.addrb(i_effective_addr[11*15+11-1:11*15]), 
		.dinb(8'h0), 
		.doutb(douti[8*15+8-1:8*15])
	);
endmodule
