module Encoder32to5(
    // 32-to-5 encoder inputs
    input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, 
    R9out, R10out, R11out, R12out, R13out, R14out, R15out, HIout, LOout, Zhighout, 
    Zlowout, PCout, MDRout, InPortout, Cout,

    // 5-bit output as Sel
    output reg [4:0] EncoderoutSel
);

wire [31:0] EncoderinQ = {Cout, InPortout, MDRout, PCout, Zlowout, Zhighout, LOout, HIout, R15out, R14out, R13out, 
R12out, R11out, R10out, R9out, R8out, R7out, R6out, R5out, R4out, R3out, R2out, R1out, R0out};

always@(*) begin
			$display("Select:");
			$display(EncoderinQ);
        case (EncoderinQ)
        
            // 23 input signals are outputted to the 32-to-5 encoders and the 5-bit output is 
            // used to select the input to the 32:1 multiplexer
            32'h00000001 : EncoderoutSel = 5'b00000;
            32'h00000002 : EncoderoutSel = 5'b00001;
            32'h00000004 : EncoderoutSel = 5'b00010;
            32'h00000008 : EncoderoutSel = 5'b00011;
            32'h00000010 : EncoderoutSel = 5'b00100;
            32'h00000020 : EncoderoutSel = 5'b00101;
            32'h00000040 : EncoderoutSel = 5'b00110;
            32'h00000080 : EncoderoutSel = 5'b00111;
            32'h00000100 : EncoderoutSel = 5'b01000;
            32'h00000200 : EncoderoutSel = 5'b01001;
            32'h00000400 : EncoderoutSel = 5'b01010;
            32'h00000800 : EncoderoutSel = 5'b01011;
            32'h00001000 : EncoderoutSel = 5'b01100;
            32'h00002000 : EncoderoutSel = 5'b01101;
            32'h00004000 : EncoderoutSel = 5'b01110;
            32'h00008000 : EncoderoutSel = 5'b01111;
            32'h00010000 : EncoderoutSel = 5'b10000;
            32'h00020000 : EncoderoutSel = 5'b10001;
            32'h00040000 : EncoderoutSel = 5'b10010;
            32'h00080000 : EncoderoutSel = 5'b10011;
            32'h00100000 : EncoderoutSel = 5'b10100;
				32'h00200000 : EncoderoutSel = 5'b10101;
				32'h00400000 : EncoderoutSel = 5'b10110;
				32'h00800000 : EncoderoutSel = 5'b10111;
            // dont care value
            default EncoderoutSel = 5'bx;
        endcase
    end
endmodule
