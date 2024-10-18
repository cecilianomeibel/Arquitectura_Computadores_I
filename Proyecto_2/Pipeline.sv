module Pipeline(
	input logic clk, reset,
	input logic [3:0] cuadrante,
	output logic [7:0] pixel

);

   //Definición de señales 
	
	// Etapa Fetch
	logic PCSrcE;
	logic [19:0] InstrD;
	logic [14:0] PCD;
	
	// Etapa Decode
	logic [4:0] RdW;              //Son 19 registros, 19 bits es 2^5
	logic [18:0] ResultW;        //Tamaño de registro

	logic RegWriteE, MemWriteE, JumpE, ALUSrcE;
	logic [1:0] BranchE;
	logic ResultSrcE;
	logic [2:0] ALUControlE;            //Toma los 3 bits de operación en el opcode
	logic [18:0] RD1E, RD2E,ImmExtE;   //Registros fuentes, inmediato
	logic [4:0] RS1E, RS2E;           //RS1E Y RS2E PARA EL HAZARD *****
	logic [14:0] PCE;
	logic [4:0] RDE;   //Destino
	logic Cant_ByteE;
	
	// Etapa Execute
	logic PCSrcM, RegWriteM, MemWriteM; 
	logic ResultSrcM;
	logic [4:0]  RDM; 
	logic [18:0] WriteDataM, ALUResultM;
	logic [14:0] PCTargetE;
	logic Cant_ByteM;
	logic [1:0] ForwardA_E, ForwardB_E;

	// Etapa Memory
	logic RegWriteW,ResultSrcW;
	logic [4:0]  RDW;
	logic [18:0] ReadDataW;
	logic [18:0] ALUResultW;
	
	
	//Fetch
	Fetch fetch_etapa(  
		.clk(clk),
		.reset(reset),
		.PCSrcE(PCSrcE),
		.PCTargetE(PCTargetE),
		
		.InstrD(InstrD),
		.PCD(PCD)
	);

	
	//Decode 
	Decode decode_etapa(
		.clk(clk), 
		.reset(reset), 
		.RegWriteW(RegWriteW),
		.InstrD(InstrD),           //Tamaño de instrucción
		.ResultW(ResultW),        //Tamaño de registro
		.PCD(PCD),
		.RdW(RdW),              //Son 19 registros, 19 bits es 2^5

		.RegWriteE(RegWriteE),
		.MemWriteE(MemWriteE),
		.JumpE(JumpE),
		.ALUSrcE(ALUSrcE),
		.BranchE(BranchE),
		.ResultSrcE(ResultSrcE),
		.ALUControlE(ALUControlE),        //Toma los 3 bits de operación en el opcode
		.RD1E(RD1E), 				//Registros fuentes
		.RD2E(RD2E),
		.ImmExtE(ImmExtE),   			//Registros fuentes, inmediato
		.PCE(PCE),
		.RDE(RDE),   				//Destino
		.Cant_ByteE(Cant_ByteE),
		.RS1E(RS1E), 
		.RS2E(RS2E)
	);     
	
	//Execute
	Execute execute_etapa(
		.clk(clk), 
		.reset(reset), 
		.RegWriteE(RegWriteE),
		.MemWriteE(MemWriteE),
		.JumpE(JumpE),
		.ALUSrcE(ALUSrcE),
		.BranchE(BranchE),
		.ResultSrcE(ResultSrcE),
		.ALUControlE(ALUControlE),
		.RD1E(RD1E), 
		.RD2E(RD2E), 
		.ImmExtE(ImmExtE),
		.PCE(PCE),
		.RDE(RDE),
		.Cant_ByteE(Cant_ByteE),
		.ForwardA_E(ForwardA_E), 
		.ForwardB_E(ForwardB_E),
		.ResultW(ResultW),
		
		.PCSrcE(PCSrcE), 
		.RegWriteM(RegWriteM), 
		.MemWriteM(MemWriteM), 
		.ResultSrcM(ResultSrcM),
		.RDM(RDM), 
		.WriteDataM(WriteDataM), 
		.ALUResultM(ALUResultM),
		.PCTargetE(PCTargetE),
		.Cant_ByteM(Cant_ByteM)
	);
	
	
	//Memory
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
	
	//WriteBack
	Mux_2_1 pc_mux(
		.a(ALUResultW),
		.b(ReadDataW),
		.s(ResultSrcW),
		.c(ResultW)
	);
	
	
	//Hazard
	Hazard hazard(
		.reset(reset), 
		.RegWriteM(RegWriteM), 
		.RegWriteW(RegWriteW),
		.RDM(RDM), 
		.RDW(RDW), 
		.RS1E(RS1E), 
		.RS2E(RS2E),    
		.ForwardA_E(ForwardA_E), 
		.ForwardB_E(ForwardB_E)
	);
	
endmodule