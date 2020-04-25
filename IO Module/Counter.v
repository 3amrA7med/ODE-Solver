module Counter #(parameter VALUE_WIDTH = 8)
               (output [VALUE_WIDTH - 1 :0] value,
		input Enable,
                input CLK,
                input RST);
	
	genvar i;
	// Inputs wire "i" are the input to T flip flop number i
	wire [VALUE_WIDTH - 1 :0]inputs;
	// First T flip flop connected directly to the enable 
	TFlipFlop  firstBit (Enable, CLK, RST, Enable, value[0]);  
	assign inputs[0] = Enable; 
	// Generate T flip flops equivalent to the value width - 1
	generate
		for(i=1; i<VALUE_WIDTH; i=i+1) begin 
			// Input of the T flip flop is the anding between the previous input and the previous output
			and andInputs(inputs[i],inputs[i-1],value[i-1]);
			TFlipFlop  counterBits (inputs[i], CLK, RST, Enable, value[i]);
		end
	endgenerate
endmodule
