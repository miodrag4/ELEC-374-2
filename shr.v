// Demonstrate that your Shift Right circuitry works correctly by simulating the Control Sequence for the
// shr R1, R3, R5 instruction. The following Control Sequence is for a one-time shift right operation.
module shr(A, B, C);
input [31:0] A, B;
output [31:0] C;
always @ (A, B) begin
    C = A >> B;
    end
endmodule