module Vga_adress (
	input logic [9:0] x,
	input logic [9:0] y,
	input logic interpolacion,
	input logic [15:0] dimensiones,
	output logic [10:0] DataAdr_out
	
);		
	logic [9:0] desplazamiento_horizontal;
	
	
	logic enable_plus_adress;
	logic [9:0] contador_char_vertical;
	//logic [9:0] contador_char_horizontal;
	
	/*
	initial begin
		contador_char_vertical = '0;
		DataAdr = '0;	
		enable_plus_adress = 0;
		desplazamiento_horizontal = 0;
	
	end
	
	//((x > 144 && y > 34) && (x < 785 && y < 515) && enable_plus_adress) begin
	
	
	
	// 145 + 80*8 = 784
	always @(x,y) begin
		
		if() begin
		
		
		end
		else if ((x > 144 && y > 34) && (x < 785 && y < 515) && enable_plus_adress) begin
			
			DataAdr = ((x-145)/8) + desplazamiento_horizontal;
			
		end
		
		else if(contador_char_vertical == 7 && x >= 786 && enable_plus_adress) begin
			contador_char_vertical = '0;
			desplazamiento_horizontal = desplazamiento_horizontal + 80;
		
		end
		
		else if(x == 785 && (y > 34 && y < 515) && enable_plus_adress) begin
			contador_char_vertical = contador_char_vertical + 1;
		end
		else begin
			desplazamiento_horizontal = '0;
		end
		
		if(x == 144 && y == 35) begin
			enable_plus_adress = 1;
		
		end
		

	end
	
	assign DataAdr_out = DataAdr;
	*/
	
endmodule