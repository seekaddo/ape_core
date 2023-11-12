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

module ape_core import ape_pkg::*;  #(
    parameter APE_DATAWIDTH   = 32

)(
    input logic             clk_i,
    input logic             rst_ni,
    XBAR_TCDM_BUS.Slave     mem_slave_i,
    XBAR_TCDM_BUS.Slave     mem_slave_0
);


    ape_Vc_t lvc; // store Decryption state for the next state

    //todo: handle slave master request
    assign mem_slave_i.req = mem_slave_0.req;
    assign mem_slave_i.add = mem_slave_0.add;

    always_ff @(posedge clk_i, negedge rst_ni) begin
        if (!rst_ni) begin
            lvc.valid  <= 1'b0;
            lvc.Vc     <= '0;
        end else begin
            lvc.valid  <= 1'b1;
            lvc.Vc     <= mem_slave_i.r_rdata[15:0];  // just for testing
        end
    end


    always_comb begin
        if (mem_slave_i.req == 1 && mem_slave_i.gnt == 1 ) begin
            //mem_slave_0.req       = mem_slave_i.req;
            mem_slave_0.gnt       = mem_slave_i.gnt;
            mem_slave_0.r_rdata   = mem_slave_i.r_rdata[31:0];
            //mem_slave_0.r_opc     = mem_slave_i.r_opc;
            mem_slave_0.r_valid   = mem_slave_i.r_valid;
        end else begin // output gnt, output r_rdata, output r_opc, output r_valid
            //mem_slave_0.req       = mem_slave_i.req;
            mem_slave_0.gnt       = mem_slave_i.gnt;
            mem_slave_0.r_rdata   = '0;
            //mem_slave_0.r_opc     = mem_slave_i.r_opc;
            mem_slave_0.r_valid   = mem_slave_i.r_valid;
        end
    end


endmodule : ape_core