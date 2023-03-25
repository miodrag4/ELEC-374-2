// Simulating the Control Sequence for the logical mul R6, R7 instruction using a 32x32 Booth algorithm with bit-pair recoding of multiplier
module multiplier(
input [31:0] A,
input [31:0] B,
output [63:0] Mulout
);
reg [63:0] C;
integer i;

//"A_neg" is introduced to store the two's complement representation of 
//the negative of the input "A". The negative of "A" is computed using 
//the expression (~A + 1), which flips all the bits of "A" and then adds 
//1 to obtain the two's complement representation of the negative.
reg [63:0] A_neg;

always @ (A or B) begin
  C = 64'b0;
  A_neg = (~A + 1);
  //"B" is sign-extended and stored in a register "BoothSign_Ext".
  //"A" is replaced by the addition/subtraction of "A" or "A_neg", depending 
  //on the value of the three bits extracted from "BoothSign_Ext"
    for (i = 0; i < 30; i = i + 2) begin
        case (B[(i*1) +: 3])
            3'b001: C = C + (A << i+1);
            3'b010: C = C + (A << i+1);
            3'b011: C = C + (A << i+2);
            3'b100: C = C + (A_neg << i+2);
            3'b101: C = C + (A_neg << i+1);
            3'b110: C = C + (A_neg << i+1);
            default : C = C;
    endcase
	 end
end
assign Mulout = C;
endmodule
