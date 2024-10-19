module Top(
	input logic clk_fpga,
	input logic reset,
	input logic [3:0] cuadrante,
	input logic interpolacion,
	output logic [7:0] r,
	output logic [7:0] g,
	output logic [7:0] b,
	
	output logic vgaclk,    		// VGA_CLK
	output logic vga_blank, 		// VGA_BLANK_N
	output logic horizontal_sync,	// VGA_HS
	output logic vertical_sync,		// VGA_VS
	output logic vga_sync			// VGA_SYNC_N
);
	
	logic vgaclk_25;
	logic [7:0] pixel;
	logic [15:0] dimensiones;  // tomaran las dimensiones de la imagen
	
	pll vgapll(
		.clk(clk_fpga),
		.reset(reset),
		.vgaclk(vgaclk_25)
	);
	
	Vga vga_module(
		.vgaclk(vgaclk_25),
		.reset(reset),
		.interpolacion(interpolacion),
		.dimensiones(dimensiones),
		.horizontal_sync(horizontal_sync),
		.vertical_sync(vertical_sync),
		.vga_sync(vga_sync),
		.vga_blank(vga_blank)
	);
	
	Pipeline(
		.clk(vgaclk_25), 
		.reset(reset),
		.cuadrante(cuadrante),
		.pixel(pixel)
	);
	
	assign r = pixel;
	assign g = pixel;
	assign b = pixel;
	assign vgaclk = vgaclk_25;
	
endmodule