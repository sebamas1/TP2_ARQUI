module Segmento(
  input wire [3:0] hex_in,
  input wire [1:0] display_sel,
  output wire [6:0] seg_out
);

  reg [6:0] segment_data;

  always @(*) begin
    case(hex_in)
      4'h0: segment_data = 7'b1000000; // Display 0
      4'h1: segment_data = 7'b1111001; // Display 1
      4'h2: segment_data = 7'b0100100; // Display 2
      4'h3: segment_data = 7'b0110000; // Display 3
      4'h4: segment_data = 7'b0011001; // Display 4
      4'h5: segment_data = 7'b0010010; // Display 5
      4'h6: segment_data = 7'b0000010; // Display 6
      4'h7: segment_data = 7'b1111000; // Display 7
      4'h8: segment_data = 7'b0000000; // Display 8
      4'h9: segment_data = 7'b0010000; // Display 9
      4'ha: segment_data = 7'b0001000; // Display A
      4'hb: segment_data = 7'b0000011; // Display B
      4'hc: segment_data = 7'b1000110; // Display C
      4'hd: segment_data = 7'b0100001; // Display D
      4'he: segment_data = 7'b0000110; // Display E
      4'hf: segment_data = 7'b0001110; // Display F
      default: segment_data = 7'b1111111; // Display blank
    endcase
  end

//   assign seg_out = segment_data;
assign seg_out = (display_sel == 2'b00) ? segment_data : 7'b1111111;

endmodule