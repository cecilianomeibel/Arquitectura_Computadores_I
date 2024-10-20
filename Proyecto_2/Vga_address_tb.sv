module Vga_address_tb();	

	logic [9:0] x;
	logic [9:0] y;
	logic interpolacion;
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
		
	integer i;
	integer j;

	initial begin
		interpolacion = 0;
		dimensiones = 400;
		
		for (i = 33; i< 515; i = i+1) begin
			y = i;
			if (y == 35) begin
			
				dimensiones = 300;
			end
			for (j = 120; j < 645; j = j+1) begin
				x = j;
				#10;
			end
		end
		
	end
	
	
endmodule