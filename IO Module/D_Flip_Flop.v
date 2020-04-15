module DFlipFlop(input D,
                 input CLK,
                 input RST,
		 input Enable,
                 output reg Q);
    
    always @(posedge CLK)
    begin
        if (RST == 1'b1)
            Q <= 1'b0;
        else if (Enable == 1)
            Q <= D;
    end
endmodule
