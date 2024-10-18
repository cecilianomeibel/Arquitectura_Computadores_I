////////////////////////////////////////////////////////////////////////////////
//
// By: Jatin Kumar Mandav
// 
// Module: Stimulus Division
// 
// Description: Stimulus or Test Bench for Division.v
//
////////////////////////////////////////////////////////////////////////////////

module division_tb();
	
	parameter N = 19;
	
	// Inputs
	reg [N-1:0] divisor;
	reg [N-1:0] dividend;

	// Outputs
	wire [N-1:0] remainder;
	wire [N-1:0] result;

	// Instantiate the Unit Under Test (UUT)
	division #(N) uut (
		.divisor(divisor), 
		.dividendo(dividend), 
		.resultado(result),
		.residuo(remainder)
	);

	initial begin
		// Initialize Inputs
		//divisor = 13;
		//dividend = 28;

		// Wait 100 ns for global reset to finish
		//#10;
        
		// Add stimulus here
		//divisor = 5;
		//dividend = 25;
		
		//#10;
		//divisor = 6;
		//dividend = 37;
	
		dividend = 25;
		divisor = 5;
		
		#10;
		
	end
endmodule
