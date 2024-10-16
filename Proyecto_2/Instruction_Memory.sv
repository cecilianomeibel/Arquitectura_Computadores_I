module Instruction_Memory(
	input logic reset,
	input logic [14:0] a,     //PCF
	output logic [19:0] rd   //instruccion
);
	
	logic [19:0] ROM [511:0];     //Caben 500 instrucciones aproximadamente
	
	initial begin
		  
	  $readmemb("memfile.hex",ROM);
			  
	end
	
	assign rd = (reset == 1'b0) ? {20{1'b0}} : ROM[a];   // Lee el dato en la direccion alineada "A"
														 // Se hace PC+1, porque las instrucciones son de 17 bits y es un número primo, no es divisible en bytes
endmodule