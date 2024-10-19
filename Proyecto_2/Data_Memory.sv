
module Data_Memory(
	input logic clk,reset,
	input logic [3:0] cuadrante,
	input logic [18:0] A,WD, // dirección y dato a escribir en la dirección A
	input logic WE,   // enable de escritura en memoria
	input logic Cant_Byte,
	output logic [18:0] RD,
	output logic [7:0] pixel
); 

	logic [18:0] address_a;
	logic [18:0] address_b;
	logic [1:0] byteena_a;
	logic [1:0] byteena_b;
	logic [15:0] data_a;
	logic [15:0] data_b;
	logic wren_a;
	logic wren_b;
	logic [15:0] q_a;
	logic [15:0] q_b;
	logic [1:0] bytes_select_a;
	logic [1:0] bytes_select_b;
	
	// Variables intermedias
	logic [15:0] RD_temp;
	logic [15:0] pixel_temp;
	logic [18:0] A_temp;
	logic [15:0] WD_temp;
	
	// Cant_Byte = 1 --> 2 bytes 
	// Cant_Byte = 0 --> 1 byte
	assign bytes_select_a = (Cant_Byte && ~A[0])? 2'b11: // Escribir 2 bytes en una direcc. multiplo de 2
						  (A[0])? 2'b10: // Escribir 2 bytes o 1 en una direcc. no multiplo de 2
						  2'b01; // Escribir 1 byte en una dirección multiplo de 2
						  
	assign WD_temp = (~A[0])? WD[15:0]: {WD[7:0], 8'h0};
					 
	RAM ram(
		.address_a({1'b0, A[18:1]}),
		.address_b(19'h0),				// direccion que viene del vga
		.byteena_a(bytes_select_a),		// bytes a escribir
		.byteena_b(2'b01),
		.clock(clk),
		.data_a(WD_temp),
		.data_b({12'h0,cuadrante}),		// no se puede escribir en este puerto pues la vga estará leyendo en puerto B
		.wren_a(WE),
		.wren_b(1'b0),					// en el puerto B nunca se escribe, solo se lee
		.q_a(RD_temp),
		.q_b(pixel_temp)
	);
	
	always @(*) begin
		
		// se determina el o los bytes que se deben sacar de memoria (segun la instrucción)
		RD <= (Cant_Byte && ~A[0])? {3'h0, RD_temp}: 
				(A[0])? {11'h0,RD_temp[15:8]}: {11'h0,RD_temp[7:0]};
				
		pixel <= pixel_temp[7:0]; // pixel buscado por la vga
	end
	
endmodule
