//simulating the Control Sequence for the logical and R1, R2, R3 instruction
Module and(
    input [31:0] A,
    input [31:0] B,
    output [31:0] C
    );
    always @ (R1, R2) begin
        R3 = R1 & R2;
    end
endmodule