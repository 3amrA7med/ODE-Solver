module Coordinator_Module(input RST,
                        input CLK,
                        input INT,
                        input Process,
                        output Done_Processing,  // I/O  Coordinator Inputs Outputs
                        input Change_State_End,
                        output Chage_State, // Interpolator  Coordinator Inputs Outputs
                        wire Euler_Enable,
                        wire Euler_End ,
                        wire Error_Flag);  // Euler Coordinator Inputs Outputs

    parameter RAM_ADDRESS_WIDTH = 13;
    parameter DATA_WIDTH = 64;
    parameter RAM_DEPTH  =200 ;

    wire [RAM_ADDRESS_WIDTH - 1 :0] Step_RAM_WR_Address;  // Write Address
    wire [DATA_WIDTH - 1 :0] Step_RAM_WR_Data;           // Write Data
    wire Step_Memory_WR_Enable;                         // Write Enable
    wire [RAM_ADDRESS_WIDTH - 1 :0] Step_RAM_RD1_Address; // Read Address1
    wire [DATA_WIDTH - 1 :0] Step_RAM_RD1_Data;           // Data Read 1
    wire [RAM_ADDRESS_WIDTH - 1 :0] Step_RAM_RD2_Address; // Read Address2
    wire [DATA_WIDTH - 1 :0] Step_RAM_RD2_Data;          //  Data Read 2



    Step_Module # (RAM_ADDRESS_WIDTH, DATA_WIDTH) Step
    (RST, CLK, Step_Memory_WR_Enable, Step_RAM_RD1_Data, Step_RAM_RD2_Data,
      Step_RAM_RD1_Address, Step_RAM_RD2_Address, Step_RAM_WR_Data, Step_RAM_WR_Address, Euler_Enable, Euler_End , Error_Flag );


    RAM #(RAM_ADDRESS_WIDTH, DATA_WIDTH, RAM_DEPTH) Memory
    (CLK, RST , Step_Memory_WR_Enable,  Step_RAM_RD1_Address,  Step_RAM_RD2_Address
	, Step_RAM_WR_Address, Step_RAM_RD1_Data, Step_RAM_RD2_Data, Step_RAM_WR_Data);








endmodule
