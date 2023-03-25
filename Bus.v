// PHASE 1
module Bus(
	 // Encoder Signals
	 input wire clock, clear,
	 
	 input wire R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, 
    R12in, R13in, R14in, R15in, HIin, LOin, Zhighin, Zlowin, PCin, MDRin, IRin, Yin, InPort, Cin, MARin,
	 
    input wire R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, 
    R12out, R13out, R14out, R15out, HIout, LOout, Zhighout, Zlowout, PCout, MDRout, InPortout, Cout,
	 
	 input wire read, IncPc,
	 
	 input wire [31:0] Mdatain,

	 input wire [4:0] ALU
	 
	 );
	 
	 
//Mux Signals
wire [31:0]BusMuxinR0, BusMuxinR1,  BusMuxinR2, BusMuxinR3, BusMuxinR4,  
BusMuxinR5,BusMuxinR6, BusMuxinR7,  BusMuxinR8, BusMuxinR9, BusMuxinR10,
BusMuxinR11, BusMuxinR12, BusMuxinR13, BusMuxinR14, BusMuxinR15, BusMuxinZhigh,
BusMuxinZlow, BusMuxinPC, BusMuxinIR, BusMuxinMDR, BusMuxinInPort, BusMuxinC,
BusMuxinY, BusMuxinHI, BusMuxinLO;

wire [31:0] BusMuxOut;

wire [63:0] Z_data_out;

wire [31:0] encoder_in;

wire [4:0] encoder_out;

MuxBusMux32to1 Mux (BusMuxinR0, BusMuxinR1, BusMuxinR2, BusMuxinR3, BusMuxinR4, 
BusMuxinR5, BusMuxinR6, BusMuxinR7, BusMuxinR8, BusMuxinR9, BusMuxinR10, 
BusMuxinR11, BusMuxinR12, BusMuxinR13, BusMuxinR14, BusMuxinR15, BusMuxinHI, 
BusMuxinLO, BusMuxinZhigh, BusMuxinZlow, BusMuxinPC, BusMuxinMDR, 
BusMuxinInPort, BusMuxinC, encoder_out,BusMuxOut);


Encoder32to5 Encoder (R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, 
    R9out, R10out, R11out, R12out, R13out, R14out, R15out, HIout, LOout, Zhighout, 
    Zlowout, PCout, MDRout, InPortout, Cout, encoder_out);

// General Purpose Registers
REG_32 R0 (clock, clear, R0in, BusMuxOut, BusMuxinR0);
REG_32 R1 (clock, clear, R1in, BusMuxOut, BusMuxinR1);
REG_32 R2 (clock, clear, R2in, BusMuxOut, BusMuxinR2);
REG_32 R3 (clock, clear, R3in, BusMuxOut, BusMuxinR3);
REG_32 R4 (clock, clear, R4in, BusMuxOut, BusMuxinR4);
REG_32 R5 (clock, clear, R5in, BusMuxOut, BusMuxinR5);
REG_32 R6 (clock, clear, R6in, BusMuxOut, BusMuxinR6);
REG_32 R7 (clock, clear, R7in, BusMuxOut, BusMuxinR7);
REG_32 R8 (clock, clear, R8in, BusMuxOut, BusMuxinR8);
REG_32 R9 (clock, clear, R9in, BusMuxOut, BusMuxinR9);
REG_32 R10 (clock, clear, R10in, BusMuxOut, BusMuxinR10);
REG_32 R11 (clock, clear, R11in, BusMuxOut, BusMuxinR11);
REG_32 R12 (clock, clear, R12in, BusMuxOut, BusMuxinR12);
REG_32 R13 (clock, clear, R13in, BusMuxOut, BusMuxinR13);
REG_32 R14 (clock, clear, R14in, BusMuxOut, BusMuxinR14);
REG_32 R15 (clock, clear, R15in, BusMuxOut, BusMuxinR15);

// Registers
REG_32 HI 		(clock, clear, HIin, BusMuxOut, BusMuxinHI);
REG_32 LO 		(clock, clear, LOin, BusMuxOut, BusMuxinLO);
REG_32 Zhigh 	(clock, clear, Zhighin, Z_data_out[63:32], BusMuxinZhigh);
REG_32 Zlow 	(clock, clear, Zlowin, Z_data_out[31:0], BusMuxinZlow);
REG_32 PC 		(clock, clear, IncPc, BusMuxOut, BusMuxinPC);
REG_32 IR 		(clock, clear, IRin, BusMuxOut, BusMuxinIR);
REG_32 Y			(clock, clear, Yin, BusMuxOut, BusMuxinY);
REG_32 inport	(clear, clock, InPort, BusMuxOut, BusMuxinInPort);
REG_32 Csign	(clear, clock, Cin, BusMuxOut, BusMuxinC);

// Devices
MDR MDR(clear, clock, MDRin, BusMuxOut, Mdatain, read, BusMuxinMDR);
//REG_32 mar(clock, clear, MARin, BusMuxOut,  BusMuxinMAR);
ALU alu(BusMuxinY, BusMuxOut, ALU, Z_data_out);

endmodule
