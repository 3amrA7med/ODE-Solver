module Division_LHA_tb ();
 
  reg reset, clk;
  reg [15:0] dividend, divisor;
  wire [15:0] Q;
  wire ready, overFlow, divideByZero;

  Division_CLHA DUT (
	.reset(reset),	
    	.clk(clk),
   	.dividend(dividend),
	.divisor(divisor),
	.Q(Q),
	.ready(ready),
	.overFlow(overFlow),
	.divideByZero(divideByZero)
  );
initial
begin
	clk = 1'b0;
   	reset = 1'b1; // put reset signal with one in the first iterration of every time we use the division module
		      // to reset all signal and start with the initial values 
  	repeat(1) #50 clk = ~clk; // with a clock cycle 100 psec
    	dividend = 16'b0000000000000111; // 7 & scale factor = 0
    	divisor =16'b0000000000000010; // 2 & scale factor = 0
	#50	// delay 50 to just feel the effect of the input 
  	reset = 1'b0; // to start the new clk cycle executing the else statments and calculate the ouput of the division operation 
	repeat(38) #50 clk = ~clk; // to take 20 ns 
	// check on the output value	
	if(Q != 16'b0110000000011100) $error(" Test1 Failed:Output is %f with scale factor = %f but it should be %f with scale facotr = %f"
	,$itor(Q[12:0])*2.0**-3.0,$itor(Q[15:13]) , $itor(16'b0110000000011100)*2.0**-3.0,$itor(3));
	if(Q == 16'b0110000000011100)$display("TEST1 Passed : %f / %f = %f", $itor(dividend[12:0])*2.0**-$itor(dividend[15:13]), $itor(divisor[12:0]),$itor(Q[12:0])*2.0**-3.0);
	// check on the ready flag 
	if (ready == 1'b1) $display("TEST1 passed successfully with ready signal = 1");
	if (ready != 1'b1) $error("TEST1 Failed with ready signal must be 1 not 0");
	// check on the overflow flag 
	if (overFlow == 1'b0) $display("TEST1 passed successfully with overFlow signal = 0");
	if (overFlow != 1'b0) $error("TEST1 Failed with overFlow signal must be 0 not 1");
	// check on the dividebyzero flag 
	if (divideByZero == 1'b0) $display("TEST1 passed successfully with divideByZero signal = 0");
	if (divideByZero != 1'b0) $error("TEST1 Failed with divideByZero signal must be 0 not 1");

        clk = 1'b0;
   	reset = 1'b1; // put reset signal with one in the first iterration of every time we use the division module
		      // to reset all signal and start with the initial values 
  	repeat(1) #50 clk = ~clk; // with a clock cycle 100 psec
    	dividend = 16'b0010000000001001; // 4.5 => 9 & scale factor = 1
    	divisor =16'b0000000000000010; // 2 & scale factor = 0
	#50	// delay 50 to just feel the effect of the input 
  	reset = 1'b0; // to start the new clk cycle executing the else statments and calculate the ouput of the division operation 
	repeat(38) #50 clk = ~clk; // to take 20 ns 
	// check on the output value	
	if(Q != 16'b0110000000010010) $error(" Test2 Failed:Output is %f with scale factor = %f but it should be %f with scale facotr = %f"
	,$itor(Q[12:0])*2.0**-3.0,$itor(Q[15:3]) , $itor(16'b0110000000010010)*2.0**-3.0,$itor(3));
	if(Q == 16'b0110000000010010)$display("TEST2 Passed : %f / %f = %f", $itor(dividend[12:0])*2.0**-$itor(dividend[15:13]), $itor(divisor[12:0]),$itor(Q[12:0])*2.0**-3.0);
	// check on the ready flag 
	if (ready == 1'b1) $display("TEST2 passed successfully with ready signal = 1");
	if (ready != 1'b1) $error("TEST2 Failed with ready signal must be 1 not 0");
	// check on the overflow flag 
	if (overFlow == 1'b0) $display("TEST2 passed successfully with overFlow signal = 0");
	if (overFlow != 1'b0) $error("TEST2 Failed with overFlow signal must be 0 not 1");
	// check on the dividebyzero flag 
	if (divideByZero == 1'b0) $display("TEST2 passed successfully with divideByZero signal = 0");
	if (divideByZero != 1'b0) $error("TEST2 Failed with divideByZero signal must be 0 not 1");

	clk = 1'b0;
   	reset = 1'b1; // put reset signal with one in the first iterration of every time we use the division module
		      // to reset all signal and start with the initial values 
  	repeat(1) #50 clk = ~clk; // with a clock cycle 100 psec
    	dividend = 16'b0100000101000111; // 81.75 => 327& scale factor = 2
    	divisor =16'b0000000000000111; // 7 & scale factor = 0
	#50	// delay 50 to just feel the effect of the input 
  	reset = 1'b0; // to start the new clk cycle executing the else statments and calculate the ouput of the division operation 
	repeat(38) #50 clk = ~clk; // to take 20 ns 
	// check on the output value	
	if(Q != 16'b0110000001011101) $error(" Test3 Failed:Output is %f with scale factor = %f but it should be %f with scale facotr = %f"
	,$itor(Q[12:0])*2.0**-3.0,$itor(Q[15:13]) , $itor(16'b0110000001011101)*2.0**-3.0,$itor(3));
	if(Q == 16'b0110000001011101)$display("TEST3 Passed : %f / %f = %f", $itor(dividend[12:0])*2.0**-$itor(dividend[15:13]), $itor(divisor[12:0]),$itor(Q[12:0])*2.0**-3.0);
	// check on the ready flag 
	if (ready == 1'b1) $display("TEST3 passed successfully with ready signal = 1");
	if (ready != 1'b1) $error("TEST3 Failed with ready signal must be 1 not 0");
	// check on the overflow flag 
	if (overFlow == 1'b0) $display("TEST3 passed successfully with overFlow signal = 0");
	if (overFlow != 1'b0) $error("TEST3 Failed with overFlow signal must be 0 not 1");
	// check on the dividebyzero flag 
	if (divideByZero == 1'b0) $display("TEST3 passed successfully with divideByZero signal = 0");
	if (divideByZero != 1'b0) $error("TEST3 Failed with divideByZero signal must be 0 not 1");

	clk = 1'b0;
   	reset = 1'b1; // put reset signal with one in the first iterration of every time we use the division module
		      // to reset all signal and start with the initial values 
  	repeat(1) #50 clk = ~clk; // with a clock cycle 100 psec
    	dividend = 16'b0001111111111100; // -4 & scale factor = 0
    	divisor =16'b0010000000000001; // 0.5 => 1 & scale factor = 1
	#50	// delay 50 to just feel the effect of the input 
  	reset = 1'b0; // to start the new clk cycle executing the else statments and calculate the ouput of the division operation 
	repeat(38) #50 clk = ~clk; // to take 20 ns 
	// check on the output value	
	if(Q != 16'b0111111111000000) $error(" Test4 Failed:Output is %f with scale factor = %f but it should be %f with scale facotr = %f"
	,$itor(Q[12:0])*2.0**-3.0,$itor(Q[15:13]) , $itor(16'b0111111111000000)*2.0**-3.0,$itor(3));
	if(Q == 16'b0111111111000000)$display("TEST4 Passed : - %f / %f = -%f", $itor(-(dividend[12:0]))*2.0**-$itor(dividend[15:13]), $itor(divisor[12:0])*2.0**-$itor(divisor[15:13]),$itor(-(Q[12:0]))*2.0**-3.0);
	// check on the ready flag 
	if (ready == 1'b1) $display("TEST4 passed successfully with ready signal = 1");
	if (ready != 1'b1) $error("TEST4 Failed with ready signal must be 1 not 0");
	// check on the overflow flag 
	if (overFlow == 1'b0) $display("TEST4 passed successfully with overFlow signal = 0");
	if (overFlow != 1'b0) $error("TEST4 Failed with overFlow signal must be 0 not 1");
	// check on the dividebyzero flag 
	if (divideByZero == 1'b0) $display("TEST4 passed successfully with divideByZero signal = 0");
	if (divideByZero != 1'b0) $error("TEST4 Failed with divideByZero signal must be 0 not 1");

	clk = 1'b0;
   	reset = 1'b1; // put reset signal with one in the first iterration of every time we use the division module
		      // to reset all signal and start with the initial values 
  	repeat(1) #50 clk = ~clk; // with a clock cycle 100 psec
    	dividend = 16'b0000000000001000; // 8 & scale factor = 0
    	divisor =16'b0000000000000010; // 2 & scale factor = 0
	#50	// delay 50 to just feel the effect of the input 
  	reset = 1'b0; // to start the new clk cycle executing the else statments and calculate the ouput of the division operation 
	repeat(38) #50 clk = ~clk; // to take 20 ns 
	// check on the output value	
	if(Q != 16'b0110000000100000) $error(" Test5 Failed:Output is %f with scale factor = %f but it should be %f with scale facotr = %f"
	,$itor(Q[12:0])*2.0**-3.0,$itor(Q[15:13]) , $itor(16'b0110000000100000)*2.0**-3.0,$itor(3));
	if(Q == 16'b0110000000100000)$display("TEST5 Passed : - %f / %f = -%f", $itor((dividend[12:0])), $itor(divisor[12:0]),$itor((Q[12:0]))*2.0**-3.0);
	// check on the ready flag 
	if (ready == 1'b1) $display("TEST5 passed successfully with ready signal = 1");
	if (ready != 1'b1) $error("TEST5 Failed with ready signal must be 1 not 0");
	// check on the overflow flag 
	if (overFlow == 1'b0) $display("TEST5 passed successfully with overFlow signal = 0");
	if (overFlow != 1'b0) $error("TEST5 Failed with overFlow signal must be 0 not 1");
	// check on the dividebyzero flag 
	if (divideByZero == 1'b0) $display("TEST5 passed successfully with divideByZero signal = 0");
	if (divideByZero != 1'b0) $error("TEST5 Failed with divideByZero signal must be 0 not 1");

	clk = 1'b0;
   	reset = 1'b1; // put reset signal with one in the first iterration of every time we use the division module
		      // to reset all signal and start with the initial values 
  	repeat(1) #50 clk = ~clk; // with a clock cycle 100 psec
    	dividend = 16'b0000000000000111; // 7 & scale factor = 0
    	divisor =16'b0000000000000111; // 7 & scale factor = 0
	#50	// delay 50 to just feel the effect of the input 
  	reset = 1'b0; // to start the new clk cycle executing the else statments and calculate the ouput of the division operation 
	repeat(38) #50 clk = ~clk; // to take 20 ns 
	// check on the output value	
	if(Q != 16'b0110000000001000) $error(" Test6 Failed:Output is %f with scale factor = %f but it should be %f with scale facotr = %f"
	,$itor(Q[12:0])*2.0**-3.0,$itor(Q[15:13]) , $itor(16'b0110000000001000)*2.0**-3.0,$itor(3));
	if(Q == 16'b0110000000001000)$display("TEST6 Passed : - %f / %f = -%f", $itor((dividend[12:0])), $itor(divisor[12:0]),$itor((Q[12:0]))*2.0**-3.0);
	// check on the ready flag 
	if (ready == 1'b1) $display("TEST6 passed successfully with ready signal = 1");
	if (ready != 1'b1) $error("TEST6 Failed with ready signal must be 1 not 0");
	// check on the overflow flag 
	if (overFlow == 1'b0) $display("TEST6 passed successfully with overFlow signal = 0");
	if (overFlow != 1'b0) $error("TEST6 Failed with overFlow signal must be 0 not 1");
	// check on the dividebyzero flag 
	if (divideByZero == 1'b0) $display("TEST6 passed successfully with divideByZero signal = 0");
	if (divideByZero != 1'b0) $error("TEST6 Failed with divideByZero signal must be 0 not 1");

	clk = 1'b0;
   	reset = 1'b1; // put reset signal with one in the first iterration of every time we use the division module
		      // to reset all signal and start with the initial values 
  	repeat(1) #50 clk = ~clk; // with a clock cycle 100 psec
    	dividend = 16'b0000000000000111; // 7 & scale factor = 0
    	divisor =16'b0000000000000001; // 1 & scale factor = 0
	#50	// delay 50 to just feel the effect of the input 
  	reset = 1'b0; // to start the new clk cycle executing the else statments and calculate the ouput of the division operation 
	repeat(38) #50 clk = ~clk; // to take 20 ns 
	// check on the output value	
	if(Q != 16'b0110000000111000) $error(" Test7 Failed:Output is %f with scale factor = %f but it should be %f with scale facotr = %f"
	,$itor(Q[12:0])*2.0**-3.0,$itor(Q[15:13]) , $itor(16'b0110000000111000)*2.0**-3.0,$itor(3));
	if(Q == 16'b0110000000111000)$display("TEST7 Passed : - %f / %f = -%f", $itor((dividend[12:0])), $itor(divisor[12:0]),$itor((Q[12:0]))*2.0**-3.0);
	// check on the ready flag 
	if (ready == 1'b1) $display("TEST7 passed successfully with ready signal = 1");
	if (ready != 1'b1) $error("TEST7 Failed with ready signal must be 1 not 0");
	// check on the overflow flag 
	if (overFlow == 1'b0) $display("TEST7 passed successfully with overFlow signal = 0");
	if (overFlow != 1'b0) $error("TEST7 Failed with overFlow signal must be 0 not 1");
	// check on the dividebyzero flag 
	if (divideByZero == 1'b0) $display("TEST7 passed successfully with divideByZero signal = 0");
	if (divideByZero != 1'b0) $error("TEST7 Failed with divideByZero signal must be 0 not 1");

		clk = 1'b0;
   	reset = 1'b1; // put reset signal with one in the first iterration of every time we use the division module
		      // to reset all signal and start with the initial values 
  	repeat(1) #50 clk = ~clk; // with a clock cycle 100 psec
    	dividend = 16'b0001111111111111; // -1 & scale factor = 0
    	divisor =16'b0000000000000111; // 7 & scale factor = 0
	#50	// delay 50 to just feel the effect of the input 
  	reset = 1'b0; // to start the new clk cycle executing the else statments and calculate the ouput of the division operation 
	repeat(38) #50 clk = ~clk; // to take 20 ns 
	// check on the output value	
	if(Q != 16'b0111111111111111) $error(" Test8 Failed:Output is %f with scale factor = %f but it should be %f with scale facotr = %f"
	,$itor(Q[12:0])*2.0**-3.0,$itor(Q[15:13]) , $itor(16'b0111111111111111)*2.0**-3.0,$itor(3));
	if(Q == 16'b0111111111111111)$display("TEST8 Passed : - %f / %f = -%f",$itor(-(dividend[12:0]))*2.0**-$itor(dividend[15:13]), $itor(divisor[12:0])*2.0**-$itor(divisor[15:13]),$itor(-(Q[12:0]))*2.0**-3.0);
	// check on the ready flag 
	if (ready == 1'b1) $display("TEST8 passed successfully with ready signal = 1");
	if (ready != 1'b1) $error("TEST8 Failed with ready signal must be 1 not 0");
	// check on the overflow flag 
	if (overFlow == 1'b0) $display("TEST8 passed successfully with overFlow signal = 0");
	if (overFlow != 1'b0) $error("TEST8 Failed with overFlow signal must be 0 not 1");
	// check on the dividebyzero flag 
	if (divideByZero == 1'b0) $display("TEST8 passed successfully with divideByZero signal = 0");
	if (divideByZero != 1'b0) $error("TEST8 Failed with divideByZero signal must be 0 not 1");

clk = 1'b0;
   	reset = 1'b1; // put reset signal with one in the first iterration of every time we use the division module
		      // to reset all signal and start with the initial values 
  	repeat(1) #50 clk = ~clk; // with a clock cycle 100 psec
    	dividend = 16'b0000000000001110; // 14 & scale factor = 0
    	divisor =16'b0000000000000111; // 7 & scale factor = 0
	#50	// delay 50 to just feel the effect of the input 
  	reset = 1'b0; // to start the new clk cycle executing the else statments and calculate the ouput of the division operation 
	repeat(38) #50 clk = ~clk; // to take 20 ns 
	// check on the output value	
	if(Q != 16'b0110000000010000) $error(" Test9 Failed:Output is %f with scale factor = %f but it should be %f with scale facotr = %f"
	,$itor(Q[12:0])*2.0**-3.0,$itor(Q[15:13]) , $itor(16'b0110000000010000)*2.0**-3.0,$itor(3));
	if(Q == 16'b0110000000010000)$display("TEST9 Passed : - %f / %f = -%f", $itor((dividend[12:0])), $itor(divisor[12:0]),$itor((Q[12:0]))*2.0**-3.0);
	// check on the ready flag 
	if (ready == 1'b1) $display("TEST9 passed successfully with ready signal = 1");
	if (ready != 1'b1) $error("TEST9 Failed with ready signal must be 1 not 0");
	// check on the overflow flag 
	if (overFlow == 1'b0) $display("TEST9 passed successfully with overFlow signal = 0");
	if (overFlow != 1'b0) $error("TEST9 Failed with overFlow signal must be 0 not 1");
	// check on the dividebyzero flag 
	if (divideByZero == 1'b0) $display("TEST9 passed successfully with divideByZero signal = 0");
	if (divideByZero != 1'b0) $error("TEST9 Failed with divideByZero signal must be 0 not 1");

	clk = 1'b0;
   	reset = 1'b1; // put reset signal with one in the first iterration of every time we use the division module
		      // to reset all signal and start with the initial values 
  	repeat(1) #50 clk = ~clk; // with a clock cycle 100 psec
    	dividend = 16'b0001111111111001; // -7 & scale factor = 0
    	divisor =16'b0001111111111001; //  -7 & scale factor = 0
	#50	// delay 50 to just feel the effect of the input 
  	reset = 1'b0; // to start the new clk cycle executing the else statments and calculate the ouput of the division operation 
	repeat(38) #50 clk = ~clk; // to take 20 ns 
	// check on the output value	
	if(Q != 16'b0110000000001000) $error(" Test10 Failed:Output is %f with scale factor = %f but it should be %f with scale facotr = %f"
	,$itor(Q[12:0])*2.0**-3.0,$itor(Q[15:13]) , $itor(16'b0110000000001000)*2.0**-3.0,$itor(3));
	if(Q == 16'b0110000000001000)$display("TEST10 Passed : - %f / %f = -%f", $itor((dividend[12:0])), $itor(divisor[12:0]),$itor((Q[12:0]))*2.0**-3.0);
	// check on the ready flag 
	if (ready == 1'b1) $display("TEST10 passed successfully with ready signal = 1");
	if (ready != 1'b1) $error("TEST10 Failed with ready signal must be 1 not 0");
	// check on the overflow flag 
	if (overFlow == 1'b0) $display("TEST10 passed successfully with overFlow signal = 0");
	if (overFlow != 1'b0) $error("TEST10 Failed with overFlow signal must be 0 not 1");
	// check on the dividebyzero flag 
	if (divideByZero == 1'b0) $display("TEST10 passed successfully with divideByZero signal = 0");
	if (divideByZero != 1'b0) $error("TEST10 Failed with divideByZero signal must be 0 not 1");

	clk = 1'b0;
   	reset = 1'b1; // put reset signal with one in the first iterration of every time we use the division module
		      // to reset all signal and start with the initial values 
  	repeat(1) #50 clk = ~clk; // with a clock cycle 100 psec
    	dividend = 16'b0001111111111001; // -7 & scale factor = 0
    	divisor =16'b0000000000000000; // 0 & scale factor = 0
	#50	// delay 50 to just feel the effect of the input 
  	reset = 1'b0; // to start the new clk cycle executing the else statments and calculate the ouput of the division operation 
	repeat(38) #50 clk = ~clk; // to take 20 ns 
	// check on the ready flag 
	if (ready == 1'b1) $display("TEST11 passed successfully with ready signal = 1");
	if (ready != 1'b1) $error("TEST11 Failed with ready signal must be 1 not 0");
	// check on the overflow flag 
	if (overFlow == 1'b0) $display("TEST11 passed successfully with overFlow signal = 0");
	if (overFlow != 1'b0) $error("TEST11 Failed with overFlow signal must be 0 not 1");
	// check on the dividebyzero flag 
	if (divideByZero == 1'b1) $display("TEST10 passed successfully with divideByZero signal = 0");
	if (divideByZero != 1'b1) $error("TEST10 Failed with divideByZero signal must be 0 not 1");

	$finish;

end
endmodule