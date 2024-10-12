module Fetch 
(  
	 input logic clk,reset,
	 input logic PCSrcE,
	 input logic [14:0] PCTargetE,
	 output logic [19:0] InstrD,
	 output logic [14:0] PCD,PCPlus1D
);

	 logic [19:0] InstrF;
	 logic [14:0] PC_F, PCF,PCPlus1F;
	 reg [49:0] fetch_reg;   //InstrF_reg, PCPlus4F_reg, PCF_reg;
	 
	 
	 // Se llaman a los módulos que componen al Fetch
	 
	 Mux_2_1 pc_mux(
	 .a(PCPlus1F),
	 .b(PCTargetE),
	 .s(PCSrcE),
	 .c(PC_F));
	 
	 
	 PC pc(
	 .clk(clk),
	 .reset(reset),
	 .pc(PC_F),
	 .pc_next(PCF));
	 
	 
	 Instruction_Memory im (
	 .reset(reset),
	 .a(PCF),
	 .rd(InstrF));
	 
	 
	 Adder adder_pc (
	 .a(PCF),
	 .b(15'h1),
	 .c(PCPlus1F));
	 
	 
	 // Fetch Stage Registers
	 
	 always @(posedge clk or negedge reset)begin
	    if (reset == 1'b0)begin
		     fetch_reg    <= 50'h0;

		 end
		 else begin
		   fetch_reg [19:0]  <= InstrF;
			fetch_reg [34:20] <= PCF;
		   fetch_reg [49:35] <= PCPlus1F;
		   
	    end		
	 end	
	 
	 
	 // Asignación de puertos de salida 
	 
	 assign InstrD = fetch_reg [19:0];
	 assign PCD = fetch_reg [34:20];
	 assign PCPlus1D = fetch_reg [49:35];
	 
endmodule