module Register_File (
	input logic clk,reset,
	input logic [4:0] a1,a2,a3,     //Número de Rf1,Rf2,Rd
	input logic we3,               // Señal de WB (en cual se va a escribir) RegWriteW
	input logic [18:0] wd3,       //ResultW
	output logic [18:0] rd1,rd2  //Tamaño de registros fuentes
);
        
	reg [18:0] Register [19:0];   //Tamaño de registro 19 bits, cant registros 19 (2^5)

	always @(posedge clk) begin
		if(we3 && (a3 != 5'h0) && (a3 != 5'h13)) begin //se definen registros "intocables" el L0 (#0) y PC (#19)
			Register[a3] <= wd3;
		end
	end

	assign rd1 = (reset==1'b0) ? 19'd0 : Register[a1];
	assign rd2 = (reset==1'b0) ? 19'd0 : Register[a2];

	initial begin
		Register[0] = 19'h0;
	end
	
endmodule 