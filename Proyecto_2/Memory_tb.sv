module Memory_tb();
       logic clk,reset;
	    logic RegWriteM,MemWriteM,ResultSrcM;
	    logic [4:0]  RDM; 
	    logic [18:0] WriteDataM, ALUResultM;
	    logic Cant_ByteM;
	 
	    logic RegWriteW,ResultSrcW;
	    logic [4:0]  RDW; 
	    logic [18:0] ReadDataW;
	    logic [18:0] ResultW;
		 
		 
		 Memory memory(
		 .clk(clk),
		 .reset(reset),
		 .RegWriteM(RegWriteM),
		 .MemWriteM(MemWriteM),
		 .ResultSrcM(ResultSrcM),
		 .RDM(RDM),
		 .WriteDataM(WriteDataM),
		 .ALUResultM(ALUResultM),
		 .Cant_ByteM(Cant_ByteM),
		 
		 .RegWriteW(RegWriteW),
		 .ResultSrcW(ResultSrcW),
		 .RDW(RDW),
		 .ReadDataW(ReadDataW),
		 .ResultW(ResultW));
		 
		 
		 initial begin
	    reset = 1'b0;
	
	    clk = 0;
	    #5;
	 
	    reset = 1'b1;
		 
		 //Prueba1
		
		 MemWriteM = 1'b1;    //escribir en memoria
		 WriteDataM = 19'h3;  // lo que se va a guardar
		 ALUResultM = 19'h5;  // dirección
		 Cant_ByteM = 1'b0;   // 1 byte
   	 
	    #40;
		 
		 //Prueba2
		
		 MemWriteM = 1'b0;      //no va a escribir
		 WriteDataM = 19'b0;   // no se va a guardar nada
		 ALUResultM = 19'h5;  //dirección 
		 Cant_ByteM = 1'b0;  // 1 byte
   	 
	    #40;
		 
		 
		 $finish;
	 
	    end
	 
	 
	    always begin
		 
		  clk = ~clk; #5;
	    
		 end
		 
endmodule