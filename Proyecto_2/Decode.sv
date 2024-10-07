/*module Decode (
       input logic clk, reset, 
		 input RegWrite,
		 input [31:0] InstrD,PCD,PCPlus4D,ResultW,
		 input [4:0] RDW
);     
      
		//Se llaman los módulos que componen a Decode
		
		Control_Unit control_unit (
		   .op(),
			.RegWrite(),
			.ResultSrc(),
			.MemWrite(),
			.Jump(),
			.Branch(),
			.AluControl(),
			.ImmSrc());
		
		
		Register_File register_file(
		   .a1(),
			.a2(),
			.a3(),
			.wd3(),
			.we3(),
			.rd1(),
			.rd2()
		);
		
		
		
		Extend extend(
		   
		
		);
		
		
		// Decode Stage Registers
		
		

endmodule 
*/
