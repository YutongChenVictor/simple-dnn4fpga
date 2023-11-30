`include "PARAMS.vh"
module sigmoid(
    input       signed      [`DATA_SIZE - 1:0]      pre_data        ,

    output  reg signed      [`DATA_SIZE - 1:0]      act_data
);

wire    [2:0]                   func_choose     ;
wire    [`DATA_SIZE - 1:0]      data_func       ;



assign  func_choose = pre_data > `DATA_SIZE'sd262144 ? 3'b001 : pre_data < `DATA_SIZE'sd4294751052 ? 3'b100 : 3'b010;

always @ (*)begin
    case(func_choose)
        3'b001 : act_data <= `DATA_SIZE'd256;
        3'b010 : act_data <= data_func;
        3'b100 : act_data <= `DATA_SIZE'd0;
    endcase
end

appro_func func_inst(
    .pre_data   (pre_data   ),
    .data_func  (data_func  )
);

endmodule
