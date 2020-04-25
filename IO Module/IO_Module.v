module IO_Module #(parameter ADDRESS_WIDTH = 13,
                   parameter DATA_WIDTH = 64)
                  (input RST,
                   input CLK,
                   input INT,
                   input Load_Process,
                   inout [31 :0] CPU_Bus,
                   output Done_Loading,
                   output Done_Processing_Current_Packet,
                   output reg Done_Processing,
                   output reg IO_Memory_WR_Enable,
                   input [DATA_WIDTH - 1 :0] RAM_Data_RD_A,
                   input [DATA_WIDTH - 1 :0] RAM_Data_RD_B,
                   output reg [DATA_WIDTH - 1 :0] RAM_Data_WR,
                   output reg [ADDRESS_WIDTH - 1 :0] RAM_Address_RD_A,
                   output reg [ADDRESS_WIDTH - 1 :0] RAM_Address_RD_B,
                   output reg [ADDRESS_WIDTH - 1 :0] RAM_Address_WR);
    
    wire Loading_Enable = (INT && Load_Process);
    wire Sending_Enable;
    wire [ADDRESS_WIDTH - 1 :0] Decoder_Memory_Address_WR;
    wire [ADDRESS_WIDTH - 1 :0] Sender_Memory_Address_RD_A;
    wire [ADDRESS_WIDTH - 1 :0] Sender_Memory_Address_RD_B;
    wire [DATA_WIDTH - 1 :0] Decoder_Memory_Data_WR;
    wire Decoder_Memory_WR_Enable;
    
    
    Decoder_Receiver #(ADDRESS_WIDTH , DATA_WIDTH) DR
    (RST, CLK, CPU_Bus, Loading_Enable, Done_Loading, Done_Processing_Current_Packet,
    Decoder_Memory_WR_Enable, Decoder_Memory_Address_WR, Decoder_Memory_Data_WR);
    
    Results_Sender #(ADDRESS_WIDTH ,DATA_WIDTH) RS
    (RST, CLK, Sending_Enable, CPU_Bus, Done_Sending,
    RAM_Data_RD_A, RAM_Data_RD_B, Sender_Memory_Address_RD_A, Sender_Memory_Address_RD_B);
	
    initial begin
	RAM_Address_WR   =  {ADDRESS_WIDTH {1'b0}};
        RAM_Data_WR      =  {DATA_WIDTH {1'b0}};
        RAM_Address_RD_A =  {ADDRESS_WIDTH {1'b0}};
        RAM_Address_RD_B =  {ADDRESS_WIDTH {1'b0}};
        IO_Memory_WR_Enable = 0;
	Done_Processing = 0;
    end

    always @* begin
        RAM_Address_WR = Decoder_Memory_Address_WR;
        RAM_Data_WR = Decoder_Memory_Data_WR;
        RAM_Address_RD_A = Sender_Memory_Address_RD_A;
        RAM_Address_RD_B = Sender_Memory_Address_RD_B;
        IO_Memory_WR_Enable = Decoder_Memory_WR_Enable;
    end

endmodule
