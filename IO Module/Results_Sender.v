module Results_Sender #(parameter ADDRESS_WIDTH = 13,
                        parameter DATA_WIDTH = 64)
                       (input RST,
                        input CLK,
                        input Sending_Enable,
                        output reg [31 :0] CPU_Bus,
                        output reg Done_Sending,
                        input [DATA_WIDTH - 1 :0] RAM_Data_A,
                        input [DATA_WIDTH - 1 :0] RAM_Data_B,
                        output reg [ADDRESS_WIDTH - 1 :0] RAM_Address_A,
                        output reg [ADDRESS_WIDTH - 1 :0] RAM_Address_B);
    
/*     parameter COUNT_ADDRESS = 1;
    parameter N_ADDRESS     = 2;
    parameter T_ADDRESS     = 3;
    parameter X_ADDRESS     = 10;
    
    wire [1  :0] Init_Count;
    wire [DATA_WIDTH - 1 :0] T_Count;
    wire [DATA_WIDTH - 1 :0] N_Count;
    wire [1  :0]  Partial_Data_Count;
    
    wire [DATA_WIDTH :0] T_Num = (Init_Count == 1) ? RAM_Data_A : T_Num;
    wire [DATA_WIDTH :0] N     = (Init_Count == 1) ? RAM_Data_B : N;
    reg Start_Bit, T_Count_Enable, Partial_Data_Count_Enable, N_Count_Enable;
    
    initial begin
        Done_Sending = 0;
    end

    
    reg [ADDRESS_WIDTH :0] RAM_Addr_B;
    reg [ADDRESS_WIDTH :0] RAM_Addr_A;
    
    Counter #(2) Init_Counter (Init_Count, Sending_Enable && (Init_Count != 2), CLK, RST, 2, 1'b1);
    Counter #(DATA_WIDTH) T_Counter (T_Count, T_Count_Enable , CLK, RST, T_Num + 1, 1'b1);
    Counter #(DATA_WIDTH) N_Counter (N_Count, N_Count_Enable , CLK, RST, N, 1'b1);
    Counter #(2) Partial_Data_Counter (Partial_Data_Count, Partial_Data_Count_Enable, CLK, RST, 1, 1'b1);
    
    
    always @(posedge CLK) begin
        Done_Sending = 0;
        Start_Bit                 = (Init_Count == 2) && ~Done_Sending;
        
        T_Count_Enable            = Start_Bit && (N_Count == N);
        Partial_Data_Count_Enable = Start_Bit && (DATA_WIDTH == 64);
        N_Count_Enable = Start_Bit && ((Partial_Data_Count == 1 && Partial_Data_Count_Enable) ||
                        (Partial_Data_Count == 0 && ~Partial_Data_Count_Enable));
        
        RAM_Addr_B = (Init_Count == 1) ? N_ADDRESS: RAM_Address_B;
        RAM_Addr_A = (Init_Count == 1) ? COUNT_ADDRESS:

        (N_Count == 0) ? T_ADDRESS + T_Count:
        X_ADDRESS + (N_Count * T_Count);
        
        CPU_Bus = (Partial_Data_Count_Enable == 0) ? RAM_Data_A:
        (Partial_Data_Count == 0) ? RAM_Data_A[DATA_WIDTH - 1: 32]:
        RAM_Data_A[31: 0];
        RAM_Address_A = RAM_Addr_A;
        RAM_Address_B = RAM_Addr_B;
        end
         */
endmodule
    
