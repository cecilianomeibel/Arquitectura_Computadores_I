module Execute_tb();

       logic clk, reset, RegWriteE,MemWriteE,JumpE,BranchE,ALUSrcE;
	    logic [1:0] ResultSrcE;
       logic [2:0] ALUControlE;
       logic [18:0] RD1E, RD2E, ImmExtE;
       logic [14:0] PCE;
	    logic [4:0] RDE;
       logic [18:0] ResultW;
       
		 logic PCSrcE, RegWriteM, MemWriteM;
       logic [1:0] ResultSrcM;
       logic [4:0]  RDM;
       logic [18:0] WriteDataM, ALUResultM;
       logic [14:0] PCTargetE;

       Execute execute(
		 .clk(clk),
		 .reset(reset),
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
		 .RDE(RDE),
		 .ResultW(ResultW),
		 
		 .PCSrcE(PCSrcE),
		 .RegWriteM(RegWriteM),
		 .MemWriteM(MemWriteM),
		 .ResultSrcM(ResultSrcM),
		 .RDM(RDM),
		 .WriteDataM(WriteDataM),
		 .ALUResultM(ALUResultM),
		 .PCTargetE(PCTargetE) 
		 );
		 
		 initial begin
	    reset = 1'b0;
	
	    clk = 0;
	    #5;
	 
	    reset = 1'b1;
		 
		 
		 JumpE = 1'b0 ;         
		 BranchE = 1'b0;
		 ALUSrcE = 1'b0;         //Elije el mux 00 ALU y 01 Memoria
       ALUControlE = 3'b011;  // Div
       RD1E = 19'd20;
		 RD2E = 19'd10;
		 ImmExtE = 19'd0;
       PCE = 15'd1;
   	 
	    #40;
	    $finish;
	 
	    end
	 
	 
	    always begin
		 
		  clk = ~clk; #5;
	    
		 end

endmodule 