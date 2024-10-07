module PC (
    input logic clk,reset,
	 input logic [31:0] pc,
	 output logic [31:0] pc_next 
);
   reg [31:0] pc_reg; 
	
   always @(posedge clk)
   begin
        if(reset == 1'b0)
            pc_reg <= {32{1'b0}};
        else
            pc_reg <= pc;
   end
	assign pc_next = pc_reg;
	
endmodule