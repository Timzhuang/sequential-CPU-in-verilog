// Constant values

// Instruction codes
parameter IHALT = 4'h0;
parameter INOP = 4'h1;
parameter IRRMOVQ = 4'h2;
parameter IIRMOVQ = 4'h3;
parameter IRMMOVQ = 4'h4;
parameter IMRMOVQ = 4'h5;
parameter IOPQ = 4'h6;
parameter IJXX = 4'h7;
parameter ICALL = 4'h8;
parameter IRET = 4'h9;
parameter IPUSHQ = 4'hA;
parameter IPOPQ = 4'hB;
parameter IDISP = 4'hC;
parameter IBTN = 4'hD;

// Function codes
parameter FNONE = 4'h0;

// Jump conditions
parameter UNCOND = 4'h0;

// Register IDs
parameter RRSP = 4'h4;
parameter RRBP = 4'h5;
parameter RNONE = 4'hF;

 // ALU operations
parameter ALUADD = 4'h0;
parameter ALUXOR = 4'h3;
parameter ALUAND = 4'h2;
parameter ALUSUB = 4'h1;
parameter ALUMUL = 4'h4;
//FLAG
parameter BF = 3;
parameter ZF = 2;
parameter SF = 1;
parameter OF = 0;

//Condition
parameter C_YES = 4'h0;
parameter C_LE = 4'h1;
parameter C_L = 4'h2;
parameter C_E = 4'h3;
parameter C_NE = 4'h4;
parameter C_GE = 4'h5;
parameter C_G = 4'h6;
parameter C_B = 4'h7;

// Status conditions
parameter SBUB = 3'h0;
parameter SAOK = 3'h1;
parameter SHLT = 3'h2;
parameter SADR = 3'h3;
parameter SINS = 3'h4;

//Sequenctial States
parameter state_init = 4'h0;
parameter state_fetch = 4'h1;
parameter state_decode = 4'h2;
parameter state_execution = 4'h3;
parameter state_memory =4'h4;
parameter state_writeback = 4'h5;
parameter state_pc = 4'h6;
parameter state_wait_pc = 4'h7;
parameter state_wait_memory=4'h8;
parameter state_halted = 4'h9;