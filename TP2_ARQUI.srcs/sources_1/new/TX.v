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
        output o_tx
        );
        
        reg [9 : 0] dato = 10'b1111111110;
        reg [3 : 0] contador_ticks = 4'b0000;
        reg [3 : 0] reg_index = 0;
        
        assign o_tx = dato[reg_index];
        
         always @(posedge i_tick)
         begin
            contador_ticks <= contador_ticks + 1;
         end
         
         always @*
         begin
         if (contador_ticks == 15)
             begin
             contador_ticks <= 0;
             if(reg_index == 9)
             begin
             reg_index = 0;
             end
             else begin
             reg_index <= reg_index + 1;
             end
             end
         end
        
    endmodule
