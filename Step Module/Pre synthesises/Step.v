module Step_Module #(parameter ADDRESS_WIDTH = 13,
                   parameter DATA_WIDTH = 64)
                  (input RST,
                   input CLK,
                   output reg Step_Memory_WR_Enable,
                   input [DATA_WIDTH - 1 :0] RAM_Data_RD_A,
                   input [DATA_WIDTH - 1 :0] RAM_Data_RD_B,
                   output reg [ADDRESS_WIDTH - 1 :0] RAM_Address_RD_A,
                   output reg [ADDRESS_WIDTH - 1 :0] RAM_Address_RD_B,
                   output reg [DATA_WIDTH - 1 :0] RAM_Data_WR,
                   output reg [ADDRESS_WIDTH - 1 :0] RAM_Address_WR,  //  Ram Coordinator Inputs Outputs
                   output reg Euler_Enable,
                   input Euler_End , // Euler Coordinator Inputs Outputs
                   output reg Error_Flag);
// Adder module



                   reg sub1 ;
                   reg [15:0] in11 ;
                   reg [15:0] in21 ;
                   wire [15:0] adder_out1;
                   reg cin1 ;
                   wire cout1;
                   wire invalid1;
                   add_sub_cla adder1( sub1, in11, in21, cin1, adder_out1, cout1, invalid1);


                   reg sub2 ;
                   reg [15:0] in12 ;
                   reg [15:0] in22 ;
                   wire [15:0] adder_out2;
                   reg cin2 ;
                   wire  cout2;
                   wire  invalid2;


                   add_sub_cla adder2( sub2, in12, in22, cin2, adder_out2, cout2, invalid2);



/////// mulitplication module

                  wire signed [15:0] out ;
                  wire mult_overflow;
                  reg signed[15:0]first_operand  ;
                  reg signed[15:0]second_operand ;
                  reg mult_enable ;
                  multiplier_16bit multiplier (first_operand, second_operand, out, mult_enable, mult_overflow);


///////////////////// Division module
                   reg reset;
                   reg [15:0] dividend;
                   reg [15:0] divisor;
                   wire [15:0] Q;
                   wire ready;
                   wire div_overflow;
                   wire divideByZero;
                  Division_CSA  Division(reset, CLK, dividend, divisor, Q,ready,  div_overflow, divideByZero);


reg [63:0] resultT ;
reg [63:0] currentT;

reg [63:0] N;
reg [63:0] M;
reg [63:0] htemp;
reg [63:0] Errortemp;
reg [63:0] hnew;
reg [63:0] Temp  ;

//reg [63:0] tolerance;
reg [12:0] count ;
reg [2:0] hstate ;
reg [1:0] flag;

reg division_operation ;

reg [ADDRESS_WIDTH-1:0] N_ADD;
reg [ADDRESS_WIDTH-1:0] M_ADD	;
reg [ADDRESS_WIDTH-1:0] mode_ADD;
reg [ADDRESS_WIDTH-1:0] X_process_ADD	;
reg [ADDRESS_WIDTH-1:0] X_init_ADD	;
reg [ADDRESS_WIDTH-1:0] Xn0_ADD	;
reg [ADDRESS_WIDTH-1:0] Htemp_ADD ;
reg [ADDRESS_WIDTH-1:0] Hinit_ADD ;


reg [3:0]State;
reg [3:0]NextState;

reg[3:0] Start ;
reg[3:0] Euler ;
reg[3:0] Fixed ;
reg[3:0] Step;
reg[3:0] hstate_zero ;
reg[3:0] Read ;
reg[3:0] Write1 ;
reg[3:0] Write2 ;
// for Error calclation

reg[3:0] Read2 ;
reg[3:0] Process_error ;
reg[3:0] Error ;
reg[3:0] Compare ;
reg[3:0] Continue ;
reg[3:0] Check_Result_Time ;
reg[3:0] helper ;
reg[3:0]  Division_State  ;






