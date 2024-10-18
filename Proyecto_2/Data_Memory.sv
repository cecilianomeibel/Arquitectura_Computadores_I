
module Data_Memory(
	input logic clk,reset,
	input logic [3:0] cuadrante,
	input logic [18:0] A,WD, // dirección y dato a escribir en la dirección A
	input logic WE,   // enable de escritura en memoria
	input logic Cant_Byte,
	output logic [18:0] RD,
	output logic [7:0] pixel
); 
	//reg [63:0] mem [500:0];   //389 mil aproximadamente, por eso el 2^19
	
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
	logic [1:0] bytes_select;
	
	// Variables intermedias
	logic [15:0] RD_temp;
	logic [15:0] pixel_temp;
	logic [18:0] A_temp;
	
	// Cant_Byte = 1 --> 2 bytes 
	// Cant_Byte = 0 --> 1 byte
	assign bytes_select = (Cant_Byte && ~A[0])? 2'b11: 2'b01;
	assign A_temp = (A[0] && ~WE)? {A[18:1], 1'b0}: A;

	RAM ram(
		.address_a(A_temp),
		.address_b(19'h0),
		.byteena_a(bytes_select),  // bytes a escribir
		.byteena_b(2'b01),
		.clock(clk),
		.data_a(WD[15:0]),
		.data_b({12'h0,cuadrante}),
		.wren_a(WE),
		.wren_b(1'b1),
		.q_a(RD_temp),
		.q_b(pixel_temp)
	);
	
	
	assign RD = (Cant_Byte && ~A[0])? RD_temp: 
				(~Cant_Byte && A[0])? {11'h0,RD_temp[15:8]}: {11'h0,RD_temp[7:0]};
				
	//assign RD = {2'h0, RD_temp};
	assign pixel = pixel_temp[7:0];
	

endmodule



/*
module Data_Memory(
	input logic clk,reset,
	input logic [3:0] cuadrante,
	input logic [18:0] A,WD,
	input logic WE,
	input logic Cant_Byte,
	output logic [18:0] RD
); 
	reg [63:0] mem [500:0];   //389 mil aproximadamente, por eso el 2^19
	
	
	
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
		
		mem[19'h0] <= {15'h0,cuadrante};
		
    end

	assign RD = (~reset) ? 19'd0 : (Cant_Byte)? {3'h0,mem[A[18:1]]}: 
				(~A[0])? {12'h0,mem[A[18:1]][7:0]}: {12'h0,mem[A[18:1]][15:8]};

	initial begin
		mem[0] = 16'h0;
	end

endmodule
*/