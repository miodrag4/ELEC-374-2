module CON_FF(
input [1:0] IR,
input [31:0] Bus,
input CONin,
output Q
);

reg D;

wire [3:0]Decoderout;

Decoder2to4 decoder(IR,Decoderout);

wire nott;
assign nott = (Bus == 0);

always @(IR, Bus)
	begin
	case(Decoderout)
		// Logic for flipflop
		4'b0000 : D = Decoderout [3] & nott;
		4'b0001 : D = Decoderout [2] & ~(nott);
		4'b0010 : D = Decoderout [1] & ~(Bus[31]);
		4'b0011 : D = Decoderout [0] & Bus[31];
		default D = 1'b0;
	endcase
end

CON_Flip_Flop FF( D, CONin, Q);
	
endmodule 
