module ALU_tb();

     logic [18:0] A,B;
	  logic [2:0] ALUControl; 
	  logic [18:0] Result;
	  logic Zero,OverFlow,Negative;
     
	  ALU alu(
	  .A(A),
	  .B(B),
	  .ALUControl(ALUControl),
	  .Result(Result),
	  .Zero(Zero),
	  .OverFlow(OverFlow),
	  .Negative(Negative)
	  );
	  
	  
	  initial begin
	  ALUControl = 3'b011;
	  A = 19'd25;
	  B = 19'd5;
	 
	  
	  #40;
	  
	  ALUControl = 3'b100;
	  A = 19'd26;
	  B = 19'd5;
	 
     #40;
	  
	  ALUControl = 3'b010;
	  A = 19'd10;
	  B = 19'd2;
	 
     #40;
	  end

endmodule 