 module ALU(
    input [31:0]Y, 
	 input [31:0]BusMuxOut, 
	 input [4:0]ALU,
    output [63:0] Z
);
    reg [31:0]A;
    reg [31:0]B;
    reg [63:0]C;
    integer i;
	 
	 wire Sel;
    wire [63:0]Mulout;
    //wire [63:0]Divout;
	 wire [31:0] Q,R;
	 wire [31:0] CC;

    ripple_carry_adder add (Y, BusMuxOut, CC, 1'b0);
	 NonRestoringDivisionAlgorithim div(A,B,Q,R);
    multiplier mul(Y,BusMuxOut,Mulout);

    always @ (*) begin
       A = Y;
       B = BusMuxOut;

       // ALU switch case for the specific operations
       case (ALU)
            5'b00000: C = {32'b0, CC}; // Additon
            5'b00001: C = {32'b0, CC}; // Subtraction
            5'b00010: C = Mulout; // Multiplication
            5'b00011: C = {R,Q}; // Division
            5'b00100: C = {32'b0, A >> B}; // Shift Right
            5'b00101: C = {32'b0, A >>> B}; // Shift Right Arithmetic
            5'b00110: C = {32'b0, A << B}; // Shift Left
            5'b00111: C = {32'b0, A >> B | A << 32-B}; // Rotate Right
            5'b01000: C = {32'b0, A << B | A >> 32-B}; // Rotate Left
            5'b01001: C = {32'b0, A & B}; // Logical AND
            5'b01010: C = {32'b0, A | B}; // Logical OR
            5'b01011: C = ~B + 1'b1; // Negate
            5'b01100: C = {31'b0, ~B}; // NOT
            5'b01101: C = {32'b0, A}; // Copy A
            5'b01110: C = {32'b0, B}; // Copy B
            default: C = 0; // Zero
       endcase
       end
      assign Z = C;
		 
 endmodule
 