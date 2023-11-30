`include "PARAMS.vh"

module tb_dnn_soh;

    reg clk;
    reg rst_n;
    reg signed [`DATA_SIZE - 1:0] delta;
    reg signed [`DATA_SIZE - 1:0] Kin;
    
    wire signed [`DATA_SIZE - 1:0] omega;
    wire    data_out_en;
    // Instantiate the dnn module
    dnn_soh my_dnn (
        .clk(clk),
        .rst_n(rst_n),
        .data_in_0(delta),
        .data_in_1(Kin),
        .data_out(omega),
        .data_out_en(data_out_en)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Initialize inputs
    initial begin
        rst_n = 0;
            delta = `DATA_SIZE'd187199;
            Kin =   `DATA_SIZE'd4590619;
            //delta = 16'b0000000011011010; // Example input values
            //Kin =   16'b0000000010110100;
        // Release reset and provide inputs
        //delta = `DATA_SIZE'b00000000000000001101101011111111; // Example input values
        //Kin =   `DATA_SIZE'b00000000000000001011010000100010;  // Example input values
        
        #10 rst_n = 1;


        // Add additional input sequences as needed

        // Wait for some time to observe the outputs
        
    end

endmodule

