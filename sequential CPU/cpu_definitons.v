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

 // Status conditions
 parameter SBUB = 3'h0;
 parameter SAOK = 3'h1;
 parameter SHLT = 3'h2;
 parameter SADR = 3'h3;
 parameter SINS = 3'h4;