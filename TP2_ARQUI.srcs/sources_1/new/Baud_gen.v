`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2022 17:23:59
// Design Name: 
// Module Name: Baud_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// clock de 450MGz y se hace con un baud rate de 9600 Baudios, seran 2930 
        
        module Baud_gen(
        
            input i_clk,
            output o_tick
            
            );
            
            reg [11:0] contador_flancos = 11'b000000000000;
            reg [1 : 0] tick;
            
            assign o_tick = tick;
            
            always @(posedge i_clk)
            begin
                if(contador_flancos == 11'b101101110010)
                        tick = 1;
                            else begin
                        contador_flancos = contador_flancos + 1;
                        tick = 0;
                     end
            
            end
        endmodule
