module Euler
    #(parameter ADDRESS_WIDTH=13,
                DATA_WIDTH=64,
                CUR_DATA_WIDTH=17)
    (input INT,
     input PROCESS,  // 0 => INIT, 1=> Start Computation
     input CLK,
     output reg DONE,
     input Interpolate_DONE,
     output reg Interpolate_Enable);

parameter   Start=3'b000,
            Init=3'b001,
            Prepare=3'b010,
            Interpolate=3'b011,
            Load1=3'b100,
            Load2=3'b101,
            Final_Calc=3'b110;

    reg  [2:0] state,next;
    reg  [ADDRESS_WIDTH-1:0] A_ADD,B_ADD,X_ADD,U_ADD,h_ADD,XNew_ADD,n_ADD,m_ADD;
    reg  [ADDRESS_WIDTH-1:0] RES1_ADD,RES2_ADD;
    reg  [ADDRESS_WIDTH-1:0] RAM_ADD_RD1,RAM_ADD_RD2,RAM_ADD_WR;
    wire [DATA_WIDTH-1:0] RAM_DATA_RD1,RAM_DATA_RD2;
    reg  [DATA_WIDTH-1:0] RAM_DATA_WR;
    reg  RAM_ENABLE_WR;

    reg  Back, Matrix_Multiplication1_Enable, Matrix_Multiplication2_Enable, Final_Calc_Enable;
    reg  [DATA_WIDTH-1:0] n_val, m_val, h_val;
    reg  [CUR_DATA_WIDTH-1:0] MATRIX_CNT,VECTOR_CNT,MATRIX_ADD,VECTOR_ADD,VECTOR2_ADD,Element_Result,RESULT_ADD;
    wire [CUR_DATA_WIDTH-1:0] NEW_Element_Result,NEW_MATRIX_CNT,NEW_VECTOR_CNT,NEW_MATRIX_ADD,NEW_VECTOR_ADD,NEW_VECTOR2_ADD,NEW_RESULT_ADD,Addition_Result,FINAL_RESULT;
    wire [CUR_DATA_WIDTH-2:0] Multiplication_Result,h_VECTOR_RESULT;
    reg  [1:0] counter;
    wire invalid[8:0], overflow[1:0];

    initial begin
    end

    always@(negedge CLK)    begin
        state=next;

        case(state)
            Interpolate:    RAM_ADD_RD1=h_ADD;

            Load1:  begin
                VECTOR_ADD=NEW_VECTOR_ADD;
                MATRIX_ADD=NEW_MATRIX_ADD;
                VECTOR_CNT=NEW_VECTOR_CNT;
                Element_Result=NEW_Element_Result;
                RAM_ADD_RD1=MATRIX_ADD;
                RAM_ADD_RD2=VECTOR_ADD;
                RAM_DATA_WR=Element_Result;
                RAM_ADD_WR=RESULT_ADD;

                RAM_ENABLE_WR=0;

                if(VECTOR_CNT==m_val)   begin
                    RAM_ENABLE_WR=1;
                    VECTOR_CNT=0;
                    MATRIX_CNT=NEW_MATRIX_CNT;
                    VECTOR_ADD=U_ADD;
                    RAM_ADD_RD2=VECTOR_ADD;
                    RESULT_ADD=NEW_RESULT_ADD;
                end
            end

            Load2:  begin
                VECTOR_ADD=NEW_VECTOR_ADD;
                MATRIX_ADD=NEW_MATRIX_ADD;
                VECTOR_CNT=NEW_VECTOR_CNT;
                Element_Result=NEW_Element_Result;
                RAM_ADD_RD1=MATRIX_ADD;
                RAM_ADD_RD2=VECTOR_ADD;
                RAM_DATA_WR=Element_Result;
                RAM_ADD_WR=RESULT_ADD;

                RAM_ENABLE_WR=0;

                if(VECTOR_CNT==n_val)   begin
                    RAM_ENABLE_WR=1;
                    VECTOR_CNT=0;
                    MATRIX_CNT=NEW_MATRIX_CNT;
                    VECTOR_ADD=X_ADD;
                    RAM_ADD_RD2=VECTOR_ADD;
                    RESULT_ADD=NEW_RESULT_ADD;
                end
                
            end

            Final_Calc: begin
                RAM_ADD_RD2=MATRIX_ADD;
                RAM_ADD_WR=RESULT_ADD;
                RAM_ENABLE_WR=0;

                case (counter)
                    0:  begin
                        RAM_ADD_RD1=VECTOR2_ADD;
                        VECTOR_ADD=NEW_VECTOR_ADD;
                        counter=1;
                    end 

                    1:  begin
                        Element_Result=RAM_DATA_RD1;
                        RAM_ADD_RD1=VECTOR_ADD;
                        counter=2;
                    end

                    2:  begin
                        RAM_ENABLE_WR=1;
                        RAM_DATA_WR=FINAL_RESULT;
                        VECTOR2_ADD=NEW_VECTOR2_ADD;
                        MATRIX_ADD=NEW_MATRIX_ADD;
                        RESULT_ADD=NEW_RESULT_ADD;
                        VECTOR_CNT=NEW_VECTOR_CNT;
                        counter=0;
                    end
                    default:    counter=0;

                endcase
            end
        endcase
    end

    always@(PROCESS or INT)    begin
        DONE=0;
    end

    always@(CLK or state or INT or PROCESS or DONE) begin

        case(state)
            Start: begin
                if(Back)    begin
                    DONE=1;
                end
                Back=0;
                RAM_ENABLE_WR=0;
            end

            Init: begin
                n_ADD=0;
                m_ADD=1;
                h_ADD=4;
                A_ADD=7;
                B_ADD=2507;
                X_ADD=5207;
                U_ADD=5257;
                RES1_ADD=5307;
                RES2_ADD=5357;
                XNew_ADD=5407;
                counter=0;
                Back=1;
                
            end

            Prepare: begin
                Back=1;
                n_val=RAM_DATA_RD1;
                m_val=RAM_DATA_RD2;
            end

            Interpolate:    begin
                Interpolate_Enable=1;
                h_val=RAM_DATA_RD1;
            end


            Load1: begin
                if(Matrix_Multiplication1_Enable) begin
                    Matrix_Multiplication1_Enable=0;
                    VECTOR_CNT=0;
                    MATRIX_CNT=0;
                    Element_Result=0;
                    VECTOR_ADD=U_ADD;
                    MATRIX_ADD=B_ADD;
                    RESULT_ADD=RES1_ADD;
                    RAM_ADD_RD1=B_ADD;
                    RAM_ADD_RD2=U_ADD;
                    RAM_ADD_WR=RES1_ADD;
                end
                if (VECTOR_CNT==0) Element_Result=0;
            end

            Load2: begin
                if(Matrix_Multiplication2_Enable) begin
                    Matrix_Multiplication2_Enable=0;
                    VECTOR_CNT=0;
                    MATRIX_CNT=0;
                    Element_Result=0;
                    VECTOR_ADD=X_ADD;
                    MATRIX_ADD=A_ADD;
                    RESULT_ADD=RES2_ADD;
                    RAM_ADD_RD1=A_ADD;
                    RAM_ADD_RD2=X_ADD;
                    RAM_ADD_WR=RES2_ADD;
                end
                if (VECTOR_CNT==0) Element_Result=0;
            end
            Final_Calc: begin
                if(Final_Calc_Enable)   begin
                   Final_Calc_Enable=0;
                   VECTOR_CNT=0;
                   VECTOR_ADD=RES1_ADD;
                   MATRIX_ADD=RES2_ADD;
                   VECTOR2_ADD=X_ADD;
                   RESULT_ADD=XNew_ADD;
                   RAM_ADD_RD1=X_ADD;
                   RAM_ADD_RD2=RES2_ADD;
                   RAM_ADD_WR=XNew_ADD;
                end
            end

            
        endcase



        if(INT) begin
            if(!PROCESS) begin
                if (state==Init) next = Start;
                else begin
                    if(!DONE)  next = Init;
                    else next=Start;
                end
            end
            else begin
                case (state)
                    Start:      begin
                        if(!DONE)   begin
                            next=Prepare;
                            RAM_ADD_RD1=n_ADD;
                            RAM_ADD_RD2=m_ADD;
                        end
                    end
                    
                    Prepare:    begin
                        next=Interpolate;
                    end

                    Interpolate:    begin
                        if(Interpolate_DONE==1) begin
                            next=Load1;
                            Interpolate_Enable=0;
                            Matrix_Multiplication1_Enable=1;
                        end
                    end
                    
                    Load1:  begin
                        if (MATRIX_CNT==n_val)  begin
                            next=Load2;
                            Matrix_Multiplication2_Enable=1;
                        end
                    end
                    Load2:  begin
                        if(MATRIX_CNT==n_val)  begin
                            next=Final_Calc;
                            Final_Calc_Enable=1;
                        end
                    end

                    Final_Calc: begin
                        if(VECTOR_CNT==n_val)   next=Start;
                    end
                    default:    next=Start;
                endcase
            end
        end
        else    next=Start;

    end

    RAM #(ADDRESS_WIDTH,DATA_WIDTH,2**ADDRESS_WIDTH) Memory(CLK,1'b0,RAM_ENABLE_WR,RAM_ADD_RD1,RAM_ADD_RD2,RAM_ADD_WR,
    RAM_DATA_RD1,RAM_DATA_RD2,RAM_DATA_WR);

    