always @(posedge CLK) begin
//$display("RST" , RST);
if(RST)begin

   // States

    Start = 4'd_0;
    Euler = 4'd_1;
    Fixed = 4'd_2;
    Step = 4'd_3;
    hstate_zero = 4'd_4;
    Read = 4'd_5;
    Write1 = 4'd_6;
    Write2 = 4'd_7;
   // for Error calclation

    Read2 = 4'd_8;
    Process_error = 4'd_9;
    Error = 4'd_10;
    Compare = 4'd_11;
    Continue = 4'd_12;
    Check_Result_Time = 4'd_13;
    helper = 4'd_14;
    Division_State = 4'd_15 ;
   // modules Initializtion


   sub1 = 0;
   in11 = 0 ;
   in21 = 0 ;
   cin1 = 0;


    sub2 = 0;
    in12 = 0 ;
    in22 = 0 ;
    cin2 = 0;

     first_operand = 0 ;
     second_operand = 0;
     mult_enable = 1;

     reset = 1;
     dividend  = 1;
     divisor = 1;

     Step_Memory_WR_Enable = 0;
     RAM_Address_RD_A = 0;
     RAM_Address_RD_B = 1;
     RAM_Address_WR = 0;
     RAM_Data_WR = 0;
     Euler_Enable = 0 ;


   // Address Initializtion

   N_ADD	= 0;
   M_ADD	= 1;
   mode_ADD= 2;
   X_process_ADD	= 6;
   X_init_ADD	= 56;
   Xn0_ADD	= 106;
   Htemp_ADD = 4;
   Hinit_ADD = 5;

   // reg Initializtion
   Error_Flag = 0;
   resultT = 64'd_2 ;
   currentT = 64'd_1;
   N = 64'd_0;
   M = 64'd_0;
   htemp = 64'd_0;
   Errortemp = 64'd_0;
   hnew = 64'd_0;
   flag = 2'd_0;
   division_operation = 0;

   //reg [63:0] tolerance;
   count = 13'd_0;
   Temp  = 64'd_0;
   hstate = 3'd_0;
   State = 4'd_0;
   NextState  = 4'd_0;

end
  else begin

case(NextState)


////////////////////////////////////////////***************** Start *****************\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Start: begin
State = Start;
//$display("state Start");
N = RAM_Data_RD_A;
M = RAM_Data_RD_B;         // Start Init Read N , M from Ram and save them in N , M
NextState = Euler;
end

