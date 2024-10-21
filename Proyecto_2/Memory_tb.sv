`timescale 1 ps / 1 ps
module Memory_tb();

	logic clk,reset;
	logic [3:0] cuadrante;
	logic [18:0] DataAdr_VGA;
	logic interpolacion;
	logic RegWriteM,MemWriteM,ResultSrcM;
	logic [4:0]  RDM; 
	logic [18:0] WriteDataM, ALUResultM;
	logic Cant_ByteM;

	logic RegWriteW,ResultSrcW;
	logic [4:0]  Rdw; 
	logic [18:0] ReadDataW;
	logic [18:0] ALUResultW;
	logic [7:0] pixel;
	logic [15:0] dimensiones;

		 
	Memory memory(
		.clk(clk),
		.reset(reset),
		.cuadrante(cuadrante),
		.DataAdr_VGA(DataAdr_VGA),
		.interpolacion(interpolacion),
		.RegWriteM(RegWriteM),
		.MemWriteM(MemWriteM),
		.ResultSrcM(ResultSrcM),
		.RDM(RDM),
		.WriteDataM(WriteDataM),
		.ALUResultM(ALUResultM),
		.Cant_ByteM(Cant_ByteM),

		.RegWriteW(RegWriteW),
		.ResultSrcW(ResultSrcW),
		.Rdw(Rdw),
		.ReadDataW(ReadDataW),
		.ALUResultW(ALUResultW),
		.pixel(pixel),
		.dimensiones(dimensiones)
	);

	
	always begin
	
		clk = ~clk; #10;

	end
	
	initial begin
		reset = 1'b0;
		clk = 0;

		#10;
		
		reset = 1'b1;
		
		cuadrante = 4'h2;
		DataAdr_VGA = 19'h0;
		interpolacion = 1'b1;
		RegWriteM = 1'b0;
		MemWriteM = 1'b1;    //escribir en memoria
		ResultSrcM = 1'b0;
		RDM = 5'd6;
		cuadrante = 4'h2;
		WriteDataM = 19'h3;  // lo que se va a guardar
		ALUResultM = 19'h8;  // dirección
		Cant_ByteM = 1'b1;   // 1 byte

		
		#20;
		
		cuadrante = 4'h2;
		DataAdr_VGA = 19'h0;
		interpolacion = 1'b1;
		RegWriteM = 1'b1;
		MemWriteM = 1'b0;    //escribir en memoria
		ResultSrcM = 1'b1;
		RDM = 5'd6;
		cuadrante = 4'h2;
		WriteDataM = 19'h0;  // lo que se va a guardar
		ALUResultM = 19'h8;  // dirección
		Cant_ByteM = 1'b1;   // 2 byte
	
		
		
		// Prueba inicial
		MemWriteM = 1'b0;      //se lee
		WriteDataM = 19'b0;   // no se va a guardar nada
		ALUResultM = 19'h0;  //dirección 
		Cant_ByteM = 1'b1;  // 1 byte
		cuadrante = 4'h2;
		
		#20;
		
		//Prueba1

		MemWriteM = 1'b1;    //escribir en memoria
		WriteDataM = 19'heeff;  // lo que se va a guardar
		ALUResultM = 19'h6;  // dirección
		Cant_ByteM = 1'b1;   // 2 byte
		cuadrante = 4'h2;

		#20;
		
		//Prueba2

		MemWriteM = 1'b1;    //escribir en memoria
		WriteDataM = 19'hccaa;  // lo que se va a guardar
		ALUResultM = 19'h7;  // dirección
		Cant_ByteM = 1'b1;   // 2 byte
		cuadrante = 4'h2;

		#20;
		
		
		//Prueba3

		MemWriteM = 1'b0;      //se lee
		WriteDataM = 19'b0;   // no se va a guardar nada
		ALUResultM = 19'h6;  //dirección 
		Cant_ByteM = 1'b1;  // 1 byte
		cuadrante = 4'h2;
		
		
		#20;
		
		//Prueba4

		MemWriteM = 1'b1;      //se escribe
		WriteDataM = 19'h00bb;   //se va a guardar
		ALUResultM = 19'h6;  //dirección 
		Cant_ByteM = 1'b0;  // 2 byte
		cuadrante = 4'h2;
		
		#20;
		
		
		//Prueba5

		MemWriteM = 1'b0;      //se lee
		WriteDataM = 19'h00bb;   //no se va a guardar nada
		ALUResultM = 19'h6;  //dirección 
		Cant_ByteM = 1'b1;  // 2 byte
		cuadrante = 4'h2;

		#20;
		
		//Prueba6

		MemWriteM = 1'b1;      //se lee
		WriteDataM = 19'h2;   // se va a guardar
		ALUResultM = 19'h7;  //dirección 
		Cant_ByteM = 1'b0;  // 2 byte
		cuadrante = 4'h2;

		#20;
		
		//Prueba7

		MemWriteM = 1'b0;      //se lee
		WriteDataM = 19'h0;   // no se va a guardar nada
		ALUResultM = 19'h6;  //dirección 
		Cant_ByteM = 1'b1;  // 2 byte
		cuadrante = 4'h2;
	
		
		#60;
		

		$finish;

	end

		 
endmodule