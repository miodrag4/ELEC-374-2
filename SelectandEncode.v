module SelectandEncode (
input wire [31:0]IRout,
input Gra, Grb, Grc, Rin, Rout, BAout,
output wire [31:0]Csign,
output wire[16:0]Decoderin,
output wire[16:0]Decoderout
);

reg [3:0] Decoderinput;
reg [3:0]Ra, Rb, Rc;
reg [15:0] Decoderoutput;

always @(IRout, Gra, Grb, Grc) begin   
	Ra = IRout[26:23]; Rb = IRout[22:19]; Rc = IRout[18:15];
	if (Gra) Decoderinput = Ra;
	else if (Grb) Decoderinput = Rb;
	else if (Grc) Decoderinput = Rc;
	case (Decoderinput)
		4'b0000: Decoderoutput = 16'b0000000000000001;         
		4'b0001: Decoderoutput = 16'b0000000000000010;         
		4'b0010: Decoderoutput = 16'b0000000000000100;         
		4'b0011: Decoderoutput = 16'b0000000000001000;         
		4'b0100: Decoderoutput = 16'b0000000000010000;         
		4'b0101: Decoderoutput = 16'b0000000000100000;         
		4'b0110: Decoderoutput = 16'b0000000001000000;         
		4'b0111: Decoderoutput = 16'b0000000010000000;         
		4'b1000: Decoderoutput = 16'b0000000100000000;         
		4'b1001: Decoderoutput = 16'b0000001000000000;         
		4'b1010: Decoderoutput = 16'b0000010000000000;         
		4'b1011: Decoderoutput = 16'b0000100000000000;         
		4'b1100: Decoderoutput = 16'b0001000000000000;         
		4'b1101: Decoderoutput = 16'b0010000000000000;         
		4'b1110: Decoderoutput = 16'b0100000000000000;         
		4'b1111: Decoderoutput = 16'b1000000000000000;
		endcase 
end 

assign Csign = {{13{IRout[18]}}, IRout[18:0]};
assign Decoderin = {16{Rin}};
assign Decoderout = {16{Rout | BAout}} & Decoderoutput;

endmodule
