module Decoder2to4(     
input [1:0] Din,    
output reg [3:0] Dout 
);

always @(*) begin   
	case (Din)
		2'b00: Dout = 4'b0001;         
		2'b01: Dout = 4'b0010;         
		2'b10: Dout = 4'b0100;         
		2'b11: Dout = 4'b1000;         
		default Dout = 4'bx;
		endcase 
end 
endmodule
