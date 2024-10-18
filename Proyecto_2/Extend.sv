module Extend (
       
		   input logic [14:0] In,         //Tamaño por instrucción control de flujo
			input logic [1:0]	ImmSrc,     //Enable de Extend
			output logic [18:0] ImmExt   //Tamaño de inmediato
		);
		
		assign ImmExt =  (ImmSrc == 2'b00) ? 19'h0:                //No se usa
                        (ImmSrc == 2'b01) ? {14'h0,In[14:10]}:  // Ext de AR
								(ImmSrc == 2'b10) ? {9'h0,In[14:5]}:   // Ext de TD
								(ImmSrc == 2'b11) ? In[14:0]:19'h0;   //Ext de CF
endmodule