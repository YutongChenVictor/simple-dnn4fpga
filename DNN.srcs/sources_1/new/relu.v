`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/20 13:23:46
// Design Name: 
// Module Name: relu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "PARAMS.vh"

module relu(
    input   signed  [`DATA_SIZE - 1:0]      pre_data     ,
    output  signed  [`DATA_SIZE - 1:0]      relu_data
    );
    
    assign relu_data = pre_data[`DATA_SIZE - 1] ?`DATA_SIZE'd0 : pre_data;
    
endmodule
