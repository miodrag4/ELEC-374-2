// Demonstrate that your Rotate left circuitry works correctly by simulating the Control Sequence for the
// rol R6, R6, R4 instruction. The Control Sequence is the same as the ror instruction except for using the ROL
// control signal in T4 instead of ROR.
module rol(A,B,C);
input [31:0] A, B;
output [31:0] C;
always @ (A, B) begin
    C = A <<< B;
    end
endmodule