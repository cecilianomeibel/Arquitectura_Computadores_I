module Control_Unit (
       input logic [4:0] Opcode,    
		 output logic RegWrite,ResultSrc,
		 output logic MemWrite,Jump,
		 output logic [1:0] Branch,
		 output logic [2:0] ALUControl,
		 output logic ALUSrc,
		 output logic [1:0] ImmSrc,
		 output logic Cant_Byte
);

	always @(*) begin
	case(Opcode)
	
	  //Aritméticas categoría 00

	  //SUM
		5'b00000:
			begin
			ImmSrc = 2'b00;           //Enable del Extend 00 (no se usa), 01 (exd AR), 10 (ext TD), 11(ext CF)
			ALUControl = 3'b000;     //Indicar cual operación en la ALU
			ResultSrc = 1'b0;      //mux_3_1 si es 00 de ALU, 01 de Memoria
			MemWrite = 1'b0;       //Enable de escritura en Memoria
			Jump = 1'b0;          //Jump
			Branch = 2'b00;       //Branch
			RegWrite = 1'b1;    //WriteBack
			ALUSrc = 1'b0;     //mux_2_1 si es 0 operación con 2 registros , si es 1 operación con 1 registro y un inmediato
			Cant_Byte = 1'b0;  // con 0 toma 1 byte, con 1 toma 2 bytes en memoria 
			end
			
		//SUMI
		5'b00001:
			begin
			ImmSrc = 2'b01;
			ALUControl = 3'b000;
			ResultSrc = 1'b0; 
			MemWrite = 1'b0;
			Jump = 1'b0;
			Branch = 2'b00;
			RegWrite = 1'b1;
			ALUSrc = 1'b1;
			Cant_Byte = 1'b0;  // con 0 toma 1 byte, con 1 toma 2 bytes en memoria 
			end
			
	   //RES
		5'b00010:
			begin
			ImmSrc = 2'b00;
			ALUControl = 3'b001;
			ResultSrc = 1'b0; 
			MemWrite = 1'b0;
			Jump = 1'b0;
			Branch = 2'b00;
			RegWrite = 1'b1;
			ALUSrc = 1'b0;
			Cant_Byte = 1'b0;  // con 0 toma 1 byte, con 1 toma 2 bytes en memoria 
			end
			
		//MULT
		5'b00011:
			begin
			ImmSrc = 2'b00;
			ALUControl = 3'b010;
			ResultSrc = 1'b0; 
			MemWrite = 1'b0;
			Jump = 1'b0;
			Branch = 2'b00;
			RegWrite = 1'b1;
			ALUSrc = 1'b0;
			Cant_Byte = 1'b0;  // con 0 toma 1 byte, con 1 toma 2 bytes en memoria 
			end
			
		//DIV
		5'b00100:
			begin
			ImmSrc = 2'b00;
			ALUControl = 3'b011;
			ResultSrc = 1'b0; 
			MemWrite = 1'b0;
			Jump = 1'b0;
			Branch = 2'b00;
			RegWrite = 1'b1;
			ALUSrc = 1'b0;
			Cant_Byte = 1'b0;  // con 0 toma 1 byte, con 1 toma 2 bytes en memoria 
			end
			
		//MOD 
		5'b00101:
			begin
			ImmSrc = 2'b00;
			ALUControl = 3'b100;
			ResultSrc = 1'b0; 
			MemWrite = 1'b0;
			Jump = 1'b0;
			Branch = 2'b00;
			RegWrite = 1'b1;
			ALUSrc = 1'b0;
			Cant_Byte = 1'b0;  // con 0 toma 1 byte, con 1 toma 2 bytes en memoria 
			end
			
		//CLI
		5'b00110:
			begin
			ImmSrc = 2'b01;
			ALUControl = 3'b101;
			ResultSrc = 1'b0; 	
			MemWrite = 1'b0;
			Jump = 1'b0;
			Branch = 2'b00;
			RegWrite = 1'b1;
			ALUSrc = 1'b1;
			Cant_Byte = 1'b0;  // con 0 toma 1 byte, con 1 toma 2 bytes en memoria 
			end
			
		//SUAVE 
		5'b00111:
			begin
			ImmSrc = 2'b00;
			ALUControl = 3'b000;   //SUM
			ResultSrc = 1'b0; 
			MemWrite = 1'b0;
			Jump = 1'b0;
			Branch = 2'b00;
			RegWrite = 1'b1;
			ALUSrc = 1'b0;
			Cant_Byte = 1'b0;  // con 0 toma 1 byte, con 1 toma 2 bytes en memoria 
			end
			
		//Transferencia de Datos, categoría 01
		//TRF (mv)
		5'b01000:
			begin
			ImmSrc = 2'b00;
			ALUControl = 3'b000;    //SUM
			ResultSrc = 1'b0;      //00 de ALU
			MemWrite = 1'b0;
			Jump = 1'b0;
			Branch = 2'b00;
			RegWrite = 1'b1;
			ALUSrc = 1'b0;      //2 registros
			Cant_Byte = 1'b0;  // con 0 toma 1 byte, con 1 toma 2 bytes en memoria 
			end
			
		//TRFI (li)
		5'b01001:
			begin
			ImmSrc = 2'b10;          //ext 10 de TD
			ALUControl = 3'b110;    //TRFI
			ResultSrc = 1'b0;      //00 de ALU
			MemWrite = 1'b0;
			Jump = 1'b0;
			Branch = 2'b00;
			RegWrite = 1'b1;
			ALUSrc = 1'b1;      //registro+inmediato
			Cant_Byte = 1'b0;  // con 0 toma 1 byte, con 1 toma 2 bytes en memoria 
			end
			
		//ALM (store)
		5'b01010:
			begin
			ImmSrc = 2'b00;
			ALUControl = 3'b111;   //ALM
			ResultSrc = 1'b0;     //00 ALU
			MemWrite = 1'b1;     
			Jump = 1'b0;
			Branch = 2'b00;
			RegWrite = 1'b0;     //no writeback
			ALUSrc = 1'b0;       //2 registros 
			Cant_Byte = 1'b1;  // con 0 toma 1 byte, con 1 toma 2 bytes en memoria 
			end
			
		//ALMB (store)
		5'b01011:
			begin
			ImmSrc = 2'b00;
			ALUControl = 3'b111;  //ALM
			ResultSrc = 1'b0;    //00 ALU
			MemWrite = 1'b1;
			Jump = 1'b0;
			Branch = 2'b00;
			RegWrite = 1'b0;      //no writeback
			ALUSrc = 1'b0;       //2 registros 
			Cant_Byte = 1'b0;   // con 0 toma 1 byte, con 1 toma 2 bytes en memoria 
			end 
			
		//LR (load)
		5'b01100:
			begin
			ImmSrc = 2'b00;
			ALUControl = 3'b000;   //SUM
			ResultSrc = 1'b1;    //1 memoria
			MemWrite = 1'b0;     //no escribe en memoria
			Jump = 1'b0;
			Branch = 2'b00;
			RegWrite = 1'b1;     //writeback
			ALUSrc = 1'b0;      //2 registros
			Cant_Byte = 1'b1;  // con 0 toma 1 byte, con 1 toma 2 bytes en memoria 
			end
			
		//LRB (load)
		5'b01101:
			begin
			ImmSrc = 2'b00;
			ALUControl = 3'b000;    //SUM
			ResultSrc = 1'b1;     //1 memoria
			MemWrite = 1'b0;      //no escribe en memoria
			Jump = 1'b0; 
			Branch = 2'b00;
			RegWrite = 1'b1;     //writeback
			ALUSrc = 1'b0;      //2 registros
			Cant_Byte = 1'b0;  // con 0 toma 1 byte, con 1 toma 2 bytes en memoria 
			end
			
		//Control de Flujo, categoría 10	
		//SAP
		5'b10000:
			begin
			ImmSrc = 2'b11;        //11 ext de CF
			ALUControl = 3'b000;  //En realidad no es suma
			ResultSrc = 1'b0;   //00 de ALU 
			MemWrite = 1'b0;
			Jump = 1'b1;        //salto 
			Branch = 2'b00;
			RegWrite = 1'b0;
			ALUSrc = 1'b1;
			Cant_Byte = 1'b0;  // con 0 toma 1 byte, con 1 toma 2 bytes en memoria 
			end
			
		//CMB
		5'b10001:
			begin
			ImmSrc = 2'b00;
			ALUControl = 3'b001;   //RES
			ResultSrc = 1'b0;    // Con ALU
			MemWrite = 1'b0;
			Jump = 1'b0;
			Branch = 2'b00;
			RegWrite = 1'b0;
			ALUSrc = 1'b0;      //Con 2 registros
			Cant_Byte = 1'b0;  // con 0 toma 1 byte, con 1 toma 2 bytes en memoria 
			end
			
		//SMAE
		5'b10010:
			begin
			ImmSrc = 2'b11;       //11 ext de CF
			ALUControl = 3'b000;
			ResultSrc = 1'b0;    //ALU
			MemWrite = 1'b0;
			Jump = 1'b0;
			Branch = 2'b01;
			RegWrite = 1'b0;
			ALUSrc = 1'b1;
			Cant_Byte = 1'b0;  // con 0 toma 1 byte, con 1 toma 2 bytes en memoria 
			end
			
		//SMEE
		5'b10011:
			begin
			ImmSrc = 2'b11;        //11 ext de CF
			ALUControl = 3'b000;
			ResultSrc = 1'b0;
			MemWrite = 1'b0;
			Jump = 1'b0;
			Branch = 2'b10;
			RegWrite = 1'b0;
			ALUSrc = 1'b1;
			Cant_Byte = 1'b0;  // con 0 toma 1 byte, con 1 toma 2 bytes en memoria 
			end
			
		//SPE
		5'b10100:
			begin
			ImmSrc = 2'b11;       //11 ext de CF
			ALUControl = 3'b000;
			ResultSrc = 1'b0;
			MemWrite = 1'b0;
			Jump = 1'b0;
			Branch = 2'b11;
			RegWrite = 1'b0;
			ALUSrc = 1'b1;
			Cant_Byte = 1'b0;  // con 0 toma 1 byte, con 1 toma 2 bytes en memoria 
			end
			
	 default: 
			begin  // Opcode not implemented
         ImmSrc = 2'bxx;      
			ALUControl = 3'bxxx;
			ResultSrc = 1'bx;
			MemWrite = 1'bx;
			Jump = 1'bx;
			Branch = 1'b1;
			RegWrite = 1'bx;
			ALUSrc = 1'bx;
			Cant_Byte = 1'bx;  // con 0 toma 1 byte, con 1 toma 2 bytes en memoria 
         end
	endcase
  end
endmodule