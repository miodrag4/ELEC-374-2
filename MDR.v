// Memory data register (MDR) is a 32-bit register with MUX to select between input from the bus or memory chip
module MDR ( 
    input clear, clk, MDRin,
	 input [31:0]BusMuxOut, Mdatain,
	 input Read,
    output [31:0]BusMuxinMDR
);
    reg [31:0]D;
    reg [31:0]Q;
//update its value on the positive edge of the clock signal
 always @ (posedge clk) begin 
            //source of the data is controlled by the Read
				if (MDRin) begin
					if (Read) begin
						Q <= Mdatain;
					end
					 else begin
						Q <= BusMuxOut;
					end
				end

            else if (clear) begin
                Q <= 32'b0;
            end
			end
    assign BusMuxinMDR = Q;
endmodule
