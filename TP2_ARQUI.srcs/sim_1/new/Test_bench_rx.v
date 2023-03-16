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
    reg bit_envio = 1'b1;
    reg reset = 1'b0;
    wire o_tick;
    wire o_tx;
    wire [7 : 0] o_dato_recibido;
    wire o_recibido;
                      
        Baud_gen baud_gen
    (
            .i_clk(clk),
            .o_tick(o_tick)
    );
    TX tx( 
           .i_tick(o_tick),
           .i_reset(reset),
           .o_tx(o_tx)              
    );
    
    RX rx(
           .i_clk(clk),   
           .i_tick(o_tick),
           .i_rx(o_tx),
           .i_reset(reset),
           .o_dato_recibido(o_dato_recibido),
           .o_recibido(o_recibido)              
    );
    
    Interface interface(
     .o_operando_1(),
     .o_operando_2(),
     .o_operacion(),
     .i_entrada_rx(o_dato_recibido),
     .i_recibido(o_recibido),
     .i_reset(reset),
     .i_clk(clk)   
    );
               
    always begin
        #1
        clk = ~clk;
    end
endmodule
