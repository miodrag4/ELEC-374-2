//The Z register holds the result of the operation in ALU and will be able to drive the Bus in the next clock cycle when the bus is free. The Z register is 64-bit long to hold the result of a multiplication (product) or a division (remainder in the higher byte, and quotient in the lower byte) operation temporarily before loading the HI and LO registers.
module REG_64(
    input wire clk, 
	 input wire clear,
	 input wire enable,
    input wire [63:0] BusMuxOut,
    output wire [63:0] BusMuxin
);
    reg [63:0] Q;
    
    always @(posedge clk)
        begin
          if (clear)
            Q <= 63'b0;
          else if (enable)
            Q <= BusMuxOut;
        end
    assign BusMuxin = Q;
endmodule

//module ZMux(
//	input [63:0] ZMuxIn,
//	input ZSelect,
//	input ZMuxEnable,
//	output wire [31:0]BusMuxOut
//);
//
//reg [31:0]Zout;
//always @ (ZMuxEnable) begin
//	if (ZSelect) begin
//		Zout = ZMuxIn[63:32];
//	end
//	else begin
//		Zout = ZMuxIn[31:0];
//	end
//end
//assign BusMuxOut = Zout;
//endmodule