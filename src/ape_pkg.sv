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

//! APE Package
/// Contains all necessary type definitions, constants, and generally useful functions.
package ape_pkg;

  typedef struct packed {
    logic          req;
    logic [31:0]   add;
    logic [31:0]   r_rdata;
    logic          r_valid;
    logic          gnt;
    logic          r_opc;

  } ape_core_t;
  /// APE-IE instruction size :
  localparam APE_CORE_IE_DATAWITH   =  34;

endpackage
