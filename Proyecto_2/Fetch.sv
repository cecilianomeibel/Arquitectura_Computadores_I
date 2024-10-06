module Fetch 
(  
	 input logic clk,reset,
	 input PCSrcE,
	 input [31:0] PCTargetE,
	 output [31:0] InstrD, PCD,PCPlus4D
);
   
	 wire [31:0] PC_F,PCF,PCPlus4F,InstrF;
	 reg [31:0] InstrF_reg, PCPlus4F_reg, PCF_reg;
	 
	 
	 // Se llaman a los módulos que componen al Fetch
	 
	 PC_mux pc_mux(
	 .a(PCPlus4F),
	 .b(PCTargetE),
	 .s(PCSrcE),
	 .c(PC_F));
	 
	 
	 PC pc(
	 .clk(clk),
	 .reset(reset),
	 .pc(PC_F),
	 .pc_next(PCF));
	 
	 
	 Instruction_memory im (
	 .reset(reset),
	 .a(PCF),
	 .rd(InstrF));
	 
	 
	 Adder_PC adder(
	 .a(PCF),
	 .b(32'h4),
	 .c(PCPlus4F));
	 
	 
	 // Fetch Stage Registers
	 
	 always @(posedge clk or negedge reset)begin
	    if (reset == 1'b0)begin
		     InstrF_reg    <= 32'h0;
			  PCPlus4F_reg  <= 32'h0;
			  PCF_reg       <= 32'h0;
		 end
		 else begin
		   InstrF_reg    <= InstrF;
		   PCPlus4F_reg  <= PCPlus4F;
		   PCF_reg       <= PCF;
	    end		
	 end	
	 
	 
	 // Asignación de puertos de salida 
	 
	 assign InstrD = InstrF_reg;
	 assign PCD = PCF_reg;
	 assign PCPlus4D = PCPlus4F_reg;
	 
	 
	 
endmodule