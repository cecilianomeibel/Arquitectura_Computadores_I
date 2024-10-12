module PC (
    input logic clk,reset,
	 input logic [14:0] pc,
	 output logic [14:0] pc_next 
);
   reg [14:0] pc_reg; 
	
   always @(posedge clk)
   begin
        if(reset == 1'b0)
            pc_reg <= {15{1'b0}};
        else
            pc_reg <= pc;
   end
	assign pc_next = pc_reg;
	
endmodule