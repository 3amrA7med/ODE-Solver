module DFlipFlop(input D,
                 input CLK,
                 input RST,
		 input Enable,
                 output reg Q);
    
    always @(posedge CLK)
    begin
        if (RST)
            Q <= 1'b0;
        else if (Enable)
            Q <= D;
    end
endmodule
