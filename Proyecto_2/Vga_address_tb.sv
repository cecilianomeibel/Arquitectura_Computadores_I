module Vga_address_tb ();	

	logic [9:0] x;
	logic [9:0] y;
	logic interpolacion,
	logic [15:0] dimensiones;
	logic [18:0] DataAdr_out;
	logic enable_pixel;
	
	Vga_address vga_test(
		x,
		y,
		interpolacion,
		dimensiones,
		DataAdr_out,
		enable_pixel
	);		


endmodule