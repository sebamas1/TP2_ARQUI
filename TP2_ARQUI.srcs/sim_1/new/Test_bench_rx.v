`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2022 19:46:41
// Design Name: 
// Module Name: Test_bench_rx
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

    
module Test_bench_rx;
        
    reg clk = 1'b0;
    reg bit_envio = 1'b0;
    reg reset = 1'b0;
    wire o_tick;
                      
        Baud_gen baud_gen
    (
            clk,
            o_tick
    );
    RX rx(
           .i_clk(clk),   
           .i_tick(o_tick),
           .i_rx(bit_envio),
           .i_reset(reset)              
    );
    initial begin
        
    end
                    
    always begin
        #1
        clk = ~clk;
    end
endmodule
