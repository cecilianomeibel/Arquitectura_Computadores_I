
module Vga_address (
	input logic [9:0] x,
	input logic [9:0] y,
	input logic interpolacion,
	input logic [15:0] dimensiones,
	output logic [18:0] DataAdr_out,
	output logic enable_pixel
);		

	logic [15:0] dimensiones_reg = 16'd392;					// se almacena dimension de img original
	logic [15:0] dimensiones_interpolacion_reg = 16'd292;	// se almacena dimension de cuadrante interpolado
	logic [18:0] address_temp_out;  			 // será un puntero en memoria para que la vga leea los pixeles
	
	always @(posedge interpolacion) begin
	
		dimensiones_interpolacion_reg = ((dimensiones_reg >> 2) +(dimensiones_reg >> 2) +(dimensiones_reg >> 2)) - 2'd2; // dimensiones del cuadrante
	end
	
	
	always @(x,y) begin
		 
		
		// condición para mostrar imagen original, interpolación = 0
		if ((x > 144 && y > 34) && (x < (145 + dimensiones_reg)) && (y < (35 + dimensiones_reg)) && ~interpolacion) begin
			DataAdr_out = address_temp_out;
			address_temp_out = address_temp_out + 1'b1;
			enable_pixel = 1'b1;
			
		end
		// condición para mostrar el cuadrante, interpolacion = 1
		else if ((x > 144 && y > 34) && (x < (145 + dimensiones_interpolacion_reg)) && (y < (35 + dimensiones_interpolacion_reg)) && interpolacion) begin
			DataAdr_out = address_temp_out;
			address_temp_out = address_temp_out + 1'b1;
			enable_pixel = 1'b1;
		
		end
		else if (y < 35) begin
			DataAdr_out = 19'h2;  // dirección donde estarán las dimensiones de la matriz
			dimensiones_reg = dimensiones;  // dimensiones imagen original
			
			address_temp_out = (interpolacion)? 19'd125016: 19'h6;
			enable_pixel = 1'b0;
			
		end
		
		else begin
			enable_pixel = 1'b0;
			DataAdr_out = address_temp_out;
		end
		
	end
	
endmodule