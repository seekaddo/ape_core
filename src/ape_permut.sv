`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2021 22:19:53
// Design Name: Addo Dennis
// Module Name: ape_permut
// Name: Dennis Addo
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

//Proper Implementation will be implemented later

module ape_pe(
      input logic  [49:0] in,
      output logic [49:0] dout
      );
 //just simple permiutation for testing {in[19:0],10'h0,20'h0};
  assign dout = {in[19:0], in[29:20], in[49:30] };
    
endmodule
