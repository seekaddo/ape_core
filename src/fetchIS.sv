`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Author: Dennis Addo <dennis_addo@aol.com>
// 
// Create Date: 07.08.2020 20:56:22
// Design Name: 
// Module Name: fetchInst
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


module fetchInst(
    input clk_1,
    input [63:0] key_in,
    input   [15:0]    tag,
    input [33:0]  data_i,
    output var [63:0] key_o,
    output var [33:0]  data_o,
    output var [15:0]  tag_o
    );
    

    
    always_ff @(posedge clk_1) // remove falling edge
    begin
          key_o = key_in;
          data_o = data_i;
          tag_o = tag;
    end
endmodule
