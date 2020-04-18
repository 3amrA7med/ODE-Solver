module TFlipFlop(input T,
                 input CLK,
                 input RST,
		 input Enable,
                 output reg Q);
    
    	always @(posedge CLK)
    	begin
        	if (RST)
            		Q <= 1'b0;
    		else if (T && Enable) 
          		Q <= ~Q;
      		else
          		Q <= Q;
  		
    	end
endmodule