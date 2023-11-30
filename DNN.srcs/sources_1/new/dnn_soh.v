`include "PARAMS.vh"
module dnn_soh(
    input                                           clk             ,
    input                                           rst_n           ,
    input       signed      [`DATA_SIZE - 1:0]      data_in_0       ,
    input       signed      [`DATA_SIZE - 1:0]      data_in_1       ,

    output reg  signed      [`DATA_SIZE - 1:0]      data_out        ,
    output reg                                      data_out_en
);

    parameter WEIGHTS_LAYER_1_0_0 = `DATA_SIZE'b00000000000000000111000101001110   ;
    parameter WEIGHTS_LAYER_1_0_1 = `DATA_SIZE'b00000000000000000111100010101110   ;
    parameter WEIGHTS_LAYER_1_1_0 = `DATA_SIZE'b11111111111111111011111010101011   ;
    parameter WEIGHTS_LAYER_1_1_1 = `DATA_SIZE'b00000000000000001000110101010110   ;
    parameter WEIGHTS_LAYER_1_2_0 = `DATA_SIZE'b11111111111111111100010011001010   ;
    parameter WEIGHTS_LAYER_1_2_1 = `DATA_SIZE'b00000000000000000001000100001101   ;
    parameter WEIGHTS_LAYER_1_3_0 = `DATA_SIZE'b11111111111111111000111110100100   ;
    parameter WEIGHTS_LAYER_1_3_1 = `DATA_SIZE'b00000000000000000100111001110111   ;
    parameter WEIGHTS_LAYER_1_4_0 = `DATA_SIZE'b00000000000000001001111110010001   ;
    parameter WEIGHTS_LAYER_1_4_1 = `DATA_SIZE'b11111111111111110111101100110000   ;
    parameter WEIGHTS_LAYER_1_5_0 = `DATA_SIZE'b00000000000000001000001110011100   ;
    parameter WEIGHTS_LAYER_1_5_1 = `DATA_SIZE'b00000000000000000000001001010100   ;
    parameter WEIGHTS_LAYER_1_6_0 = `DATA_SIZE'b00000000000000001010001100111010   ;
    parameter WEIGHTS_LAYER_1_6_1 = `DATA_SIZE'b00000000000000000011111101011100   ;
    parameter WEIGHTS_LAYER_1_7_0 = `DATA_SIZE'b00000000000000000100110011101110   ;
    parameter WEIGHTS_LAYER_1_7_1 = `DATA_SIZE'b11111111111111111101110100010101   ;

    parameter BIAS_LAYER_1_0      = `DATA_SIZE'b00000000000000000110111101100011   ;
    parameter BIAS_LAYER_1_1      = `DATA_SIZE'b00000000000000000000001001100001   ;
    parameter BIAS_LAYER_1_2      = `DATA_SIZE'b11111111111111111001011111110000   ;
    parameter BIAS_LAYER_1_3      = `DATA_SIZE'b00000000000000000001001101101000   ;
    parameter BIAS_LAYER_1_4      = `DATA_SIZE'b11111111111111111010110010011000   ;
    parameter BIAS_LAYER_1_5      = `DATA_SIZE'b11111111111111111100110100001110   ;
    parameter BIAS_LAYER_1_6      = `DATA_SIZE'b11111111111111111101101001011000   ;
    parameter BIAS_LAYER_1_7      = `DATA_SIZE'b00000000000000000110110111000110   ;

    parameter WEIGHTS_LAYER_2_0   = `DATA_SIZE'b11111111111111111101100011111100   ;
    parameter WEIGHTS_LAYER_2_1   = `DATA_SIZE'b11111111111111111111011100110010   ;
    parameter WEIGHTS_LAYER_2_2   = `DATA_SIZE'b00000000000000000000000100100111   ;
    parameter WEIGHTS_LAYER_2_3   = `DATA_SIZE'b11111111111111111110100101001011   ;
    parameter WEIGHTS_LAYER_2_4   = `DATA_SIZE'b00000000000000000000100010001101   ;
    parameter WEIGHTS_LAYER_2_5   = `DATA_SIZE'b11111111111111111011110100101111   ;
    parameter WEIGHTS_LAYER_2_6   = `DATA_SIZE'b00000000000000000111110111011001   ;
    parameter WEIGHTS_LAYER_2_7   = `DATA_SIZE'b11111111111111111011110010010010   ;

    parameter BIAS_LAYER_2_0      = `DATA_SIZE'b00000000000000000110011000111001   ;

    reg                     [2:0]                        cnt_layer          ;

    reg   signed            [`DATA_DOUBLE_SIZE - 1:0]    mult_0             ;
    reg   signed            [`DATA_DOUBLE_SIZE - 1:0]    mult_1             ;
    reg   signed            [`DATA_DOUBLE_SIZE - 1:0]    mult_2             ;
    reg   signed            [`DATA_DOUBLE_SIZE - 1:0]    mult_3             ;
    reg   signed            [`DATA_DOUBLE_SIZE - 1:0]    mult_4             ;
    reg   signed            [`DATA_DOUBLE_SIZE - 1:0]    mult_5             ;
    reg   signed            [`DATA_DOUBLE_SIZE - 1:0]    mult_6             ;
    reg   signed            [`DATA_DOUBLE_SIZE - 1:0]    mult_7             ;

    reg   signed            [`DATA_SIZE - 1:0]          mult_0_in1          ;
    reg   signed            [`DATA_SIZE - 1:0]          mult_1_in1          ;
    reg   signed            [`DATA_SIZE - 1:0]          mult_2_in1          ;
    reg   signed            [`DATA_SIZE - 1:0]          mult_3_in1          ;
    reg   signed            [`DATA_SIZE - 1:0]          mult_4_in1          ;
    reg   signed            [`DATA_SIZE - 1:0]          mult_5_in1          ;
    reg   signed            [`DATA_SIZE - 1:0]          mult_6_in1          ;
    reg   signed            [`DATA_SIZE - 1:0]          mult_7_in1          ;

    reg   signed            [`DATA_SIZE - 1:0]          mult_0_in2          ;
    reg   signed            [`DATA_SIZE - 1:0]          mult_1_in2          ;
    reg   signed            [`DATA_SIZE - 1:0]          mult_2_in2          ;
    reg   signed            [`DATA_SIZE - 1:0]          mult_3_in2          ;
    reg   signed            [`DATA_SIZE - 1:0]          mult_4_in2          ;
    reg   signed            [`DATA_SIZE - 1:0]          mult_5_in2          ;
    reg   signed            [`DATA_SIZE - 1:0]          mult_6_in2          ;
    reg   signed            [`DATA_SIZE - 1:0]          mult_7_in2          ;

    reg   signed            [`DATA_SIZE - 1:0]          out_layer1_0        ;
    reg   signed            [`DATA_SIZE - 1:0]          out_layer1_1        ;
    reg   signed            [`DATA_SIZE - 1:0]          out_layer1_2        ;
    reg   signed            [`DATA_SIZE - 1:0]          out_layer1_3        ;
    reg   signed            [`DATA_SIZE - 1:0]          out_layer1_4        ;
    reg   signed            [`DATA_SIZE - 1:0]          out_layer1_5        ;
    reg   signed            [`DATA_SIZE - 1:0]          out_layer1_6        ;
    reg   signed            [`DATA_SIZE - 1:0]          out_layer1_7        ;

    wire  signed            [`DATA_SIZE - 1:0]          mult_group_1        ;
    wire  signed            [`DATA_SIZE - 1:0]          mult_group_2        ;

    wire  signed            [`DATA_SIZE - 1:0]          out_layer1_0_act    ;
    wire  signed            [`DATA_SIZE - 1:0]          out_layer1_1_act    ;
    wire  signed            [`DATA_SIZE - 1:0]          out_layer1_2_act    ;
    wire  signed            [`DATA_SIZE - 1:0]          out_layer1_3_act    ;
    wire  signed            [`DATA_SIZE - 1:0]          out_layer1_4_act    ;
    wire  signed            [`DATA_SIZE - 1:0]          out_layer1_5_act    ;
    wire  signed            [`DATA_SIZE - 1:0]          out_layer1_6_act    ;
    wire  signed            [`DATA_SIZE - 1:0]          out_layer1_7_act    ;

    always @ (posedge clk or negedge rst_n)begin
        if (!rst_n)
            cnt_layer <= 3'b0;
        else if (cnt_layer == 3'd5)
            cnt_layer <= 3'd5;
        else
            cnt_layer <= cnt_layer + 1'b1;
    end

    always @ (posedge clk or negedge rst_n)begin
        if (!rst_n)
            data_out_en <= 1'b0;
        else if (cnt_layer == 3'd5)
            data_out_en <= 1'd1;
    end

    always @ (posedge clk or negedge rst_n)begin
        if (!rst_n) begin
            mult_0_in1 <= `DATA_SIZE'd0;
            mult_1_in1 <= `DATA_SIZE'd0;
            mult_2_in1 <= `DATA_SIZE'd0;
            mult_3_in1 <= `DATA_SIZE'd0;
            mult_4_in1 <= `DATA_SIZE'd0;
            mult_5_in1 <= `DATA_SIZE'd0;
            mult_6_in1 <= `DATA_SIZE'd0;
            mult_7_in1 <= `DATA_SIZE'd0;
        end
        else if (cnt_layer == 3'd0) begin
            mult_0_in1 <= WEIGHTS_LAYER_1_0_0;
            mult_1_in1 <= WEIGHTS_LAYER_1_1_0;
            mult_2_in1 <= WEIGHTS_LAYER_1_2_0;
            mult_3_in1 <= WEIGHTS_LAYER_1_3_0;
            mult_4_in1 <= WEIGHTS_LAYER_1_4_0;
            mult_5_in1 <= WEIGHTS_LAYER_1_5_0;
            mult_6_in1 <= WEIGHTS_LAYER_1_6_0;
            mult_7_in1 <= WEIGHTS_LAYER_1_7_0;
        end
        else if (cnt_layer == 3'd1) begin
            mult_0_in1 <= WEIGHTS_LAYER_1_0_1;
            mult_1_in1 <= WEIGHTS_LAYER_1_1_1;
            mult_2_in1 <= WEIGHTS_LAYER_1_2_1;
            mult_3_in1 <= WEIGHTS_LAYER_1_3_1;
            mult_4_in1 <= WEIGHTS_LAYER_1_4_1;
            mult_5_in1 <= WEIGHTS_LAYER_1_5_1;
            mult_6_in1 <= WEIGHTS_LAYER_1_6_1;
            mult_7_in1 <= WEIGHTS_LAYER_1_7_1;
        end
        else if (cnt_layer >= 3'd3) begin
            mult_0_in1 <= WEIGHTS_LAYER_2_0;
            mult_1_in1 <= WEIGHTS_LAYER_2_1;
            mult_2_in1 <= WEIGHTS_LAYER_2_2;
            mult_3_in1 <= WEIGHTS_LAYER_2_3;
            mult_4_in1 <= WEIGHTS_LAYER_2_4;
            mult_5_in1 <= WEIGHTS_LAYER_2_5;
            mult_6_in1 <= WEIGHTS_LAYER_2_6;
            mult_7_in1 <= WEIGHTS_LAYER_2_7;
        end
    end

    always @ (posedge clk or negedge rst_n)begin
        if (!rst_n) begin
            mult_0_in2 <= `DATA_SIZE'd0;
            mult_1_in2 <= `DATA_SIZE'd0;
            mult_2_in2 <= `DATA_SIZE'd0;
            mult_3_in2 <= `DATA_SIZE'd0;
            mult_4_in2 <= `DATA_SIZE'd0;
            mult_5_in2 <= `DATA_SIZE'd0;
            mult_6_in2 <= `DATA_SIZE'd0;
            mult_7_in2 <= `DATA_SIZE'd0;
        end
        else if (cnt_layer == 3'd0) begin
            mult_0_in2 <= data_in_0;
            mult_1_in2 <= data_in_0;
            mult_2_in2 <= data_in_0;
            mult_3_in2 <= data_in_0;
            mult_4_in2 <= data_in_0;
            mult_5_in2 <= data_in_0;
            mult_6_in2 <= data_in_0;
            mult_7_in2 <= data_in_0;
        end
        else if (cnt_layer == 3'd1) begin
            mult_0_in2 <= data_in_1;
            mult_1_in2 <= data_in_1;
            mult_2_in2 <= data_in_1;
            mult_3_in2 <= data_in_1;
            mult_4_in2 <= data_in_1;
            mult_5_in2 <= data_in_1;
            mult_6_in2 <= data_in_1;
            mult_7_in2 <= data_in_1;
        end
        else if (cnt_layer == 3'd3) begin
            mult_0_in2 <= out_layer1_0_act;
            mult_1_in2 <= out_layer1_1_act;
            mult_2_in2 <= out_layer1_2_act;
            mult_3_in2 <= out_layer1_3_act;
            mult_4_in2 <= out_layer1_4_act;
            mult_5_in2 <= out_layer1_5_act;
            mult_6_in2 <= out_layer1_6_act;
            mult_7_in2 <= out_layer1_7_act;
        end
    end

    always @ (posedge clk or negedge rst_n)begin
        if (!rst_n) begin
            mult_0 <= `DATA_DOUBLE_SIZE'd0;
            mult_1 <= `DATA_DOUBLE_SIZE'd0;
            mult_2 <= `DATA_DOUBLE_SIZE'd0;
            mult_3 <= `DATA_DOUBLE_SIZE'd0;
            mult_4 <= `DATA_DOUBLE_SIZE'd0;
            mult_5 <= `DATA_DOUBLE_SIZE'd0;
            mult_6 <= `DATA_DOUBLE_SIZE'd0;
            mult_7 <= `DATA_DOUBLE_SIZE'd0;
        end
        else if (cnt_layer >= 3'd1 && !data_out_en) begin
            mult_0 <=  mult_0_in1 * mult_0_in2;
            mult_1 <=  mult_1_in1 * mult_1_in2;
            mult_2 <=  mult_2_in1 * mult_2_in2;
            mult_3 <=  mult_3_in1 * mult_3_in2;
            mult_4 <=  mult_4_in1 * mult_4_in2;
            mult_5 <=  mult_5_in1 * mult_5_in2;
            mult_6 <=  mult_6_in1 * mult_6_in2;
            mult_7 <=  mult_7_in1 * mult_7_in2;
        end
    end

    always @ (negedge clk or negedge rst_n)begin
        if (!rst_n)begin
            out_layer1_0 <= BIAS_LAYER_1_0;
            out_layer1_1 <= BIAS_LAYER_1_1;
            out_layer1_2 <= BIAS_LAYER_1_2;
            out_layer1_3 <= BIAS_LAYER_1_3;
            out_layer1_4 <= BIAS_LAYER_1_4;
            out_layer1_5 <= BIAS_LAYER_1_5;
            out_layer1_6 <= BIAS_LAYER_1_6;
            out_layer1_7 <= BIAS_LAYER_1_7;
        end
        else if (cnt_layer == 3'd2) begin
            out_layer1_0 <= out_layer1_0 + mult_0[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE];
            out_layer1_1 <= out_layer1_1 + mult_1[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE];
            out_layer1_2 <= out_layer1_2 + mult_2[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE];
            out_layer1_3 <= out_layer1_3 + mult_3[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE];
            out_layer1_4 <= out_layer1_4 + mult_4[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE];
            out_layer1_5 <= out_layer1_5 + mult_5[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE];
            out_layer1_6 <= out_layer1_6 + mult_6[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE];
            out_layer1_7 <= out_layer1_7 + mult_7[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE];
        end
        else if (cnt_layer == 3'd3) begin
            out_layer1_0 <= out_layer1_0 + mult_0[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE];
            out_layer1_1 <= out_layer1_1 + mult_1[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE];
            out_layer1_2 <= out_layer1_2 + mult_2[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE];
            out_layer1_3 <= out_layer1_3 + mult_3[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE];
            out_layer1_4 <= out_layer1_4 + mult_4[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE];
            out_layer1_5 <= out_layer1_5 + mult_5[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE];
            out_layer1_6 <= out_layer1_6 + mult_6[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE];
            out_layer1_7 <= out_layer1_7 + mult_7[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE];
        end
/*        else begin
            out_layer1_0 <= out_layer1_0;
            out_layer1_1 <= out_layer1_1;
            out_layer1_2 <= out_layer1_2;
            out_layer1_3 <= out_layer1_3;
            out_layer1_4 <= out_layer1_4;
            out_layer1_5 <= out_layer1_5;
            out_layer1_6 <= out_layer1_6;
            out_layer1_7 <= out_layer1_7;
        end*/
    end

    always @ (negedge clk or negedge rst_n)begin
        if (!rst_n)
            data_out <= `DATA_SIZE'b0;
        else if (cnt_layer == 3'd5)
            data_out <= BIAS_LAYER_2_0 + mult_group_1 + mult_group_2;
    end

    assign mult_group_1 = mult_0[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE] + mult_1[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE] + mult_2[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE] + mult_3[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE];
    assign mult_group_2 = mult_4[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE] + mult_5[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE] + mult_6[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE] + mult_7[`DATA_SIZE + `QUAN_SIZE - 1:`QUAN_SIZE];

    relu act_mult_0(out_layer1_0, out_layer1_0_act);
    relu act_mult_1(out_layer1_1, out_layer1_1_act);
    relu act_mult_2(out_layer1_2, out_layer1_2_act);
    relu act_mult_3(out_layer1_3, out_layer1_3_act);
    relu act_mult_4(out_layer1_4, out_layer1_4_act);
    relu act_mult_5(out_layer1_5, out_layer1_5_act);
    relu act_mult_6(out_layer1_6, out_layer1_6_act);
    relu act_mult_7(out_layer1_7, out_layer1_7_act);

endmodule
