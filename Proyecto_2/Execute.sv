module Execute(

    input logic clk, reset, RegWriteE,MemWriteE,JumpE,BranchE,ALUSrcE,
	 input logic [1:0] ResultSrcE,
    input logic [2:0] ALUControlE,
    input logic [18:0] RD1E, RD2E, ImmExtE,
    input logic [14:0] PCE,
	 input logic [4:0] RDE,
    input logic [18:0] ResultW,
    //input logic [1:0] ForwardA_E, ForwardB_E,  (Hazard)

    output logic PCSrcE, RegWriteM, MemWriteM, 
	 output logic [1:0] ResultSrcM,
    output logic [4:0]  RDM, 
    output logic [18:0] WriteDataM, ALUResultM,
    output logic [14:0] PCTargetE
);


    //Valores intermedios
	 
    logic [18:0] SrcA, SrcB_intermedio, SrcB; 
    logic [18:0] ResultE;
    logic ZeroE, OverFlowE,NegativeE;

	 
	 //Registro de Execute
	  reg [46:0] execute_reg;
		 
		 
    
	//Se instancian los módulos que componen a execute
	 
	
	//Mux para Hazard
    
	/* Mux_3_1 srca_mux (
                        .a(RD1E),
                        .b(ResultW),
                        .c(ALUResultM),
                        .s(ForwardA_E),
                        .d(Src_A)
                        );

    
    Mux_3_1 srcb_mux (
                        .a(RD2E),
                        .b(ResultW),
                        .c(ALUResultM),
                        .s(ForwardB_E),
                        .d(Src_B_interim)
                       );*/ 
    
	 
	 //Mux para ALU
	
    Mux_2_1 alu_mux (
            .a(SrcB_intermedio),
            .b(ImmExtE),
            .s(ALUSrcE),
            .c(SrcB)
            );

 
    ALU alu (
            .A(SrcA),
            .B(SrcB),
            .Result(ResultE),
            .ALUControl(ALUControlE),
            .OverFlow(OverFlowE),
            .Zero(ZeroE),
            .Negative(NegativeE)
            );

    
    Adder branch_adder (
            .a(PCE),
            .b(ImmExtE),
            .c(PCTargetE)
            );

				
    // Logica de registros de execute
	 
    always @(posedge clk or negedge reset) begin
        if(reset == 1'b0) begin
		     execute_reg <= 47'h0;
		 
		  end
		  else begin

            execute_reg [0] <= RegWriteE; 
            execute_reg [1] <= MemWriteE; 
            execute_reg [3:2] <= ResultSrcE;
            execute_reg [8:4] <= RDE; 
            execute_reg [27:9] <= SrcB_intermedio; 
            execute_reg [46:28] <= ResultE;
        end
    end

	 
    // Asignación de puertos de salida 

    assign PCSrcE = (ZeroE & BranchE)||JumpE;    //AND Gate
    assign RegWriteM = execute_reg [0];
    assign MemWriteM = execute_reg [1];
    assign ResultSrcM = execute_reg [3:2];
    assign RDM = execute_reg [8:4];
    assign WriteDataM = execute_reg [27:9];  
    assign ALUResultM = execute_reg [46:28];

endmodule