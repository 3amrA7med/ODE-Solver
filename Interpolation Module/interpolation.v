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
         output reg Intialization_Done);

     reg [ADDRESS_WIDTH-1:0] CURRENT_TIME_ADD = 0;
     reg [ADDRESS_WIDTH-1:0] TZ_ADD	= 2;
     reg [ADDRESS_WIDTH-1:0] TN_ADD	= 1;
     reg [ADDRESS_WIDTH-1:0] UZ_ADD	= 5;
     reg [ADDRESS_WIDTH-1:0] UN_ADD	= 3;
     reg [ADDRESS_WIDTH-1:0] UK_ADD	= 10;
     reg [ADDRESS_WIDTH-1:0] UTEMP_ADD	= 8;
     reg [2 : 0] USIZE = 2;
     reg [3 : 0] U_CURRENT_SIZE = 0;
     reg First_Time = 1;
     reg [DATA_WIDTH-1 : 0] TN;
     reg [DATA_WIDTH-1 : 0] TZ;
     reg [DATA_WIDTH-1 : 0] UN;
     reg [DATA_WIDTH-1 : 0] UZ;
     reg [DATA_WIDTH-1 : 0] UTEMP;
     reg [DATA_WIDTH-1 : 0] UTEMP_VEC [0 : 2];
     reg [DATA_WIDTH-1 : 0] Temp;
     reg [DATA_WIDTH-1 : 0] Count;
     reg [DATA_WIDTH-1 : 0] R_Sub;
     reg [DATA_WIDTH-1 : 0] R_Mul;
     reg [DATA_WIDTH-1 : 0] CURRENT_TIME;
     reg [3 : 0] current_intialization_state = 0;
     reg [3 : 0] current_interpolation_state = 0;
     reg Start_Interpolation = 0;
     reg Start_Intialization = 0;
     reg [2 : 0] Count2;
     reg [3 : 0] Intialization_state0 = 0;
     reg [3 : 0] Intialization_state1 = 1;
     reg [3 : 0] Intialization_state2 = 2;
     reg [3 : 0] Intialization_state3 = 3;
     reg [3 : 0] Intialization_state4 = 4;
     reg [3 : 0] Intialization_state5 = 5;
     reg [3 : 0] Intialization_state6 = 6;
     reg [3 : 0] Intialization_state7 = 7;
     reg [3 : 0] Intialization_state8 = 8;
     reg [3 : 0] Intialization_state9 = 9;
     reg [3 : 0] Intialization_state10 = 10;

     reg [3 : 0] Interpolation_state0 = 0;
     reg [3 : 0] Interpolation_state1 = 1;
     reg [3 : 0] Interpolation_state2 = 2;
     reg [3 : 0] Interpolation_state3 = 3;
     reg [3 : 0] Interpolation_state4 = 4;
     reg [3 : 0] Interpolation_state5 = 5;
     reg [3 : 0] Interpolation_state6 = 6;
     reg [3 : 0] Interpolation_state7 = 7;
     reg [3 : 0] Interpolation_state8 = 8;
     reg [3 : 0] Interpolation_state9 = 9;


reg adder_sub1_Sub;
reg adder_sub1_Cin;
wire adder_sub1_Cout;
wire adder_sub1_Invalid;
reg [15 : 0] adder_sub1_In1;
reg [15 : 0] adder_sub1_In2;
wire [15 : 0] adder_sub1_Out;

reg adder_sub2_Sub;
reg adder_sub2_Cin;
wire adder_sub2_Cout;
wire adder_sub2_Invalid;
reg [15 : 0] adder_sub2_In1;
reg [15 : 0] adder_sub2_In2;
wire [15 : 0] adder_sub2_Out;

