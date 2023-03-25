// PHASE 2
module Bus_2(
	 // Encoder Signals
	 input wire clock, clear, write,
	 input wire Gra, Grb, Grc, Rin, Rout, BAout, CONin,
	 input wire HIin, LOin, Zhighin, Zlowin, PCin, MDRin, Outportin,
	 input wire IRin, Yin, Cin, MARin,
    input wire HIout, LOout, Zhighout, Zlowout, PCout, MDRout, InPortout, Cout,
	 input wire read, IncPc,
	 input wire [4:0] ALU,
	 input wire InPort, 
	 output [31:0] Mdatain, 
	 output wire Q,
	 output wire [31:0] OutportWire
	 );
	 
	 wire [31:0] Address;
	 
	 wire R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, 
    R12in, R13in, R14in, R15in;
	 
	 wire R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, 
    R12out, R13out, R14out, R15out;
	 	 
//Mux Signals
wire [31:0]BusMuxinR0, BusMuxinR1,  BusMuxinR2, BusMuxinR3, BusMuxinR4,  
BusMuxinR5,BusMuxinR6, BusMuxinR7,  BusMuxinR8, BusMuxinR9, BusMuxinR10,
BusMuxinR11, BusMuxinR12, BusMuxinR13, BusMuxinR14, BusMuxinR15, BusMuxinZhigh,
BusMuxinZlow, BusMuxinPC, BusMuxinIR, BusMuxinMDR, BusMuxinInPort, BusMuxinC,
BusMuxinY, BusMuxinHI, BusMuxinLO, IRout, BusMuxinMAR;

wire [31:0] BusMuxOut;

wire [63:0] Z_data_out;

wire [31:0] encoder_in;

wire [4:0] encoder_out;

MuxBusMux32to1 Mux (BusMuxinR0, BusMuxinR1, BusMuxinR2, BusMuxinR3, BusMuxinR4, 
BusMuxinR5, BusMuxinR6, BusMuxinR7, BusMuxinR8, BusMuxinR9, BusMuxinR10, 
BusMuxinR11, BusMuxinR12, BusMuxinR13, BusMuxinR14, BusMuxinR15, BusMuxinHI, 
BusMuxinLO, BusMuxinZhigh, BusMuxinZlow, BusMuxinPC, BusMuxinMDR, 
BusMuxinInPort, BusMuxinC, encoder_out, BusMuxOut);


Encoder32to5 Encoder (R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, 
    R9out, R10out, R11out, R12out, R13out, R14out, R15out, HIout, LOout, Zhighout, 
    Zlowout, PCout, MDRout, InPortout, Cout, encoder_out);

// General Purpose Registers
REG_0 R0 (clock, clear, R0in, BAout, BusMuxOut, BusMuxinR0);
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

//Increment PC register using alu add functionality
wire [31:0] InPCout;
ripple_carry_adder increment (BusMuxOut, 32'b1, InPCout, 1'b0);
REG_32 Zhigh 	(clock, clear, Zhighin, Z_data_out[63:32], BusMuxinZhigh);
REG_32 Zlow 	(clock, clear, Zlowin, IncPc ? InPCout : Z_data_out[31:0], BusMuxinZlow);
REG_32 PC 		(clock, clear, PCin, BusMuxOut, BusMuxinPC);
REG_32 IR 		(clock, clear, IRin, BusMuxOut, IRout);
REG_32 Y			(clock, clear, Yin, BusMuxOut, BusMuxinY);
REG_32 inport	(clock, clear, InPort, BusMuxOut, BusMuxinInPort);
REG_32 outport (clock, clear, Outportin, BusMuxOut, OutportWire);
//REG_32 Csign	(clock, clear, Cin, BusMuxOut, BusMuxinC);

// Devices
REG_32 MAR(clock, clear, MARin, BusMuxOut, Address);
MDR MDR(clear, clock, MDRin, BusMuxOut, Mdatain, read, BusMuxinMDR);
ALU alu(BusMuxinY, BusMuxOut, ALU, Z_data_out);

SelectandEncode SelectandEncode(IRout, Gra, Grb, Grc, Rin, Rout, BAout, BusMuxinC, R1in,
//{R15in, R14in, R13in, R12in, R11in, R10in, R9in, R8in, R7in, R6in, R5in, R4in, R3in, R2in, R1in, R0in}, 
{R15out, R14out, R13out, R12out, R11out, R10out, R9out, R8out, R7out, R6out, R5out, R4out, R3out, R2out, 
R1out, R0out});
 
CON_FF CON_FF(IRout[20:19],BusMuxOut, CONin, Q);
 
RAM RAM(read, write, clock, BusMuxOut, Address[8:0], Mdatain);

endmodule
