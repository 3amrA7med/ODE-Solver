//------------------ This Module is Used To Receive Data From CPU Module Decode It and Store It in RAM ----------------//

module Decoder_Receiver #(parameter ADDRESS_WIDTH = 13,
                          parameter DATA_WIDTH = 64)
                         (input RST,
                          input CLK,
                          input [31 :0] CPU_Bus,
                          input Loading_Enable,           			// Module Enable Signal
                          output reg Done_Loading,        			// Module Done Signal
                          output reg Done_Processing_Current_Packet,  		// Handshaking with CPU
                          output reg Done_Element,           			// Memory Write Enable 
                          output reg [ADDRESS_WIDTH - 1 :0] RAM_Address,	// Memory Address
                          output reg [DATA_WIDTH - 1 :0] RAM_Data);		// Memory Data
    
    // Constants
    parameter B_STARTING_ADDRESS = 2507;
    parameter X0_STARTING_ADDRESS = 5007;

    // Bits Required For The Operation => Each One Is Illustrated in Its Usage in the always Block
    reg Start_Bit, Row_Done_Bit, Row_Last_Bit, Data_Bit, Real_Loading_Enable, N_Indication_Bit, Update_Address_Indication_Bit;

    wire Done_Element_Delayed;
    DFlipFlop  Delay (Done_Element, CLK, RST, Done_Element || Done_Element_Delayed, Done_Element_Delayed);

    wire Row_Done_Bit_Delayed;
    DFlipFlop  Delay2 (Row_Done_Bit, CLK, RST, Row_Done_Bit || (Row_Done_Bit_Delayed && ~Done_Element), Row_Done_Bit_Delayed);

    // Counter Used to Start Data Receiving Process
    wire [1  :0] InitCount;
    Counter #(2) Init_Counter (InitCount, Real_Loading_Enable && (InitCount < 2) && ~Done_Loading, CLK, RST);

    
    reg [15: 0] RowsNum;
    // Counter to Store Number of Processed Rows
    wire [15 :0] RowsCount;
    Counter #(16)  Rows_Counter (RowsCount, Row_Done_Bit && Start_Bit && ~Done_Loading, CLK, RST || (RowsCount == RowsNum));
 
    reg [11: 0] N;
    reg [5: 0] PacketSize;
    reg [31: 0] Data_Size;
    reg [5: 0] Writing_Size;
    reg [15: 0] Relative_Address;	
    reg [5: 0] Writing_Last_Index;
    reg [5: 0] Writing_Start_Index;
    reg [31: 0] Small_Packet_Data_Size;
    reg [DATA_WIDTH - 1 :0] Decoded_Data;
    reg [5: 0] Small_Packet_Indication_Bit_Location;
 
    always @(posedge CLK) begin
	//  Delay Loading Enable for One Clock Cycle
	if(Loading_Enable == 1) begin
	     Real_Loading_Enable = 1;
	end
	else begin
	     Real_Loading_Enable = 0;
	end
    end

    integer i = 0;
    always @(posedge CLK) begin
		if(RST || Done_Loading) begin
			RowsNum = 1'b0;
			Data_Bit = 1'b0;
			Start_Bit = 1'b0;
			PacketSize = 1'b0;
			N = {12 {1'b0}};
			Row_Done_Bit = 1'b0;
			Done_Element = 1'b0;
			Done_Loading = RST ? 1'b0: Done_Loading;
			Row_Last_Bit = 1'b0;
			RAM_Address  = -1;
			N_Indication_Bit = 1'b0;
			Data_Size = {32 {1'b0}};
			Writing_Size = {6 {1'b0}};
			Writing_Last_Index = {6 {1'b0}};
			Decoded_Data = {DATA_WIDTH {1'b0}};
			RAM_Data     = {DATA_WIDTH {1'b0}};
			Update_Address_Indication_Bit = 1'b0;
			Done_Processing_Current_Packet  = 1'b1;
			Small_Packet_Data_Size = {32 {1'b0}};
			Writing_Start_Index = DATA_WIDTH - 1;
			Relative_Address =  X0_STARTING_ADDRESS; 
			Small_Packet_Indication_Bit_Location = {6 {1'b0}};
		end
		else begin
				
				// Two Registers To Store The Packet Size & Number of Rows in Input Data
				// [The 1st Two Received Data From CPU]
				PacketSize = (InitCount == 0) ? CPU_Bus[5: 0] : PacketSize;
				RowsNum    = (InitCount == 1) ? CPU_Bus[15: 0] : RowsNum;

				Start_Bit  = (InitCount == 2);
	//--------------------------------- The Main Procedure --------------------------------------------------------//
	// --------- It Starts after Reading the Data Required For Decoding [Packet Size & Number Of Rows]-------------//
	// ----------------------- It Works untill Reading All Rows => Done Loading -----------------------------------//
	// ------------------- Each Clock Cycle, One of those Two Operations will be Done -----------------------------//
	// - 1) Writing Data To Memory In Case there's an Element that has been Decoded Successfully => Done_Element --//
	// --- 2) In case the Decoded Data < DATA_WIDTH, Start To Process Another Small Packet => Not Done_Element ----//
	//-------------------------------------------------------------------------------------------------------------//
				if (Start_Bit && ~Done_Loading) begin

					// Done Element Delayed as I Want to stall the Next Packet not The Current One
					if(~Done_Element_Delayed) 
						// IF Reached The Last Small Packet in The 32 bits => Start from the Beginning Again
						if (Small_Packet_Indication_Bit_Location == PacketSize - 1) begin
							Small_Packet_Indication_Bit_Location = 31;
						end
						// Go To The Next Packet
						else begin
							Small_Packet_Indication_Bit_Location = Small_Packet_Indication_Bit_Location - PacketSize;
						end

					// This Bit is used to Store the Last Bit of The First Packet in the Row, We'll Compare this Bit
					// to all Last Bits of the next Packets till It Changes which means => This is the Last Packet in the Row
					// Row_Done_Bit_Delayed as  want to change it to the Last Bit of the First Packet in the next Row So I Delayed Row_Done_Bit one Cycle
					Row_Last_Bit = Row_Done_Bit_Delayed ? CPU_Bus[Small_Packet_Indication_Bit_Location] : Row_Last_Bit;

					// This Bit Indicate The Last Packet in The Row using The Previous Criteria 
					// It's Anded with Its Inverse to Make It High for only one cycle 
					Row_Done_Bit = (CPU_Bus[Small_Packet_Indication_Bit_Location] != Row_Last_Bit) && ~Row_Done_Bit;
			
					// Bit Indicating The End of The Process when All Rows are Processed
					Done_Loading = (RowsCount == RowsNum);

					// This is the Handshaking Signal Sent to the CPU to Send Another 32 Bits
					Done_Processing_Current_Packet  = (Small_Packet_Indication_Bit_Location == PacketSize - 1) && ~Done_Element;

					// This Bit is used To Indicate That Some Row is Done But It'll be High till the First Element in the Next Row
					// is calculated and Ready to be written in Memory so I Can Change The Address That It'll be Written at.
					Update_Address_Indication_Bit =  Row_Done_Bit_Delayed || Update_Address_Indication_Bit;
		
					// Operation 2) => Process The Packet     
					if(~Done_Element) begin
						// Get The Packet Size => Number Of Consecutive Zeros Or Ones
						for (i = 31; i >= 0; i = i - 1) begin
							if(i < PacketSize - 1) begin
								Small_Packet_Data_Size[PacketSize - i - 2] =  CPU_Bus[Small_Packet_Indication_Bit_Location - i - 1];
							end
						end
						// Bit to Indicate If This Packet Represent Zero Or One 
						// It Alternates Each Clock Cycle of Operation 2 
						// It initialised with the Last Bit of the First Packet For Each Row
						Data_Bit  = Row_Done_Bit_Delayed ? Row_Last_Bit : ~Data_Bit;
					end
			 
					// Data Size Represents Number of Already Decoded Bits + This Packet Size 
					// This Variable is the Indicator of Operation 1 or 2 
					Data_Size = (Data_Size >= DATA_WIDTH) ?  Data_Size - DATA_WIDTH : Data_Size + Small_Packet_Data_Size;
		
					Done_Element = (Data_Size >= DATA_WIDTH);

					Writing_Size = ~Done_Element ? Data_Size - (DATA_WIDTH - 1 - Writing_Start_Index) : Writing_Size;

					Writing_Last_Index = ~Done_Element ? Writing_Start_Index - Writing_Size + 1 : 0;

					for (i = DATA_WIDTH - 1; i >= 0; i = i - 1) begin
						if (i <= Writing_Start_Index && i >= Writing_Last_Index) begin
							Decoded_Data[i] = Data_Bit;
						end
					end

					Writing_Start_Index = ~Done_Element ? Writing_Start_Index - Writing_Size : DATA_WIDTH - 1;
					
					// I Want To Read The N Value as It's used in RAM Address Calculations
					// So I need a Bit to indicate That This Element is The First Done Element which is N
					// So It won't be overrided By the Following Elements 
					N = ~N_Indication_Bit && Done_Element ? Decoded_Data[11:0] : N;  
					N_Indication_Bit = Done_Element || N_Indication_Bit;
					
					// Update Ram Data 			
					RAM_Data = Done_Element ? Decoded_Data: RAM_Data;
					
					// Calculate The RAM Address 
					if (Done_Element) begin
						// IF Matrix A is Done and This is a New Row => Change To Matrix B Address
						if((RowsCount == N + 1) && Update_Address_Indication_Bit) begin
							Update_Address_Indication_Bit = 0;
							RAM_Address = B_STARTING_ADDRESS;	 
						end 
						// IF Matrix B is Done and This is a New Row => Change To Vector X0 Address
						else if((RowsCount == (N << 1) + 1) && Update_Address_Indication_Bit) begin
							Update_Address_Indication_Bit = 0;
							RAM_Address = X0_STARTING_ADDRESS;	 
						end
						// IF Vector X0 is Done and This is a New Row => Add 50 To the Address for each following vector 
						else if((RowsCount > (N << 1) + 1) && Update_Address_Indication_Bit) begin
							Update_Address_Indication_Bit = 0;
							Relative_Address = Relative_Address + 50;
							RAM_Address = Relative_Address; 
						end
						else begin 
							RAM_Address = RAM_Address + 1;
						end
					end
				end  
//--------------------------------- The Main Procedure End ----------------------------------------------------//
//--------------------- Initilization that I want to be Done before starting the Main Procedure --------------//
				else if(~Start_Bit) begin 
					Row_Done_Bit = (InitCount < 1);
					Small_Packet_Indication_Bit_Location = 31 + PacketSize;
				end
//-----------------------------------------------------------------------------------------------------------//
		end
    end
 endmodule
        

