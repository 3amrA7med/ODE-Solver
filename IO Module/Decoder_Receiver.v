module Decoder_Receiver #(parameter ADDRESS_WIDTH = 13,
                          parameter DATA_WIDTH = 64)
                         (input RST,
                          input CLK,
                          input Loading_Enable,
                          input [31 :0] CPU_Bus,
                          output reg Done_Loading,
                          output reg Done_Packet,
                          output reg Done_Element,
                          output reg [ADDRESS_WIDTH - 1 :0] RAM_Address,
                          output reg [DATA_WIDTH - 1 :0] RAM_Data);
    
    reg Row_Done_Bit, Row_Last_Bit, Data_Bit, Start_Bit;
    // Flip Flop used to Dealy the Row Done Signal One Cycle 
    wire Row_Done_Bit_Temp;
    DFlipFlop  Temp (Row_Done_Bit, CLK, RST, Row_Done_Bit || (Row_Done_Bit_Temp && ~Done_Element ), Row_Done_Bit_Temp);
    // Flip Flop used to Dealy the Loading Enable Signal One Cycle 
    wire Real_Loading_Enable;
    DFlipFlop  RLE (Loading_Enable, CLK, RST, Loading_Enable, Real_Loading_Enable);
    // Register To Store The Data after Decoding
    // [Passed to Memory after Collecting 64 bits]
    reg [DATA_WIDTH - 1 :0] Decoded_Data;
    // Temp Registers Used to Manipulate Decoding Process
    reg [31: 0] Data_Size              = 0;
    reg [31: 0] Small_Packet_Data_Size = 0;
    reg [5: 0] Writing_Start_Index     = DATA_WIDTH - 1;
    reg [5: 0] Writing_Size            = 0;
    reg [5: 0] Small_Packet_Indication_Bit;
    
    // Counter Used to Start Data Receiving Process
    wire [1  :0] InitCount;
    Counter #(2, 2)   Init_Counter (InitCount, Real_Loading_Enable && (InitCount != 2), CLK, RST, 3, 1'b1);
    // Counter to Store Number of Received Rows
    wire [31 :0] RowsCount;
    Counter #(32, 32)  Rows_Counter (RowsCount, Row_Done_Bit && Start_Bit, CLK, RST, (2**32) - 1,  1'b1);
    // Two Registers To Store each Packet Size and Number of Rows in Input Data
    // [The two 1st Received Data From CPU]
    wire [5 :0] PacketSize = (InitCount == 0) ? CPU_Bus[5: 0] : PacketSize;
    wire [15 :0] RowsNum   = (InitCount == 1) ? CPU_Bus[15: 0] : RowsNum;
    // Counter Used to Count Number of Small Packets in each Received 32 bits
    // Down Counting as It's used to Index Received Packets Which
    // Must be indexed from Left to Right
    wire [3 : 0] SmallPacketsCount;
    Counter #(4, 5)   Row_Packets_Counter (SmallPacketsCount,
    ~Done_Element && (InitCount >= 1),
    CLK, RST, (32/PacketSize) - 1, 1'b0);

    integer i = 0;

    initial begin
        Start_Bit    = 0;
        Data_Bit     = 0;
        Row_Last_Bit = 0;
        Done_Element = 0;
	    Done_Loading = 0;
	    Small_Packet_Indication_Bit = 0;
        Done_Packet  = 1;
        Decoded_Data = {DATA_WIDTH {1'b0}};
        RAM_Data     = {DATA_WIDTH {1'b0}};
        RAM_Address  = -1;
    end
    
    always @(posedge CLK) begin
        Start_Bit    = (InitCount == 2) || Start_Bit;
       

        if (Start_Bit && ~Done_Loading) begin
            Done_Loading = (RowsCount == RowsNum);
	    Small_Packet_Indication_Bit = (PacketSize * (SmallPacketsCount + 1)) - 1;
            Row_Done_Bit = (CPU_Bus[Small_Packet_Indication_Bit] != Row_Last_Bit);
            Row_Last_Bit = Row_Done_Bit_Temp ? CPU_Bus[Small_Packet_Indication_Bit] : Row_Last_Bit;
            Done_Packet  = (SmallPacketsCount == 0) && ~Done_Element;

            if (~Done_Element) begin
		        for (i = 0; i < PacketSize - 1; i = i + 1) begin
                    Small_Packet_Data_Size[PacketSize - i - 2] =  CPU_Bus[Small_Packet_Indication_Bit - i - 1];
                end
                Data_Size              = Data_Size + Small_Packet_Data_Size;
                Data_Bit               = Row_Done_Bit_Temp ? Row_Last_Bit : ~Data_Bit;
            end
            
            if (Data_Size >= DATA_WIDTH) begin
                for (i = Writing_Start_Index; i >= 0; i = i - 1) begin
                    Decoded_Data[i] = Data_Bit;
                end
                Writing_Start_Index = DATA_WIDTH - 1;
                Data_Size           = Data_Size - DATA_WIDTH;
                RAM_Data            = Decoded_Data;
                RAM_Address         = RAM_Address + 1;
		        Done_Element        = 1;
            end
            else if (Data_Size < DATA_WIDTH) begin
                Writing_Size = Data_Size - (DATA_WIDTH - 1 - Writing_Start_Index);
                for (i = Writing_Start_Index; i > Writing_Start_Index - Writing_Size; i = i-1) begin
                    Decoded_Data[i] = Data_Bit;
                end
                Writing_Start_Index = Writing_Start_Index - Writing_Size;
                Done_Element        = 0;
            end    
        end
	    else begin 
        	Row_Done_Bit = (InitCount < 1);
	    end
    end
 endmodule
        
