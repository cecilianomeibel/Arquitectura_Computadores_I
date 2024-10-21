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
	logic [18:0] DataAdr_VGA = 19'h0;
	logic enable_pixel;
	
	
	logic [9:0] counter_H = 0;
	logic [9:0] counter_V = 0;

	
	pll vgapll(
		.clk(clk_fpga),
		.reset(reset),
		.vgaclk(vgaclk_25)
	);
	
	
	Vga vga_module(
		.vgaclk(vgaclk_25),
		.interpolacion(interpolacion),
		.dimensiones(dimensiones),
		.horizontal_sync(horizontal_sync),
		.vertical_sync(vertical_sync),
		.vga_sync(vga_sync),
		.vga_blank(vga_blank),
		.DataAdr_out(DataAdr_VGA),
		.enable_pixel(enable_pixel)
	);
	
	
	Pipeline pipeline(
		.clk(vgaclk_25), 
		.reset(reset),
		.cuadrante(cuadrante),
		.DataAdr_VGA(DataAdr_VGA),
		.interpolacion(interpolacion),
		.pixel(pixel),
		.dimensiones(dimensiones)
	);
	
	always @(posedge vgaclk_25) begin
		r = (enable_pixel)? pixel: 8'h0;
		g = r;
		b = r;
	end
	
	
	assign vgaclk = vgaclk_25;
	
endmodule