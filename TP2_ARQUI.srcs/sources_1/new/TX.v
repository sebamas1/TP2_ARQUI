    `timescale 1ns / 1ps
    //////////////////////////////////////////////////////////////////////////////////
    // Company: 
    // Engineer: 
    // 
    // Create Date: 10.03.2023 18:59:56
    // Design Name: 
    // Module Name: TX
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
    
    
    module TX(
        input i_clk,
        input i_tick,
        input i_reset,
        input [7 : 0] i_dato,
        input i_enviar,
        output o_tx
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

        reg [3 : 0] present_state = IDDLE_STATE;
        reg [3 : 0] next_state = IDDLE_STATE;
        
        // wire [9 : 0] dato; 
        reg [3 : 0] contador_ticks = 5'b00000;
        // reg [3 : 0] reg_index = 0;
        reg terminado = 1'b0;
        reg salida = 1;
        reg contador = 1'b0;
        reg i_enviar_prev;
        
        // assign o_tx = dato[reg_index];
        // assign dato = {1'b0, i_dato, 1'b1};
        // assign dato = 10'b0011000011;


        always @(posedge i_clk) //hay que ver que venga desde un alto y empiece con un flanco descendente
        begin
            if(i_reset == 1)
                present_state <= IDDLE_STATE;
            else 
            begin
                present_state <= next_state;
            end
        end

        always @(i_enviar)
        begin
                if (i_enviar && !i_enviar_prev) 
                begin
                    terminado <= 0;
                end 
                else 
                begin
                    terminado <= 1;
                end
                i_enviar_prev <= i_enviar;
        end

        // always @(posedge i_clk) 
        // begin
        //     // begin
                
        //     // end
        // end
        

        always @(posedge i_tick)
        begin
            contador_ticks <= contador_ticks + 1;
            case(present_state)
                IDDLE_STATE:
                begin
                    if(i_enviar == 1 && terminado == 0)
                        begin
                            next_state <= WAITING_STATE;
                            contador_ticks <= 4'b0000; 
                        end
                end
                WAITING_STATE:
                    begin
                                salida <= 0;
                                if(contador_ticks == 4'b1111)
                                    begin
                                        next_state <= BIT0_STATE;
                                        contador_ticks <= 4'b0000;                     
                                    end
                                    
                    end
                    
                BIT0_STATE:
                    begin
                        salida <= i_dato[0];
                        if(contador_ticks == 4'b1111)
                        begin
                            next_state <= BIT1_STATE;
                            contador_ticks <= 4'b0000;
                        end
                    end
                
                BIT1_STATE:
                    begin
                        salida <= i_dato[1];
                        if(contador_ticks == 4'b1111)
                        begin
                            next_state <= BIT2_STATE;
                            contador_ticks <= 4'b0000;
                        end
                    end
                BIT2_STATE:
                    begin
                        salida <= i_dato[2];
                        if( contador_ticks == 4'b1111)
                        begin
                            next_state <= BIT3_STATE;
                            contador_ticks <= 4'b0000;
                        end
                    end
                BIT3_STATE:
                    begin 
                        salida <= i_dato[3];
                        if(contador_ticks == 4'b1111)
                        begin
                            next_state <= BIT4_STATE;
                            contador_ticks <= 4'b0000;
                        end
                    end
                BIT4_STATE:
                    begin
                        salida <= i_dato[4];
                        if(contador_ticks == 4'b1111)
                        begin
                            next_state <= BIT5_STATE;
                            contador_ticks <= 4'b0000;
                        end
                    end
                BIT5_STATE:
                    begin
                        salida <= i_dato[5];
                        if(contador_ticks == 4'b1111)
                        begin
                            next_state <= BIT6_STATE;
                            contador_ticks <= 4'b0000;
                        end
                    end
                BIT6_STATE:
                    begin
                        salida <= i_dato[6];
                        if(contador_ticks == 4'b1111)
                        begin
                            next_state <= BIT7_STATE;
                            contador_ticks <= 4'b0000;
                        end
                    end
                BIT7_STATE:
                    begin
                        salida <= i_dato[7];
                        if(contador_ticks == 4'b1111)
                        begin
                            next_state <= STOP_STATE;
                            contador_ticks <= 4'b0000;
                        end
                    end
                STOP_STATE:
                 begin
                    salida <= 1;
                            if(contador_ticks == 4'b1111)
                                begin
                                    next_state <= IDDLE_STATE;
                                    contador_ticks <= 4'b0000;    
                                    // terminado <= 1'b1;                
                                end
                        end
                endcase
        end

        //assign o_terminado = terminado;
        assign o_tx = salida;
         
       
        
    endmodule
