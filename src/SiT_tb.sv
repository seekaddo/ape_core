`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.09.2020 15:31:03
// Design Name: 
// Module Name: SiT_tb
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


module SiT_tb;

    logic clk_i = 1;
    logic  en;
    logic [63:0] key;
    logic [79:0] keyExp;
    logic [63:0] plaintext;
    logic [63:0] ciphertext;
    
    
    wire [15:0] krFF;
    logic [15:0] kin;
    
    logic [3:0] csfh;
    wire [3:0] csfh_o;
    
    SiT_Function fFunc(.kbi(kin), .kbo(krFF) );
    SiTKey skeyExp(.key(key), .keyExp(keyExp) );
    circshift_s #(.i(3)) cirshh(.ai(csfh), .cirs(csfh_o) );
    
    
    wire [15:0] casflp_o;
    logic [15:0] cas_i;
    ConcastFlip cflip(.ai(cas_i),.dout(casflp_o) );
    
    SitEncryption encrptSiT(.plaint(plaintext), .keyExp(keyExp), .ciphert(ciphertext) );
    
    logic [63:0] cpltt1;
    logic [63:0] pltt1;
    SitDecryption decryptSiT(.ciphert(cpltt1), .keyExp(keyExp), .plaint(pltt1) );
    
    
     localparam period = 20; 
    
    //simulate the clock
    always 
    begin
      clk_i= 1; #period; clk_i= 0; #period;  // // 40ns period at each clock edge
    end
    
    initial 
    begin
        key = 64'h0011223344556674;
        plaintext = 64'h2677380043862078;
        cpltt1 = 64'hb74b9b4567aaf19e;
        csfh = 4'h6;
        cas_i = 16'he498;
        kin = key[63:48];
        en = 1;
        
        # period;

    end
    
    always @(negedge clk_i)
    begin

       
        $display("Encryption : Key: %h ",key);       
        $display("FF_Function 1-16bits: %h ",krFF);       
        //$display("KeyExpansion: %h ",keyExp);       
             
        $display("Circular shift: %b "  ,csfh_o);       
        $display("Key Expansion : %h "  ,keyExp[78:64] );       
        $display("Key Expansion : %h "  ,keyExp[63:48] );       
        $display("Key Expansion : %h "  ,keyExp[47:32] );      
        $display("Key Expansion : %h "  ,keyExp[31:16] );      
        $display("Key Expansion : %h "  ,keyExp[15:0] );      
        $display("Key Expansion Final : %h "  ,keyExp );      
        $display("Concast&Flip : %h "  , casflp_o ); 
        $display("ciphertext: %h "  ,ciphertext);      
        $display("Plaintext: %h "  ,pltt1);      
       $finish();
    end  


endmodule
