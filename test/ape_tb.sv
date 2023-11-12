`timescale 1ns / 1ps

// Copyright (c) 2021-2018 Dennis Addo
//
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

// Author:
// Dennis Addo <dennis_addo@aol.com>
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2021 20:42:48
// Design Name: 
// Module Name: ape_tb 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ape_tb;

    logic clk_i     = 1;
    logic err_i     = 0;
    int             en;
    logic [63:0]    key;
    logic [33:0]    plaintext;
    logic [33:0]    ciphertext;
    logic [15:0]    tag;
    
    logic [15:0]    Vc;
    logic [33:0]    prevISA;
        
    logic [15:0]    vc_latch;
    logic [33:0]    prev_latch;
    
   
    Ape ape_enc(clk_i, err_i, key, tag, ciphertext, Vc, prevISA,  plaintext , vc_latch, prev_latch );
    
    logic  [49:0] inData;
    logic  [49:0] outData;
    ape_pe dut (inData, outData);
    static int j = 1; // specific case in the test 
    static int total_cases = 9;   
    localparam period = 20; 
    
    //Arm_ISA testcases
    logic [33:0] testinput [$];
    
    //simulate the clock
    always 
    begin
      clk_i= 1; #period; clk_i= 0; #period;  // // 40ns period at each clock edge
    end
    
    initial 
    begin
        key = 64'h1234567890ABCDEF;
        //plaintext = 239'h4142434445464748494a4b4c4d4e4f505152535455565758; // the same as  ==> ABCDEFGHIJKLMNOPQRSTUVWX
        //cpltt1 = 239'hb74b9b4567aaf19e;
        tag = 16'haded;
        ciphertext = 34'hf37b80e1;
        inData = 50'h3cdee80e11800;
        
       Vc   = 16'h0;
       prevISA = 34'h0;
       testinput[0] = 34'hf37b80e1;  
       testinput[1] = 34'h5a000003;  
       testinput[2] = 34'hf37b20e0;
       testinput[3] = 34'h1800a003;
       testinput[4] = 34'hf17ba0e0;
       testinput[5] = 34'h1a002103;      
       testinput[6] = 34'hf37bf1e1;      
       testinput[7] = 34'h4000b101;      
       testinput[8] = 34'h737ba0e0;      
       testinput[9] = 34'h0;      // Last instruction should be zero out.
        
        
        en = 0;
        
        # period;

    end
    
    always @(negedge clk_i)
    begin

        $display("Encryption : Key: %h ",key);
        $display("ciphertext: %h "  ,ciphertext);      
        $display("Plaintext: %h "  ,plaintext);    
        $display("Plaintext: %b "  ,plaintext);    
        //$display("outData: 0x%h "  ,outData);    
        //$display("outData: %b "  ,outData);    
        //$display("inData:  %b "  ,inData);    
        //$display("Tag: %h "  ,tag); 
        //ciphertext = 34'h5a000003;
        Vc   = vc_latch;
        prevISA = prev_latch ;
        err_i = 1;

        if (j <= total_cases) begin
           ciphertext = testinput[j];
           j++;
        end
        else begin 
           $display("No more cases."); 
           $finish; 
        end  
           en = en + 1;
    end

// Todo: For reference use this
//plaintext--> 0xa0e1
//plaintext--> 0x51e1
//plaintext--> 0x1a0080e2
//plaintext--> 0x20050e1
//plaintext--> 0x20081e0
//plaintext--> 0x20080e0
//plaintext--> 0x20080e0
//plaintext--> 0xa0e1
//plaintext--> 0x20080e0
//ciptext output: 0001110011011110111010000011100000 --> 0x737ba0e0
//ciptext output: 0001000000000000001011000100000001 --> 0x4000b101
//ciptext output: 0011110011011110111111000111100001 --> 0xf37bf1e1
//ciptext output: 0000011010000000000010000100000011 --> 0x1a002103
//ciptext output: 0011110001011110111010000011100000 --> 0xf17ba0e0
//ciptext output: 0000011000000000001010000000000011 --> 0x1800a003
//ciptext output: 0011110011011110110010000011100000 --> 0xf37b20e0
//ciptext output: 0001011010000000000000000000000011 --> 0x5a000003
//ciptext output: 0011110011011110111000000011100001 --> 0xf37b80e1 first
//Tag output: 0xaded
//Decrypt tag: 0110000000000010 --> 0x6002
//Decrypt output: 0000000000000000000000000000000000 --> 0x0
//Decrypt output: 0000000010000000001000000011100000 --> 0x20080e0
//Decrypt output: 0000000000000000001010000011100001 --> 0xa0e1
//Decrypt output: 0000000010000000001000000011100000 --> 0x20080e0
//Decrypt output: 0000000010000000001000000011100000 --> 0x20080e0
//Decrypt output: 0000000010000000001000000111100000 --> 0x20081e0
//Decrypt output: 0000000010000000000101000011100001 --> 0x20050e1
//Decrypt output: 0000011010000000001000000011100010 --> 0x1a0080e2
//Decrypt output: 0000000000000000000101000111100001 --> 0x51e1
//Decrypt output: 0000000000000000001010000011100001 --> 0xa0e1     

endmodule