////////////////////////////////////////////***************** Euler *****************\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Euler : begin
State = Euler;
NextState = Euler;
//$display("state Euler");
Step_Memory_WR_Enable = 1'b0;
RAM_Address_RD_A = mode_ADD; // to know type variable or step
//$display("ADD A = ", RAM_Address_RD_A );
//$display("DAta at ADD A",RAM_Data_RD_A);
Euler_Enable = 1'b1;  // Send Euler Enable to start Euler
//$display("Euler_Enable " , Euler_Enable );
if(Euler_End) begin
  Euler_Enable = 1'b0;  // low Euler Enable
    if(RAM_Data_RD_A == 64'd_1)   // check type variable or fixed
      NextState = Step;
    else
      NextState = Fixed;
end

else begin
  State = Euler;
end
end

////////////////////////////////////////////***************** Step *****************\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Step: begin
State = Step;

if(hstate == 2'd_0)begin
count = 13'd_0;
Temp  = 64'd_0;
RAM_Address_RD_A = Htemp_ADD;  // read address of htemp
NextState = hstate_zero;
//
in11 = Temp[15:0];
in21 = 1;
//
end
else if(hstate == 2'd_1 )begin
hstate = 2'd_2;
NextState = Euler;
end
else begin
// hstate == 2;
NextState = helper;
hstate = 0;
count = 0;
Errortemp = 0;

in12 = 0;
in22 = 0;
end
end

////////////////////////////////////////////***************** Fixed *****************\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Fixed: begin
State = Fixed;
//$display("ErrorEnd = " , ErrorEnd);
NextState = Fixed;
end

////////////////////////////////////////////***************** Division_State *****************\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Division_State:begin
State = Division_State;
NextState = Division_State;
reset = 0;
if (flag == 2'b_11)begin
if(ready)begin
division_operation = 1;
NextState = Compare;
reset = 1;
end
end

else begin
if(ready)begin
htemp[15:0] = Q;
division_operation = 1;
NextState = hstate_zero;
reset = 1;
end
end
if(div_overflow | divideByZero | mult_overflow)
NextState = Error;


end
////////////////////////////////////////////***************** hstate_zero *****************\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

hstate_zero: begin
State = hstate_zero;

if(Temp == N) begin // if temp = N then xn+1 = xprocess
//RAM_Data_WR = htemp / 64'd_2;
if(~ division_operation)begin
dividend = htemp[15:0];
divisor = 16'd_2;
reset = 1;
NextState = Division_State ;
end
else begin
division_operation = 0;
RAM_Data_WR = htemp;
RAM_Address_WR = Htemp_ADD ;// change h temp to h temp/2
hstate = 2'd_1;
NextState = Euler;
end
end

else begin

if (Temp == 64'd_0)
htemp = RAM_Data_RD_A;

Step_Memory_WR_Enable = 1'b0;
//Temp = Temp + 64'd_1;
Temp[15:0] = adder_out1;

in11= X_process_ADD;  // address of xprocess
in21= count;

in12 = X_init_ADD;    // address of xinit
in22 = count;
NextState = Read;
end
end

////////////////////////////////////////////***************** Read *****************\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Read:begin
State = Read;

RAM_Address_RD_A = adder_out1[12:0];  // load address of xprocess  + count
RAM_Address_RD_B = adder_out2[12:0]; // load address of xinit  + count

//$display("ADD A = ", RAM_Address_RD_A );
//$display("DAta at ADD A",RAM_Data_RD_A);
//$display("ADD B = ", RAM_Address_RD_B );
//$display("DAta at ADD B",RAM_Data_RD_B);
NextState = Write1;

// set address of write1 and write2 into 2adder

in22 = Xn0_ADD;
in12 = count;
//
end

////////////////////////////////////////////***************** Write1 *****************\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Write1:begin             // write x process at (xn+1)0
State = Write1;
RAM_Data_WR = RAM_Data_RD_A;
RAM_Address_WR = adder_out2[12:0];    // write x process at xn+1
Step_Memory_WR_Enable = 1'b1;
//$display("RAM_Address_WR ", RAM_Address_WR );
//$display("DAta that will be written ",RAM_Data_WR);
NextState = Write2;

// inc count
in12 = 1;
in22 = count;

end

////////////////////////////////////////////***************** Write2*****************\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Write2:begin             // write x init  at x process
State = Write2;
RAM_Data_WR = RAM_Data_RD_B;
RAM_Address_WR = adder_out1[12:0];    // write x process at xn+1
//$display("RAM_Address_WR ", RAM_Address_WR );
//$display("DAta that will be written ",RAM_Data_WR);
count = adder_out2[12:0];
// inc temp
in11 = Temp;
in21 = 1;
NextState = hstate_zero;
end


////////////////////// error States /////////////////////



////////////////////////////////////////////***************** helper *****************\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
helper:begin

if (State == Compare  & flag == 2'b_01)begin
//$display("enter helper at flag ==1");
State = helper;
first_operand = out;
second_operand = RAM_Data_RD_B[15:0];
flag = 2'b_10;
NextState = helper;
end

else if (State == helper  & flag == 2'b_10)begin
//$display("enter helper at flag ==2");
first_operand = out;
second_operand = RAM_Data_RD_B[15:0];
flag = 2'b_11;
division_operation = 0;
NextState = Compare;
end

else if (State == Compare  & flag == 2'b_00)begin
//$display("came from Compare");
State = helper;
//resultT > currentT + RAM_Data_RD_B
in11 = currentT[16:0];
in21 = RAM_Data_RD_B[16:0];

//RAM_Data_WR = resultT - currentT ;
sub2 = 1;
in12 = resultT[16:0];
in22 = currentT[16:0];
//flag = 2'b_10;
NextState = helper;
end

else if (State == helper  & flag == 2'b_00)begin
//$display("check if time exced time required");
State = helper;
//resultT - currentT + RAM_Data_RD_B
sub1 = 1;
in11 = resultT[16:0];
in21 = adder_out1;
flag = 2'b_01;
NextState = Compare;
end


else begin
//$display("default job update error and calcualte new addresses");
State = helper;
Errortemp[15:0] = adder_out2; // update error
// get address of  (xn+1)1 and (xn+1)0 into 2adder
in11= X_process_ADD;  // address of xprocess == (xn+1)1
in21= count;

in12 = Xn0_ADD;    // address of (xn+1)0
in22 = count;

NextState = Read2;
end

if(mult_overflow)
NextState = Error;
end

////////////////////////////////////////////***************** Read2*****************\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Read2:begin
State = Read2;
if(N[12:0] == count)begin
//$display("Error Calcualted" );
RAM_Address_RD_A = 13'd_3 ; // get tolerance
RAM_Address_RD_B = Hinit_ADD; // get hinit
flag = 0;
hnew = 0;
NextState = Compare;
end
else begin
if (invalid1 | invalid2)
NextState = Error;
else
RAM_Address_RD_A = adder_out1[12:0];
RAM_Address_RD_B = adder_out2[12:0];

NextState = Process_error;

// inc count ;
in12 = 1;
in22 = count;


end
end

////////////////////////////////////////////***************** Process_error*****************\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Process_error:begin
State = Process_error;
//Temp = RAM_Data_RD_A - RAM_Data_RD_B;
in11 = RAM_Data_RD_A[15:0];
in21 = RAM_Data_RD_B[15:0];
sub1 = 1;

count = adder_out2[12:0]; // set with new value
NextState = Error;
end

////////////////////////////////////////////***************** Compare *****************\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Compare:begin
State = Compare;

if (Errortemp > RAM_Data_RD_A)begin
// need to get new h
if(flag == 0)begin
//$display("enter flag 0");
mult_enable = 1;
first_operand = 16'b1110000001110011; // 0.9
second_operand = RAM_Data_RD_A[15:0]; // tolerance
NextState = helper;
flag = 2'b_01;
end
if(flag == 2'b_11)begin
//$display("entered flag 3");
if(~ division_operation)begin
reset = 1;
dividend = out;
divisor = Errortemp[15:0];

NextState = Division_State;
end
else begin
//$display("Division Calcualted and put in hnew");
Step_Memory_WR_Enable = 1;
hnew[15:0] = Q;//(out) / Errortemp[15:0];   // 0.9 -> 16'b1110000001110011
RAM_Data_WR = hnew;
RAM_Address_WR = Htemp_ADD ;// change h temp to h new
flag = 0;
NextState = Continue;
end
end
end


else begin
// current h is good
if (flag)begin
RAM_Address_WR = Htemp_ADD ;// change h temp/2 to h temp
Step_Memory_WR_Enable = 1;
if(adder_out1[12] == 0)
  RAM_Data_WR = RAM_Data_RD_B;
else
  RAM_Data_WR[16:0] = adder_out2;

NextState = Continue;
sub2 = 0;
sub1 = 0;
end
else
NextState = helper;
end
end

////////////////////////////////////////////***************** Continue *****************\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Continue:begin
State = Continue;
RAM_Address_WR = Hinit_ADD ;// change h init to h new
if(flag)
NextState = Check_Result_Time;
else
NextState = Euler;
end

////////////////////////////////////////////***************** Check_Result_Time*****************\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Check_Result_Time:begin
State = Check_Result_Time;
Step_Memory_WR_Enable = 0;
NextState = Check_Result_Time;
//$display("Finishised");
end


////////////////////////////////////////////***************** Error *****************\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Error: begin
State = Error;
if(div_overflow | divideByZero | mult_overflow | invalid1 | invalid2)begin
Error_Flag = 1 ;
NextState = Error;
end
else begin
//$display("Temp ", Temp);
if (adder_out1[12] == 1'b_1) begin
  //$display("error in neg");
  NextState = Error;
  in11 = RAM_Data_RD_B[15:0];
  in21 = RAM_Data_RD_A[15:0];
end
else begin
  //$display("error in pos");
  sub1 = 0;
  Temp[16:0] = adder_out1;
  htemp = Temp;

//$display("htemp after aboslute ", htemp);
//Errortemp = Errortemp + htemp ;  add Errortemp , htemp
in12 = Errortemp[15:0];
in22 = htemp[15:0];
if (invalid1 | invalid2)
NextState = Error;
else
NextState = helper;
end
end
end


endcase
end
end
endmodule
