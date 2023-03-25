//simulating the Control Sequence for the logical add R0, R4, R5 instruction
`timescale 1 ns/10ps

//Defube the module, inputs, and ouputs
module ripple_carry_adder(
input [31:0] A, 
input [31:0] B,
output reg [31:0] CC,
input wire Sel //select add or subtract
);


//Defube internal registers
reg [63:0] carry;
reg [31:0] B_neg;

//Define a counter variable
integer i;

//Always block executes when there's a change in inputs A, B, or Sel
always@(A or B or Sel) begin
	//if is Sel is 1, substract B from A by computing the two's complement of B
	if (Sel == 1) begin
		B_neg = ~B +1'b1; //2's complement
	end else begin
		B_neg = B;
	end
	
	//Initialize the local carry to 0
	carry = 33'd0;
	
	//Loop through each bit in A and B
	for (i=0; i<32; i = i+1)
		begin
		
			//Compute the sum bit using XOR gates
			CC[i] = A[i]^B_neg[i]^carry[i];
			
			//Compute the carry-out using OR gates
			carry[i+1] = (A[i] & B_neg[i]) | (carry[i] & (A[i] | B_neg[i]));
		end
	end
endmodule


