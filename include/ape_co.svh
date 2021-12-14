//-----------------------------------------------------------------------------
// Title         : APE Core Definitions
//-----------------------------------------------------------------------------
// File          : ape_core.svh
// Author        : Addo Dennis  <dennis_addo@aol.com>
// Created       : 14.12.2021
//-----------------------------------------------------------------------------
// Description :
// .
//-----------------------------------------------------------------------------
// Copyright (C) 2021 Addo Dennis
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//-----------------------------------------------------------------------------

`ifndef APE_CORE_SVH
`define APE_CORE_SVH

`define APE_CORE_JAL_START_ADDR              32'hDADE_0000
`define APE_CORE_JAL_END_ADDR                32'hDEDA_0000

`define APE_CORE_TAG                         16'hBABA_0000
`define APE_CORE_DATA_WIDTH                  34             // 32 for AEE (Capacity 168), 34 for APE-IE (capacity 16), 96 for AEE_Light (capacity 32)

//Todo: Uncomment any of the Following to generate the right code
`define APE_ROM_EMUL                         1              // ROM decryption only
//`define APE_L2_PSLAVE0_EMUL                  2              // Instruction decyption only
//`define APE_FPGA_EMUL                        3              // This will activate both ROM and Instruction in private slave 0 decryption


`endif


