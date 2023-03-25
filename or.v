//simulating the Control Sequence for the logical OR R1, R2, R3 instruction
module OR(
    input [31:0] A,
    input [31:0] B,
    output [31:0] C
    );
    always @ (R1, R2) begin
        R3 = R1 or R2;
    end
endmodule