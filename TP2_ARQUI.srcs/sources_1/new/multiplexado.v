module Basys3_Multiplexado(
    input wire i_clk,
    input wire [7:0] value,
    output wire [6:0] seg,
    output wire [3:0] an
);

reg [3:0] display = 4'b0010; // Valor inicial del display

reg [7:0] display_value; // Valor a mostrar en el último display
reg [6:0] seg_reg;
reg [3:0] an_reg;

always @(posedge i_clk) begin
    display_value <= value;
    
    case (display)
        4'b0001: begin
            seg_reg <= 7'b0000000;
            // case(display_value)
            //     4'h0: seg_reg = 7'b1000000; // Display 0
            //     4'h1: seg_reg = 7'b1111001; // Display 1
            //     4'h2: seg_reg = 7'b0100100; // Display 2
            //     4'h3: seg_reg = 7'b0110000; // Display 3
            //     4'h4: seg_reg = 7'b0011001; // Display 4
            //     4'h5: seg_reg = 7'b0010010; // Display 5
            //     4'h6: seg_reg = 7'b0000010; // Display 6
            //     4'h7: seg_reg = 7'b1111000; // Display 7
            //     4'h8: seg_reg = 7'b0000000; // Display 8
            //     4'h9: seg_reg = 7'b0010000; // Display 9
            //     4'ha: seg_reg = 7'b0001000; // Display A
            //     4'hb: seg_reg = 7'b0000011; // Display B
            //     4'hc: seg_reg = 7'b1000110; // Display C
            //     4'hd: seg_reg = 7'b0100001; // Display D
            //     4'he: seg_reg = 7'b0000110; // Display E
            //     4'hf: seg_reg = 7'b0001110; // Display F
            //     default: seg_reg = 7'b1111111; // Display blank
            // endcase
            an_reg <= display;
        end
        
        4'b0010: begin
            seg_reg <= 7'b0010001;
            an_reg <= display;
        end
        
        4'b0100: begin
            seg_reg <= 7'b1000000;
            an_reg <= display;
        end
        
        4'b1000: begin
            seg_reg <= 7'b0000001;
            an_reg <= display;
        end
    endcase
    
    display <= display << 1; // Desplazamiento circular del display
end

assign seg = seg_reg;
assign an = an_reg;

endmodule