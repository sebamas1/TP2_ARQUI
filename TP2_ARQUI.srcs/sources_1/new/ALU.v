    
    
    module ALU #(
            parameter BUS_SIZE = 8
        )
        (
            input [BUS_SIZE - 1 :0] i_operando_1,
            input [BUS_SIZE - 1 :0] i_operando_2,
            input [BUS_SIZE - 1 : 0] i_operacion,
            output [BUS_SIZE + 1 :0] o_resultado
            
        );
        
        localparam OP_ADD = 8'b01010011;//S
        localparam OP_SUB = 8'b01010010;//R
        localparam OP_AND = 8'b01000001;//A
        localparam OP_OR =  8'b01001111;//O
        localparam OP_XOR = 8'b01011000;//X
        localparam OP_SRA = 8'b01001000;//H
        localparam OP_SRL = 8'b01001100;//L
        localparam OP_NOR = 8'b01001110;//N
        
        reg [BUS_SIZE - 1 : 0] operador_1; 
        reg [BUS_SIZE - 1 : 0] operador_2; 
        reg [BUS_SIZE - 1 : 0] operacion; 
        reg[BUS_SIZE-1 : 0] resultado;
        
        
        assign o_resultado[BUS_SIZE] = resultado[BUS_SIZE]; //carry
        assign o_resultado[BUS_SIZE + 1] = ~| resultado[BUS_SIZE - 1 : 0]; //zero
        assign o_resultado[BUS_SIZE : 0] = resultado;
    
            always @(*)  
        begin       
            operador_1 = i_operando_1;
            operador_2 = i_operando_2;
            operacion = i_operacion;
        end
            
            always @(i_operando_1, i_operando_2, i_operacion) 
       begin     
            resultado[BUS_SIZE] <= 0;
            
            case(operacion)
                OP_ADD:
                    begin
                        resultado <= operador_1 + operador_2; 
                        // resultado <= {1'b0, operador_1} + {1'b0, operador_2}; 
                    end
                OP_SUB:
                    begin
                        resultado <= operador_1 - operador_2 ;
                    end
                OP_AND:
                    begin
                        resultado <= operador_1 & operador_2;
                    end
                OP_OR:
                    begin
                        resultado <= operador_1 | operador_2;
                    end
                OP_XOR:
                    begin
                        resultado <= operador_1 ^ operador_2;
                    end
                OP_SRA:
                    begin
                        resultado <= operador_1 >>> 1;
                    end
                OP_SRL:
                    begin
                        resultado <= operador_1 >> 1;
                    end
                OP_NOR:
                    begin
                        resultado <= ~(operador_1 | operador_2);
                    end
                default: 
                    begin
                        resultado <= operador_1 + operacion; 
                    end
            endcase
        end
    endmodule
