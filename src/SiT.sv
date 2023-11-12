`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Author: Dennis Addo <dennis_addo@aol.com>
// 
// Create Date: 07.09.2020 14:58:02
// Design Name: 
// Module Name: SiT
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




module RoundSwap
   #( 
     parameter round = 0
   )(
      input [15:0] key,
      input [63:0] data,
      output [63:0] dout
   );
   
   wire [15:0] enc0;
   wire [15:0] enc1;
   wire [15:0] enc2;
   wire [15:0] enc3;
   
   wire [31:0] rout;
   wire [15:0] t1;
   wire [15:0] t2;
   
   assign {enc0,enc1,enc2,enc3} = data;
   //////// enc3, enc2, enc1 enc0
   
   assign t1 = ~{key ^ enc0};
   assign t2 = ~{key ^ enc3};
   
   generate
       SiT_Function f1( .kbi(t1), .kbo(rout[31:16]) );
       SiT_Function f2( .kbi(t2), .kbo(rout[15:0]) );
   endgenerate
   
   assign dout =  (round == 5) ? { t1, {rout[31:16] ^ enc2}, {rout[15:0] ^ enc1}, t2}
                   : {{rout[31:16] ^ enc2}, t1, t2, {rout[15:0] ^ enc1}};
   
endmodule

module Round_i
   (
      input [15:0] key,
      input [63:0] data,
      output [63:0] dout
   );
   
   wire [15:0] enc0;
   wire [15:0] enc1;
   wire [15:0] enc2;
   wire [15:0] enc3;
   
   wire [31:0] rout;
   wire [15:0] t1;
   wire [15:0] t2;
   
   assign {enc0,enc1,enc2,enc3} = data;
   
   
   assign t1 = ~{key ^ enc0};
   assign t2 = ~{key ^ enc3};
   
   generate
       SiT_Function f1( .kbi(t1 ), .kbo(rout[31:16]) );
       SiT_Function f2( .kbi(t2 ), .kbo(rout[15:0]) );
   endgenerate

   assign dout =  {t1, rout[31:16] ^ enc1 , rout[15:0] ^ enc2, t2 };
   
endmodule


module SitEncryption
   (
     input [63:0] plaint,
     input [79:0] keyExp,
     output [63:0] ciphert
   );
   
   wire [15:0] k1;
   wire [15:0] k2;
   wire [15:0] k3;
   wire [15:0] k4;
   wire [15:0] k5;

   wire [63:0] cphter;
   wire [63:0] cphter1;
   wire [63:0] cphter2;
   wire [63:0] cphter3;

   
   assign {k1,k2,k3,k4,k5} = keyExp;
   
   generate
         RoundSwap r1( .key(k1), .data(plaint), .dout(cphter) );
         
          //Todo: Rounding -2//
          Round_i  r2( .key(k2), .data(cphter), .dout(cphter1) );
          RoundSwap r3( .key(k3), .data(cphter1), .dout(cphter2) );
          Round_i  r4( .key(k4), .data(cphter2), .dout(cphter3) ); 
          RoundSwap#(.round(5))  r5( .key(k5), .data(cphter3), .dout(ciphert) ); 
   endgenerate
   
   
   
endmodule



//module Rinverse_i // odd
//   (
//      input [15:0] key,
//      input [63:0] data,
//      output [63:0] dout
//   );
   
//   wire [15:0] enc0;
//   wire [15:0] enc1;
//   wire [15:0] enc2;
//   wire [15:0] enc3;
   
//   wire [31:0] rout;
//   wire [15:0] t1;
//   wire [15:0] t2;
   
//   assign {enc0,enc1,enc2,enc3} = data;
//         //bit3 bit2 bit1 bit0
   
   
//   assign t1 = ~{key ^ enc0};
//   assign t2 = ~{key ^ enc3};
   
//   generate
//       SiT_Function f1( .kbi(enc3 ), .kbo(rout[31:16]) );
//       SiT_Function f2( .kbi(enc0 ), .kbo(rout[15:0]) );
//   endgenerate

//   assign dout =  {t1, rout[31:16] ^ enc2 , rout[15:0] ^ enc1, t2 };
   
//endmodule



//module RinverseSwap // Even
//   (
//      input [15:0] key,
//      input [63:0] data,
//      output [63:0] dout
//   );
   
//   wire [15:0] enc0;
//   wire [15:0] enc1;
//   wire [15:0] enc2;
//   wire [15:0] enc3;
   
//   wire [31:0] rout;
//   wire [15:0] t1;
//   wire [15:0] t2;
   
//   assign {enc0,enc1,enc2,enc3} = data;
//         //bit3 bit2 bit1 bit0
   
   
//   assign t1 = ~{key ^ enc0};
//   assign t2 = ~{key ^ enc3};
   
//   generate
//       SiT_Function f1( .kbi(enc0 ), .kbo(rout[31:16]) );
//       SiT_Function f2( .kbi(enc3 ), .kbo(rout[15:0]) );
//   endgenerate

//   //assign dout =  {t1, rout[31:16] ^ enc1 , rout[15:0] ^ enc2, t2 };
//   assign dout =  {rout[31:16] ^ enc1, t1, t2 , rout[15:0] ^ enc2 };
   
//endmodule


module RinverseDec
   #( 
     parameter round = 1
   )
   (
      input [15:0] key,
      input [63:0] data,
      output [63:0] dout
   );
   
   wire [15:0] enc0;
   wire [15:0] enc1;
   wire [15:0] enc2;
   wire [15:0] enc3;
   
   wire [31:0] rout;
   wire [15:0] t1;
   wire [15:0] t2;
   
   assign {enc0,enc1,enc2,enc3} = data;
         //bit3 bit2 bit1 bit0
   
   
   assign t1 = ~{key ^ enc0};
   assign t2 = ~{key ^ enc3};
   
   generate
       SiT_Function f1( .kbi((round % 2) == 0 ? enc0 : enc3 ), .kbo(rout[31:16]) );
       SiT_Function f2( .kbi((round % 2) == 0 ? enc3 : enc0 ), .kbo(rout[15:0]) );
   endgenerate

   
   assign dout = (round % 2) == 0 ? {rout[31:16] ^ enc1, t1, t2 , rout[15:0] ^ enc2 }
                  : {t1, rout[31:16] ^ enc2 , rout[15:0] ^ enc1, t2 } ;
   
endmodule


module SitDecryption
   (
     input [63:0] ciphert,
     input [79:0] keyExp,
     output [63:0] plaint
   );
   
//   wire [15:0] k1;
//   wire [15:0] k2;
//   wire [15:0] k3;
//   wire [15:0] k4;
//   wire [15:0] k5;

//   wire [63:0] plaint0;
//   wire [63:0] plaint1;
//   wire [63:0] plaint2;
//   wire [63:0] plaint3;
   wire [63:0] pdata [5:0];
   wire [15:0] pkey [4:0];
   
   assign pdata[0] = ciphert;
   //assign {k1,k2,k3,k4,k5} = keyExp;
   assign {pkey[4],pkey[3],pkey[2],pkey[1],pkey[0]} = keyExp;
   
//   generate
//       Rinverse_i r1( .key(k5), .data(ciphert), .dout(plaint0) );
//       RinverseSwap r2( .key(k4), .data(plaint0), .dout(plaint1) );
//       Rinverse_i r3( .key(k3), .data(plaint1), .dout(plaint2) );
//       RinverseSwap r4( .key(k2), .data(plaint2), .dout(plaint3) );
//       Rinverse_i r5( .key(k1), .data(plaint3), .dout(plaint) );
//   endgenerate
    genvar k;
    generate
        for (k=1; k < 6; k++) begin : SiTDec
              RinverseDec#(.round(k)) rN( .key(pkey[k-1]), .data(pdata[k-1]), .dout(pdata[k]) );
        end
    endgenerate
    
    assign plaint = pdata[5];
   
endmodule