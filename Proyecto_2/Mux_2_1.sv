module Mux_2_1(

	 input logic [31:0] a,b,
    input logic s,             //selector
	 output logic [31:0] c
);
    
	 assign c = (~s) ? a : b ;      //Si s=0 c toma a , si s=1 c toma b


endmodule



