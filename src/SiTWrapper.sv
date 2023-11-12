`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.09.2020 12:37:09
// Design Name: 
// Module Name: SiTWrapper
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


module SiTWrapper
   (
     input [63:0] key,
     input [63:0] plaintext,
     output [63:0] cphtext
    );
    
    wire [79:0] int_kexp;
    
     generate 
        SiTKey skeyExp(.key(key), .keyExp(int_kexp) );
     endgenerate
    
    //SitEncryption encrptSiT(.plaint(plaintext), .keyExp(int_kexp), .ciphert(cphtext) );
    SitDecryption decryptSiT(.ciphert(plaintext), .keyExp(int_kexp), .plaint(cphtext) );

    
endmodule
