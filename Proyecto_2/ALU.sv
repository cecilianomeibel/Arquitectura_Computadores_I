module ALU(
     input logic [18:0] A,B,
	  input logic [2:0] ALUControl, 
	  output logic [18:0] Result,
	  output logic [2:0] ALUFlags
);
    
	 parameter N=19;
    logic [18:0] Result1,Residuo;
	 
	 
	 Div #(N) div(
	 .divisor(B),
	 .dividendo(A),
	 .residuo(Residuo),
	 .resultado(Result1)
	 );
	  
	 
    always @(*) begin
        case (ALUControl)
            3'b000: begin  // SUM   //Orden (Z,O,N)
                Result = A + B;
                ALUFlags = {Result == 0,(A[18] ^ B[18]) && (Result[18] ^ B[18]), Result[18]};
            end
            3'b001: begin  // RES
                Result = A - B;
                ALUFlags = {Result == 0,(A[18] ^ B[18]) && (Result[18] ^ B[18]), Result[18]};
            end
            3'b010: begin  // MULT
                Result = A * B;
                ALUFlags = {Result == 0,(A[18] ^ B[18]) && (Result[18] ^ B[18]), Result[18]};
            end
            3'b011: begin  // DIV
		         Result = Result1;
               ALUFlags = {Result == 0,(A[18] ^ B[18]) && (Result[18] ^ B[18]), Result[18]};
            end
            3'b100: begin  // MOD
                Result = Residuo;
                ALUFlags = {Result == 0,(A[18] ^ B[18]) && (Result[18] ^ B[18]), Result[18]};
            end
            3'b101: begin  // CLI
                Result = A << B;
                ALUFlags = {Result == 0,(A[18] ^ B[18]) && (Result[18] ^ B[18]), Result[18]};
            end
				3'b110: begin  //TRFI  
                Result = B;
                ALUFlags = {Result == 0,(1'b0 ^ B[18]) && (Result[18] ^ B[18]), Result[18]};
			   end		 
            default: begin  // Opcode not implemented
                Result = 19'bx;
                ALUFlags = 3'b000;
            end
        endcase
    end

endmodule 