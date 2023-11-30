`include "PARAMS.vh"

module tb_sigmoid;

    reg signed  [`DATA_SIZE - 1:0]  pre_data;
    reg                             clk;
    reg                             rst;

    wire signed [`DATA_SIZE - 1:0]  act_data;

    // Instantiate the sigmoid module
    sigmoid sigmoid_inst (
        .pre_data(pre_data),
        .act_data(act_data)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Initial block
    initial begin
        clk = 0;
        rst = 1;

        // Apply reset
        #10 rst = 0;

        // Test case 1
        #10 pre_data = `DATA_SIZE'sd1200; // Example value, adjust as needed

        // Test case 2
        #10 pre_data = `DATA_SIZE'sd500;  // Example value, adjust as needed

        // Add more test cases as needed

        #100 $stop; // Stop simulation after some time
    end



    // Add any additional checks or monitors as needed

endmodule
