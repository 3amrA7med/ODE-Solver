module Interpolation_Ram(input RST,
                        input CLK,
			input Interpolation_Enable,
      input Interpolation_Intialize);


    parameter RAM_ADDRESS_WIDTH                       = 13;
    parameter DATA_WIDTH                              = 64;
    parameter RAM_DEPTH                               = 50;

    wire [RAM_ADDRESS_WIDTH - 1 :0] Interpolation_RAM_WR_Address;
    wire [DATA_WIDTH - 1 :0] Interpolation_RAM_WR_Data;
    wire [RAM_ADDRESS_WIDTH - 1 :0] Interpolation_RAM_RD1_Address;
    wire [DATA_WIDTH - 1 :0] Interpolation_RAM_RD1_Data;
    wire [RAM_ADDRESS_WIDTH - 1 :0] Interpolation_RAM_RD2_Address;
    wire [DATA_WIDTH - 1 :0] Interpolation_RAM_RD2_Data;
    wire Interpolation_Memory_WR_Enable;
    wire Interpolation_Done;
    wire Intialization_Done;

    Interpolation #(RAM_ADDRESS_WIDTH, DATA_WIDTH) inter
    (RST, CLK, Interpolation_Enable, Interpolation_Intialize, Interpolation_Memory_WR_Enable, Interpolation_RAM_RD1_Data, Interpolation_RAM_RD2_Data,
    Interpolation_RAM_WR_Data, Interpolation_RAM_RD1_Address, Interpolation_RAM_RD2_Address, Interpolation_RAM_WR_Address, Interpolation_Done
    , Intialization_Done);

    RAM #(RAM_ADDRESS_WIDTH, DATA_WIDTH, RAM_DEPTH) Memory
    (CLK, RST , Interpolation_Memory_WR_Enable,  Interpolation_RAM_RD1_Address,  Interpolation_RAM_RD2_Address
	, Interpolation_RAM_WR_Address, Interpolation_RAM_RD1_Data, Interpolation_RAM_RD2_Data, Interpolation_RAM_WR_Data);



endmodule
