module Execute(

	input logic clk, reset, RegWriteE,MemWriteE,JumpE,ALUSrcE,
	input logic [1:0] BranchE,
	input logic ResultSrcE,
	input logic [2:0] ALUControlE,
	input logic [18:0] RD1E, RD2E, ImmExtE,
	input logic [14:0] PCE,
	input logic [4:0] RDE,
	input logic Cant_ByteE,

	//input logic [1:0] ForwardA_E, ForwardB_E,  (Hazard)
	output logic PCSrcE, RegWriteM, MemWriteM, 
	output logic ResultSrcM,
	output logic [4:0]  RDM, 
	output logic [18:0] WriteDataM, ALUResultM,
	output logic [14:0] PCTargetE,
	output logic Cant_ByteM
);


	//Valores intermedios

	logic [18:0]  SrcB;   //SrcA, //SrcB_intermedio,
	logic [18:0] ResultE;
	logic ZeroE, OverFlowE,NegativeE;
	logic [2:0] ALUFlags;


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
		.a(RD2E),
		.b(ImmExtE),
		.s(ALUSrcE),
		.c(SrcB)
	);


	ALU alu (
		.A(RD1E),
		.B(SrcB),
		.Result(ResultE),
		.ALUControl(ALUControlE),
		.ALUFlags(ALUFlags)
	);


	Adder branch_adder (
		.a(PCE),
		.b(ImmExtE[14:0]),
		.c(PCTargetE)
	);

	
	always @(posedge clk) begin
		if (BranchE == 2'b00)begin
			ZeroE <= ALUFlags[2];
			OverFlowE <= ALUFlags[1];
			NegativeE <= ALUFlags[0]; 

		end
	end
				
				
	// Logica de registros de execute

	always @(posedge clk or negedge reset) begin
		if(reset == 1'b0) begin
			execute_reg <= 47'h0;

		end
		else begin

			execute_reg [0] <= RegWriteE; 
			execute_reg [1] <= MemWriteE; 
			execute_reg [2] <= ResultSrcE;
			execute_reg [7:3] <= RDE; 
			execute_reg [26:8] <= RD2E; 
			execute_reg [45:27] <= ResultE;
			execute_reg [46] <= Cant_ByteE;
		end
	end

 
	// Asignación de puertos de salida 

	assign RegWriteM = execute_reg [0];
	assign MemWriteM = execute_reg [1];
	assign ResultSrcM = execute_reg [2];
	assign RDM = execute_reg [7:3];
	assign WriteDataM = execute_reg [26:8];  
	assign ALUResultM = execute_reg [45:27];
	assign Cant_ByteM = execute_reg [46];

	//Condiciones de Salto 
	assign PCSrcE = (ZeroE && BranchE[0] && BranchE[1])? 1'b1:   //SPE
					(~(NegativeE ^ OverFlowE) && ~(BranchE[1]) && BranchE[0])? 1'b1:  //SMAE
					((NegativeE ^ OverFlowE) && BranchE[1] && ~(BranchE[0]))? 1'b1:   //SMEE
					(JumpE)? 1'b1: 1'b0;    //SAP


endmodule