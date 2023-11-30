`include "PARAMS.vh"


module tb_dnn_soc;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in time units
  parameter SIM_TIME   = 100; // Simulation time in time units

  // Signals
  reg clk, rst_n;
  reg signed [`DATA_SIZE - 1:0] data_in_0, data_in_1, data_in_2;
  wire signed [`DATA_SIZE - 1:0] data_out;
  wire data_out_en;

  // Instantiate the DNN module
  dnn_soc dut (
    .clk(clk),
    .rst_n(rst_n),
    .data_in_0(data_in_0),
    .data_in_1(data_in_1),
    .data_in_2(data_in_2),
    .data_out(data_out),
    .data_out_en(data_out_en)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Reset generation
  initial begin
  clk = 1'b1;
    rst_n = 1'b0;
    #10 rst_n = 1'b1;
  end

  // Stimulus generation
  initial begin
    // Add your test vectors here
    /*data_in_0 = `DATA_SIZE'd275614;
    data_in_1 = `DATA_SIZE'd131068;
    data_in_2 = `DATA_SIZE'd1703936;*/
//2.3982400044006464,1.1404286418043554,26
    data_in_0 = `DATA_SIZE'd157171;
    data_in_1 = `DATA_SIZE'd74739;
    data_in_2 = `DATA_SIZE'd1703936;
   end

endmodule

