module CON_Flip_Flop(
input wire D,
input wire clock,
output reg Q
);

always @(clock) begin //On posedge???
	Q = D;
	end
endmodule
