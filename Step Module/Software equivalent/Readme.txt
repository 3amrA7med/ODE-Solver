This is a software equivalent to step module it generate random N between 1 -> 50 then generate random (xn+1)0 and (xn+1)1 vectors and calculate error and calculate hnew if error > tolerance then generate tcl script (testbench) to test post and pre modules and make sure that verilog code is equivalent to python code


To use it run the python code then take the generated .do file and place it in your project folder and run the do file if no error occurred then all the tests will pass

Note: There are 5 pregenerated test cases to use with different N and H and X vectors all tests works correctly although TestCase4 produce an overflow in multiplication making error_flag signal to be 1