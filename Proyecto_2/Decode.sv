module Decode (
       input logic clk, reset, 
		 input RegWriteW,
		 input [16:0] InstrD,          //Tamaño de instrucción
		 input [18:0] ResultW,        //Tamaño de registro
		 input [11:0] PCD,PCPlus1D,
		 input [4:0] RdW,            //Son 19 registros, 19 bits es 2^5
		 
		 output RegWriteE,MemWriteE,JumpE,BranchE,ALUSrcE,
		 output ResultSrcE [1:0],
       output [2:0] ALUControlE,            //Toma los 3 bits de operación en el opcode
       output [18:0] RD1E, RD2E,ImmExtE,   //Registros fuentes, inmediato
       //output [4:0] RS1E, RS2E,         //RS1E Y RS2E PARA EL HAZARD *****
       output [11:0] PCE, PCPlus1E
		 output [18:0] RDE
);     
         
       logic RegWriteD,MemWriteD,JumpD,BranchD,ALUSrcD;
		 logic [1:0] ResultSrcD;
       logic [2:0] ALUControlD;                 //Toma los 3 bits de operación en el opcode (intermedio)
		 logic [1:0] ImmSrcD;                    //Enable de Extend
		 logic [18:0] RD1D, RD2D, ImmExtD; //Registros fuentes, inmediato (intermedios)
       

		 //Registro de Decode
		 reg [111:0] decode_reg;
		 
		
		//Se llaman los módulos que componen a Decode
		
		Control_Unit control_unit (
		   .Opcode(InstrD[4:0]),    //conformado por categoría y operación
			.RegWrite(RegWriteD),
			.ResultSrc(ResultSrcD),
			.MemWrite(MemWriteD),
			.Jump(JumpD),
			.Branch(BranchD),
			.AluControl(AluControlD),
			.AluSrc(AluSrcD),
			.ImmSrc(ImmSrcD));
		
		
		Register_File register_file(
		   .clk(clk),
			.reset(reset),
		   .a1(InstrD[12:9]),   //Rf1 registro fuente1
			.a2(InstrD[16:13]),  //Rf2 registro fuente2
			.a3(RdW),           // Señal de WB (en cual se va a escribir)
			.wd3(ResultW),
			.we3(RegWriteW),
			.rd1(RD1D),
			.rd2(RD2D)
		);
		
		
		Extend extend(
		   .ImmExt(ImmExtD),
			.In(InstrD[16:5]),     //Tamaño por instrucción dontrol de flujo
			.ImmSrc(ImmSrcD)
		);
		
		
		// Decode Stage Registers
		
      always @(posedge clk or negedge reset) begin
        if(reset == 1'b0) begin
            decode_reg <= 112'h0;

        end
        else begin
            decode_reg[0]<= RegWriteD;
				decode_reg[1] <= MemWriteD;
				decode_reg[2] <= JumpD;
				decode_reg[3] <= BranchD;
            decode_reg[4] <= ALUSrcD;
            decode_reg[6:5] <= ResultSrcD; 
            decode_reg[9:7] <= ALUControlD;
				decode_reg[11:10] <= ImmSrcD;
            decode_reg[30:12] <= RD1D; 
            decode_reg[49:31] <= RD2D; 
            decode_reg[68:50] <= ImmExtD;
				decode_reg[80:69] <= PCD;
				decode_reg[92:81] <= PCPlus1D;
				decode_reg[111:93] <= InstrD[8:5];   //RDD
        end
    end

	 
    // Asignación de puertos de salida 
    assign RegWriteE = decode_reg[0];
	 assign MemWriteE = decode_reg[1];
	 assign JumpE = decode_reg[2];
	 assign BranchE = decode_reg[3];
    assign ALUSrcE = decode_reg[4];
    assign ResultSrcE =  decode_reg[6:5];
    assign ALUControlE = decode_reg[9:7];
	 assign RD1E = decode_reg[30:12];
    assign RD2E = decode_reg[49:31];
	 assign ImmExtE = decode_reg[68:50];
    assign PCE = decode_reg[80:69]; 
    assign PCPlus4E = decode_reg[92:81];
	 assign RDE = decode_reg [111:93];

endmodule 

