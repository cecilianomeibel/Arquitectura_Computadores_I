module Pipeline_tb();

	logic clk, reset;
	logic [3:0] cuadrante;
	logic [7:0] pixel;

	Pipeline(
		.clk(clk), 
		.reset(reset),
		.cuadrante(cuadrante),
		.pixel(pixel)
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
	 
	 #40;
	 $finish;
	 
	 end
	 
	
endmodule