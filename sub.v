//simulating the Control Sequence for the logical sub R0, R4, R5 instruction
module sub(
    input [31:0] A,
    input [31:0] B,
    output [31:0] C
    );
    always @ (R0, R4) begin
        R5 = R0 - R4;
    end
endmodule