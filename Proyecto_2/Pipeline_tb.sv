`timescale 1 ps / 1 ps
module Pipeline_tb();

	logic clk, reset;
	logic [3:0] cuadrante;
   logic [18:0] DataAdr_VGA;
	logic interpolacion;
	logic [7:0] pixel;
	logic [15:0] dimensiones;
	

	Pipeline pipeline(
		.clk(clk), 
		.reset(reset),
		.cuadrante(cuadrante),
		.DataAdr_VGA(DataAdr_VGA),
		.interpolacion(interpolacion),
		.pixel(pixel),
		.dimensiones(dimensiones)
	);
	
	always begin
	
		clk = ~clk; #5;
	end
	
	initial begin
	 reset = 1'b0;
	
	 clk = 0;
	 #10;
	 
	 reset = 1'b1;
	 cuadrante = 4'd10;
	 interpolacion = 1'b1;
	 
	 #500;
	 $finish;
	 
	 end
	 
	
endmodule