module Interpolation#(parameter ADDRESS_WIDTH = 13,
                          parameter DATA_WIDTH = 64)
		     (input RST,
          input CLK,
		     input Interpolation_Enable,
         input Interpolation_Intialize,
		     output reg Interpolation_Memory_WR_Enable,
		     input [DATA_WIDTH - 1 :0] Interpolation_RAM_RD1_Data,
		     input [DATA_WIDTH - 1 :0] Interpolation_RAM_RD2_Data,
		     output reg [DATA_WIDTH - 1 :0] Interpolation_RAM_WR_Data,
   		   output reg [ADDRESS_WIDTH - 1 :0] Interpolation_RAM_RD1_Address,
		     output reg [ADDRESS_WIDTH - 1 :0] Interpolation_RAM_RD2_Address,
		     output reg [ADDRESS_WIDTH - 1 :0] Interpolation_RAM_WR_Address,
         output reg Interpolation_Done,
         output reg Intialization_Done,
         output reg Error,
         output reg [3 : 0] intialization_state,
         output reg [3 : 0] interpolation_state);

     reg [ADDRESS_WIDTH-1:0] CURRENT_TIME_ADD;
     reg [ADDRESS_WIDTH-1:0] USIZE_ADD;
     reg [ADDRESS_WIDTH-1:0] TZ_ADD;
     reg [ADDRESS_WIDTH-1:0] TN_ADD;
     reg [ADDRESS_WIDTH-1:0] UZ_ADD;
     reg [ADDRESS_WIDTH-1:0] UN_ADD;
     reg [ADDRESS_WIDTH-1:0] UK_ADD;
     reg [ADDRESS_WIDTH-1:0] UTEMP_ADD;

     reg [4 : 0] USIZE;
     reg [7 : 0] U_CURRENT_SIZE;
     reg First_Time;
     reg Div_First_Cycle;
     reg [DATA_WIDTH-1 : 0] TN;
     reg [DATA_WIDTH-1 : 0] TZ;
     reg [DATA_WIDTH-1 : 0] UN;
     reg [DATA_WIDTH-1 : 0] UZ;
     reg [DATA_WIDTH-1 : 0] UTEMP;
     reg [DATA_WIDTH-1 : 0] Temp;
     reg [DATA_WIDTH-1 : 0] R_Sub;
     reg [DATA_WIDTH-1 : 0] R_Mul;
     reg [DATA_WIDTH-1 : 0] CURRENT_TIME;
     reg [3 : 0] current_intialization_state;
     reg [3 : 0] current_interpolation_state;
     reg Start_Interpolation;
     reg Start_Intialization;
     reg [2 : 0] Count2;
     reg Div_Count;
     reg [3 : 0] Intialization_state0;
     reg [3 : 0] Intialization_state1;
     reg [3 : 0] Intialization_state2;
     reg [3 : 0] Intialization_state3;
     reg [3 : 0] Intialization_state4;
     reg [3 : 0] Intialization_state5;
     reg [3 : 0] Intialization_state6;
     reg [3 : 0] Intialization_state7;
     reg [3 : 0] Intialization_state8;
     reg [3 : 0] Intialization_state9;
     reg [3 : 0] Intialization_state10;
     reg [3 : 0] Intialization_state11;

     reg [3 : 0] Interpolation_state0;
     reg [3 : 0] Interpolation_state1;
     reg [3 : 0] Interpolation_state2;
     reg [3 : 0] Interpolation_state3;
     reg [3 : 0] Interpolation_state4;
     reg [3 : 0] Interpolation_state5;
     reg [3 : 0] Interpolation_state6;
     reg [3 : 0] Interpolation_state7;
     reg [3 : 0] Interpolation_state8;
     reg [3 : 0] Interpolation_state9;

     reg  div_state0;
     reg  div_state1;


reg adder_sub1_Sub;
reg adder_sub1_Cin;
reg [15 : 0] adder_sub1_In1;
reg [15 : 0] adder_sub1_In2;
wire adder_sub1_Cout;
wire adder_sub1_Invalid;
wire [15 : 0] adder_sub1_Out;


