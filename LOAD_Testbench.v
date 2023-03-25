`timescale 1ns/10ps
module LOAD_Testbench;
	reg Gra, Grb, Grc, Rin, Rout, BAout, CONin;
	reg MARin, Zlowin, Zhighin, PCin, MDRin, Outportin, IRin, Yin ;
	reg IncPC, write, read, LOin, HIin;
	reg clock, clear, enable;
	reg [4:0] ALU;
	wire [31:0] Mdatain, OutportWire;
	reg HIout, LOout, Zhighout, Zlowout, PCout, MDRout, InPortout, Cout, InPort, IncPc, Cin, InportIn;
	wire Q;

	parameter	Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011,
                Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,
                T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100,
					 T6 = 4'b1011, T7 = 4'b1110;
	reg [3:0] Present_state = Default;

Bus_2 BUS(clock, clear, write, Gra, Grb, Grc, Rin, Rout, BAout, CONin, HIin, LOin, Zhighin, Zlowin, PCin, MDRin, Outportin,
	 IRin, Yin, Cin, MARin, HIout, LOout, Zhighout, Zlowout, PCout, MDRout, InPortout, Cout, read, IncPc, ALU, InPort, Mdatain, Q, OutportWire);

initial
	begin
		clock = 0;
		forever #2	clock = ~clock;
	end
	
always@(posedge clock)
	begin
		case (Present_state)
			Default : Present_state = Reg_load1a;
            Reg_load1a : #40 Present_state = Reg_load1b;
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
			T5 : #40 Present_state = T6;
			T6 : #40 Present_state = T7;
		endcase
	end

always@(Present_state)
	begin
		case (Present_state)
			Default: begin
				
				Gra <=0; Grb <=0; Grc <=0; Rin <=0; Rout <=0; BAout <=0; CONin <= 0;
				MARin <=0; Zlowin <=0; Zhighin <=0; PCin <=0; MDRin <=0; IRin <=0; Yin <= 0;
				IncPC <=0; write <=0; read <=0; LOin <=0; HIin <=0;
	
				ALU <= 0; 
				
				{HIout, LOout, Zhighout, 
					Zlowout, PCout, MDRout, InPortout, Cout} <= 8'b00000000;
				
				clear <= 1;	
				#15 	
				clear <= 0;
				
			end
			
			Reg_load1a: begin
				#10 InPort = 32'h75; InportIn = 1;
				#15 InPort = 32'hx; InportIn = 0;
			end
			
			Reg_load1b: begin
				#10 InPortout = 1; MARin = 1;
				#15 InPortout = 0; MARin = 0;
			end
			
			Reg_load2a: begin
				#10 InPort = 32'h8; InportIn = 1;
				#15 InPort = 32'hx; InportIn = 0;
			end
			
			Reg_load2b: begin
				#10 InPortout = 1; MDRin = 1;
				#15 InPortout = 0; MDRin = 0;
			end
			
			Reg_load3a: begin
				#10 write = 1; InPort = 32'h0; InportIn = 1;
				#15 write = 0; InportIn = 0;
			end
			
			Reg_load3b: begin
				#10 InPortout = 1; Rin = 1; PCin = 1;
				#15 InPortout = 0; Rin = 0; PCin = 0;
			end
			
			T0: begin
				#10 PCout <= 1; MARin <= 1; IncPC <= 1; Zlowin <= 1;
				#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
			end
			T1: begin
				#10 Zlowout <= 1; PCin <=1; read<=1; MDRin<=1;  
				#15 Zlowout <= 0; PCin <=0; read<=0; MDRin<=0;
			end
			T2: begin
				#10 MDRout <= 1; IRin <=1;
				#15 MDRout <= 0; IRin <=0;
			end
			T3: begin
				# 10 Grb <=1; BAout <=1; Yin <= 1;
				# 15 Grb <=0; BAout <=0; Yin <= 0;
			end
			T4: begin
				# 10 Cout <= 1; ALU <= 5'b00011; Zlowin <= 1;
				# 15 Cout <= 0; Zlowin <= 0;
			end
			T5: begin
				# 10 Zlowout <= 1; MARin <=1;
				# 15 Zlowout <= 0; MARin <=0;
			end
			T6: begin
				# 10 read <= 1; MDRin <=1; 
				# 15 read <= 0; MDRin <=0; 
			end
			T7: begin
				# 10 MDRout <=1; Gra <= 1; Rin <= 1;
				# 15 MDRout <=0; Gra <= 0; Rin <= 0;
			end
		endcase
	end
endmodule
