`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2020 21:10:35
// Design Name: 
// Module Name: decodeInst
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


module decodeInst
  (
     input clk_2,
     input [33:0]  data_i,
     output var [33:0]  d_cphtext
   );
    
    always_ff @(posedge clk_2) // remove falling edge
    begin
          d_cphtext  = data_i;
    end    
    
endmodule
