`timescale 1ns/10ps
module add_tb;


    reg [31:0]Y;
	 reg [31:0]BusMuxOut; 
	 reg [4:0]ALU;
    wire [63:0]Z;
	 

	 ALU uut(Y, BusMuxOut, ALU, Z);
	 
	 
initial begin 

	Y = 0; 
	BusMuxOut = 0; 
	ALU = 5'b0;
	
	#10
	
	Y = 21;
	
	#10 
	
	BusMuxOut = 5;
	
	#10
	
	ALU = 5'b00011;

end


endmodule

