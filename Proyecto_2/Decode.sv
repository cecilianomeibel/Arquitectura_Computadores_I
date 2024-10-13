module Decode (
       input logic clk, reset, 
		 input logic RegWriteW,
		 input logic [19:0] InstrD,          //Tamaño de instrucción
		 input logic [18:0] ResultW,        //Tamaño de registro
		 input logic [14:0] PCD,
		 input logic [4:0] RdW,            //Son 19 registros, 19 bits es 2^5
		 
		 output logic RegWriteE,MemWriteE,JumpE,BranchE,ALUSrcE,
		 output logic [1:0] ResultSrcE ,
       output logic [2:0] ALUControlE,            //Toma los 3 bits de operación en el opcode
       output logic [18:0] RD1E, RD2E,ImmExtE,   //Registros fuentes, inmediato
       //output [4:0] RS1E, RS2E,         //RS1E Y RS2E PARA EL HAZARD *****
       output logic [14:0] PCE,
		 output logic [4:0] RDE   //Destino
);     
         
       logic RegWriteD,MemWriteD,JumpD,BranchD,ALUSrcD;
		 logic [1:0] ResultSrcD;
       logic [2:0] ALUControlD;                 //Toma los 3 bits de operación en el opcode (intermedio)
		 logic [1:0] ImmSrcD;                    //Enable de Extend
		 logic [18:0] RD1D, RD2D, ImmExtD;      //Registros fuentes, inmediato (intermedios)
       

		 //Registro de Decode
		 reg [86:0] decode_reg;
		 
		
		//Se llaman los módulos que componen a Decode
		
		Control_Unit control_unit (
		   .Opcode(InstrD[4:0]),    //conformado por categoría y operación
			.RegWrite(RegWriteD),
			.ResultSrc(ResultSrcD),
			.MemWrite(MemWriteD),
			.Jump(JumpD),
			.Branch(BranchD),
			.ALUControl(ALUControlD),
			.ALUSrc(ALUSrcD),
			.ImmSrc(ImmSrcD));
		
		
		Register_File register_file(
		   .clk(clk),
			.reset(reset),
		   .a1(InstrD[14:10]),   //Rf1 registro fuente1
			.a2(InstrD[19:15]),  //Rf2 registro fuente2
			.a3(RdW),           // Señal de WB (en cual se va a escribir)
			.wd3(ResultW),
			.we3(RegWriteW),
			.rd1(RD1D),
			.rd2(RD2D)
		);
		
		
		Extend extend(
			.In(InstrD[19:5]),     //Tamaño por instrucción control de flujo
			.ImmSrc(ImmSrcD),
			.ImmExt(ImmExtD)
		);
		
		
		// Decode Stage Registers
		
      always @(posedge clk or negedge reset) begin
        if(reset == 1'b0) begin
            decode_reg <= 87'h0;

        end
        else begin
            decode_reg[0]<= RegWriteD;
				decode_reg[1] <= MemWriteD;
				decode_reg[2] <= JumpD;
				decode_reg[3] <= BranchD;
            decode_reg[4] <= ALUSrcD;
            decode_reg[6:5] <= ResultSrcD; 
            decode_reg[9:7] <= ALUControlD;
            decode_reg[28:10] <= RD1D; 
            decode_reg[47:29] <= RD2D; 
            decode_reg[66:48] <= ImmExtD;
				decode_reg[81:67] <= PCD;
				decode_reg[86:82] <= InstrD[9:5]; //RDD
				   
        end
    end

	 
    // Asignación de puertos de salida 
    assign RegWriteE = decode_reg[0];
	 assign MemWriteE = decode_reg[1];
	 assign JumpE = decode_reg[2];
	 assign BranchE = decode_reg[3];
    assign ALUSrcE = decode_reg[4];
    assign ResultSrcE = decode_reg[6:5];
    assign ALUControlE = decode_reg[9:7];
	 assign RD1E = decode_reg[28:10];
    assign RD2E = decode_reg[47:29];
	 assign ImmExtE = decode_reg[66:48];
    assign PCE = decode_reg[81:67]; 
    assign RDE = decode_reg[86:82];

endmodule 

