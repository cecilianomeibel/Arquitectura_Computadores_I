module Instruction_Memory(
	input logic reset,
	input logic [14:0] a,     //PCF
	output logic [19:0] rd   //instruccion
);
	
	logic [19:0] ROM [511:0];     //Caben 500 instrucciones aproximadamente
	
	initial begin
		integer i;
		for (i = 0; i < 512; i++) begin
			ROM[i] = 20'b0;  // Asigna 0 a cada posición de la ROM
		end
		$readmemb("imemfile.hex",ROM);
	  
	end

	assign rd = (reset == 1'b0) ? {20{1'b0}} : ROM[a];   // Lee el dato en la direccion alineada "A"
													             	 // Se hace PC+1, porque las instrucciones son de 17 bits y es un número primo, no es divisible en bytes
endmodule