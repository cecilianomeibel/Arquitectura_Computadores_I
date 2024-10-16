module Register_tb();

	logic clk,reset;
	logic [4:0] a1,a2,a3;    //Número de Rf1,Rf2,Rd
	logic we3;            	// Señal de WB (en cual se va a escribir) RegWriteW
	logic [18:0] wd3;      //ResultW
	
	logic [18:0] rd1,rd2;  //Tamaño de registros fuentes
	
Register_File register(
	.clk(clk),
	.reset,
	.a1(a1),
	.a2(a2),
	.a3(a3),     		//Número de Rf1,Rf2,Rd
	.we3(we3),         // Señal de WB (en cual se va a escribir) RegWriteW
	.wd3(wd3),       //ResultW
	
	.rd1(rd1),
	.rd2(rd2)  //Tamaño de registros fuentes
);

	always begin
	
		clk = ~clk; #5;
	end
	
	initial begin
		reset = 1'b0;
		clk = 0;
		
		#5;
		
		reset = 1'b1;
		
		a1 = 5'h1;
		a2 = 5'h1;
		a3 = 5'h2;
		
		we3 = 1'b1;
		wd3 = 19'h4;
		
		#10;
		
		a1 = 5'h2;
		a2 = 5'h2;
		a3 = 5'h5;
		
		we3 = 1'b0;
		wd3 = 19'h0;
		
		#40;
	
		$finish;
	end

endmodule