module Hazard(

    input reset, RegWriteM, RegWriteW,   //Señal que indica si se está escribiendo en un registro en Mem o WB
    input [4:0] RDM, RDW, RS1E, RS2E,    //RDM, RDW registro destino,
    output [1:0] ForwardA_E, ForwardB_E
   
);
    
	 //10 Forwarding desde la etapa de memoria
	 //01 Forwarding desde la etapa de writeback

	 
	 //Señal que indica el forwarding para el primer operando en la etapa de ejecución
	 
    assign ForwardA_E = (reset == 1'b0) ? 2'b00 :   //sin forwarding
                       ((RegWriteM == 1'b1) & (RDM != 5'h00) & (RDM == RS1E)) ? 2'b10 :
                       ((RegWriteW == 1'b1) & (RDW != 5'h00) & (RDW == RS1E)) ? 2'b01 : 2'b00;
                   
	 //Señal que indica el forwarding para el segundo operando en la etapa de ejecución.			 
    assign ForwardB_E = (reset == 1'b0) ? 2'b00 :   //sin forwarding
                       ((RegWriteM == 1'b1) & (RDM != 5'h00) & (RDM == RS2E)) ? 2'b10 :
                       ((RegWriteW == 1'b1) & (RDW != 5'h00) & (RDW == RS2E)) ? 2'b01 : 2'b00;

endmodule