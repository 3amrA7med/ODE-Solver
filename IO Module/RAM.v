module RAM #(parameter ADDRESS_WIDTH = 13,
             parameter DATA_WIDTH = 64,
             parameter DEPTH = 16)
            (input CLK,
             input RST,
             input WR_Enable,
             input [ADDRESS_WIDTH - 1 :0] address_RD1,
             input [ADDRESS_WIDTH - 1 :0] address_RD2,
             input [ADDRESS_WIDTH - 1 :0] address_WR,
             output reg [DATA_WIDTH - 1 :0] dataOut1,
             output reg [DATA_WIDTH - 1 :0] dataOut2,
             input [DATA_WIDTH - 1 :0] dataIn);
    
    reg [DATA_WIDTH - 1 :0]  Memory[0: DEPTH];
    integer i;
    always @(posedge CLK) begin
        if (~RST) begin
            if (WR_Enable) begin
                Memory[address_WR] = dataIn;
            end
        end
        else begin
            for (i = 0 ;i < DEPTH; i = i + 1)
                 Memory[i] <= 0;
        end
        
    end

    always @(negedge CLK) begin
	if (~RST) begin
            dataOut1 = Memory[address_RD1];
            dataOut2 = Memory[address_RD2];
        end
    end
    
    
endmodule
    
