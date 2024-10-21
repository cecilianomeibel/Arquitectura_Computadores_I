module Vga(
	input logic vgaclk,
	input logic interpolacion, 
	input logic [15:0] dimensiones,
	output logic horizontal_sync,
	output logic vertical_sync,
	output logic vga_sync,
	output logic vga_blank,
	output logic [18:0] DataAdr_out,
	output logic enable_pixel
);
	
	logic [9:0] counter_H = 0;
	logic [9:0] counter_V = 0;
	
	
	VgaController controladorVGA(
		.vgaclk(vgaclk),
		.hsync(horizontal_sync),
		.vsync(vertical_sync),
		.vga_sync(vga_sync),
		.vga_blank(vga_blank),
		.counter_H(counter_H),
		.counter_V(counter_V)
	);
	
	// Determina la dirección en memoria donde se debe buscar el pixel
	Vga_address video(
		.x(counter_H), 
		.y(counter_V),
		.interpolacion(interpolacion),
		.dimensiones(dimensiones),
		.DataAdr_out(DataAdr_out),
		.enable_pixel(enable_pixel)
	);
	
endmodule



	