`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2022 14:32:26
// Design Name: 
// Module Name: Interface
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

    
        module Interface
            (
            output [7 :0] o_operando_1,
            output [7 :0] o_operando_2,
            output [5 : 0] o_operacion,
            output o_clk
            );
            
                ALU #( .BUS_SIZE(8) ) alu
        (
                .i_operando_1(o_operando_1),
                .i_operando_2(o_operando_2),
                .i_operacion(o_operacion)
        );
        
                Baud_gen baud_gen
        (
                .i_clk(o_clk)
        );
        
//                RX rx
//        (
//                .i_clk(o_clk),
//                .i_tick(baud_gen.o_tick)
//        );
        
        reg clk = 1'b0;
        
        assign o_operando_1 = 8'b00000010;
        assign o_operando_2 = 8'b00000010;
        assign o_operacion = 6'b100000;
        assign o_clk = clk;
        
        always begin
        #1
        clk = ~clk;
        end
        
        endmodule
