module PC (
    input logic clk,reset,
	 input logic [11:0] pc,
	 output logic [11:0] pc_next 
);
   reg [11:0] pc_reg; 
	
   always @(posedge clk)
   begin
        if(reset == 1'b0)
            pc_reg <= {12{1'b0}};
        else
            pc_reg <= pc;
   end
	assign pc_next = pc_reg;
	
endmodule