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
            input rx,//UART RX
            input i_reset,
            input i_clk,
            output [7 : 0] salida,
            output [7 : 0] salida_operadores,
            output tx,
            output [6:0] display1,
            output [3:0] an
            );

            wire i_recibido;
            wire transmitir;
            wire [7 : 0] rec_data;
            wire [7 : 0] o_operando_1;
            wire [7 : 0] o_operando_2;
            wire [7 : 0] o_operacion;
            wire [7 : 0] resultado;
            

             Baud_gen baud_gen
                (
                        .i_clk(i_clk),
                        .o_tick(o_tick)
                );
    
                RX receptor(
                       .i_clk(i_clk),   
                       .i_tick(o_tick),
                       .i_rx(rx),
                       .i_reset(i_reset),
                       .o_dato_recibido(rec_data),
                       .o_recibido(i_recibido)              
                );
            
                // ALU #( .BUS_SIZE(8) ) alu
                // (
                //         .i_operando_1(o_operando_1),
                //         .i_operando_2(o_operando_2),
                //         .i_operacion(o_operacion),
                //         .o_resultado(resultado)
                // );

                TX tramsmisor(
                        .i_clk(i_clk),
                        .i_tick(o_tick),
                        .i_reset(i_reset),
                        .i_instruccion(INSTRUCCION),
                        .i_enviar(transmitir),
                        .o_tx(tx)
                );

                Basys3_7SegmentMultiplexing basys3_7SegmentMultiplexing (
                        
                        .data(salida_operadores),
                        .seg(display1),
                        .an(an),
                        .clk(o_tick),
                        .rst(resultado)
                );

        
        
        reg [7 : 0] operando_1;
        reg [7 : 0] operando_2;
        reg [7 : 0] operacion;
        reg [7 : 0] salida_op;
        reg transmitiendo = 1'b0;

        
        localparam PRIMER_HEXA = 2'b00;
        localparam SEGUNDO_HEXA = 2'b01;
        localparam TERCER_HEXA = 2'b10;
        localparam CUARTO_HEXA = 2'b11;

        reg [31 : 0] INSTRUCCION;

        reg [3 : 0] present_state = PRIMER_HEXA;
        reg [3 : 0] next_state = PRIMER_HEXA;

        assign salida = resultado;
        assign o_operando_1 = operando_1;
        assign o_operando_2 = operando_2;
        assign o_operacion = operacion;
        assign salida_operadores = salida_op;
        assign transmitir = transmitiendo;

          
        always @(posedge i_clk)
        begin
            if(i_reset == 1)
            begin
                present_state <= PRIMER_HEXA;
                operando_1 <= 8'bxxxxxxxx;
                operando_2 <= 8'bxxxxxxxx;
                operacion <= 8'bxxxxxxxx;
                end
            else 
                present_state <= next_state;
        end
        
        always @(posedge i_recibido)
                begin
                
                        case(present_state)
                                PRIMER_HEXA:
                                begin
                                        transmitiendo <= 0;
                                        next_state <= SEGUNDO_HEXA;
                                        // operando_1 <= rec_data;
                                        // salida_op <= rec_data;
                                        INSTRUCCION [ 7 : 0] <= rec_data;
                                end
                                
                                SEGUNDO_HEXA:
                                begin
                                        // operando_2 <= rec_data;
                                        next_state <= TERCER_HEXA;
                                        // salida_op <= rec_data;
                                        INSTRUCCION [ 15 : 8] <= rec_data;
                                end

                                TERCER_HEXA:
                                begin
                                        // operando_2 <= rec_data;
                                        next_state <= CUARTO_HEXA;
                                        // salida_op <= rec_data;
                                        INSTRUCCION [ 23 : 16] <= rec_data;
                                end
                                
                                CUARTO_HEXA:
                                begin
                                        // operacion <= rec_data;
                                        next_state <= PRIMER_HEXA;
                                        // salida_op <= rec_data;
                                        INSTRUCCION [ 31 : 24] <= rec_data;

                                        transmitiendo <= 1;
                                end

                        endcase   
                
                end    

endmodule
