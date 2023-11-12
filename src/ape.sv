`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Dennis Addo <dennis_addo@aol.com>
// Create Date: 01.02.2021 19:19:40
// Module Name: ape
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
// Name: Dennis Addo
//////////////////////////////////////////////////////////////////////////////////
//
// APE --> IE version
// Rate: 34
// capacity: 16
//

module Ape (
      input  logic           clk,
      input  logic           error,
      input  logic [63:0]    key_i,
      input  logic [15:0]    tag,
      input  logic [33:0]    Ctext,
      input  logic [15:0]    Vc,
      input  logic [33:0]    prevISA,
      output logic [33:0]    dout,
      output logic [15:0]    vc_l,
      output logic [33:0]    prev_l
      //output [15:0] Tag_o // 16bit Tag len
   );
   
   enum {INIT, READY, DECRYPT, PC_ERROR} State, NextState;
   

   
   
   logic [33:0]  nextISA;
   
   logic [49:0]  data;
   logic [49:0]  tmp;
   
   always @(posedge clk, negedge error)
     if (!error) State <= INIT;
     else State <= NextState;
   
   
   always_comb begin
        case (State)
        INIT: NextState = READY;
        READY: NextState = DECRYPT;
        DECRYPT: NextState = READY;
        endcase
   end
   
     generate
         ape_pe permute50b (data,tmp );
    endgenerate;  
   //Todo: decryption with 1 clock delay at the beginning
   
  always_comb begin
     //Vc      = 16'h0;
     data    = 50'h0;
     nextISA = 34'h0;
     dout    = 34'h0;
     //Vc      = vc_latch;
     //prevISA = prev_latch ;  
    unique case (State)
      INIT: begin
          data     = 50'h0;
          vc_l     = {tag ^ key_i[15:0]};
          prev_l   = Ctext[33:0];
          dout     = 34'h0;      
      end
      READY,
      DECRYPT: begin
          nextISA  = Ctext[33:0];
          data     = { prevISA[33:0], Vc[15:0] };
          dout     = { Ctext[33:0] ^  tmp[49:16] };
          prev_l   = nextISA[33:0];
          vc_l     =  tmp[15:0]; // store previous Vc state 
      end

      default: ;
    endcase
  end       
  
     
endmodule


//module Ape (
//      input  logic           clk,
//      input  logic           error,
//      input  logic [63:0]    key_i,
//      input  logic [15:0]    tag,
//      input  logic [33:0]    Ctext,
//      output logic [33:0]    dout
//      //output [15:0] Tag_o // 16bit Tag len
//   );
   
//   enum {INIT, READY, DECRYPT, PC_ERROR} State, NextState;
   
//   logic [15:0] vc_latch;
//   logic [33:0] prev_latch;
//   logic [15:0] Vc;
   
//   logic [33:0]  nextISA;
//   logic [33:0]  prevISA;
//   logic [49:0]  data;
//   logic [49:0]  tmp;
   
//   always @(posedge clk, negedge error)
//     if (!error) State <= INIT;
//     else State <= NextState;
   
   
//   always_comb begin
//        case (State)
//        INIT: NextState = READY;
//        READY: NextState = DECRYPT;
//        DECRYPT: NextState = READY;
//        endcase
//   end
   
//     generate
//         ape_pe permute50b (data,tmp );
//    endgenerate;  
//   //Todo: decryption with 1 clock delay at the beginning
   
//  always_comb begin
//     //Vc      = 16'h0;
//     data    = 50'h0;
//     nextISA = 34'h0;
//     dout    = 34'h0;
//     Vc      = vc_latch;
//     prevISA = prev_latch ;  
//    unique case (State)
//      INIT: begin
//          data    = 50'h0;
//          Vc      = {tag ^ key_i[15:0]};
//          prevISA = Ctext[33:0];
//          dout    = 34'h0;      
//      end
//      READY,
//      DECRYPT: begin
//          nextISA  = Ctext[33:0];
//          data     = { prevISA[33:0], Vc[15:0] };
//          dout     = { Ctext[33:0] ^  tmp[49:16] };
//          prevISA  = nextISA[33:0];
//          Vc       =  tmp[15:0]; // store previous Vc state 
//      end

//      default: ;
//    endcase
//  end       
  
  
//  always_latch begin : latch_Vc_preISA

////      if (!error) begin 
////        vc_latch   = '0;
////        prev_latch = '0 ;
////      end
////      else begin
//       vc_latch   = Vc;
//       prev_latch = prevISA ;     
////      end;

//  end
     
//endmodule



