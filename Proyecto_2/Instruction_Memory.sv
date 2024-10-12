module Instruction_Memory(
       input logic reset,
		 input logic [14:0] a,     //PCF
		 output logic [19:0] rd   //instruccion
);

      reg [19:0] ROM [511:0];
  
      assign rd = (reset == 1'b0) ? {20{1'b0}} : ROM[a];   // Lee el dato en la direccion alineada "A"
		                                                     // Se hace PC+1, porque las instrucciones son de 17 bits y es un número primo, no es divisible en bytes

      initial begin
		  
		  $readmemh("memfile.hex",ROM);
		  
      end

endmodule