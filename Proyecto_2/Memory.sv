module Memory(
	input logic clk,reset,
	input logic [3:0] cuadrante,
	input logic RegWriteM,MemWriteM,ResultSrcM,
	input logic [4:0]  RDM, 
	input logic [18:0] WriteDataM, ALUResultM,
	input logic Cant_ByteM,

	output logic RegWriteW,ResultSrcW,
	output logic [4:0]  RdW, 
	output logic [18:0] ReadDataW,
	output logic [18:0] ALUResultW,
	output logic [7:0] pixel
);


	//Valores intermedios

	logic [18:0]  ReadDataM;   


	//Registro de Memory
	reg [44:0] memory_reg;   //RegWriteM,ResultSrcM,RDM,ALUResultM,ReadDataM,
	 

   //Se instancian los modulos de Memory 
	Data_Memory data_memory(
		.clk(clk),
		.reset(reset),
		.cuadrante(cuadrante),
		.A(ALUResultM),
		.WD(WriteDataM),
		.WE(MemWriteM),
		.Cant_Byte(Cant_ByteM),
		.RD(ReadDataM),
		.pixel(pixel)
	);
		 
		 
	 // Logica de registros de memory
	 
    always @(posedge clk or negedge reset) begin
		if(reset == 1'b0) begin
			 memory_reg <= 45'h0;
		 
		end
		else begin

			memory_reg [0] <= RegWriteM; 
			memory_reg [1] <= ResultSrcM; 
			memory_reg [20:2] <= ALUResultM; 
			memory_reg [25:21] <= RDM;
			memory_reg [44:26] <= ReadDataM; 
		end
	end

	 
    // Asignación de puertos de salida 
	               
	assign RegWriteW = memory_reg [0];
	assign ResultSrcW = memory_reg [1];
	assign ALUResultW = memory_reg [20:2];
	assign RdW = memory_reg [25:21];
	assign ReadDataW = memory_reg [44:26];

endmodule