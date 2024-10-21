module pll(
	input logic clk,
	input logic reset, 
	output logic vgaclk
);
		
	always @(posedge clk or negedge reset) begin
		if (reset == 1'b0) begin
			vgaclk <= 0;
		end 
		else begin
			vgaclk <= ~vgaclk;
		end
	end
	
endmodule 