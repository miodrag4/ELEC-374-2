// Demonstrate that the Not circuitry works correctly by simulating the Control Sequence for the
// not R0, R1 instruction. The Control Sequence is the same as the neg instruction except for using the NOT
// control signal in T3 instead of NEG.
module not(A, B);
input [31:0] A;
output [31:0] B;
always @ (A) begin
    B = ~A;
    end
endmodule