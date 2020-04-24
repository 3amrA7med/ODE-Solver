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
    	
	// Constant Addresses
    	parameter NUMBER_OF_T_ADDRESS = 1;
	parameter NUMBER_OF_X_ADDRESS = 2;
    	parameter STARTING_OF_T_ADDRESS = 3;
    	parameter STARTING_OF_X_ADDRESS = 10;
	parameter COUNTER_SIZE = 8;
    	
	// Wires used in counters
    	wire [1  :0] Init_Count,  Partial_Data_Count, T_OR_X;
    	wire [COUNTER_SIZE - 1 :0] T_Count, X_Count;
	
	// Counter enables
    	reg Start_Bit, T_Count_Enable, _64data_Enable, X_Count_Enable, T_OR_X_Enable, Init_Count_Enable;
	reg _64data = DATA_WIDTH == 64;

	// Reg values used to keep size of T and X
    	reg [DATA_WIDTH - 1 :0] num_of_T, num_of_X;
    
    	reg [ADDRESS_WIDTH-1 :0] RAM_Addr_B, RAM_Addr_A;
    	
	// This counter is used to initialize sizes of the data that will be sent
    	Counter #(2) Init_Counter (Init_Count, Init_Count_Enable, CLK, RST || ((Init_Count == 2'b11)&&Init_Count_Enable));
	// This two counters to state which T or X we are sending
    	Counter #(COUNTER_SIZE) T_Counter (T_Count, T_Count_Enable , CLK, RST || ((T_Count == num_of_T)&& T_Count_Enable) );
    	Counter #(COUNTER_SIZE) X_Counter (X_Count, X_Count_Enable , CLK, RST || ((X_Count == num_of_X - 1)&& X_Count_Enable));
	// This counter used to load 64 data on 2 clock cycles
    	Counter #(2) _64data_Counter (Partial_Data_Count, _64data_Enable, CLK, RST || ((Partial_Data_Count== 2'b01)&&_64data_Enable)); 
	// This counter used to state whether we are sending T or X values
    	Counter #(2) T_OR_X_COUNTER (T_OR_X, T_OR_X_Enable, CLK, RST || ((T_OR_X==2'b01)&&T_OR_X_Enable));
    	
    	always @(posedge CLK) begin
		if(RST) begin
			num_of_T = {DATA_WIDTH {1'b0}};
	    		num_of_X = {DATA_WIDTH {1'b0}};
			CPU_Bus = {32 {1'b0}};
		end
		else begin
			// Load size of t and x when init count = 0 and sending is enabled.
			num_of_T = (Init_Count == 0 && Sending_Enable) ? RAM_Data_A : num_of_T;
			num_of_X = (Init_Count == 0 && Sending_Enable) ? RAM_Data_B : num_of_X;

			// Read data from ram to the cpu bus
        		CPU_Bus = (_64data_Enable == 0 && ~Done_Sending) ? RAM_Data_A[31: 0]:
        		(Partial_Data_Count == 0 || Done_Sending) ?  RAM_Data_A[DATA_WIDTH - 1: DATA_WIDTH - 32]:RAM_Data_A[31: 0];
		end
		
        end
     
	// Address handler always block
	always @(negedge CLK) begin
		if(RST) begin
			Start_Bit = 1'b0;
			T_Count_Enable = 1'b0;
			_64data_Enable = 1'b0;
			X_Count_Enable = 1'b0;
			T_OR_X_Enable = 1'b0;
			Init_Count_Enable = 1'b0;
	    		Done_Sending = 1'b0;
			RAM_Addr_A = {ADDRESS_WIDTH {1'b0}};
			RAM_Addr_B = {ADDRESS_WIDTH {1'b0}};
			RAM_Address_A = RAM_Addr_A;
        		RAM_Address_B = RAM_Addr_B;
		end
		else if (Sending_Enable) begin
			// All the results have been sent to the cpu so stop counters
			Done_Sending = (Init_Count == 0)?0:
			((T_Count == num_of_T - 1) && (X_Count == num_of_X - 1) && (Partial_Data_Count == 0))? 1 : 0;

			// Start Bit indicate that the initialization of num_of_T and num_of_X Has finished 
			// And the remaining of the system is ready to start		
			Start_Bit = (Init_Count == 2) && ~Done_Sending;

			// Enable only if the data sent is 64 bit, to send the data on 2 clock cycles
        		_64data_Enable =  Start_Bit && (DATA_WIDTH == 64);

			// This is the Init counter enable which is enabled when sending enable is active and the Init count didn't reach 2.
			Init_Count_Enable = Sending_Enable && (Init_Count != 2);

			// This enable is for T_OR_X_Counter as it determines whether the data being sent
			// in the moment is of type T or its X's
			T_OR_X_Enable =  ( Start_Bit && ( (T_OR_X == 2'b00)||(X_Count == num_of_X - 1) )&&(Partial_Data_Count != 1)) || ((Init_Count == 1)&&_64data_Enable) ;


			// This is T counter enable which is enabled if the module has started and we are sending the last 
			// X value of this T
			T_Count_Enable = (Start_Bit && (X_Count == num_of_X - 1)) &&(Partial_Data_Count != 1);



			// This is X counter enable which is enabled if the module has started and we are currently sending X values
        		X_Count_Enable = (Start_Bit && (T_OR_X == 2'b01))
						&&(Partial_Data_Count != 1) ;

        
			// Calculate address A which is set to be the Number_Of_T_Address constant if we are at the first 2 clock cycles
			// and initializing the variables otherwise it send T or X depending on T_OR_X value
        		RAM_Addr_A = (Init_Count == 0) ? NUMBER_OF_T_ADDRESS:
        		(T_OR_X == 0) ? STARTING_OF_T_ADDRESS + T_Count:
        		STARTING_OF_X_ADDRESS + X_Count + (num_of_X * T_Count);

			// Calculate address B which is set to be the Number_Of_X_Address constant if we are at the first 2 clock cycles
			// and initializing the variables 
			RAM_Addr_B = (Init_Count == 0 && Sending_Enable) ? NUMBER_OF_X_ADDRESS: RAM_Address_B;

			// Set address of the ram to that calculated in the previous step.
        		RAM_Address_A = RAM_Addr_A;
        		RAM_Address_B = RAM_Addr_B;
		end
	end
endmodule
