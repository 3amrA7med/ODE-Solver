module Interpolation_Ram #(parameter RAM_ADDRESS_WIDTH = 13, parameter DATA_WIDTH = 64, parameter RAM_DEPTH = 50)
    (input RST,
      input CLK,
			input Interpolation_Enable,
      input Interpolation_Intialize,
      input [RAM_ADDRESS_WIDTH - 1 :0] test_RAM_WR_Address,
      input [DATA_WIDTH - 1 :0] test_RAM_WR_Data,
      input [RAM_ADDRESS_WIDTH - 1 :0] test_RAM_RD1_Address,
      output reg [DATA_WIDTH - 1 :0] test_RAM_RD1_Data,
      input [RAM_ADDRESS_WIDTH - 1 :0] test_RAM_RD2_Address,
      output reg [DATA_WIDTH - 1 :0] test_RAM_RD2_Data,
      input test_Memory_RD_Enable,
      input test_Memory_WR_Enable,
      output Interpolation_Done,
      output Intialization_Done,
      output Error,
      output [3 : 0] intialization_state,
      output [3 : 0] interpolation_state);




    wire [RAM_ADDRESS_WIDTH - 1 :0] Interpolation_RAM_WR_Address;
    wire [RAM_ADDRESS_WIDTH - 1 :0] Interpolation_RAM_RD1_Address;
    wire [RAM_ADDRESS_WIDTH - 1 :0] Interpolation_RAM_RD2_Address;
    wire [DATA_WIDTH - 1 :0] Interpolation_RAM_WR_Data;
    reg [DATA_WIDTH - 1 :0] Interpolation_RAM_RD1_Data;
    reg [DATA_WIDTH - 1 :0] Interpolation_RAM_RD2_Data;
    wire Interpolation_Memory_WR_Enable;
    reg [RAM_ADDRESS_WIDTH - 1 :0] RAM_WR_Address;
    reg [DATA_WIDTH - 1 :0] RAM_WR_Data;
    reg [RAM_ADDRESS_WIDTH - 1 :0] RAM_RD1_Address;
    reg [RAM_ADDRESS_WIDTH - 1 :0] RAM_RD2_Address;
    wire [DATA_WIDTH - 1 :0] RAM_RD1_Data;
    wire [DATA_WIDTH - 1 :0] RAM_RD2_Data;
    reg Memory_WR_Enable;

    Interpolation inter
    (RST, CLK, Interpolation_Enable, Interpolation_Intialize, Interpolation_Memory_WR_Enable, Interpolation_RAM_RD1_Data, Interpolation_RAM_RD2_Data,
    Interpolation_RAM_WR_Data, Interpolation_RAM_RD1_Address, Interpolation_RAM_RD2_Address, Interpolation_RAM_WR_Address, Interpolation_Done
    , Intialization_Done, Error, intialization_state, interpolation_state);

    RAM Memory
    (CLK, Interpolation_Memory_WR_Enable,  RAM_RD1_Address,  RAM_RD2_Address
	, Interpolation_RAM_WR_Address, RAM_RD1_Data, RAM_RD2_Data, Interpolation_RAM_WR_Data);


      initial
      begin
        assign Interpolation_RAM_RD1_Data = 0;
        assign Interpolation_RAM_RD2_Data = 0;
      end

    always @(*) begin
          $display("Interpolation_RAM_WR_Address = ", Interpolation_RAM_WR_Address);
          $display("Interpolation_RAM_WR_Data = ", Interpolation_RAM_WR_Data);
          $display("RAM_RD1_Data = ", RAM_RD1_Data);
          $display("RAM_RD2_Data = ", RAM_RD2_Data);
          $display("RAM_RD1_Address = ", RAM_RD1_Address);
          $display("RAM_RD2_Address = ", RAM_RD2_Address);
          if(test_Memory_WR_Enable) begin
              assign RAM_RD1_Address = test_RAM_WR_Address;
              assign RAM_WR_Data = test_RAM_WR_Data;
          end
          else begin
              assign RAM_RD1_Address = Interpolation_RAM_WR_Address;
              assign RAM_WR_Data = Interpolation_RAM_WR_Data;
          end
          if(test_Memory_RD_Enable) begin
              assign RAM_RD1_Address = test_RAM_RD1_Address;
              assign RAM_RD2_Address = test_RAM_RD2_Address;
          end
          else begin
              assign RAM_RD1_Address = Interpolation_RAM_RD1_Address;
              assign RAM_RD2_Address = Interpolation_RAM_RD2_Address;
          end
          assign test_RAM_RD1_Data = RAM_RD1_Data;
          assign test_RAM_RD2_Data = RAM_RD2_Data;
          assign Interpolation_RAM_RD1_Data = RAM_RD1_Data;
          assign Interpolation_RAM_RD2_Data = RAM_RD2_Data;
    end
endmodule
