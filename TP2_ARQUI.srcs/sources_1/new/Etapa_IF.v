`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2024 19:11:24
// Design Name: 
// Module Name: Etapa_IF
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


module Etapa_IF#(
        parameter   PC_SIZE = 11, //para los 2048
        parameter   TAM_DATA = 32,
        parameter   BYTE = 8
    )
    (
        input                           i_clk,
        input                           i_reset,
        input                           i_branch,
        input   [PC_SIZE - 1 : 0]       i_branch_addr,
        input                           i_stall,
        input  [TAM_DATA - 1 : 0]       i_instruccion,
        input  [PC_SIZE - 1 : 0]        i_instruccion_addr,
        input                           i_increment_addr,
        output  [TAM_DATA - 1 : 0]      o_instruccion,
        output  [PC_SIZE - 1 : 0]       o_pc_value

);

reg [PC_SIZE - 1 : 0] program_counter = 0;


ROM mem_inst(
    .i_addra({21'b0 ,i_instruccion_addr}), //La salida del PC entra a la mem
    .i_dina(i_instruccion),
    .i_clka(i_clk),
    .i_wea(1'b1),
    .i_ena(1'b1),
    .i_rsta(1'b0),                           // Output reset (does not affect memory contents)
    .i_regcea(1'b1),
    .i_increment_addr(i_increment_addr),
    .o_douta(),
    .o_halt()
);

always @(posedge i_clk) // always para resetear el PC si llega al final de la memoria
begin
    if(program_counter < 2048)
    begin
       program_counter <= i_branch == 1 ?  i_branch_addr :  
                          program_counter + 1;
    end else begin
       program_counter <= i_branch == 1 ?  i_branch_addr :  
                          0;
    end

end

always @(posedge i_stall) // always para disminuir el PC si hay stall
begin
    program_counter <= program_counter - 1;
end

assign o_pc_value   =   program_counter - 1;//es una negrada esto, pero es para que en el primer ciclo de clock se lea la instruccion anterior
assign o_instruccion =  mem_inst.o_douta; // la salida de la memoria es la instruccion

endmodule

