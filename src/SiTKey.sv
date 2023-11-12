`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Author: Dennis Addo <dennis_addo@aol.com>
// 
// Create Date: 07.09.2020 14:58:02
// Design Name: 
// Module Name: SiTKey
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


module pKci
   (
      input [3:0] ai,
      output logic [31:0] con
   );
   
   always_comb
   begin
     case (ai)
         0: con  = 4'h3;
         1: con = 4'hF;
         2: con = 4'hE;
         3: con = 4'h0;
         4: con = 4'h5;                 
         5: con = 4'h4;
         6: con = 4'hB;
         7: con = 4'hC;
         8: con = 4'hD;
         9: con = 4'hA;
         10: con = 4'h9;
         11: con = 4'h6;
         12: con = 4'h7;
         13: con = 4'h8;
         14: con = 4'h2;
         15: con = 4'h1;
        default : con = 4'hx; // 
      endcase  
   end
   
   ////Kci for the P Table
//uint8_t pKci[16] = {
//        0x3, 0xF, 0xE, 0x0, 0x5, 0x4, 0xB, 0xC, //3 F E 0 5 4 B C
//        0xD, 0xA, 0x9, 0x6, 0x7, 0x8, 0x2, 0x1}; // D A 9 6 7 8 2 1

endmodule


module qKci
   (
      input [3:0] ai,
      output logic [31:0] con
   );
   
   always_comb
   begin
     case (ai)
         0: con  = 4'h9;
         1: con = 4'hE;
         2: con = 4'h5;
         3: con = 4'h6;
         4: con = 4'hA;                 
         5: con = 4'h2;
         6: con = 4'h3;
         7: con = 4'hC;
         8: con = 4'hF;
         9: con = 4'h0;
         10: con = 4'h4;
         11: con = 4'hD;
         12: con = 4'h7;
         13: con = 4'hB;
         14: con = 4'h1;
         15: con = 4'h8;
        default : con = 4'hx; // 
      endcase  
   end
   ////Q Table
//uint8_t qKci[16] = {
//        0x9, 0xE, 0x5, 0x6, 0xA, 0x2, 0x3, 0xC, //9 E 5 6 A 2 3 C
//        0xF, 0x0, 0x4, 0xD, 0x7, 0xB, 0x1, 0x8}; // F 0 4 D 7 B 1 8
endmodule


//Todo: KeyExpansion for SiT encryption and Decryption.
module SiT_Function
   (
     input [15:0] kbi,
     output [15:0] kbo
   );
    
  wire [15:0] rt1;
  wire [15:0] rt2;
 // wire [15:0] rt3;
  
  //R1
    //genvar k;
    generate
        //for (k=0; k < 4; k++) begin : LT_1
            pKci pk_1(.ai(kbi[15:12]), .con(rt1[15:12]) );
            qKci qk_1(.ai(kbi[11:8]) , .con(rt1[11:8]) );
            
            pKci pk_2(.ai(kbi[7:4]), .con(rt1[7:4]) );
            qKci qk_2(.ai(kbi[3:0]), .con(rt1[3:0]) );
        //end
    endgenerate
    
   //R2 
   generate
        //for (k=0; k < 4; k++) begin : LT_1
            qKci qki_1(.ai( {rt1[15:14],rt1[11:10]} ), .con(rt2[15:12]) );
            pKci pki_1(.ai( {rt1[13:12],rt1[9:8]} ) , .con(rt2[11:8]) );
            
            qKci qki_2(.ai( {rt1[7:6],rt1[3:2]} ), .con(rt2[7:4]) );
            pKci pki_2(.ai( {rt1[5:4],rt1[1:0]} ), .con(rt2[3:0]) );
        //end
    endgenerate
 
    //R3
   generate
        //for (k=0; k < 4; k++) begin : LT_1
            pKci qke_1(.ai( {rt2[15:14],rt2[11:10]} ), .con(kbo[15:12]) );
            qKci pke_1(.ai( {rt2[13:12],rt2[9:8]} ) , .con(kbo[11:8]) );
            
            pKci qke_2(.ai( {rt2[7:6],rt2[3:2]} ), .con(kbo[7:4]) );
            qKci pke_2(.ai( {rt2[5:4],rt2[1:0]} ), .con(kbo[3:0]) );
        //end
    endgenerate   
    
    //assign kbo = rt3;

endmodule

module circshift_s
  #( 
     parameter i = 0
   )
   (
      input [3:0] ai,
      output [31:0] cirs
   );
   
   assign cirs = (i == 1) ? {ai[0], ai[3:1]} : (i == 2) ? {ai[1:0], ai[3:2]} : (i == 3) ? {ai[2:0], ai[3]} : ai;
   
endmodule


module ConcastFlip
   (
      input [15:0] ai,
      output [15:0] dout
   );
   
  wire [3:0] c_1;
  wire [3:0] c_2;
  wire [3:0] c_3;
  wire [3:0] c_4;
  
  assign {c_1,c_2,c_3,c_4} = {{ai[0],ai[4],ai[8],ai[12]},{ai[1],ai[5],ai[9],ai[13]},
                              {ai[2],ai[6],ai[10],ai[14]}, {ai[3],ai[7],ai[11],ai[15]} };
   
  assign dout = {  {{c_4[0], c_4[1], c_4[2], c_4[3]}} , c_3 , {c_2[0], c_2[1], c_2[2], c_2[3]}, c_1 };
   
endmodule


//Todo: KeyExpansion for SiT encryption and Decryption.
module SiTKey
   (
     input [63:0] key,
     output [79:0] keyExp
   );
   
   wire [63:0] kw1;
   wire [63:0] cirs;
   
   wire [15:0] cflip1;
   wire [15:0] cflip2;
   
//   assign kw1 = key[63:48];
//   assign kw2 = key[32:47];
//   assign kw3 = key[31:16];
//   assign kw4 = key[15:0];
   
   SiT_Function ff_kc1( .kbi(key[63:48]), .kbo(kw1[63:48]) );
   SiT_Function ff_kc2( .kbi(key[47:32]), .kbo(kw1[47:32]) );
   SiT_Function ff_kc3( .kbi(key[31:16]), .kbo(kw1[31:16]) );
   SiT_Function ff_kc4( .kbi(key[15:0]),  .kbo(kw1[15:0]) );
   

    genvar k;
    generate
        for (k=63; k > 0; k = k - 16) begin : cirshift
            assign cirs[k :(k-3)] = kw1[k :(k-3)];
            circshift_s #(.i(1)) circula_0(.ai(kw1[(k-4): (k-4)-3 ]), .cirs(cirs[(k-4): (k-4)-3 ] ) );
            circshift_s #(.i(2)) circula_1(.ai(kw1[(k-8): (k-8)-3 ]), .cirs(cirs[(k-8): (k-8)-3 ] ) );
            circshift_s #(.i(3)) circula_2(.ai(kw1[(k-12): (k-12)-3 ]), .cirs(cirs[(k-12): (k-12)-3 ] ) );
        end
        
        ConcastFlip dflip1(.ai(cirs[47:32]),.dout(cflip1) );
        ConcastFlip dflip2(.ai(cirs[31:16]),.dout(cflip2) );
        
    endgenerate
   
    assign keyExp = {cirs[63:48], cflip2, cflip1, cirs[15:0], {{ cirs[63:48]^ cflip2}^{ cflip1 ^ cirs[15:0]}}}; // cirs[63:48], cirs[15:0] flip/concast cirs[47:32] cirs[31:16]
   
endmodule




