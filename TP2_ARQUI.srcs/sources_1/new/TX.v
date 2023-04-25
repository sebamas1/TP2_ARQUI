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
        input i_tick,
        input i_reset,
        input [7 : 0] i_dato,
        input i_enviar,
        output o_tx
        );
        
        wire [9 : 0] dato; 
        reg [3 : 0] contador_ticks = 4'b0000;
        reg [3 : 0] reg_index = 0;
        reg reg_terminado = 0;
        
        assign o_tx = dato[reg_index];
        // assign dato = {1'b0, i_dato, 1'b1};
        assign dato = 10'b0011000011;
   
         always @(posedge i_tick)
         begin
            if(i_enviar == 1 && reg_terminado == 0)
            begin
                if (contador_ticks == 15)
                begin
                    if(reg_index == 9)
                        begin
                            reg_index = 0;//termino de enviar
                            reg_terminado = 1;
                        end
                    else 
                        begin
                            reg_index = reg_index + 1;
                        end
                    contador_ticks = 0;
                end
                contador_ticks <= contador_ticks + 1;
            end
            if(i_enviar == 0)
            begin
                reg_terminado = 0;
                contador_ticks = 0;
            end
         end
         
        //  always @*
        //  begin
        //  if (contador_ticks == 15)
        //      begin
        //         if(reg_index == 9)
        //             begin
        //                 reg_index = 0;
        //             end
        //         else 
        //             begin
        //                 reg_index = reg_index + 1;
        //             end
        //         contador_ticks = 0;
        //     end
        //  end
        
    endmodule
