module PC (
    input logic clk,reset,
	 input [31:0] pc,
	 output [31:0] pc_next,
	 reg [31:0] pc   
);

   always @(posedge clk)
   begin
        if(reset == 1'b0)
            pc <= {32{1'b0}};
        else
            pc <= pc_next;
   end
	 
endmodule