module multiplier_testbench();
 
	reg signed [15:0] first_operand, second_operand;
  	wire signed [15:0] out;
	wire overflow;
 	
  	multiplier_16bit DUT(
    		.first_operand(first_operand),
    		.second_operand(second_operand),
    		.out(out),
		.enable(1'b1),
		.overflow(overflow)
  	);
 
 
	initial
	begin
    		first_operand = 16'b000_0000000000010; // 2
    		second_operand =16'b000_0000000000011; // 3
		#50 // Delay 50ps
		
		
		if((out == 16'b000_0000000000110) && (overflow == 1'b0))$display("TEST1 Passed");
		else $error(" Test1 Failed");
		// Output should be 6
    		#50

//================================================================================
    		first_operand = 16'b001_000000000011_1; // 3.5
    		second_operand =16'b100_000000101_0100; // 5.25
		#50 // Delay 50ps
		
		
		if((out == 16'b100_000010010_0110) && (overflow == 1'b0))$display("TEST2 Passed");
		else $error(" Test1 Failed");
		// Output should be 18.375
    		#50
//=================================================================================
    		first_operand = 16'b001_111111111001_1; // -6.5
    		second_operand = 16'b000_0000000000100; // 4
		#50 // Delay 50ps
		
		
		if((out == 16'b001_111111100110_0) && (overflow == 1'b0))$display("TEST3 Passed");
		else $error(" Test1 Failed");
		// Output should be -26
    		#50

//================================================================================
  		first_operand = 16'b101_00000101_00011; // 5.09375
    		second_operand =16'b101_00000101_10001; // 5.53125
		#50 // Delay 50ps
		
		
		if((out == 16'b101_00011100_00101) && (overflow == 1'b0))$display("TEST4 Passed");
		else $error(" Test1 Failed");
		// Output should be 28.15625
    		#50

//================================================================================
  		first_operand = 16'b111_010000_0000000; // 16
    		second_operand =16'b111_000100_0000000; // 4
		#50 // Delay 50ps
		
		
		if((out == 16'b111_000000_0000000) && (overflow == 1'b1))$display("TEST5 Passed");
		else $error(" Test1 Failed");
		// Output should be 0
    		#50

		#200

		$finish;

    	end
endmodule
