module Fetch 
(  
	 input logic clk,reset,
	 input logic PCSrcE,
	 input logic [11:0] PCTargetE,
	 output logic [16:0] InstrD,
	 output logic [11:0] PCD,PCPlus4D
);

	 logic [16:0] InstrF;
	 logic [11:0] PC_F, PCF,PCPlus4F;
	 reg [40:0] fetch_reg;   //InstrF_reg, PCPlus4F_reg, PCF_reg;
	 
	 
	 // Se llaman a los módulos que componen al Fetch
	 
	 Mux_2_1 pc_mux(
	 .a(PCPlus4F),
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
	 .b(12'h1),
	 .c(PCPlus4F));
	 
	 
	 // Fetch Stage Registers
	 
	 always @(posedge clk or negedge reset)begin
	    if (reset == 1'b0)begin
		     fetch_reg    <= 45'h0;

		 end
		 else begin
		   fetch_reg [16:0]  <= InstrF;
			fetch_reg [28:17] <= PCF;
		   fetch_reg [40:29] <= PCPlus4F;
		   
	    end		
	 end	
	 
	 
	 // Asignación de puertos de salida 
	 
	 assign InstrD = fetch_reg [16:0];
	 assign PCD = fetch_reg [28:17];
	 assign PCPlus4D = fetch_reg [40:29];
	 
endmodule