reg adder_sub2_Sub;
reg adder_sub2_Cin;
reg [15 : 0] adder_sub2_In1;
reg [15 : 0] adder_sub2_In2;
wire adder_sub2_Cout;
wire adder_sub2_Invalid;
wire [15 : 0] adder_sub2_Out;


reg adder_sub3_Sub;
reg adder_sub3_Cin;
reg [15 : 0] adder_sub3_In1;
reg [15 : 0] adder_sub3_In2;
wire adder_sub3_Cout;
wire adder_sub3_Invalid;
wire [15 : 0] adder_sub3_Out;

reg [15 : 0] mult1_first_operand;
reg [15 : 0] mult1_second_operand;
reg mult1_enable;
wire mult1_overflow;
wire [15 : 0] mult1_out;

reg div1_reset;
reg [15 : 0] div1_dividend;
reg [15 : 0] div1_divisor;
wire [15 : 0] div1_Q;
wire div1_ready;
wire div1_overFlow;
wire div1_divideByZero;



add_sub_cla adder_sub1 (adder_sub1_Sub, adder_sub1_In1, adder_sub1_In2, adder_sub1_Cin, adder_sub1_Out, adder_sub1_Cout, adder_sub1_Invalid);

add_sub_cla adder_sub2 (adder_sub2_Sub, adder_sub2_In1, adder_sub2_In2, adder_sub2_Cin, adder_sub2_Out, adder_sub2_Cout, adder_sub2_Invalid);

add_sub_cla adder_sub3 (adder_sub3_Sub, adder_sub3_In1, adder_sub3_In2, adder_sub3_Cin, adder_sub3_Out, adder_sub3_Cout, adder_sub3_Invalid);

