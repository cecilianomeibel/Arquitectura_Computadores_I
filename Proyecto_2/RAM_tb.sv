`timescale 1 ps / 1 ps
module RAM_tb();

	logic clk;
	logic	[18:0]  address_a;
	logic	[18:0]  address_b;
	logic	[1:0]  byteena_a;
	logic	[1:0]  byteena_b;
	logic	[15:0]  data_a;
	logic	[15:0]  data_b;
	logic	  wren_a;
	logic	  wren_b;
	logic	[15:0]  q_a;
	logic	[15:0]  q_b;
	
	
	
	RAM ram_test(
		address_a,
		address_b,
		byteena_a,
		byteena_b,
		clk,
		data_a,
		data_b,
		
		wren_a,
		wren_b,
		q_a,
		q_b
	);
	
	
	always begin
	
		clk = ~clk; #10;

	end
	
	initial begin
		clk = 0;
		
		#10;
		/*
		address_a = 19'h0;
		data_a = 16'h00ff;
		byteena_a = 2'b01;
		wren_a = 1;
		
		#20;
		
		address_a = 19'h0;
		data_a = 16'heeaa;
		byteena_a = 2'b10;
		wren_a = 1;
		
		
		#20;
		*/
		address_a = 19'h0;
		byteena_a = 2'b11;
		wren_a = 0;
		
		#20;
		
		address_a = 19'h1;
		byteena_a = 2'b01;
		wren_a = 0;
		
		#20;
		
		$finish;
	end
endmodule