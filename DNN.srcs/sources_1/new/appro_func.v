`include "PARAMS.vh"

module appro_func(
    input   signed  [`DATA_SIZE - 1:0]      pre_data        ,
    output  signed  [`DATA_SIZE - 1:0]      data_func
);

assign  data_func = pre_data >> 2 + `DATA_SIZE'd128;

endmodule
