module Instruction_Memory(
       input logic reset,
		 input [31:0] a,
		 output [31:0] rd
);

      reg [31:0] ROM [1023:0];
  
      assign rd = (reset == 1'b0) ? {32{1'b0}} : ROM[A[31:2]];   //// Lee el dato en la direccion alineada "A"

      initial begin
		  
		  $readmemh("memfile.dat",ROM);
		  
      end

endmodule