add_sub_cla adder_sub1 (adder_sub1_Sub, adder_sub1_In1, adder_sub1_In2, adder_sub1_Cin, adder_sub1_Out, adder_sub1_Cout, adder_sub1_Invalid);
add_sub_cla adder_sub2 (adder_sub2_Sub, adder_sub2_In1, adder_sub2_In2, adder_sub2_Cin, adder_sub2_Out, adder_sub2_Cout, adder_sub2_Invalid);



     always @(posedge CLK) begin
          if(~RST) begin
              if(Interpolation_Enable) begin
                  assign Start_Interpolation = 1;
                  Interpolation_Done = 0;
                  Count2 = 0;
              end
          end
     end

     always @(posedge CLK) begin
          if(~RST) begin
              if(Interpolation_Intialize) begin
                  assign Start_Intialization = 1;
                  Intialization_Done = 0;
                  Count2 = 0;
              end
          end
     end


     always @(posedge CLK) begin
          if(~RST) begin
              if(Start_Intialization) begin
                  case(current_intialization_state)
                        Intialization_state0:
                                  begin
                                              $display("state 0");
                                              if(~First_Time) begin
                                                  U_CURRENT_SIZE = USIZE;
                                                  UN_ADD = UZ_ADD;
                                                  TN_ADD = TZ_ADD;
                                                  assign adder_sub2_In2 = 1;
                                              end
                                              else begin
                                                  assign adder_sub2_In2 = 0;
                                              end
                                              First_Time = 0;
                                              assign adder_sub1_In1 = UZ_ADD;
                                              assign adder_sub1_In2 = U_CURRENT_SIZE;
                                              assign adder_sub1_Sub = 0;
                                              assign adder_sub1_Cin = 0;

                                              assign adder_sub2_In1 = TZ_ADD;
                                              assign adder_sub2_Sub = 0;
                                              assign adder_sub2_Cin = 0;
                                              current_intialization_state = 1;
                                  end
                        Intialization_state1:
                                  begin
                                              UZ_ADD = adder_sub1_Out;
                                              TZ_ADD = adder_sub2_Out;
                                              $display("UZ_ADD = ", UZ_ADD);
                                              $display("TZ_ADD = ", TZ_ADD);
                                              $display("UN_ADD = ", UN_ADD);
                                              $display("TN_ADD = ", TN_ADD);
                                              assign Interpolation_RAM_RD1_Address = TN_ADD;
                                              assign Interpolation_RAM_RD2_Address = TZ_ADD;
                                              $display("state 0");
                                              current_intialization_state = 2;
                                  end
                        Intialization_state2:
                                  begin
                                              $display("state 2");
                                              TN = {48'd0, Interpolation_RAM_RD1_Data[15:0]};
                                              TZ = {48'd0, Interpolation_RAM_RD2_Data[15:0]};
                                              assign adder_sub1_In1 = TZ[15:0];
                                              assign adder_sub1_In2 = TN[15:0];
                                              assign adder_sub1_Sub = 1;
                                              assign adder_sub1_Cin = 0;
                                              $display("TN = ", TN);
                                              $display("TZ = ", TZ);
                                              $display("adder_sub1_In1 = ", adder_sub1_In1);
                                              $display("adder_sub1_In2 = ", adder_sub1_In2);
                                              current_intialization_state = 3;
                                   end
                        Intialization_state3:
                                begin
                                              Temp = adder_sub1_Out;
                                              $display("Temp2 = ",Temp);
                                              $display("state 3");
                                              current_intialization_state = 4;
                                end
                        Intialization_state4:
                                begin
                                              $display("state 4");
                                              $display("Count = ",Count2);
                                              assign adder_sub1_In1 = UZ_ADD;
                                              assign adder_sub1_In2 = Count2;
                                              assign adder_sub1_Sub = 0;
                                              assign adder_sub1_Cin = 0;
                                              assign adder_sub2_In1 = UN_ADD;
                                              assign adder_sub2_In2 = Count2;
                                              assign adder_sub2_Sub = 0;
                                              assign adder_sub2_Cin = 0;
                                              current_intialization_state = 5;
                                end
                        Intialization_state5:
                                begin
                                              $display("state 4");
                                              assign Interpolation_RAM_RD1_Address = adder_sub1_Out;
                                              assign Interpolation_RAM_RD2_Address = adder_sub2_Out;
                                              $display("Interpolation_RAM_RD1_Address = ", Interpolation_RAM_RD1_Address);
                                              $display("Interpolation_RAM_RD2_Address = ", Interpolation_RAM_RD2_Address);
                                              current_intialization_state = 6;
                                end
                        Intialization_state6:
                                begin
                                              UZ = {48'd0, Interpolation_RAM_RD1_Data[15:0]};
                                              UN = {48'd0, Interpolation_RAM_RD2_Data[15:0]};
                                              $display("UZ = ", UZ);
                                              $display("UN = ", UN);
                                              assign adder_sub1_In1 = UZ;
                                              assign adder_sub1_In2 = UN;
                                              assign adder_sub1_Sub = 1;
                                              assign adder_sub1_Cin = 0;
                                              assign adder_sub2_In1 = UTEMP_ADD;
                                              assign adder_sub2_In2 = Count2;
                                              assign adder_sub2_Sub = 0;
                                              assign adder_sub2_Cin = 0;
                                              current_intialization_state = 7;
                                end
                        Intialization_state7:
                                begin
                                              UTEMP = adder_sub1_Out;
                                              assign Interpolation_RAM_WR_Address = adder_sub2_Out;
                                              $display("Interpolation_RAM_WR_Address = ", Interpolation_RAM_WR_Address);
                                              UTEMP = UTEMP / Temp;
                                              current_intialization_state = 8;
                                end
                        Intialization_state8:
                                begin
                                              assign Interpolation_RAM_WR_Data = UTEMP;
                                              $display("Interpolation_RAM_WR_Data = ",Interpolation_RAM_WR_Data);
                                              assign Interpolation_Memory_WR_Enable = 1;
                                              $display("Interpolation_Memory_WR_Enable = ",Interpolation_Memory_WR_Enable);
                                              $display("Interpolation_RAM_WR_Address = ", Interpolation_RAM_WR_Address);
                                              $display("Count2 = ", Count2);
                                              assign adder_sub1_In1 = Count2;
                                              assign adder_sub1_In2 = 1;
                                              assign adder_sub1_Sub = 0;
                                              assign adder_sub1_Cin = 0;
                                              current_intialization_state = 9;
                                end
                        Intialization_state9:
                                begin
                                              $display("state 9");
                                              Count2 = adder_sub1_Out;
                                              $display("Count = ",Count2);
                                              if(Count2 < USIZE) begin
                                                  current_intialization_state = 4;
                                              end
                                              else begin
                                                  current_intialization_state = 10;
                                              end
                                end
                        Intialization_state10:
                                begin
                                              $display("state 10");
                                              assign Start_Intialization = 0;
                                              Intialization_Done = 1;
                                              current_intialization_state = 0;
                                end
                  endcase
              end
          end

     end

     always @(posedge CLK) begin
          if (~RST) begin
              if (Start_Interpolation) begin
                  case(current_interpolation_state)
                      Interpolation_state0:
                                begin
                                            assign Interpolation_RAM_RD1_Address = TN_ADD;
                                            $display("TN_ADD = ", TN_ADD);
                                            assign Interpolation_RAM_RD2_Address = CURRENT_TIME_ADD;
                                            $display("state 0");
                                            current_interpolation_state = 1;
                                 end
                      Interpolation_state1:
                              begin
                                            TN = {48'd0, Interpolation_RAM_RD1_Data[15:0]};
                                            CURRENT_TIME = {48'd0, Interpolation_RAM_RD2_Data[15:0]};
                                            assign adder_sub1_In1 = CURRENT_TIME[15:0];
                                            assign adder_sub1_In2 = TN[15:0];
                                            assign adder_sub1_Sub = 1;
                                            assign adder_sub1_Cin = 0;
                                            $display("TN = ", TN);
                                            $display("CURRENT_TIME = ", CURRENT_TIME);
                                            $display("adder_sub1_In1 = ", adder_sub1_In1);
                                            $display("adder_sub1_In2 = ", adder_sub1_In2);
                                            current_interpolation_state = 2;
                                 end
                      Interpolation_state2:
                              begin
                                            Temp = adder_sub1_Out;
                                            $display("Temp2 = ",Temp);
                                            current_interpolation_state = 3;
                                 end
                      Interpolation_state3:
                              begin
                                            $display("state3");
                                            $display("UTEMP_ADD = ", UTEMP_ADD);
                                            assign adder_sub1_In1 = UTEMP_ADD;
                                            assign adder_sub1_In2 = Count2;
                                            assign adder_sub1_Sub = 0;
                                            assign adder_sub1_Cin = 0;
                                            assign adder_sub2_In1 = Count2;
                                            assign adder_sub2_In2 = UN_ADD;
                                            assign adder_sub2_Sub = 0;
                                            assign adder_sub2_Cin = 0;
                                            current_interpolation_state = 4;
                                            $display("Count = ",Count2);
                                 end
                      Interpolation_state4:
                              begin
                                            $display("state 4");
                                            $display("Count = ",Count2);
                                            assign Interpolation_RAM_RD1_Address = adder_sub1_Out;
                                            $display("Interpolation_RAM_RD1_Address = ", Interpolation_RAM_RD1_Address);
                                            assign Interpolation_RAM_RD2_Address = adder_sub2_Out;
                                            current_interpolation_state = 5;
                              end
                      Interpolation_state5:
                              begin
                                            $display("state 5");
                                            $display("Count = ",Count2);
                                            UTEMP = {48'd0, Interpolation_RAM_RD1_Data[15:0]};
                                            UN = {48'd0, Interpolation_RAM_RD2_Data[15:0]};
                                            $display("UN = ",UN);
                                            $display("UTEMPbefore = ",UTEMP);
                                            UTEMP = UTEMP * Temp;
                                            $display("UTEMPafter = ",UTEMP);
                                            current_interpolation_state = 6;
                              end
                      Interpolation_state6:
                              begin
                                            $display("UN = ",UN);
                                            $display("UTEMPbefore = ",UTEMP);
                                            assign adder_sub1_In1 = UN[15:0];
                                            assign adder_sub1_In2 = UTEMP[15:0];
                                            assign adder_sub1_Sub = 0;
                                            assign adder_sub1_Cin = 0;
                                            assign adder_sub2_In1 = Count2;
                                            assign adder_sub2_In2 = UK_ADD[15:0];
                                            assign adder_sub2_Sub = 0;
                                            assign adder_sub2_Cin = 0;
                                            current_interpolation_state = 7;
                               end
                      Interpolation_state7:
                              begin
                                            assign Interpolation_RAM_WR_Data = adder_sub1_Out;
                                            $display("Interpolation_RAM_WR_Data = ",Interpolation_RAM_WR_Data);
                                            assign Interpolation_RAM_WR_Address = adder_sub2_Out;
                                            $display("Interpolation_RAM_WR_Address = ",Interpolation_RAM_WR_Address);
                                            assign Interpolation_Memory_WR_Enable = 1;
                                            $display("Interpolation_Memory_WR_Enable = ",Interpolation_Memory_WR_Enable);
                                            assign adder_sub1_In1 = Count2;
                                            assign adder_sub1_In2 = 1;
                                            assign adder_sub1_Sub = 0;
                                            assign adder_sub1_Cin = 0;
                                            current_interpolation_state = 8;
                               end
                      Interpolation_state8:
                               begin
                                            Count2 = adder_sub1_Out;
                                            $display("Count = ",Count2);
                                            if(Count2 < USIZE) begin
                                                current_interpolation_state = 3;
                                            end
                                            else begin
                                                current_interpolation_state = 9;
                                            end
                               end
                      Interpolation_state9:
                               begin
                                            Interpolation_Done = 1;
                                            assign Start_Interpolation = 0;
                                            current_interpolation_state = 0;
                               end
                  endcase
             end
	      end
        else begin
            	assign CURRENT_TIME_ADD = 0;
             	assign TZ_ADD = 0;
            	assign TN_ADD = 0;
            	assign UZ_ADD = 0;
            	assign UN_ADD = 0;
        end
     end


endmodule
