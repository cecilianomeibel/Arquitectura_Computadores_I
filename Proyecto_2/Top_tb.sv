
`timescale 1 ps / 1 ps
module Top_tb();
	
	
	logic clk;
	logic reset;
	logic [3:0] cuadrante;
	logic interpolacion;
	logic [7:0] r;
	 
	logic [7:0] g;
	logic [7:0] b;

	logic vgaclk;   		// VGA_CLK
	logic vga_blank;		// VGA_BLANK_N
	logic horizontal_sync;	// VGA_HS
	logic vertical_sync;		// VGA_VS
	logic vga_sync;			// VGA_SYNC_N
	
	
	
	Top top(
		clk,
		reset,
		cuadrante,
		interpolacion,
		r,
		g,
		b,

		vgaclk,    		// VGA_CLK
		vga_blank, 		// VGA_BLANK_N
		horizontal_sync,	// VGA_HS
		vertical_sync,		// VGA_VS
		vga_sync			// VGA_SYNC_N
	);
	
	integer i, j;
	
	always begin
	
		clk = ~clk; #10;

	end
	
	initial begin
		
		clk = 1'b0;
		reset = 0;
		
		#10;
		
		reset = 1'b1;
		
		cuadrante = 4'd2;
		interpolacion = 1'b0;
		
		for (i = 0; i < 515; i++) begin
			for (j = 0; j < 800; j++) begin
				#10;
			end
		end

		$finish;
	
	end

endmodule

