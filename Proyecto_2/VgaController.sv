module VgaController(
	input logic vgaclk,
	output logic hsync,
	output logic vsync,
	output logic vga_sync,
	output logic vga_blank,
	output logic [9:0] counter_H, 
	output logic [9:0] counter_V	
);
	// horizontal
	parameter HACTIVE = 10'd640;
	parameter HFP = 10'd16;
	parameter HSYN = 10'd96;
	parameter HBP = 10'd48;
	parameter HMAX = HACTIVE + HFP + HSYN + HBP;
	// vertical
	parameter VBP = 10'd32;
	parameter VACTIVE = 10'd480;
	parameter VFP = 10'd11;
	parameter VSYN = 10'd2;
	parameter VMAX = VACTIVE + VFP + VSYN + VBP;
	
	
	always @(posedge vgaclk) begin
	
		if (counter_H == HMAX) begin
		
			counter_H = 0;
			if (counter_V == VMAX) begin
				counter_V = 0;
			end
			else begin
				counter_V = counter_V + 1'b1;
			end
		end
		else begin
			counter_H = counter_H + 1'b1;
		
		end
		
	end
	
	// Compute sync signals (active low)
	assign hsync = ~((counter_H >= HACTIVE + HFP) && (counter_H < HACTIVE + HFP + HSYN));
	assign vsync = ~((counter_V >= VACTIVE + VFP) && (counter_V < VACTIVE + VFP + VSYN));
	assign vga_sync = hsync & vsync;
	
	// Force outputs to blacounteHck when outside the legal display area
	assign vga_blank = (counter_H < HACTIVE) & (counter_V < VACTIVE);
		
endmodule