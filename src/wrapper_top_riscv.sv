`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2020 21:13:59
// Design Name: 
// Module Name: wrapper_top_riscv
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



module wrapper_top_riscv
  (
    input clk_i,
    input [63:0] k,
    input [33:0] ciptext_in,
    input   [15:0]    tag,
    output [33:0] pltxt
  );
    
    
    wire [63:0] int_key;
    //wire [127:0] int_key;
    wire [33:0] int_data;
    wire [33:0] int_ctext;
    wire [33:0] mText;
    wire [15:0] Tag_io; // 16bit Tag len
    
    logic err_i;
    logic [15:0]    Vc;
    logic [33:0]    prevISA;
        
    logic [15:0]    vc_latch;
    logic [33:0]    prev_latch;
    
    

    fetchInst fetchMem_1 (clk_i, k,tag, ciptext_in, int_key, int_data, Tag_io);
    
//    module Ape (
//      input             clk,
//      input   [63:0]    key_i,
//      input   [15:0]    tag,
//      intput  [33:0]    Ctext,
//      output var [33:0]    dout
//      //output [15:0] Tag_o // 16bit Tag len
//   );
    Ape ape_enc (clk_i, err_i, int_key, Tag_io, int_data, Vc, prevISA, int_ctext, vc_latch, prev_latch );
    
    decodeInst decoder_1 (clk_i, int_ctext, pltxt );
    
endmodule

/*module wrapper_top_riscv
  (
    input clk_i,
    input [63:0] k,
    //input [127:0] k,
   // input [127:0] key,
    input [63:0] data_in,
    output [63:0] cptext
  );
    
    
    wire [63:0] int_key;
    //wire [127:0] int_key;
    wire [63:0] int_data;
    wire [63:0] int_ctext;
    //wire [79:0] int_kexp;
    wire [239:0] plt_i;
    wire [239:0] Ctext_i;
    wire [15:0] Tag_io; // 16bit Tag len
    
    

    fetchInst fetchMem_1 (clk_i, k, data_in, int_key, int_data);
    
    //encrypt enc_pico (int_key, int_data, int_ctext );
//     encryption encrptT (int_key, int_data, int_ctext ); //use this
    //prince_enc prince_0 (.key(k), .plaintext(int_data), .ciphertext(int_ctext)); //Using the prince core
     //prince_dec decrypt_0 (.key_c(int_key), .ci(int_data), .plaintext(int_ctext));
     
     //wire [79:0] keyExp;

     
     //SitEncryption encrptSiT(.plaint(int_data), .keyExp(int_kexp), .ciphert(int_ctext) );
     //SiTWrapper encrptSiT(.key(int_key), .plaintext(int_data),  .cphtext(int_ctext) );
     
     //Ape ape_enc (int_key,plt_i,Ctext_i,Tag_io );
    
    decodeInst decoder_1 (clk_i, int_ctext, cptext );
    
endmodule
*/

//module wrapper_top_dff
//  (
//    input clk_i,
//    input [127:0] k,
//    input [63:0] data_in,
//    output [63:0] cptext
//  );
    
    
//    wire [127:0] int_key;
//    wire [63:0] int_data;
//    wire [63:0] int_ctext;
    
    

//    fetchInst fetch (clk_i, k, data_in, int_key, int_data);
    
//    //diffusionM diffusion (int_key, int_data, int_ctext );
//    prince_dec decrypt_0 (.key_c(k), .ci(int_data), .plaintext(int_ctext));
    
//    decodeInst decode (clk_i, int_ctext, cptext );
    
//endmodule


