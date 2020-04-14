// ASynch. Reset
module Register #(parameter DATA_WIDTH = 32) 
            (input RST, 
            input CLK,
            input enable,
            input [DATA_WIDTH - 1 :0] D,
            output reg [DATA_WIDTH - 1 :0] Q);

    always @(posedge CLK or RST)
        if (RST)
            Q = 0;
        else if (enable)
            Q = D;
endmodule 
    
