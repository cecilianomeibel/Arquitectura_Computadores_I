module Data_Memory(
	input logic clk,reset,
	input logic [3:0] cuadrante,
	input logic [18:0] A,WD,
	input logic WE,
	input logic Cant_Byte,
	output logic [18:0] RD
); 
	reg [15:0] mem [18:0];   //389 mil aproximadamente, por eso el 2^19

	always @ (posedge clk) begin
	
		if(WE && Cant_Byte == 1'b0 && ~A[0]) begin          //Tomar 1 byte
			mem[A[18:1]][7:0] <= WD[7:0];
			
		end	 
		
		else if(WE && Cant_Byte == 1'b0 && A[0]) begin  //Tomar 1 byte
			mem[A[18:1]][15:8] <= WD[7:0];
			
		end	
		else if (WE && Cant_Byte == 1'b1) begin
			mem[A[18:1]] <= WD[15:0];             //Tomar 2 bytes
		
		end
		
		mem[19'h4] <= cuadrante;
		
    end

	assign RD = (~reset) ? 19'd0 : (Cant_Byte)? {4'h0,mem[A[18:1]]}: 
				(~A[0])? {12'h0,mem[A[18:1]][7:0]}: {12'h0,mem[A[18:1]][15:8]};

	initial begin
		mem[0] = 16'h0;
	end

endmodule