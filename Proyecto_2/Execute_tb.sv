module Execute_tb();

       logic clk, reset, RegWriteE,MemWriteE,JumpE,ALUSrcE;
		 logic [1:0] BranchE;
	    logic ResultSrcE;
       logic [2:0] ALUControlE;
       logic [18:0] RD1E, RD2E, ImmExtE;
       logic [14:0] PCE;
	    logic [4:0] RDE;
       logic [18:0] ResultW;
		 logic Cant_ByteE;
       
		 logic PCSrcM, RegWriteM, MemWriteM;
       logic ResultSrcM;
       logic [4:0]  RDM;
       logic [18:0] WriteDataM, ALUResultM;
       logic [14:0] PCTargetE;
		 logic Cant_ByteM;

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
		 .Cant_ByteE(Cant_ByteE),
		 
		 .PCSrcM(PCSrcM),
		 .RegWriteM(RegWriteM),
		 .MemWriteM(MemWriteM),
		 .ResultSrcM(ResultSrcM),
		 .RDM(RDM),
		 .WriteDataM(WriteDataM),
		 .ALUResultM(ALUResultM),
		 .PCTargetE(PCTargetE),
		 .Cant_ByteM(Cant_ByteM) 
		 );
		 
		 initial begin
	    reset = 1'b0;
	
	    clk = 0;
	    #5;
	 
	    reset = 1'b1;
		 
		 
		 JumpE = 1'b0 ;         
		 BranchE = 2'b00;
		 ALUSrcE = 1'b0;         //registro
       ALUControlE = 3'b011;  // Div
       RD1E = 19'd20;
		 RD2E = 19'd10;
		 ImmExtE = 19'd0;
       PCE = 15'd1;
		 Cant_ByteE = 1'b0;
   	 
	    #40;
		 
		 JumpE = 1'b0 ;         
		 BranchE = 2'b00;
		 ALUSrcE = 1'b0;         //registro
       ALUControlE = 3'b100;  // Mod
       RD1E = 19'd29;
		 RD2E = 19'd5;
		 ImmExtE = 19'd0;
       PCE = 15'd1;
		 Cant_ByteE = 1'b0;
		 
		 #40;
		 
	    JumpE = 1'b0 ;         
		 BranchE = 2'b00;
		 ALUSrcE = 1'b0;         //registro
       ALUControlE = 3'b010;  // Mult
       RD1E = 19'd15;
		 RD2E = 19'd2;
		 ImmExtE = 19'd0;
       PCE = 15'd1;
		 Cant_ByteE = 1'b0;
		 
		 #40;
		 
		 //CMP
		 JumpE = 1'b0 ;         
		 BranchE = 2'b00;
		 ALUSrcE = 1'b0;         //registro
       ALUControlE = 3'b001;  // RES
       RD1E = 19'd15;
		 RD2E = 19'd2;
		 ImmExtE = 19'd0;
       PCE = 15'd1;
		 Cant_ByteE = 1'b0;
		 
		 #40;
		 
		 //Probar el SMAE
		 JumpE = 1'b0 ;         
		 BranchE = 2'b01;
		 ALUSrcE = 1'b1;         //inmediato
       ALUControlE = 3'b000;  // SUM
       RD1E = 19'd0;
		 RD2E = 19'd0;
		 ImmExtE = 19'd5;
       PCE = 15'd5;
		 Cant_ByteE = 1'b0;
		 
		 #40;
		 
		 //CMP
		 JumpE = 1'b0 ;         
		 BranchE = 2'b00;
		 ALUSrcE = 1'b0;         //registro
       ALUControlE = 3'b001;  // RES
       RD1E = 19'd2;
		 RD2E = 19'd1;
		 ImmExtE = 19'd0;
       PCE = 15'd1;
		 Cant_ByteE = 1'b0;
		 
		 #40;
		 
		 //Probar el SMEE
		 JumpE = 1'b0 ;         
		 BranchE = 2'b10;
		 ALUSrcE = 1'b1;         //inmediato
       ALUControlE = 3'b000;  // SUM
       RD1E = 19'd0;
		 RD2E = 19'd0;
		 ImmExtE = 19'd5;
       PCE = 15'd5;
		 Cant_ByteE = 1'b0;
		 
		 #40;
		 
		 //CMP
		 JumpE = 1'b0 ;         
		 BranchE = 2'b00;
		 ALUSrcE = 1'b0;         //registro
       ALUControlE = 3'b001;  // RES
       RD1E = 19'd11;
		 RD2E = 19'd12;
		 ImmExtE = 19'd0;
       PCE = 15'd1;
		 Cant_ByteE = 1'b0;
		 
		 #40;
		 
		 //Probar el SPE
		 JumpE = 1'b0 ;         
		 BranchE = 2'b11;
		 ALUSrcE = 1'b1;         //inmediato
       ALUControlE = 3'b000;  // SUM
       RD1E = 19'd0;
		 RD2E = 19'd0;
		 ImmExtE = 19'd5;
       PCE = 15'd5;
		 Cant_ByteE = 1'b0;
   	 
		 #45;
		 
	    $finish;
	 
	    end
	 
	 
	    always begin
		 
		  clk = ~clk; #5;
	    
		 end

endmodule 