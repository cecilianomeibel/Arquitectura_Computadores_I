module Execute(

    input logic clk, rst, RegWriteE,ALUSrcE,MemWriteE,ResultSrcE,BranchE,
    input logic [2:0] ALUControlE,
    input logic [31:0] RD1_E, RD2_E, Imm_Ext_E,
    input logic [4:0] RD_E,
    input logic [31:0] PCE, PCPlus4E,
    input logic [31:0] ResultW,
    input logic [1:0] ForwardA_E, ForwardB_E,

    output logic PCSrcE, RegWriteM, MemWriteM, ResultSrcM,
    output logic [4:0]  RD_M, 
    output logic [31:0] PCPlus4M, WriteDataM, ALU_ResultM,
    output logic [31:0] PCTargetE
);


    //Valores intermedios
	 
    logic [31:0] Src_A, Src_B_interim, Src_B;
    logic [31:0] ResultE;
    logic ZeroE;

    // Registros de execute
    reg RegWriteE_r, MemWriteE_r, ResultSrcE_r;
    reg [4:0] RD_E_r;
    reg [31:0] PCPlus4E_r, RD2_E_r, ResultE_r;

    
	 //Se instancian los módulos que componen a execute
	 
	
	//Mux para Hazard
    
	 Mux_3_1 srca_mux (
                        .a(RD1_E),
                        .b(ResultW),
                        .c(ALU_ResultM),
                        .s(ForwardA_E),
                        .d(Src_A)
                        );

    
    Mux_3_1 srcb_mux (
                        .a(RD2_E),
                        .b(ResultW),
                        .c(ALU_ResultM),
                        .s(ForwardB_E),
                        .d(Src_B_interim)
                        );
    
	 //Mux para ALU
	
    Mux_2_1 alu_src_mux (
            .a(Src_B_interim),
            .b(Imm_Ext_E),
            .s(ALUSrcE),
            .c(Src_B)
            );

 
    ALU alu (
            .A(Src_A),
            .B(Src_B),
            .Result(ResultE),
            .ALUControl(ALUControlE),
            .OverFlow(),
            .Carry(),
            .Zero(ZeroE),
            .Negative()
            );

    
    Adder branch_adder (
            .a(PCE),
            .b(Imm_Ext_E),
            .c(PCTargetE)
            );

				
    // Logica de registros de execute
	 
    always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
            RegWriteE_r <= 1'b0; 
            MemWriteE_r <= 1'b0; 
            ResultSrcE_r <= 1'b0;
            RD_E_r <= 5'h00;
            PCPlus4E_r <= 32'h0; 
            RD2_E_r <= 32'h0; 
            ResultE_r <= 32'h0;
        end
        else begin
            RegWriteE_r <= RegWriteE; 
            MemWriteE_r <= MemWriteE; 
            ResultSrcE_r <= ResultSrcE;
            RD_E_r <= RD_E;
            PCPlus4E_r <= PCPlus4E; 
            RD2_E_r <= Src_B_interim; 
            ResultE_r <= ResultE;
        end
    end

	 
    // Asignación de puertos de salida 

    assign PCSrcE = ZeroE &  BranchE;    //AND Gate
    assign RegWriteM = RegWriteE_r;
    assign MemWriteM = MemWriteE_r;
    assign ResultSrcM = ResultSrcE_r;
    assign RD_M = RD_E_r;
    assign PCPlus4M = PCPlus4E_r;
    assign WriteDataM = RD2_E_r;
    assign ALU_ResultM = ResultE_r;

endmodule