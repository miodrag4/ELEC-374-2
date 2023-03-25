`timescale 1ns/10ps
module NonRestoringDivisionAlgorithim(
    input signed [31:0] Dividend, divisor,
    output wire [31:0] Q, // Quotient
    output wire [31:0] R // Remainder
);

reg [31:0] A, M;
wire [31:0] TwosCompliment;
integer i,l;
assign TwosCompliment =  ~divisor + 1;

// Divison register.
reg signed [64:0] temp;

// 32 bit register.
initial A = 32'b00000000000000000000000000000000;

always @(*)
    begin
        if(divisor[31] == 1) begin
                    M = TwosCompliment;
                    l = 1;
                end
                else begin
                    M = divisor;
                    l = 0;
                end
      // Concatenates the 32 bit register with the 32 bit dividend.
            temp = {A, Dividend};

      // Performs the 32 bit division algorithm.
          for(i=0;i<32;i=i+1) begin
            // Shifts the 64 bit register left by 1 bit.
                        temp = temp << 1;
            // Checks if th A value is >= to zero.
                        if(temp[64] == 0) begin
              // Performs subtractions on the upper 32 bits of the 64 bit register
                            temp[64:32] = temp[64:32] - M;
                        end
            // Otherwise add M to A
                        else begin
              // Performs additions on the upper 32 bits of the 64 bit register
                            temp[64:32] = temp[64:32] + M;
                        end
            // Checks if the last bit is equal to 0.
                        if(temp[64] == 0) begin
              temp[0] = 1;
            end
                       else if(temp[64] == 1) begin
                  temp[0] = 0;
            end
                if(temp[64] == 1) temp[64:32] = temp[64:32] + M;
                if(l == 1) temp[64:32] = ~temp[64:32] + 1;
     end
end
// Assigns the quotient to the lower 32 bits of the 64 bit register.
    assign Q = temp[31:0];
// Assigns the remainder to the upper 32 bits of the 64 bit register.
    assign R = temp[63:32];
endmodule
