module wallace_8bit_multiplier(multiplicand, multiplier, result);
	parameter DATA_WIDTH = 8;
	output [2*DATA_WIDTH-1:0] result;
	input  [DATA_WIDTH-1:0] multiplier,multiplicand;
	wire [DATA_WIDTH-1:0] out[DATA_WIDTH-1:0];
	wire [55:0]c,s;
	genvar i;
  	generate 
   	  for (i = 0; i < DATA_WIDTH; i = i + 1) begin
      	        nx1_product level (multiplicand[i],multiplier, out[i]);
	  end
 	 endgenerate






m_half_adder HA11 ( .Sum(s[0]),  .CarryOut(c[0]),  .A(out[1][0]), .B(out[0][1])); 
m_full_adder FA21 ( .Sum(s[1]),  .CarryOut(c[1]),  .A(out[2][0]), .B(out[1][1]),		.CarryIn(c[0]));
m_half_adder HA21 ( .Sum(s[2]),  .CarryOut(c[2]),  .A(out[0][2]), .B(s[1]));                                       
m_full_adder FA31 ( .Sum(s[3]),  .CarryOut(c[3]),  .A(out[3][0]), .B(out[2][1]),		.CarryIn(c[1]));
m_full_adder FA32 ( .Sum(s[4]),  .CarryOut(c[4]),  .A(out[1][2]), .B(s[3]),		.CarryIn(c[2]));
m_half_adder HA31 ( .Sum(s[5]),  .CarryOut(c[5]),  .A(out[0][3]), .B(s[4]));                            
m_full_adder FA41 ( .Sum(s[6]),  .CarryOut(c[6]),  .A(out[4][0]), .B(out[3][1]), 		.CarryIn(c[3]));
m_full_adder FA42 ( .Sum(s[7]),  .CarryOut(c[7]),  .A(out[2][2]), .B(s[6]), 		.CarryIn(c[4]));
m_full_adder FA43 ( .Sum(s[8]),  .CarryOut(c[8]),  .A(out[1][3]), .B(s[7]), 		.CarryIn(c[5]));
m_half_adder HA41 ( .Sum(s[9]),  .CarryOut(c[9]),  .A(out[0][4]), .B(s[8]));        
m_full_adder FA51 ( .Sum(s[10]), .CarryOut(c[10]), .A(out[5][0]), .B(out[4][1]), 		.CarryIn(c[6]));
m_full_adder FA52 ( .Sum(s[11]), .CarryOut(c[11]), .A(out[3][2]), .B(s[10]), 		.CarryIn(c[7]));
m_full_adder FA53 ( .Sum(s[12]), .CarryOut(c[12]), .A(out[2][3]), .B(s[11]), 		.CarryIn(c[8]));
m_full_adder FA54 ( .Sum(s[13]), .CarryOut(c[13]), .A(out[1][4]), .B(s[12]), 		.CarryIn(c[9]));
m_half_adder HA55 ( .Sum(s[14]), .CarryOut(c[14]), .A(out[0][5]),.B(s[13]));                             
m_full_adder FA61 ( .Sum(s[15]), .CarryOut(c[15]), .A(out[6][0]), .B(out[5][1]), 		.CarryIn(c[10]));
m_full_adder FA62 ( .Sum(s[16]), .CarryOut(c[16]), .A(out[4][2]), .B(s[15]), 		.CarryIn(c[11]));
m_full_adder FA63 ( .Sum(s[17]), .CarryOut(c[17]), .A(out[3][3]), .B(s[16]), 		.CarryIn(c[12]));
m_full_adder FA64 ( .Sum(s[18]), .CarryOut(c[18]), .A(out[2][4]), .B(s[17]), 		.CarryIn(c[13]));
m_full_adder FA65 ( .Sum(s[19]), .CarryOut(c[19]), .A(out[1][5]), .B(s[18]), 		.CarryIn(c[14]));
m_half_adder HA42 ( .Sum(s[20]), .CarryOut(c[20]), .A(out[0][6]), .B(s[19]));                                   
m_full_adder FA71 ( .Sum(s[21]), .CarryOut(c[21]), .A(out[7][0]), .B(out[6][1]), 		.CarryIn(c[15]));
m_full_adder FA72 ( .Sum(s[22]), .CarryOut(c[22]), .A(out[5][2]), .B(s[21]), 		.CarryIn(c[16]));
m_full_adder FA73 ( .Sum(s[23]), .CarryOut(c[23]), .A(out[4][3]), .B(s[22]), 		.CarryIn(c[17]));
m_full_adder FA74 ( .Sum(s[24]), .CarryOut(c[24]), .A(out[3][4]), .B(s[23]), 		.CarryIn(c[18]));
m_full_adder FA75 ( .Sum(s[25]), .CarryOut(c[25]), .A(out[2][5]), .B(s[24]), 		.CarryIn(c[19]));
m_full_adder FA76 ( .Sum(s[26]), .CarryOut(c[26]), .A(out[1][6]), .B(s[25]), 		.CarryIn(c[20]));
m_half_adder HA71 ( .Sum(s[27]), .CarryOut(c[27]), .A(out[0][7]), .B(s[26]));                                
m_full_adder FA81 ( .Sum(s[28]), .CarryOut(c[28]), .A(out[7][1]), .B( out[6][2]), 	.CarryIn(c[21]));
m_full_adder FA82 ( .Sum(s[29]), .CarryOut(c[29]), .A(out[5][3]), .B(s[28]), 		.CarryIn(c[22]));
m_full_adder FA83 ( .Sum(s[30]), .CarryOut(c[30]), .A(out[4][4]), .B(s[29]), 		.CarryIn(c[23]));
m_full_adder FA84 ( .Sum(s[31]), .CarryOut(c[31]), .A(out[3][5]), .B(s[30]), 		.CarryIn(c[24]));
m_full_adder FA85 ( .Sum(s[32]), .CarryOut(c[32]), .A(out[2][6]), .B(s[31]), 		.CarryIn(c[25]));
m_full_adder FA86 ( .Sum(s[33]), .CarryOut(c[33]), .A(out[1][7]), .B(s[32]), 		.CarryIn(c[26]));
m_half_adder HA81 ( .Sum(s[34]), .CarryOut(c[34]), .A(s[33]), 	.B(c[27]));                                 
m_full_adder FA91 ( .Sum(s[35]), .CarryOut(c[35]), .A(out[7][2]), .B( out[6][3]), 	.CarryIn(c[28]));
m_full_adder FA92 ( .Sum(s[36]), .CarryOut(c[36]), .A(out[5][4]), .B(s[35]), 		.CarryIn(c[29]));
m_full_adder FA93 ( .Sum(s[37]), .CarryOut(c[37]), .A(out[4][5]), .B(s[36]), 		.CarryIn(c[30]));
m_full_adder FA94 ( .Sum(s[38]), .CarryOut(c[38]), .A(out[3][6]), .B(s[37]), 		.CarryIn(c[31]));
m_full_adder FA95 ( .Sum(s[39]), .CarryOut(c[39]), .A(out[2][7]), .B(s[38]), 		.CarryIn(c[32]));
m_full_adder FA96 ( .Sum(s[40]), .CarryOut(c[40]), .A(s[39]), 	.B(c[33]), 		.CarryIn(c[34]));                       
m_full_adder FA101( .Sum(s[41]), .CarryOut(c[41]), .A(out[7][3]), .B( out[6][4]), 	.CarryIn(c[35]));
m_full_adder FA102( .Sum(s[42]), .CarryOut(c[42]), .A(out[5][5]), .B(s[41]), 		.CarryIn(c[36]));
m_full_adder FA103( .Sum(s[43]), .CarryOut(c[43]), .A(out[4][6]), .B(s[42]), 		.CarryIn(c[37]));
m_full_adder FA104( .Sum(s[44]), .CarryOut(c[44]), .A(out[3][7]), .B(s[43]), 		.CarryIn(c[38]));
m_full_adder FA105( .Sum(s[45]), .CarryOut(c[45]), .A(s[44]), 	.B(c[39]),		.CarryIn(c[40]));                 
m_full_adder FA111( .Sum(s[46]), .CarryOut(c[46]), .A(out[7][4]), .B( out[6][5]),		.CarryIn(c[41]));
m_full_adder FA112( .Sum(s[47]), .CarryOut(c[47]), .A(out[5][6]), .B(s[46]), 		.CarryIn(c[42]));
m_full_adder FA113( .Sum(s[48]), .CarryOut(c[48]), .A(out[4][7]), .B(s[47]), 		.CarryIn(c[43]));
m_full_adder FA114( .Sum(s[49]), .CarryOut(c[49]), .A(s[48]), 	.B(c[44]), 		.CarryIn(c[45]));         
m_full_adder FA121( .Sum(s[50]), .CarryOut(c[50]), .A(out[7][5]), .B( out[6][6]),		.CarryIn(c[46]));
m_full_adder FA122( .Sum(s[51]), .CarryOut(c[51]), .A(out[5][7]), .B(s[50]), 		.CarryIn(c[47]));
m_full_adder FA123( .Sum(s[52]), .CarryOut(c[52]), .A(s[51]), 	.B(c[48]), 		.CarryIn(c[49]));       
m_full_adder FA131( .Sum(s[53]), .CarryOut(c[53]), .A(out[7][6]), .B( out[6][7]),		.CarryIn(c[50]));
m_full_adder FA132( .Sum(s[54]), .CarryOut(c[54]), .A(s[53]),	.B(c[51]), 		.CarryIn(c[52]));
m_full_adder FA141( .Sum(s[55]), .CarryOut(c[55]), .A(out[7][7]), .B(c[53]), 		.CarryIn(c[54]));         

assign result = {c[55],s[55],s[54],s[52],s[49],s[45],s[40],s[34],s[27],s[20],s[14],s[9],s[5],s[2],s[0],out[0][0]};




    

   
endmodule
