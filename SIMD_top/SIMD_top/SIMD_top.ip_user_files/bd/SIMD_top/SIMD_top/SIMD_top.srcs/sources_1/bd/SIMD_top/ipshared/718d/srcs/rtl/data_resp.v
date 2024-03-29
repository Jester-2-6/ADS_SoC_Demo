
// ************************************************************************************************
//
// PROJECT      :   <project name where applicable>
// PRODUCT      :   <product name where applicable>
// FILE         :   <File Name/Module Name>
// AUTHOR       :   <Author's name>
// DESCRIPTION  :   <at least a short description about the module/file>
//                  Where does this file get inputs and send outputs?
//                  What does the guts of this file accomplish, and how does it do it?
//                  What module(s) does this file instantiate?
//
// ************************************************************************************************
//
// REVISIONS:
//
//	Date			Developer	Description
//	----			---------	-----------
//  29 Feb 2012		user123     bug fix - <jira issue id>
//  31 Oct 2007		userxyz		added xyz functionality - <jira issue id>
//  ...              ...         ...
//  ...              ...         ...
//
//**************************************************************************************************

`timescale 1ns / 1ps

module data_resp
    (
      clk,
      reset,
      bid,
      bresp,
      bvalid,
      bready,
      id_in,
      resp_in,
      mod2_valid_in,
      mod2_ready_out

    );

//---------------------------------------------------------------------------------------------------------------------
// Global constant headers
//---------------------------------------------------------------------------------------------------------------------
    //`include "../sim/param.v"
    parameter ADD_ID_WIDTH = 4;
    parameter ADD_WIDTH = 32;
    parameter BURST_LEN = 8;
    parameter BURST_SIZE = 3;
    parameter DATA_WIDTH = 1024;
    parameter BURST_TYPE = 2;
    parameter MAX_BYTE_SIZE = 128;
    parameter MAX_BIT_SIZE = 1024;
//---------------------------------------------------------------------------------------------------------------------
// parameter definitions
//---------------------------------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------------------------------
// localparam definitions
//---------------------------------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------------------------------
// I/O signals
//---------------------------------------------------------------------------------------------------------------------
    input clk;
    input reset;

    output [ADD_ID_WIDTH-1:0]bid;
    input[ADD_ID_WIDTH-1:0]id_in;

    output [1:0] bresp;
    input [1:0] resp_in;

    output bvalid;
    input mod2_valid_in;

    input bready;
    output mod2_ready_out;



//---------------------------------------------------------------------------------------------------------------------
// Internal wires and registers
//---------------------------------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------------------------------
// Implementation
//---------------------------------------------------------------------------------------------------------------------

assign bid = id_in;
assign bresp = resp_in;
assign bvalid = mod2_valid_in;
assign mod2_ready_out=bready;






endmodule