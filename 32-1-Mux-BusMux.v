module MuxBusMux32to1(
// 32 to 1 Mux BusMux input signals
input wire [31:0]BusMuxinR0, BusMuxinR1, BusMuxinR2, BusMuxinR3, BusMuxinR4, BusMuxinR5, BusMuxinR6, BusMuxinR7, 
BusMuxinR8, BusMuxinR9, BusMuxinR10, BusMuxinR11, BusMuxinR12, BusMuxinR13, BusMuxinR14, BusMuxinR15, 
BusMuxinHI, BusMuxinLO, BusMuxinZhigh, BusMuxinZlow, BusMuxinPC, BusMuxinMDR, BusMuxinInPort, BusMuxinC,

// Input as a 5-bit select signal
input wire [4:0]Sel,

// Output as a 32-bit wire
output reg [31:0] Q

);

// 23 cases for the 32 to 1 Mux BusMux to 1 output wire
always @ (*) begin
       case (Sel)
              5'b00000: Q <= BusMuxinR0;
              5'b00001: Q <= BusMuxinR1;
              5'b00010: Q <= BusMuxinR2;
              5'b00011: Q <= BusMuxinR3;
              5'b00100: Q <= BusMuxinR4;
              5'b00101: Q <= BusMuxinR5;
              5'b00110: Q <= BusMuxinR6;
              5'b00111: Q <= BusMuxinR7;
              5'b01000: Q <= BusMuxinR8;
              5'b01001: Q <= BusMuxinR9;
              5'b01010: Q <= BusMuxinR10;
              5'b01011: Q <= BusMuxinR11;
              5'b01100: Q <= BusMuxinR12;
              5'b01101: Q <= BusMuxinR13;
              5'b01110: Q <= BusMuxinR14;
              5'b01111: Q <= BusMuxinR15;
              5'b10000: Q <= BusMuxinHI;
              5'b10001: Q <= BusMuxinLO;
              5'b10010: Q <= BusMuxinZhigh;
              5'b10011: Q <= BusMuxinZlow;
              5'b10100: Q <= BusMuxinPC;
              5'b10101: Q <= BusMuxinMDR;
              5'b10110: Q <= BusMuxinInPort;
              5'b10111: Q <= BusMuxinC;
              default: Q <= 32'bx;
       endcase
       end

endmodule
