// Demonstrate that your Shift Right Arithmetic circuitry works fine by simulating the Control Sequence for
// the shra R1, R3, R5 instruction. The Control Sequence is the same as the shr instruction except for using the
// SHRA control signal in T4 instead of SHR.\
module shra(A, B, C);
input [31:0] A, B;
output [31:0] C;
always @ (A, B) begin
    C = A >>> B;
    end
endmodule