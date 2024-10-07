module PC_mux(

	 input logic [31:0] a,b,
    input logic s,             //selector
	 output logic [31:0] c
);
    
	 assign c = (~s) ? a : b ;      //Si s=0 c toma a , si s=1 c toma b


endmodule



module mux_3_a_1 (
    input [31:0] a,b,c,
    input [1:0] s,
    output [31:0] d
);
    assign d = (s == 2'b00) ? a : (s == 2'b01) ? b : (s == 2'b10) ? c : 32'h0;
    
endmodule