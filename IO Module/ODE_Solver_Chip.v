module ODE_Solver_Chip (input RST,
                        input CLK,
                        input INT,
                        input Load_Process,
                        inout [31 :0] CPU_Bus,
                        output Done_Loading,
                        output Done_Processing_Current_Packet,
                        output Done_Processing);
    

    parameter RAM_ADDRESS_WIDTH                       = 13;
    parameter DATA_WIDTH                              = 64;
    parameter RAM_DEPTH                               = 10000;

    wire [RAM_ADDRESS_WIDTH - 1 :0] IO_RAM_WR_Address;
    wire [DATA_WIDTH - 1 :0] IO_RAM_WR_Data;
    wire [RAM_ADDRESS_WIDTH - 1 :0] IO_RAM_RD1_Address;
    wire [DATA_WIDTH - 1 :0] IO_RAM_RD1_Data;
    wire [RAM_ADDRESS_WIDTH - 1 :0] IO_RAM_RD2_Address;
    wire [DATA_WIDTH - 1 :0] IO_RAM_RD2_Data;
    wire IO_Memory_WR_Enable;
	
    

    IO_Module #(RAM_ADDRESS_WIDTH, DATA_WIDTH) IO
    (RST, CLK, INT, Load_Process, CPU_Bus, Done_Loading, Done_Processing_Current_Packet,
    Done_Processing, IO_Memory_WR_Enable, IO_RAM_RD1_Data, IO_RAM_RD2_Data, 
    IO_RAM_WR_Data, IO_RAM_RD1_Address, IO_RAM_RD2_Address, IO_RAM_WR_Address);
    
    RAM #(RAM_ADDRESS_WIDTH, DATA_WIDTH, RAM_DEPTH) Memory
    (CLK, RST , IO_Memory_WR_Enable,  IO_RAM_RD1_Address,  IO_RAM_RD2_Address, IO_RAM_WR_Address,
    IO_RAM_RD1_Data, IO_RAM_RD2_Data, IO_RAM_WR_Data);
    
endmodule
