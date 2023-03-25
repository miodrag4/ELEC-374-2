// and datapath_tb.v file: <This is the filename>
`timescale 1ns/10ps
module OR_Testbench;
    //reg MARin, Zin, PCin, MDRin, IRin, Yin, Zlowin, Zhighin;
    reg IncPC, read, AND;// R1in, R2in, R3in;
	 reg [4:0] ALU;
    reg [31:0] Mdatain;
	 
	 reg clock, clear, R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, 
    R12out, R13out, R14out, R15out, HIout, LOout, Zhighout, Zlowout, PCout, MDRout, InPortout, Cout;
	 reg R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, 
    R12in, R13in, R14in, R15in, HIin, LOin, Zhighin, Zlowin, PCin, MDRin, IRin, Yin, InPort, Cin, MARin;

    parameter   Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011,
                Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,
                T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100;
    reg [3:0] Present_state = Default;

Bus Bus (clock, clear, R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, 
    R12in, R13in, R14in, R15in, HIin, LOin, Zhighin, Zlowin, PCin, MDRin, IRin, Yin, InPort, Cin, MARin,
	 R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, 
    R12out, R13out, R14out, R15out, HIout, LOout, Zhighout, Zlowout, PCout, MDRout, InPortout, Cout,
	 read, IncPC, Mdatain, ALU);
	 

	 
	 
// add test logic here
initial
    begin
        clock = 0;
        forever #10 clock = ~clock;
end

always @(posedge clock) // finite state machine; if clock rising-edge
    begin
        case (Present_state)
            Default : Present_state = Reg_load1a;
            Reg_load1a : #40 Present_state = Reg_load1b; //#50
            Reg_load1b : #40 Present_state = Reg_load2a;
            Reg_load2a : #40 Present_state = Reg_load2b;
            Reg_load2b : #40 Present_state = Reg_load3a;
            Reg_load3a : #40 Present_state = Reg_load3b;
            Reg_load3b : #40 Present_state = T0;
            T0 : #40 Present_state = T1;
            T1 : #40 Present_state = T2;
            T2 : #40 Present_state = T3;
            T3 : #40 Present_state = T4;
            T4 : #40 Present_state = T5;
        endcase
    end
always @(Present_state) // do the required job in each state
    begin
        case (Present_state) // assert the required signals in each clock cycle
            Default: begin
                PCout <= 0; Zlowout <= 0; MDRout <= 0; // initialize the signals
                R1out <= 0; R2out <= 0; R3out <= 0;MARin <= 0; Zlowin <= 0;
                PCin <=0; MDRin <= 0; IRin <= 0; Yin <= 0;
                IncPC <= 0; read <= 0; ALU <= 5'b00000;
				R1in <= 0; R2in <= 0; R3in <= 0; Mdatain <= 32'h00000000;
				{R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, 
				R12out, R13out, R14out, R15out, HIout, LOout, Zhighout, Zlowout, PCout, MDRout, InPortout, Cout} <= 24'b000000000000000000000000;
            end
            Reg_load1a: begin
                Mdatain <= 32'h00000012;
                #5 read <= 1; MDRin <= 1;
                #10 read <= 0; MDRin <= 0;
            end
            Reg_load1b: begin
                #5 MDRout <= 1; R2in <= 1;
                #10 MDRout <= 0; R2in <= 0; // initialize R2 with the value $12
            end
            Reg_load2a: begin
                Mdatain <= 32'h00000014;
                #5 read <= 1; MDRin <= 1;
                #10 read <= 0; MDRin <= 0;
            end
            Reg_load2b: begin
                #5 MDRout <= 1; R3in <= 1;
                #10 MDRout <= 0; R3in <= 0; // initialize R3 with the value $14
            end
            Reg_load3a: begin
				Mdatain <= 32'h00000018;
				#5 read <= 1; MDRin <= 1;
				#15 read <= 0; MDRin <= 0;
			end
			 Reg_load3b: begin
				#5 MDRout <= 1; R1in <= 1;
				#15 MDRout <= 0; R1in <= 0; // initialize R1 with the value $18 (24)
            end
            T0: begin
                #5 PCout <= 1; MARin <= 1; IncPC <= 1; Zlowin <= 1;
					 #10 PCout <= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
            end

            T1: begin
                Mdatain <= 32'h30918000;
					 #5 Zlowout <= 1; PCin <= 1; read <= 1; MDRin <= 1;
					 #10 Zlowout <= 0; PCin <= 0; read <= 0; MDRin <= 0;
            end

            T2: begin
                #5 MDRout <= 1; IRin <= 1;
					 #10 MDRout <= 0; IRin <= 0;
            end

            T3: begin
				# 5 R2out <= 1; Yin <= 1;
				# 15 R2out <= 0; Yin <= 0;
			end
			T4: begin
				# 5 R3out <= 1; ALU <= 5'b01010; Zlowin <= 1; 
                # 15 R3out <= 0; Zlowin <= 0;
			end
			T5: begin
				# 5 Zlowout <= 1; R1in <= 1;
				# 15 Zlowout <= 0; R1in <= 0; 
			end
		endcase
	end
endmodule