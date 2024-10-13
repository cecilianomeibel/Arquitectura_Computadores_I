module Decode_tb ();
      
		 logic clk,reset,RegWriteW;
		 logic [19:0] InstrD;          //Tamaño de instrucción
		 logic [18:0] ResultW;        //Tamaño de registro
		 logic [14:0] PCD;
		 logic [4:0] RdW;            //Son 19 registros, 19 bits es 2^5
		 
		 logic RegWriteE,MemWriteE,JumpE,BranchE,ALUSrcE;
		 logic [1:0] ResultSrcE;
       logic [2:0] ALUControlE;            //Toma los 3 bits de operación en el opcode
       logic [18:0] RD1E, RD2E,ImmExtE;   //Registros fuentes, inmediato
       //output [4:0] RS1E, RS2E,         //RS1E Y RS2E PARA EL HAZARD *****
       logic [14:0] PCE;
		 logic [4:0] RDE;   //Destino
		 
		 
		 Decode decode(
		 .clk(clk),
		 .reset(reset),
		 .RegWriteW(RegWriteW),
		 .InstrD(InstrD),
		 .ResultW(ResultW),
		 .PCD(PCD),
		 .RdW(RdW),
		 .RegWriteE(RegWriteE),
		 .MemWriteE(MemWriteE),
		 .JumpE(JumpE),
		 .BranchE(BranchE),
		 .ALUSrcE(ALUSrcE),
		 .ResultSrcE(ResultSrcE),
		 .ALUControlE(ALUControlE),
		 .RD1E(RD1E),
		 .RD2E(RD2E),
		 .ImmExtE(ImmExtE),
		 .PCE(PCE),
		 .RDE(RDE)
		 );
		 
		 initial begin
	    reset = 1'b0;
	
	    clk = 0;
	    #5;
	 
	    reset = 1'b1;
		 
		 RegWriteW = 1'h0;
		 InstrD = 20'h00429;       //Tamaño de instrucción
		 ResultW = 19'h5 ;         //Tamaño de registro
		 PCD = 15'h5;
		 RdW = 5'h5;
	 
	    #40;
	    $finish;
	 
	    end
	 
	 
	    always begin
		 
		  clk = ~clk; #5;
	    
		 end
 
endmodule 