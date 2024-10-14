
module Div #(parameter N = 19)(divisor, dividendo, residuo, resultado);
   
	input logic [N-1:0] divisor, dividendo;
	output logic [N-1:0] resultado, residuo;

	// Variables
	integer i;
	logic [N-1:0] divisor_temp, dividendo_temp;
	logic [N-1:0] temp;

	always @(divisor or dividendo)
	begin
		divisor_temp = divisor;
		dividendo_temp = dividendo;
		temp = 0; 
		for(i = 0;i < N;i = i + 1)
		begin
			// Se desplaza el residuo temporal a la izquierda una vez, se concatena el bit mas significativo del dividendo temp
			// Construcción progresiva del residuo de la división
			temp = {temp[N-2:0], dividendo_temp[N-1]};
			
			// Se desplaza el dividendo en 1 para ir construyendo el cociente
			dividendo_temp = dividendo_temp << 1;
			
			
			// Resta el divisor del residuo temporal y lo coloca en el residuo temporal
			temp = temp - divisor_temp;
			
			// Compara el signo del residuo temporal (si la resta es valida o no)
			if(temp[N-1] == 1)
				begin
				
					// Se coloca cero en el último bit
					dividendo_temp[0] = 0;
					
					// se restaura el residuo temporal sumandole el divisor
					temp = temp + divisor_temp;
				end
			else
				begin
					//Desplazar el bit cuantitativo hacia la izquierda, establecer el bit más a la derecha en 1.
					dividendo_temp[0] = 1;
				end
		end
		
		resultado = dividendo_temp;
		residuo = dividendo - (divisor_temp*dividendo_temp);
	end
endmodule