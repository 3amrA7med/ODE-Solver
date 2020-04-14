
module Counter #(parameter VALUE_WIDTH = 8,
                parameter RESET_VALUE_WIDTH = 8)
                (output reg [VALUE_WIDTH - 1 :0] value,
                 input Enable,
                 input CLK,
                 input RST,
		 input [RESET_VALUE_WIDTH - 1 :0] Start_Reset_Value,
                 input UP_DOWN);
    
    
    always @(posedge(CLK))
    begin
        if (RST == 1)
            value = 0;
        else begin
            if (UP_DOWN == 1 && Enable == 1)  begin
                if (value == Start_Reset_Value) begin
                    value = 0;
                end
                else begin
                    value = value + 1; //Incremend Counter
                end
            end 
            else if (UP_DOWN == 0 && Enable == 1) begin
                if (value == 0) begin
                    value = Start_Reset_Value;
                end
                else begin
                    value = value - 1; //Decrement counter
                end  
            end   
        end
    end
endmodule
