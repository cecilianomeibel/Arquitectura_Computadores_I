`timescale 1 ps / 1 ps
module Memory_tb();

	logic clk,reset;
	logic [3:0] cuadrante;
	logic RegWriteM,MemWriteM,ResultSrcM;
	logic [4:0]  RDM; 
	logic [18:0] WriteDataM, ALUResultM;
	logic Cant_ByteM;

	logic RegWriteW,ResultSrcW;
	logic [4:0]  RdW; 
	logic [18:0] ReadDataW;
	logic [18:0] ALUResultW;
	logic [7:0] pixel;

		 
	Memory memory(
		.clk(clk),
		.reset(reset),
		.cuadrante(cuadrante),
		.RegWriteM(RegWriteM),
		.MemWriteM(MemWriteM),
		.ResultSrcM(ResultSrcM),
		.RDM(RDM),
		.WriteDataM(WriteDataM),
		.ALUResultM(ALUResultM),
		.Cant_ByteM(Cant_ByteM),

		.RegWriteW(RegWriteW),
		.ResultSrcW(ResultSrcW),
		.RdW(RdW),
		.ReadDataW(ReadDataW),
		.ALUResultW(ALUResultW),
		.pixel(pixel)
	);

	
	always begin
	
		clk = ~clk; #10;

	end
	
	initial begin
		reset = 1'b0;
		clk = 0;

		#10;

		reset = 1'b1;

		//Prueba1

		MemWriteM = 1'b1;    //escribir en memoria
		WriteDataM = 19'heeff;  // lo que se va a guardar
		ALUResultM = 19'h2;  // dirección
		Cant_ByteM = 1'b1;   // 2 byte
		cuadrante = 4'h2;

		#20;
		
		//Prueba2

		MemWriteM = 1'b1;    //escribir en memoria
		WriteDataM = 19'hccaa;  // lo que se va a guardar
		ALUResultM = 19'h4;  // dirección
		Cant_ByteM = 1'b1;   // 2 byte
		cuadrante = 4'h2;

		#20;
		

		//Prueba3

		MemWriteM = 1'b0;      //se lee
		WriteDataM = 19'b0;   // no se va a guardar nada
		ALUResultM = 19'h4;  //dirección 
		Cant_ByteM = 1'b1;  // 1 byte
		cuadrante = 4'h2;

		#40;


		$finish;

	end

		 
endmodule