// Demonstrate that your Rotate Right circuitry works fine by simulating the Control Sequence for the
// ror R6, R6, R4 instruction. The following Control Sequence is for a one-time rotate right operation.
module ror(A,B,C);
input [31:0] A, B;
output [31:0] C;
always @ (A, B) begin
    C = A >>> B;
    End
Endmodule