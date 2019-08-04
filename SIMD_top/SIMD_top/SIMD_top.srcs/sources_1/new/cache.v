`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Author: Chirath Diyagama
// 
// Create Date: 08/03/2019 11:15:18 PM
// Design Name: 
// Module Name: cache
// Project Name: ADS project
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


module cache
#(
//---------------------------------------------------------------------------------------------------------------------
// parameter definitions
parameter Mem_Address_Width = 24,
parameter Mem_Word_Size = 64,
parameter Words_per_Read = 4
//---------------------------------------------------------------------------------------------------------------------
)(
//---------------------------------------------------------------------------------------------------------------------
input  clk,
input  rst,

// I/O signals - interfacing with SIMD
//Memory Read operations
input read_fetch, //read-1, prefetch-0.
input [(Mem_Address_Width*Words_per_Read-1):0] address_in_r, //.
output reg [(Mem_Word_Size*Words_per_Read-1):0] data_out, //.
output reg data_valid, //Signal to indicate data validity.
output reg r_over, //Signal to indicate operation read/fetch is over.
//Memory Write operation
input to_cache_wr, //0-write to memory directly, 1-replace cache and write to memory.
input [Mem_Word_Size-1:0] data_in, //.
input [Mem_Address_Width-1:0] address_in_w, //. 
output reg w_over, //Signal to indicate write operation is over.

// I/O signals - interfacing with main memory
input [(Mem_Word_Size*Words_per_Read-1):0] data_in_mem,
output reg read_write_mem,
output reg [(Mem_Address_Width*Words_per_Read-1):0] address_out_r_mem,
output reg [(Mem_Address_Width-1):0] address_out_w_mem,
output reg [Mem_Word_Size-1:0] data_out_mem
//---------------------------------------------------------------------------------------------------------------------

);

//---------------------------------------------------------------------------------------------------------------------
// Global constant headers
//---------------------------------------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------------------------------------
// localparam definitions

localparam Cache_line_size = Mem_Word_Size;
localparam N_sets = 1024;
localparam N_ways = 8;

//---------------------------------------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------------------------------------
// Internal wires and registers
reg [2 : 0] state = 0; // 0-decision, 1-read1, 2-read2, 3-write, 4-idle.

reg [3:0] master1_split_status = 0; //slave4, slave3, slave2, slave1.
reg [3:0] master2_split_status = 0; //slave4, slave3, slave2, slave1.
reg [3:0] master3_split_status = 0; //slave4, slave3, slave2, slave1.
reg [3:0] master4_split_status = 0; //slave4, slave3, slave2, slave1.

reg [3:0] temp1 = 0;
reg [3:0] temp2 = 0;
reg [3:0] temp3 = 0;
reg [3:0] temp4 = 0;

reg [3:0] temp5 = 0;
reg [3:0] temp6 = 0;
reg [3:0] temp7 = 0;
reg [3:0] temp8 = 0;

//---------------------------------------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------------------------------------
// Implementation


always @(posedge  clk) begin
	

end // always @(posedge  clk)
//---------------------------------------------------------------------------------------------------------------------

endmodule
