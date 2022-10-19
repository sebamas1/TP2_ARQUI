`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2022 16:17:17
// Design Name: 
// Module Name: RX
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


module RX(

    input i_clk,
    input i_tick,
    input i_rx,
    input i_reset

    );
          
    localparam IDDLE_STATE = 4'b0000;
    localparam WAITING_STATE = 4'b0001;
    localparam BIT0_STATE = 4'b0100;
    localparam BIT1_STATE = 4'b0101;
    localparam BIT2_STATE = 4'b0110;
    localparam BIT3_STATE = 4'b0111;
    localparam BIT4_STATE = 4'b1000;
    localparam BIT5_STATE = 4'b1001;
    localparam BIT6_STATE = 4'b1010;
    localparam BIT7_STATE = 4'b1011;
    localparam STOP_STATE = 4'b1100;
    localparam SAVE_STATE = 4'b1101;
    
    reg [3 : 0] present_state = IDDLE_STATE;
    reg [3 : 0] next_state = IDDLE_STATE;
    reg [7 : 0] dato;
    reg [4 : 0] contador_ticks = 4'b0000;
    
    always @(posedge i_clk)
        begin
            if(i_reset == 1)
                present_state <= IDDLE_STATE;
            else 
                present_state <= next_state;
        end
        
     always @(posedge i_tick)
     begin
        contador_ticks = contador_ticks + 1;
     end
    
    always @*
        begin
        case(present_state)
            IDDLE_STATE:
                if(i_rx == 0)
                     begin
                         next_state = WAITING_STATE;
                     end
            WAITING_STATE:
                if(i_rx == 0 && contador_ticks == 7)
                    begin
                        next_state = BIT0_STATE;
                        contador_ticks = 0;
                    end else begin
                        next_state = IDDLE_STATE;
                        contador_ticks = 0;
                    end
                
            BIT0_STATE:
                begin
                    if(contador_ticks == 16)
                    begin
                        next_state = BIT1_STATE;
                        dato[0] = i_rx;
                        contador_ticks = 0;
                    end
                end
            
            BIT1_STATE:
                begin
                    if(contador_ticks == 16)
                    begin
                        next_state = BIT2_STATE;
                        dato[1] = i_rx;
                        contador_ticks = 0;
                    end
                end
            BIT2_STATE:
                begin
                    if( contador_ticks == 16)
                    begin
                        next_state = BIT3_STATE;
                        dato[2] = i_rx;
                        contador_ticks = 0;
                    end
                end
            BIT3_STATE:
                begin 
                    if(contador_ticks == 16)
                    begin
                        next_state = BIT4_STATE;
                        dato[3] = i_rx;
                        contador_ticks = 0;
                    end
                end
            BIT4_STATE:
                begin
                    if(contador_ticks == 16)
                    begin
                        next_state = BIT5_STATE;
                        dato[4] = i_rx;
                        contador_ticks = 0;
                    end
                end
            BIT5_STATE:
                begin
                    if(contador_ticks == 16)
                    begin
                        next_state = BIT6_STATE;
                        dato[5] = i_rx;
                        contador_ticks = 0;
                    end
                end
            BIT6_STATE:
                begin
                    if(contador_ticks == 16)
                    begin
                        next_state = BIT7_STATE;
                        dato[6] = i_rx;
                        contador_ticks = 0;
                    end
                end
            BIT7_STATE:
                begin
                    if(contador_ticks == 16)
                    begin
                        next_state = STOP_STATE;
                        dato[7] = i_rx;
                        contador_ticks = 0;
                    end
                end
            STOP_STATE:
                    if(i_rx == 1 && contador_ticks == 16)
                    begin
                        next_state = IDDLE_STATE;
                        contador_ticks = 0;
                    end else begin
                        dato[7 : 0] = 8'b00000000;
                        next_state = IDDLE_STATE;
                        contador_ticks = 0;
                    end         
    
                default: next_state = IDDLE_STATE;
                endcase
            
            end
        
    endmodule
