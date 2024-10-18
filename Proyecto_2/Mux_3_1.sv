module Mux_3_1 (
    input [18:0] a,b,c,
    input [1:0] s,
    output [18:0] d
);
    assign d = (s == 2'b00) ? a : (s == 2'b01) ? b : (s == 2'b10) ? c : 19'h0;
    
endmodule