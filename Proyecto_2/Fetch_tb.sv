module Fetch_tb();
  
	  logic clk,reset;
	  logic  PCSrcE;
	  logic [14:0] PCTargetE;
	  logic [19:0] InstrD;
	  logic [14:0] PCD;
	 
	 
	 //Se instancia el módulo
	 
	 Fetch fetch(
	    .clk(clk),
		 .reset(reset),
		 .PCSrcE(PCSrcE),
		 .PCTargetE(PCTargetE),
		 .InstrD(InstrD),
		 .PCD(PCD)
	 );
	 
	 
	 initial begin
	 reset = 1'b0;
	
	 clk = 0;
	 #5;
	 
	 reset = 1'b1;
	 PCSrcE = 1'b0;
	 PCTargetE = 15'h0;
	 
	 #40;
	 $finish;
	 
	 end
	 
	 
	 always begin
	
		clk = ~clk; #5;
	end

endmodule