multiplier_16bit mult1 (mult1_first_operand, mult1_second_operand, mult1_out, mult1_enable, mult1_overflow);
Division_CLHA div1(div1_reset, CLK, div1_dividend, div1_divisor, div1_Q, div1_ready, div1_overFlow, div1_divideByZero);


     always @(posedge CLK) begin
          assign intialization_state = current_intialization_state;
          assign interpolation_state = current_interpolation_state;
          if(~RST) begin
              if(Interpolation_Intialize) begin
                  assign Start_Intialization = 1'b1;
                  assign Intialization_Done = 1'b0;
                  Count2 = 3'd0;
              end
              if(Start_Intialization) begin
                  case(current_intialization_state)
                        Intialization_state0:
                                  begin
                                              if(~First_Time) begin
                                                  U_CURRENT_SIZE = 8'd50;
                                                  UN_ADD = UZ_ADD;
                                                  TN_ADD = TZ_ADD;
                                                  assign adder_sub2_In2 = 16'd1;
                                              end
                                              else begin
                                                  assign adder_sub2_In2 = 16'd0;
                                              end
                                              First_Time = 1'b1;
                                              assign adder_sub1_In1 = {3'd0, UZ_ADD};
                                              assign adder_sub1_In2 = {8'd0, U_CURRENT_SIZE};
                                              assign adder_sub1_Sub = 1'b0;
                                              assign adder_sub1_Cin = 1'b0;

                                              assign adder_sub2_In1 = {3'd0, TZ_ADD};
                                              assign adder_sub2_Sub = 1'b0;
                                              assign adder_sub2_Cin = 1'b0;
                                              current_intialization_state = 4'd1;
                                              assign Interpolation_RAM_RD1_Address = USIZE_ADD;
                                  end
                        Intialization_state1:
                                  begin
                                              USIZE = Interpolation_RAM_RD1_Data[4:0];
                                              UZ_ADD = adder_sub1_Out[12:0];
                                              TZ_ADD = adder_sub2_Out[12:0];
                                              assign Interpolation_RAM_RD1_Address = TN_ADD;
                                              assign Interpolation_RAM_RD2_Address = TZ_ADD;
                                              current_intialization_state = 4'd2;
                                  end
                        Intialization_state2:
                                  begin
                                              TN = Interpolation_RAM_RD1_Data;
                                              TZ = Interpolation_RAM_RD2_Data;
                                              assign adder_sub1_In1 = TZ[15:0];
                                              assign adder_sub1_In2 = TN[15:0];
                                              assign adder_sub1_Sub = 1'b1;
                                              assign adder_sub1_Cin = 1'b0;
                                              current_intialization_state = 4'd3;
                                   end
                        Intialization_state3:
                                begin
                                              Temp = {48'd0, adder_sub1_Out};
                                              current_intialization_state = 4'd4;
                                end
                        Intialization_state4:
                                begin
                                              assign adder_sub1_In1 = {3'd0, UZ_ADD};
                                              assign adder_sub1_In2 = {13'd0, Count2};
                                              assign adder_sub1_Sub = 1'b0;
                                              assign adder_sub1_Cin = 1'b0;
                                              assign adder_sub2_In1 = {3'd0, UN_ADD};
                                              assign adder_sub2_In2 = {13'd0, Count2};
                                              assign adder_sub2_Sub = 1'b0;
                                              assign adder_sub2_Cin = 1'b0;
                                              current_intialization_state = 4'd5;
                                end
                        Intialization_state5:
                                begin
                                              assign Interpolation_RAM_RD1_Address = adder_sub1_Out[12:0];
                                              assign Interpolation_RAM_RD2_Address = adder_sub2_Out[12:0];
                                              current_intialization_state = 4'd6;
                                end
                        Intialization_state6:
                                begin
                                              UZ = Interpolation_RAM_RD1_Data;
                                              UN = Interpolation_RAM_RD2_Data;
                                              assign adder_sub1_In1 = UZ[15:0];
                                              assign adder_sub1_In2 = UN[15:0];
                                              assign adder_sub1_Sub = 1'b1;
                                              assign adder_sub1_Cin = 1'b0;
                                              assign adder_sub2_In1 = {3'd0, UTEMP_ADD};
                                              assign adder_sub2_In2 = {13'd0, Count2};
                                              assign adder_sub2_Sub = 1'b0;
                                              assign adder_sub2_Cin = 1'b0;
                                              current_intialization_state = 4'd7;
                                end
                        Intialization_state7:
                                begin
                                              UTEMP = {48'd0, adder_sub1_Out};
                                              assign Interpolation_RAM_WR_Address = adder_sub2_Out[12:0];
                                              div1_reset = 1'b1;
                                              div1_dividend = UTEMP[15:0];
                                              div1_divisor = Temp[15:0];
                                              current_intialization_state = 4'd8;
                                end
                        Intialization_state8:
                                begin
                                              div1_reset = 1'b0;
                                              if(div1_overFlow | div1_divideByZero) begin
                                                  assign Error = 1'b1;
                                                  Count2 = 3'd0;
                                                  current_intialization_state = 4'd0;
                                              end
                                              if(div1_ready) begin
                                                 case(Div_Count)
                                                     div_state0: begin
                                                           Div_Count = 1'b1;
                                                        end
                                                     div_state1: begin
                                                           current_intialization_state = 4'd9;
                                                           Div_Count = 1'b0;
                                                        end
                                                 endcase
                                              end
                                end
                        Intialization_state9:
                                begin
                                              UTEMP = {48'd0, div1_Q};
                                              assign Interpolation_RAM_WR_Data = UTEMP;
                                              assign Interpolation_Memory_WR_Enable = 1'b1;
                                              assign adder_sub1_In1 = {13'd0, Count2};
                                              assign adder_sub1_In2 = 16'd1;
                                              assign adder_sub1_Sub = 1'b0;
                                              assign adder_sub1_Cin = 1'b0;
                                              current_intialization_state = 4'd10;
                                end
                        Intialization_state10:
                                begin
                                              assign Interpolation_Memory_WR_Enable = 1'b0;
                                              Count2 = adder_sub1_Out[2:0];
                                              if(Count2 < USIZE) begin
                                                  current_intialization_state = 4'd4;
                                              end
                                              else begin
                                                  current_intialization_state = 4'd11;
                                              end
                                end
                        Intialization_state11:
                                begin
                                              assign Start_Intialization = 1'b0;
                                              assign Intialization_Done = 1'b1;
                                              current_intialization_state = 4'd0;
                                end
                              default: current_intialization_state = current_intialization_state;
                  endcase
              end

              if(Interpolation_Enable) begin
                  assign Start_Interpolation = 1'b1;
                  Interpolation_Done = 1'b0;
                  Count2 = 3'd0;
              end
              if (Start_Interpolation) begin
                  case(current_interpolation_state)
                      Interpolation_state0:
                                begin
                                            assign Interpolation_RAM_RD1_Address = TN_ADD;
                                            assign Interpolation_RAM_RD2_Address = CURRENT_TIME_ADD;
                                            current_interpolation_state = 4'd1;
                                 end
                      Interpolation_state1:
                              begin
                                            TN = Interpolation_RAM_RD1_Data;
                                            CURRENT_TIME = Interpolation_RAM_RD2_Data;
                                            assign adder_sub1_In1 = CURRENT_TIME[15:0];
                                            assign adder_sub1_In2 = TN[15:0];
                                            assign adder_sub1_Sub = 1'b1;
                                            assign adder_sub1_Cin = 1'b0;
                                            current_interpolation_state = 4'd2;
                                 end
                      Interpolation_state2:
                              begin
                                            Temp = {48'd0, adder_sub1_Out};
                                            current_interpolation_state = 4'd3;
                                 end
                      Interpolation_state3:
                              begin
                                            assign adder_sub1_In1 = {3'd0, UTEMP_ADD};
                                            assign adder_sub1_In2 = {13'd0, Count2};
                                            assign adder_sub1_Sub = 1'b0;
                                            assign adder_sub1_Cin = 1'b0;
                                            assign adder_sub2_In1 = {13'd0, Count2};
                                            assign adder_sub2_In2 = {3'd0, UN_ADD};
                                            assign adder_sub2_Sub = 1'b0;
                                            assign adder_sub2_Cin = 1'b0;
                                            current_interpolation_state = 4'd4;
                                 end
                      Interpolation_state4:
                              begin
                                            assign Interpolation_RAM_RD1_Address = adder_sub1_Out[13:0];
                                            assign Interpolation_RAM_RD2_Address = adder_sub2_Out[13:0];
                                            current_interpolation_state = 4'd5;
                              end
                      Interpolation_state5:
                              begin
                                            UTEMP = Interpolation_RAM_RD1_Data;
                                            UN = Interpolation_RAM_RD2_Data;
                                            assign mult1_first_operand = UTEMP[15:0];
                                            assign mult1_second_operand = Temp[15:0];
                                            assign mult1_enable = 1'b1;
                                            current_interpolation_state = 4'd6;
                              end
                      Interpolation_state6:
                              begin
                                            assign mult1_enable = 1'b0;
                                            UTEMP = {48'd0, mult1_out};
                                            assign adder_sub1_In1 = UN[15:0];
                                            assign adder_sub1_In2 = UTEMP[15:0];
                                            assign adder_sub1_Sub = 1'b0;
                                            assign adder_sub1_Cin = 1'b0;
                                            assign adder_sub2_In1 = {13'd0, Count2};
                                            assign adder_sub2_In2 = {3'd0, UK_ADD};
                                            assign adder_sub2_Sub = 1'b0;
                                            assign adder_sub2_Cin = 1'b0;
                                            current_interpolation_state = 4'd7;
                               end
                      Interpolation_state7:
                              begin
                                            assign Interpolation_RAM_WR_Data = {48'd0, adder_sub1_Out};
                                            assign Interpolation_RAM_WR_Address = adder_sub2_Out[12:0];
                                            assign Interpolation_Memory_WR_Enable = 1'b1;
                                            assign adder_sub3_In1 = {13'd0, Count2};
                                            assign adder_sub3_In2 = 16'd1;
                                            assign adder_sub3_Sub = 1'b0;
                                            assign adder_sub3_Cin = 1'b0;
                                            current_interpolation_state = 4'd8;
                               end
                      Interpolation_state8:
                               begin
                                            assign Interpolation_Memory_WR_Enable = 1'b0;
                                            Count2 = adder_sub3_Out[2:0];
                                            if(Count2 < USIZE) begin
                                                current_interpolation_state = 4'd3;
                                            end
                                            else begin
                                                current_interpolation_state = 4'd9;
                                            end
                               end
                      Interpolation_state9:
                               begin
                                            assign Interpolation_Done = 1'b1;
                                            assign Start_Interpolation = 1'b0;
                                            current_interpolation_state = 4'd0;
                               end
                             default:  current_interpolation_state = current_interpolation_state;
                  endcase
             end
          end
          else begin
              assign Interpolation_Done = 1'b0;
              assign Intialization_Done = 1'b0;
              assign Error = 1'b0;
              assign Interpolation_RAM_RD1_Address = 13'd0;
              assign Interpolation_RAM_RD2_Address = 13'd0;
              assign Interpolation_RAM_WR_Address = 13'd0;
              assign Interpolation_RAM_WR_Data = 32'd0;
              assign Interpolation_Memory_WR_Enable = 1'b0;
              assign intialization_state = 4'd0;
              assign interpolation_state = 4'd0;
              CURRENT_TIME_ADD = 13'd1;
              USIZE_ADD	= 13'd2;
              TZ_ADD	= 13'd4;
              TN_ADD	= 13'd3;
              UZ_ADD	= 13'd103;
              UN_ADD	= 13'd53;
              UK_ADD	= 13'd403;
              UTEMP_ADD	= 13'd353;
              U_CURRENT_SIZE = 8'd0;
              First_Time = 1'b1;
              Div_First_Cycle = 1'b1;
              current_intialization_state = 4'd0;
              current_interpolation_state = 4'd0;
              Start_Interpolation = 1'b0;
              Start_Intialization = 1'b0;
              Div_Count = 1'b0;
              div_state0 = 1'b0;
              div_state1 = 1'b1;
              Intialization_state0 = 4'd0;
              Intialization_state1 = 4'd1;
              Intialization_state2 = 4'd2;
              Intialization_state3 = 4'd3;
              Intialization_state4 = 4'd4;
              Intialization_state5 = 4'd5;
              Intialization_state6 = 4'd6;
              Intialization_state7 = 4'd7;
              Intialization_state8 = 4'd8;
              Intialization_state9 = 4'd9;
              Intialization_state10 = 4'd10;
              Intialization_state11 = 4'd11;

              Interpolation_state0 = 4'd0;
              Interpolation_state1 = 4'd1;
              Interpolation_state2 = 4'd2;
              Interpolation_state3 = 4'd3;
              Interpolation_state4 = 4'd4;
              Interpolation_state5 = 4'd5;
              Interpolation_state6 = 4'd6;
              Interpolation_state7 = 4'd7;
              Interpolation_state8 = 4'd8;
              Interpolation_state9 = 4'd9;
              TN = 64'd0;
              TZ = 64'd0;
              UN = 64'd0;
              UZ = 64'd0;
              UTEMP = 64'd0;
              Temp = 64'd0;
              R_Sub = 64'd0;
              R_Mul = 64'd0;
              CURRENT_TIME = 64'd0;
              Count2 = 3'd0;
              adder_sub1_Sub = 1'b0;
              adder_sub1_Cin = 1'b0;
              adder_sub1_In1 = 16'd0;
              adder_sub1_In2 = 16'd0;

              adder_sub2_Sub = 1'b0;
              adder_sub2_Cin = 1'b0;
              adder_sub2_In1 = 16'd0;
              adder_sub2_In2 = 16'd0;

              adder_sub3_Sub = 1'b0;
              adder_sub3_Cin = 1'b0;
              adder_sub3_In1 = 16'd0;
              adder_sub3_In2 = 16'd0;

              mult1_first_operand = 16'd0;
              mult1_second_operand = 16'd0;
              mult1_enable = 1'b0;

              div1_reset = 1'b1;
              div1_dividend = 16'd1;
              div1_divisor = 16'd1;
          end
     end
endmodule
