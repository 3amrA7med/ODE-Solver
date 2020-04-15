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
     reg [ADDRESS_WIDTH-1:0] TZ_ADD	= 1;
     reg [ADDRESS_WIDTH-1:0] TN_ADD	= 2;
     reg [ADDRESS_WIDTH-1:0] UZ_ADD	= 5;
     reg [ADDRESS_WIDTH-1:0] UN_ADD	= 3;
     reg [ADDRESS_WIDTH-1:0] UK_ADD	= 8;

     reg [DATA_WIDTH-1 : 0] TN;
     reg [DATA_WIDTH-1 : 0] TZ;
     reg [DATA_WIDTH-1 : 0] UN;
     reg [DATA_WIDTH-1 : 0] UZ;
     reg [DATA_WIDTH-1 : 0] Temp;
     reg [DATA_WIDTH-1 : 0] Count;
     reg [DATA_WIDTH-1 : 0] R_Sub;
     reg [DATA_WIDTH-1 : 0] R_Mul;
     reg [DATA_WIDTH-1 : 0] CURRENT_TIME;
     reg [2 : 0] status [0:7];
     reg [2 : 0] current_state = 0;
     reg [2 : 0] current_state2 = 4;
     reg Start_Interpolation = 0;
     reg Start_Intialization = 0;

     initial begin
         status[0] = 0;
         status[1] = 1;
         status[2] = 2;
         status[3] = 3;
         status[4] = 4;
         status[5] = 5;
         status[6] = 6;
         status[7] = 7;
    end



     always @(posedge CLK) begin
          if(~RST) begin
              if(Interpolation_Enable) begin
                  assign Start_Interpolation = 1;
                  Count = 0;
              end
          end
     end

     always @(posedge CLK) begin
          if(~RST) begin
              if(Interpolation_Intialize) begin
                  assign Start_Intialization = 1;
              end
          end
     end


     always @(posedge CLK) begin
          if(~RST) begin
              if(Start_Intialization) begin
                  case(current_state)
                        status[0]: begin
                                              assign Interpolation_RAM_RD1_Address = TN_ADD;
                                              assign Interpolation_RAM_RD2_Address = TZ_ADD;
                                              assign TN = Interpolation_RAM_RD1_Data;
                                              assign TZ = Interpolation_RAM_RD2_Data;
                                              $display("state 0");
                                              current_state = 1;
                                  end
                        status[1]: begin
                                              Temp = TZ - TN;
                                              $display("Temp1 = ",Temp);
                                              assign Interpolation_RAM_RD2_Address = CURRENT_TIME_ADD;
                                              assign CURRENT_TIME = Interpolation_RAM_RD2_Data;
                                              current_state = 2;
                                   end
                        status[2]: begin
                                              $display("Temp2 = ",Temp);
                                              Count = CURRENT_TIME - TN;
                                              $display("Count = ",Count);
                                              current_state = 3;
                                  end
                        status[3]: begin
                                              $display("Count3 = ",Count);
                                              $display("Temp3before = ",Temp);
                                              Temp = Count / Temp;
                                              $display("Temp3after = ",Temp);
                                              assign Start_Intialization = 0;
                                              assign Intialization_Done = 1;
                                              current_state = 0;
                                   end
                  endcase
              end
          end

     end

     always @(posedge CLK) begin
          if (~RST) begin
              if (Start_Interpolation) begin
                  case(current_state2)


                      status[4]: begin
                                            $display("Count4 = ",Count);
                                            assign Interpolation_RAM_RD1_Address = UN_ADD + Count;
                                            assign Interpolation_RAM_RD2_Address = UZ_ADD + Count;
                                            assign UN = Interpolation_RAM_RD1_Data;
                                            assign UZ = Interpolation_RAM_RD2_Data;
                                            $display("state 4");
                                            $display("Temp4 = ",Temp);
                                            current_state2 = 5;
                                 end
                      status[5]: begin
                                            R_Sub = UZ - UN;
                                            R_Mul = R_Sub * Temp;
                                            assign Interpolation_RAM_WR_Data = UN + R_Mul;
                                            $display("Interpolation_RAM_WR_Data = ",Interpolation_RAM_WR_Data);
                                            $display("R_Sub = ",R_Sub);
                                            $display("R_Mul = ",R_Mul);
                                            $display("Count = ",Count);
                                            assign Interpolation_RAM_WR_Address = UK_ADD + Count;
                                            $display("Interpolation_RAM_WR_Address = ",Interpolation_RAM_WR_Address);
                                            assign Interpolation_Memory_WR_Enable = 1;
                                            $display("Interpolation_Memory_WR_Enable = ",Interpolation_Memory_WR_Enable);
                                            current_state2 = 6;
                                 end
                      status[6]: begin
                                            $display("state 6");
                                            Count = Count + 1;
                                            $display("Count = ",Count);
                                            if(Count < 2) begin
                                                current_state2 = 4;
                                            end
                                            else begin
                                                current_state2 = 7;
                                            end
                                 end
                      status[7]: begin
                                            assign Interpolation_Done = 1;
                                            assign Start_Interpolation = 0;
                                            current_state2 = 4;
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
