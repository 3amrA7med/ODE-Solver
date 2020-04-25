
module Interpolation_testbench #(parameter ADDRESS_WIDTH = 13, parameter DATA_WIDTH = 64);

reg CLK = 1;
reg RST = 0;

reg [ADDRESS_WIDTH - 1 :0] UCOUNT_ADD = 0;
reg [ADDRESS_WIDTH - 1 :0] URESULT_ADD = 303;
reg [ADDRESS_WIDTH - 1 :0] UK_ADD = 403;
reg [DATA_WIDTH - 1 :0] URESULT;
reg [DATA_WIDTH - 1 :0] UK;
reg [ADDRESS_WIDTH-1:0] USIZE_ADD	= 2;
reg [2 : 0] USIZE;
reg [2 : 0] UCOUNT;
reg start_intialization = 1;
reg start_interpolation = 0;
reg [2 : 0] intialization_state = 0;
reg [2 : 0] interpolation_state = 0;
reg [2 : 0] Count = 0;
reg [2 : 0] Count2 = 0;
reg [DATA_WIDTH-1 : 0] CURRENT_TIME = 16'b0010000000000001;


reg Interpolation_Enable;
reg Interpolation_Intialize;
wire Interpolation_Done;
wire Intialization_Done;
wire Error;
reg [ADDRESS_WIDTH - 1 :0] test_RAM_WR_Address;
reg [ADDRESS_WIDTH - 1 :0] test_RAM_RD1_Address;
reg [ADDRESS_WIDTH - 1 :0] test_RAM_RD2_Address;
reg [DATA_WIDTH - 1 :0] test_RAM_WR_Data;
wire [DATA_WIDTH - 1 :0] test_RAM_RD1_Data;
wire [DATA_WIDTH - 1 :0] test_RAM_RD2_Data;
reg test_Memory_RD_Enable;
reg test_Memory_WR_Enable;
wire [3 : 0] current_intialization_state;
wire [3 : 0] current_interpolation_state;


reg adder_sub1_Sub;
reg adder_sub1_Cin;
wire adder_sub1_Cout;
wire adder_sub1_Invalid;
reg [15 : 0] adder_sub1_In1;
reg [15 : 0] adder_sub1_In2;
wire [15 : 0] adder_sub1_Out;

Interpolation_Ram Inter1 (RST, CLK, Interpolation_Enable, Interpolation_Intialize, test_RAM_WR_Address, test_RAM_WR_Data, test_RAM_RD1_Address
  , test_RAM_RD1_Data, test_RAM_RD2_Address, test_RAM_RD2_Data, test_Memory_RD_Enable, test_Memory_WR_Enable
   , Interpolation_Done, Intialization_Done, Error, current_intialization_state, current_interpolation_state);

add_sub_cla test_adder_sub1 (adder_sub1_Sub, adder_sub1_In1, adder_sub1_In2, adder_sub1_Cin, adder_sub1_Out, adder_sub1_Cout, adder_sub1_Invalid);

initial
begin
  assign Interpolation_Intialize = 0;
  assign Interpolation_Enable = 0;
end

always #50 CLK = !CLK;



always @(posedge CLK) begin
    if(start_intialization) begin
        case(intialization_state)
            0:
            begin
                  $display("intialization_state 0");
                  assign test_Memory_RD_Enable = 1;
                  assign test_RAM_RD1_Address = USIZE_ADD;
                  assign test_RAM_RD2_Address = UCOUNT_ADD;
                  intialization_state = 1;
            end
            1:
            begin
                  $display("intialization_state 1");
                  USIZE = test_RAM_RD1_Data;
                  UCOUNT = test_RAM_RD2_Data;
                  assign test_Memory_RD_Enable = 0;
                  $display("USIZE = ", USIZE);
                  $display("UCOUNT = ", UCOUNT);
                  intialization_state = 2;
            end
            2:
            begin
                  $display("intialization_state 2");
                  assign Interpolation_Intialize = 1;
                  intialization_state = 3;
            end
            3:
            begin
                  $display("intialization_state 3");
                  assign Interpolation_Intialize = 0;
                  if(Intialization_Done) begin
                      intialization_state = 4;
                  end
            end
            4:
            begin
                  $display("intialization_state 4");
                  start_intialization = 0;
                  start_interpolation = 1;
                  intialization_state = 2;
            end
        endcase
    end
end


always @(posedge CLK) begin
    if(start_interpolation) begin
        case(interpolation_state)
            0:
            begin
                  $display("interpolation_state 0");
                  assign Interpolation_Enable = 1;
                  assign RST = 1;
                  interpolation_state = 1;
            end
            1:
            begin
                  $display("interpolation_state 1");
                  assign RST = 0;
                  assign Interpolation_Enable = 0;
                  $display("USIZE = ", USIZE);
                  if(Interpolation_Done) begin
                      interpolation_state = 2;
                      $display("USIZE = ", USIZE);
                  end
            end
            2:
            begin
                  $display("interpolation_state 2");
                  $display("USIZE = ", USIZE);
                  Count = 0;
                  interpolation_state = 3;
            end
            3:
            begin
                  $display("interpolation_state 2");
                  assign test_Memory_RD_Enable = 1;
                  assign test_RAM_RD1_Address = URESULT_ADD + Count;
                  assign test_RAM_RD2_Address = UK_ADD + Count;
                  interpolation_state = 4;
                  $display("test_RAM_RD1_Address = ", test_RAM_RD1_Address);
                  $display("test_RAM_RD2_Address = ", test_RAM_RD2_Address);
                  $display("USIZE = ", USIZE);
            end
            4:
            begin
                  URESULT = test_RAM_RD1_Data;
                  UK = test_RAM_RD2_Data;
                  $display("URESULT = ", URESULT);
                  $display("UK = ", UK);
                  $display("USIZE = ", USIZE);
                  if(UK != URESULT) begin
                      $error(" Test Failed:Output is %d but it should be %d.", UK, URESULT);
                  end
                  else begin
                      $display("TEST Passed : UK%d is equal to URESULT%d", Count, Count);
                  end
                  Count = Count + 1;
                  if(Count < USIZE) begin
                      interpolation_state = 3;
                  end
                  else begin
                      interpolation_state = 5;
                  end
            end
            5:
            begin
                  assign test_Memory_RD_Enable = 0;
                  assign adder_sub1_In1 = CURRENT_TIME;
                  assign adder_sub1_In2 = 1;
                  assign adder_sub1_Sub = 0;
                  assign adder_sub1_Cin = 0;
                  interpolation_state = 6;
                  $display("USIZE = ", USIZE);
            end
            6:
            begin
                  assign test_RAM_WR_Data = adder_sub1_Out;
                  $display("adder_sub1_Out = ", adder_sub1_Out);
                  assign test_RAM_WR_Address = 0;
                  assign test_Memory_WR_Enable = 1;
                  interpolation_state = 7;
                  $display("USIZE = ", USIZE);
            end
            7:
            begin
                  assign test_Memory_WR_Enable = 0;
                  start_interpolation = 0;
                  interpolation_state = 0;
                  Count2 = Count2 + 1;
                  if(Count2 < UCOUNT) begin
                      start_intialization = 1;
                  end
            end
        endcase
    end
end





endmodule
