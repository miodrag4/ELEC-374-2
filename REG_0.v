module REG_0(
	 input clock,
    input clear,
    input enable,
	 input wire BAout,
    input wire [31:0] D,
	 output wire[31:0] Dout
	 );
	 
	 wire[31:0] Q;
	 
	 REG_32 R0 (clock, clear, enable, D, Q);
	 
	 assign Dout = (~BAout & Q); // Could be wrong, might have to change to BAout ? 0 : Q
	 
	 
endmodule 
