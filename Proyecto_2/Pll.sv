module pll(
	input logic clk,
	input logic reset, 
	output logic vgaclk
);
		
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			vgaclk <= 0;
		end 
		else begin
			vgaclk <= ~vgaclk;
		end
	end
	
endmodule 