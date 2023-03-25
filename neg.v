// Demonstrate that your Negate circuitry works correctly by simulating the Control Sequence for the
// neg R0, R1 instruction
module neg(A, B);
input [31:0] A;
output [31:0] B;
always @ (A) begin
    B = -A;
    end
endmodule