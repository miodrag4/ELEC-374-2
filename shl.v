// Demonstrate that your Shift Left circuitry works fine by simulating the Control Sequence for the
// shl R1, R3, R5 instruction. The Control Sequence is the same as the shr instruction except for using the SHL
// control signal in T4 instead of SHR.
module shl(A,B,C);
input [31:0] A, B;
output [31:0] C;
always @ (A, B) begin
    C = A << B;
    end
endmodule