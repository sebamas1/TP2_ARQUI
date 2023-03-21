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
            // output [7 : 0] o_operando_1,
            // output [7 : 0] o_operando_2,
            // output [5 : 0] o_operacion,
            input  [7 : 0] i_entrada_rx,
            input bit_envio,
            input i_reset,
            input i_clk
            );
            wire i_recibido;
            
             Baud_gen baud_gen
                (
                        .i_clk(i_clk),
                        .o_tick(o_tick)
                );
    
                RX rx(
                       .i_clk(i_clk),   
                       .i_tick(o_tick),
                       .i_rx(bit_envio),
                       .i_reset(i_reset),
                       .o_dato_recibido(i_entrada_rx),
                       .o_recibido(i_recibido)              
                );
            
        //         ALU #( .BUS_SIZE(8) ) alu
        // (
        //         .i_operando_1(o_operando_1),
        //         .i_operando_2(o_operando_2),
        //         .i_operacion(o_operacion)
        // );
        
        // reg [7 : 0] operando_1;
        // reg [7 : 0] operando_2;
        // reg [7 : 0] operacion;
               
        // assign o_operando_1 = operando_1;
        // assign o_operando_2 = operando_2;
        // assign o_operacion = operacion;
        
        
        // localparam OPERANDO1_STATE = 2'b00;
        // localparam OPERANDO2_STATE = 2'b01;
        // localparam OPERACION_STATE = 2'b10;

        // reg [3 : 0] present_state = OPERANDO1_STATE;
        // reg [3 : 0] next_state = OPERANDO1_STATE;
        
        
        
        // always @(posedge i_clk)
        // begin
        //     if(i_reset == 1)
        //     begin
        //         present_state <= OPERANDO1_STATE;
        //         operando_1 = 8'bxxxxxxxx;
        //         operando_2 = 8'bxxxxxxxx;
        //         operacion = 6'bxxxxxx;
        //         end
        //     else 
        //         present_state <= next_state;
        // end
        
        // always @(posedge i_recibido)
        // begin
            
        //  case(present_state)
        //  OPERANDO1_STATE:
        //  begin
        //  next_state = OPERANDO2_STATE;
        //  operando_1 = i_entrada_rx;
        //  end
         
        //  OPERANDO2_STATE:
        //  begin
        //  operando_2 = i_entrada_rx;
        //  next_state = OPERACION_STATE;
        //  end
         
        //  OPERACION_STATE:
        //  begin
        //  operacion = i_entrada_rx;
        //  next_state = OPERANDO1_STATE;
        //  end
         
        //  endcase
        
        // end        
        
        endmodule
