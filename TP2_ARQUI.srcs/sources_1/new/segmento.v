module seven_segment_display(
    input i_clk,
    input [7:0] i_data,
    output reg [6:0] o_seg_out
);

reg [3:0] digit = 0;
reg [6:0] segment_data;

// 7-segment display segment values
//          a  b  c  d  e  f  g
// digit 0: 1  1  1  1  1  1  0
// digit 1: 0  1  1  0  0  0  0
// digit 2: 1  1  0  1  1  0  1
// digit 3: 1  1  1  1  0  0  1
// digit 4: 0  1  1  0  0  1  1
// digit 5: 1  0  1  1  0  1  1
// digit 6: 1  0  1  1  1  1  1
// digit 7: 1  1  1  0  0  0  0
always @ (posedge clk) begin
    case (digit)
        4'd0: segment_data = 7'b1000000; // 0
        4'd1: segment_data = 7'b1111001; // 1
        4'd2: segment_data = 7'b0100100; // 2
        4'd3: segment_data = 7'b0110000; // 3
        4'd4: segment_data = 7'b0011001; // 4
        4'd5: segment_data = 7'b0010010; // 5
        4'd6: segment_data = 7'b0000010; // 6
        4'd7: segment_data = 7'b1111000; // 7
        4'd8: segment_data = 7'b0000000; // 8
        4'd9: segment_data = 7'b0011000; // 9
        default: segment_data = 7'b1111111; // off
    endcase
    seg_out <= segment_data;
    digit <= digit + 1;
end

endmodule