/**/
//Our Arithmetic

    multiplier_16bit MUL(RAM_DATA_RD1[15:0],RAM_DATA_RD2[15:0],Multiplication_Result[CUR_DATA_WIDTH-2:0],1'b1,overflow[0]);
    add_sub_cla ELEMENT_adder(1'b1,1'b0,Element_Result[CUR_DATA_WIDTH-2:0],Multiplication_Result[CUR_DATA_WIDTH-2:0],1'b0,NEW_Element_Result[CUR_DATA_WIDTH-2:0],NEW_Element_Result[CUR_DATA_WIDTH-1],invalid[0]);
    

    add_sub_cla VECTOR_ADD_adder(1'b1,1'b0,VECTOR_ADD[CUR_DATA_WIDTH-2:0],{16{1'b0}},1'b1,NEW_VECTOR_ADD[CUR_DATA_WIDTH-2:0],NEW_VECTOR_ADD[CUR_DATA_WIDTH-1],invalid[1]);
    add_sub_cla MATRIX_ADD_adder(1'b1,1'b0,MATRIX_ADD[CUR_DATA_WIDTH-2:0],{16{1'b0}},1'b1,NEW_MATRIX_ADD[CUR_DATA_WIDTH-2:0],NEW_MATRIX_ADD[CUR_DATA_WIDTH-1],invalid[2]);
    add_sub_cla VECTOR_CNT_adder(1'b1,1'b0,VECTOR_CNT[CUR_DATA_WIDTH-2:0],{16{1'b0}},1'b1,NEW_VECTOR_CNT[CUR_DATA_WIDTH-2:0],NEW_VECTOR_CNT[CUR_DATA_WIDTH-1],invalid[3]);
    add_sub_cla MATRIX_CNT_adder(1'b1,1'b0,MATRIX_CNT[CUR_DATA_WIDTH-2:0],{16{1'b0}},1'b1,NEW_MATRIX_CNT[CUR_DATA_WIDTH-2:0],NEW_MATRIX_CNT[CUR_DATA_WIDTH-1],invalid[4]);
    add_sub_cla RESULT_ADD_adder(1'b1,1'b0,RESULT_ADD[CUR_DATA_WIDTH-2:0],{16{1'b0}},1'b1,NEW_RESULT_ADD[CUR_DATA_WIDTH-2:0],NEW_RESULT_ADD[CUR_DATA_WIDTH-1],invalid[5]);
    add_sub_cla VECTOR2_ADD_adder(1'b1,1'b0,VECTOR2_ADD[CUR_DATA_WIDTH-2:0],{16{1'b0}},1'b1,NEW_VECTOR2_ADD[CUR_DATA_WIDTH-2:0],NEW_VECTOR2_ADD[CUR_DATA_WIDTH-1],invalid[6]);


    add_sub_cla VEC1_VEC2_adder(1'b1,1'b0,RAM_DATA_RD1[CUR_DATA_WIDTH-2:0],RAM_DATA_RD2[CUR_DATA_WIDTH-2:0],1'b0,Addition_Result[CUR_DATA_WIDTH-2:0],Addition_Result[CUR_DATA_WIDTH-1],invalid[7]);

    multiplier_16bit h_MUL(Addition_Result[CUR_DATA_WIDTH-2:0],h_val[CUR_DATA_WIDTH-2:0],h_VECTOR_RESULT[CUR_DATA_WIDTH-2:0],1'b1,overflow[1]);

    add_sub_cla FINAL_RESULT_adder(1'b1,1'b0,h_VECTOR_RESULT[CUR_DATA_WIDTH-2:0],Element_Result[CUR_DATA_WIDTH-2:0],1'b0,FINAL_RESULT[CUR_DATA_WIDTH-2:0],FINAL_RESULT[CUR_DATA_WIDTH-1],invalid[8]);

    




/*/
//Built-in Arithmetic

    assign Multiplication_Result[CUR_DATA_WIDTH-2:0]=RAM_DATA_RD1[15:0]*RAM_DATA_RD2[15:0];

    assign NEW_Element_Result[CUR_DATA_WIDTH-1:0] = {1'b0,Element_Result[CUR_DATA_WIDTH-2:0]} + {1'b0,Multiplication_Result[CUR_DATA_WIDTH-2:0]};



    assign NEW_VECTOR_ADD[CUR_DATA_WIDTH-1:0]={1'b0,VECTOR_ADD[CUR_DATA_WIDTH-2:0]} + {{(CUR_DATA_WIDTH-1){1'b0}},{1'b1}};
    assign NEW_MATRIX_ADD[CUR_DATA_WIDTH-1:0]={1'b0,MATRIX_ADD[CUR_DATA_WIDTH-2:0]} + {{(CUR_DATA_WIDTH-1){1'b0}},{1'b1}};
    assign NEW_VECTOR_CNT[CUR_DATA_WIDTH-1:0]={1'b0,VECTOR_CNT[CUR_DATA_WIDTH-2:0]} + {{(CUR_DATA_WIDTH-1){1'b0}},{1'b1}};
    assign NEW_MATRIX_CNT[CUR_DATA_WIDTH-1:0]={1'b0,MATRIX_CNT[CUR_DATA_WIDTH-2:0]} + {{(CUR_DATA_WIDTH-1){1'b0}},{1'b1}};
    assign NEW_RESULT_ADD[CUR_DATA_WIDTH-1:0]={1'b0,RESULT_ADD[CUR_DATA_WIDTH-2:0]} + {{(CUR_DATA_WIDTH-1){1'b0}},{1'b1}};
    assign NEW_VECTOR2_ADD[CUR_DATA_WIDTH-1:0]={1'b0,VECTOR2_ADD[CUR_DATA_WIDTH-2:0]} + {{(CUR_DATA_WIDTH-1){1'b0}},{1'b1}};

    assign Addition_Result[CUR_DATA_WIDTH-1:0] = {1'b0,RAM_DATA_RD1[CUR_DATA_WIDTH-2:0]} + {1'b0,RAM_DATA_RD2[CUR_DATA_WIDTH-2:0]};

    assign h_VECTOR_RESULT[CUR_DATA_WIDTH-2:0]=Addition_Result[CUR_DATA_WIDTH-2:0]*h_val[CUR_DATA_WIDTH-2:0];

    assign FINAL_RESULT[CUR_DATA_WIDTH-1:0]={1'b0,h_VECTOR_RESULT[CUR_DATA_WIDTH-2:0]} + {1'b0,Element_Result[CUR_DATA_WIDTH-2:0]};
/**/
endmodule