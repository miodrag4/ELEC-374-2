`timescale 1ns/10ps
module LOAD_Testbench;
	reg Gra, Grb, Grc, Rin, Rout, BAout, CONin, RAMenable;
	reg MARin, Zlowin, Zhighin, PCin, MDRin, Outportin, IRin, Yin ;
	reg IncPC, write, read, LOin, HIin;
	reg clock, clear, enable;
	reg [4:0] ALU;
	reg [3:0] present_state;
	wire [31:0] Mdatain, OutportWire;
	reg HIout, LOout, Zhighout, Zlowout, PCout, MDRout, InPortout, Cout, InPort, IncPc, Cin, InportIn;
	wire Q;

Bus_2 BUS(clock, clear, write, RAMenable, Gra, Grb, Grc, Rin, Rout, BAout, CONin, HIin, LOin, Zhighin, Zlowin, PCin, MDRin, Outportin,
	 IRin, Yin, Cin, MARin, HIout, LOout, Zhighout, Zlowout, PCout, MDRout, InPortout, Cout, read, IncPc, ALU, InPort, Mdatain, Q, OutportWire);
	 

parameter init = 4'b0, T0 = 4'd1, T1 = 4'd2, T2 = 4'd3, T3 = 4'd4, 
			 T4 = 4'd5, T5 = 4'd6, T6 = 4'd7, T7 = 4'd8;
			 
initial begin clock = 0; present_state = init; end
always #10 clock = ~clock;

always @ (negedge clock) 
	present_state = present_state + 1;
	
always @(present_state) begin
	case(present_state)
		init: begin
			PCout <= 0; IncPC<= 0; Zlowout <= 0; MDRout <= 0; RAMenable <= 0;
			MARin<= 0; PCin <= 0; MDRin <= 0; IRin <= 0; Yin <= 0;
			Gra <= 0; Grb <= 0; Grc <= 0; Rin <= 0; Rout <= 0; BAout <= 0;
			clock <= 0; read <= 0; write <= 0; clear <= 0; 
			  Zlowin <= 0; Cout <= 0;
			 InPortout <= 0;
		end
		T0: begin
			PCout <= 1; MARin <= 1; IncPC <= 1;
			#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
		end
		T1: begin
			read <= 1; RAMenable <= 1; MDRin <= 1;
			#15 Zlowout <= 0; PCin <= 0; read <= 0; MDRin <= 0; RAMenable <= 0;
		end
		T2: begin
			MDRout <= 1; IRin <= 1;
			#15 MDRout <= 0; IRin <= 0;
		end
		T3: begin
			Grb <= 1; BAout <= 1; Yin <= 1;
			#15 Grb <= 0; BAout <= 0; Yin <= 0;
		end
		T4: begin
			Cout <= 1; ALU <= 5'b00011;
			#15 Cout <= 0;
		end
		T5: begin
			 MARin <= 1;
			#15 MARin <= 0;
		end
		T6: begin
			read <= 1; MDRin <= 1; RAMenable <= 1;
			#15 read <= 0; MDRin <= 0; RAMenable <= 0;
		end
		T7: begin
			MDRout <= 1; Gra <= 1; Rin <= 1;
			#15 MDRout <= 0; Gra <= 0; Rin <= 0;
		end
	endcase
end

//initial begin #10 $finish; end
endmodule
