module Instruction_Memory(
       input logic reset,
		 input logic [31:0] a,
		 output logic [31:0] rd
);

      reg [31:0] ROM [1023:0];
  
      assign rd = (reset == 1'b0) ? {32{1'b0}} : ROM[a[31:2]];   //// Lee el dato en la direccion alineada "A"

      initial begin
		  
		  $readmemh("memfile.hex",ROM);
		  
      end

endmodule