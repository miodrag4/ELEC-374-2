module RAM(
input Read,
input Write,
input Clock,
input [31:0]BusMuxOut,
input [8:0]Address,
output reg [31:0] Mdatain
);

reg [31:0] Ram[511:0];
//reg [8:0] Address_Reg;

always @ (posedge Clock)
	begin
	   Ram[0] = 32'h00800075;
		Ram[117] = 32'h008000ABC;
		if (Read)
			Mdatain <= Ram[Address];
		if (Write)
			Ram[Address] = BusMuxOut;
	end

endmodule
