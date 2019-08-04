// (c) Copyright 2011 - 2015 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
//------------------------------------------------------------------------------
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: $Revision: $
//  \   \         
//  /   /         Filename: $File: $
// /___/   /\     Timestamp: $DateTime: $
// \   \  /  \
//  \___\/\___\
//
// Description:
//  This module contains HD and SD video pattern generators to drive the UHD-SDI
//  TX. It also generates ST 352 packet data. And, it contains the TX VIO module
//  to control & monitor the TX.
//------------------------------------------------------------------------------
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.

`timescale 1ns / 1ps

module uhdsdi_vidgen (
    input   wire        clk,                      // free running clock
    input   wire        tx_usrclk_in,             // txusrclk from MGT
    input   wire        tx_change_done_in,        // MGT TX change done
    input   wire        tx_change_fail_in,        // TX controller fail
    input   wire [2 :0] tx_change_fail_code_in,   // TX controller fail code
    output  wire        tx_gttxreset_out,         // gttxreset out
    output  wire        tx_full_reset_out,        // GTX full reset
    input   wire        tx_fabric_rst_in,         // TX fabric reset
    output  wire        tx_txen_out,              // tx cable driver enable
    output  wire        tx_ce_out,                // tx_ce to UHD-SDI core
    output  wire        tx_sd_ce_out,             // tx_sd_ce to UHD-SDI core
    output  wire        tx_edh_ce_out,            // tx_edh_ce to UHD-SDI core
    output  reg  [2 :0] tx_mux_pattern_out,       // tx_mux_pattern
    output  wire [2 :0] tx_mode_out,              // tx_mode valid modes
    output  reg         tx_m_out,                 // tx_m for valid modes
    input   wire        tx_m_in,                  // tx_m input for ST 352 generation
    output  wire [9 :0] tx_c_out,                 // tx chroma component
    output  wire [9 :0] tx_y_out,                 // tx luma component
    output  wire [10:0] tx_line_out,              // tx line number out
    output  wire        tx_insert_vpid_out,       // tx insert VPID enable
    output  reg  [31:0] tx_st352_data_out,        // ST 352 data
    output  reg  [10:0] tx_st352_line_f1_out,     // ST 352 line in field 1
    output  reg  [10:0] tx_st352_line_f2_out,     // ST 352 line in field 2
    output  reg         tx_st352_line_f2_en_out,  // ST 352 field 2 enable
    output  wire        tx_insert_sync_bit_out    // tx insert sync bit enable
);

localparam MODE_SD        = 3'b001;
localparam MODE_HD        = 3'b000;
localparam MODE_3G        = 3'b010;
localparam MODE_3GB       = 3'b011;
localparam MODE_6G        = 3'b100;
localparam MODE_12G       = 3'b101;
localparam MODE_SD_UNARY  = 6'b000010;
localparam MODE_HD_UNARY  = 6'b000001;
localparam MODE_3G_UNARY  = 6'b000100;
localparam MODE_3GB_UNARY = 6'b001000;
localparam MODE_6G_UNARY  = 6'b010000;
localparam MODE_12G_UNARY = 6'b100000;

//
// Internal signals
//

(* dont_touch = "true" *)(* mark_debug = "true" *) wire        tx_change_done;
(* dont_touch = "true" *)(* mark_debug = "true" *) wire        tx_change_fail;
(* dont_touch = "true" *)(* mark_debug = "true" *) wire [2:0]  tx_change_fail_code;
(* dont_touch = "true" *)(* mark_debug = "true" *) wire        tx_m;
(* dont_touch = "true" *)(* mark_debug = "true" *) wire        tx_txen;
(* dont_touch = "true" *)(* mark_debug = "true" *) wire [2:0]  tx_fmt_sel_async;
(* dont_touch = "true" *)(* mark_debug = "true" *) wire [1:0]  tx_pat_sel_async;
(* dont_touch = "true" *)(* mark_debug = "true" *) wire [2:0]  tx_mode_async;
(* dont_touch = "true" *)(* mark_debug = "true" *) wire        tx_insert_sync_bit_async;
(* dont_touch = "true" *)(* mark_debug = "true" *) wire        tx_reset;
(* dont_touch = "true" *)(* mark_debug = "true" *) wire        tx_full_reset;
reg  [2:0]  tx_fmt;
wire [9:0]  tx_sd;
wire [9:0]  tx_hd_y;
wire [9:0]  tx_hd_c;
wire [9:0]  tx_pal_patgen;
wire [9:0]  tx_ntsc_patgen;
(* shreg_extract = "no", ASYNC_REG = "TRUE" *)
reg  [2:0]  tx_fmt_sel_ss0 = 3'b100;
(* shreg_extract = "no", ASYNC_REG = "TRUE" *)
reg  [2:0]  tx_fmt_sel_ss1 = 3'b100;
(* shreg_extract = "no", ASYNC_REG = "TRUE" *)
reg  [1:0]  tx_pat_sel_ss0 = 2'b00;
(* shreg_extract = "no", ASYNC_REG = "TRUE" *)
reg  [1:0]  tx_pat_sel_ss1 = 2'b00;
(* shreg_extract = "no", ASYNC_REG = "TRUE" *)
reg  [1:0]  tx_insert_sync_bit_ss = 2'b11;
(* shreg_extract = "no", ASYNC_REG = "TRUE" *)
reg  [5:0]  tx_mode_ss0 = 6'b000001;
(* shreg_extract = "no", ASYNC_REG = "TRUE" *)
reg  [5:0]  tx_mode_ss1 = 6'b000001;
reg  [5:0]  tx_mode_unary = 6'b000001;
reg  [2:0]  tx_mode = 3'b000;
(* shreg_extract = "no", ASYNC_REG = "TRUE" *)
reg  [1:0]  tx_m_in_ss = 2'b00;
wire        tx_m_in_s;

(* equivalent_register_removal = "no" *)
(* KEEP = "TRUE" *)
reg         tx_ce = 1'b1; 
(* equivalent_register_removal = "no" *)
(* KEEP = "TRUE" *)
reg         tx_sd_ce = 1'b0;                   // This is the SD-SDI TX clock enable
(* equivalent_register_removal = "no" *)
(* KEEP = "TRUE" *)
reg  [10:0] tx_gen_sd_ce = 11'b00000100001;    // Generates 5/6/5/6 cadence SD-SDI TX clock enable
reg         tx_edh_ce;                                          // Used to generate the tx_ce signals
reg         tx_level_b = 1'b0;

assign tx_change_done         = tx_change_done_in;
assign tx_change_fail         = tx_change_fail_in;
assign tx_change_fail_code    = tx_change_fail_code_in;
assign tx_gttxreset_out       = tx_reset;
assign tx_full_reset_out      = tx_full_reset;
assign tx_ce_out              = tx_ce;
assign tx_sd_ce_out           = tx_sd_ce;
assign tx_edh_ce_out          = tx_edh_ce;
assign tx_insert_sync_bit_out = tx_insert_sync_bit_ss[1];
assign tx_txen_out            = tx_txen;
assign tx_insert_vpid_out     = (tx_mode == MODE_SD) ? 1'b0 : 1'b1;

//
// Synchronize the tx_m_in signal to tx_usrclk_in
//
always @ (posedge tx_usrclk_in)
    tx_m_in_ss <= {tx_m_in_ss[0], tx_m_in};

assign tx_m_in_s = tx_m_in_ss[1];

// TX VIO Instance
tx_vio tx_vio_i (
    .clk          (clk),                        // clk
                  
    .probe_in0    (tx_change_fail),             // 1  bit 
    .probe_in1    (tx_change_done),             // 1  bit 
    .probe_in2    (tx_change_fail_code),        // 3  bit 
                  
    .probe_out0   (tx_m),                       // 1  bit 
    .probe_out1   (tx_txen),                    // 1  bit 
    .probe_out2   (tx_fmt_sel_async),           // 3  bit 
    .probe_out3   (tx_pat_sel_async),           // 2  bit 
    .probe_out4   (tx_mode_async),              // 3  bit 
    .probe_out5   (tx_insert_sync_bit_async),   // 1  bit 
    .probe_out6   (tx_reset),                   // 1  bit 
    .probe_out7   (tx_full_reset)               // 1  bit 
);

//
// Because the tx_usrclk can start and stop, the TX VIO runs from the free running
// clk. Some control signals must be syncrhonized to the tx_usrclk. The 3-bit
// tx_mode value is carefully moved from the clk domain to the tx_usrclk domain
// by first converting it to unary encoding, moving the unary bits to the tx_usrclk
// domain, and then re-encoding them into a 3-bit value while not allowing updating
// the 3-bit value if more than one unary bit is asserted.
//
always @ (posedge tx_usrclk_in)
begin
    tx_insert_sync_bit_ss <= {tx_insert_sync_bit_ss[0], tx_insert_sync_bit_async};
    tx_pat_sel_ss0 <= tx_pat_sel_async;
    tx_pat_sel_ss1 <= tx_pat_sel_ss0;
    tx_fmt_sel_ss0 <= tx_fmt_sel_async;
    tx_fmt_sel_ss1 <= tx_fmt_sel_ss0;
end

always @ (posedge clk)
    case(tx_mode_async)
        MODE_HD:  tx_mode_unary = MODE_HD_UNARY;
        MODE_SD:  tx_mode_unary = MODE_SD_UNARY;
        MODE_3G:  tx_mode_unary = MODE_3G_UNARY;
        MODE_3GB: tx_mode_unary = MODE_3GB_UNARY;
        MODE_6G:  tx_mode_unary = MODE_6G_UNARY;
        MODE_12G: tx_mode_unary = MODE_12G_UNARY;
        default:  tx_mode_unary = MODE_HD_UNARY;
    endcase

always @ (posedge tx_usrclk_in)
begin
    tx_mode_ss0 <= tx_mode_unary;
    tx_mode_ss1 <= tx_mode_ss0;
end

always @ (posedge tx_usrclk_in)
    case(tx_mode_ss1)
        MODE_HD_UNARY:  
            begin
                tx_mode <= MODE_HD;
                tx_level_b <= 1'b0;
            end
        MODE_SD_UNARY:  
            begin
                tx_mode <= MODE_SD;
                tx_level_b <= 1'b0;
            end
        MODE_3G_UNARY:  
            begin
                tx_mode <= MODE_3G;
                tx_level_b <= 1'b0;
            end
        MODE_3GB_UNARY: 
            begin
                tx_mode <= MODE_3G;
                tx_level_b <= 1'b1;
            end
        MODE_6G_UNARY:  
            begin
                tx_mode <= MODE_6G;
                tx_level_b <= 1'b0;
            end
        MODE_12G_UNARY: 
            begin
                tx_mode <= MODE_12G;
                tx_level_b <= 1'b0;
            end
        default:        
            begin
                tx_mode <= tx_mode;
                tx_level_b <= 1'b0;
            end
    endcase

assign tx_mode_out = tx_mode;

//------------------------------------------------------------------------------
// Set the TX mux pattern. This value determines how many data streams are
// multiplexed together by the UHD-SDI TX.
//
always @ (posedge tx_usrclk_in)
    case(tx_mode)
        MODE_HD:        tx_mux_pattern_out <= 3'b000;
        MODE_SD:        tx_mux_pattern_out <= 3'b000;
        MODE_3G:        tx_mux_pattern_out <= tx_level_b ? 3'b001 : 3'b000;
        default:        tx_mux_pattern_out <= 3'b010;
    endcase
    
//------------------------------------------------------------------------------
// TX clock enable generation
//

//
// This shift register continuously circulates a pattern to generate the
// 5/6/5/6 cadence for the tx_sd_ce.
//
always @ (posedge tx_usrclk_in)
    if (tx_fabric_rst_in)
        tx_gen_sd_ce <= 11'b00000100001;
    else
        tx_gen_sd_ce <= {tx_gen_sd_ce[9:0], tx_gen_sd_ce[10]};

//
// The tx_sd_ce clock enable is high in all modes except SD-SDI. In SD-SDI mode
// it has a 5/6/5/6 cadence.
//
always @ (posedge tx_usrclk_in)
    tx_sd_ce  <= tx_mode == MODE_SD ? tx_gen_sd_ce[10] : 1'b1;

//
// The tx_edh_ce clock enable is low in all modes except SD-SDI. In SD-SDI mode
// it is indentical in phase and frequency to tx_sd_ce.
//
always @ (posedge tx_usrclk_in)
    tx_edh_ce <= tx_mode == MODE_SD ? tx_gen_sd_ce[10] : 1'b0;

//
// The tx_ce signal is hign in SD, HD, and 3GA modes (modes where the number of
// active data streams is 1 or 2. It is always high in 6G-SDI mode when 4 data
// streams are active. In 3G-B mode it has a 50% duty cycle. In 6G and 12G modes
// with 8 data streams it also has a 50% duty cycle. Not support here is the
// 12G mode with 16 active data streams where it would need to have a 25% duty
// cycle.
//
always @ (posedge tx_usrclk_in)
    tx_ce <= (tx_mux_pattern_out == 3'b010 | tx_mux_pattern_out == 3'b001) ? ~tx_ce : 1'b1;

//------------------------------------------------------------------------------
// Some logic to insure that the TX bit rate and video formats chosen by the
// user are never illegal.
//
//
// In 3G, 6G, and 12G modes, only video formats 4 (1080p60) and 5 (1080p50) are legal.
//
always @ (*)
    if (tx_mode == MODE_3G && tx_fmt_sel_ss1[2:1] != 2'b10)
        tx_fmt <= 3'b100;
    else if (tx_mode[2] && tx_fmt_sel_ss1[2:1] != 2'b10)
        tx_fmt <= 3'b100;
    else
        tx_fmt <= tx_fmt_sel_ss1;

//
// In SD-SDI mode, tx_m_out must be 0. In HD and 3G modes, if the video format is
// 0 (720p50), 3 (1080i50), or 5 (1080p25), then tx_m_out must be 0.
//
always @ (*)
    if (tx_mode == MODE_SD)          // In SD-SDI mode, tx_m_out must be 0
        tx_m_out <= 1'b0;
    else if (tx_fmt == 3'b000 || tx_fmt == 3'b011 || tx_fmt == 3'b101)
        tx_m_out <= 1'b0;
    else
        tx_m_out <= tx_m;

//------------------------------------------------------------------------------
// Video pattern generators
//
multigenHD VIDGEN (
    .clk                (tx_usrclk_in),
    .rst                (tx_fabric_rst_in),
    .ce                 (tx_ce),
    .std                (tx_fmt),
    .pattern            (tx_pat_sel_ss1),
    .user_opt           (2'b00),
    .y                  (tx_hd_y),
    .c                  (tx_hd_c),
    .h_blank            (),
    .v_blank            (),
    .field              (),
    .trs                (),
    .xyz                (),
    .line_num           (tx_line_out));

vidgen_ntsc NTSC (
    .clk                (tx_usrclk_in),
    .rst                (tx_fabric_rst_in),
    .ce                 (tx_sd_ce),
    .pattern            (tx_pat_sel_ss1[0]),
    .q                  (tx_ntsc_patgen),
    .h_sync             (),
    .v_sync             (),
    .field              ());

vidgen_pal PAL (
    .clk                (tx_usrclk_in),
    .rst                (tx_fabric_rst_in),
    .ce                 (tx_sd_ce),
    .pattern            (tx_pat_sel_ss1[0]),
    .q                  (tx_pal_patgen),
    .h_sync             (),
    .v_sync             (),
    .field              ());

//
// Video pattern generator output muxes
//
assign tx_sd     = tx_fmt[0] ? tx_pal_patgen : tx_ntsc_patgen;
assign tx_c_out  = tx_hd_c;
assign tx_y_out  = tx_mode == MODE_SD ? tx_sd : tx_hd_y;

//
// ST352 payload ID packet data generator
//
always @ (*)
    case(tx_mode)
        MODE_HD:    begin // HD-SDI
                        case(tx_fmt)
                            3'b000: begin   // 720p50
                                tx_st352_data_out       = 32'h01004984;
                                tx_st352_line_f1_out    = 11'd10;
                                tx_st352_line_f2_out    = 11'd0;
                                tx_st352_line_f2_en_out = 1'b0;
                            end

                            3'b001: begin   // 1080sfp24/23.98
                                tx_st352_data_out       = tx_m_in_s ? 32'h01004285 : 32'h01004385;
                                tx_st352_line_f1_out    = 11'd10;
                                tx_st352_line_f2_out    = 11'd572;
                                tx_st352_line_f2_en_out = 1'b1;
                            end
                            
                            3'b010: begin   // 1080i60/59.94
                                tx_st352_data_out       = tx_m_in_s ? 32'h01000685 : 32'h01000785;
                                tx_st352_line_f1_out    = 11'd10;
                                tx_st352_line_f2_out    = 11'd572;
                                tx_st352_line_f2_en_out = 1'b1;
                            end

                            3'b011: begin   // 1080i50
                                tx_st352_data_out       = 32'h01000585;
                                tx_st352_line_f1_out    = 11'd10;
                                tx_st352_line_f2_out    = 11'd572;
                                tx_st352_line_f2_en_out = 1'b1;
                            end

                            3'b100: begin   // 1080p30/29.97
                                tx_st352_data_out       = tx_m_in_s ? 32'h0100c685 : 32'h0100c785;
                                tx_st352_line_f1_out    = 11'd10;
                                tx_st352_line_f2_out    = 0;
                                tx_st352_line_f2_en_out = 1'b0;
                            end
                            
                            3'b101: begin   // 1080p25
                                tx_st352_data_out       = 32'h0100c585;
                                tx_st352_line_f1_out    = 11'd10;
                                tx_st352_line_f2_out    = 11'd0;
                                tx_st352_line_f2_en_out = 1'b0;
                            end

                            3'b110: begin   // 1080p24/23.98
                                tx_st352_data_out       = tx_m_in_s ? 32'h0100c285 : 32'h0100c385;
                                tx_st352_line_f1_out    = 11'd10;
                                tx_st352_line_f2_out    = 0;
                                tx_st352_line_f2_en_out = 1'b0;
                            end

                            default: begin  // 720p60/59.94
                                tx_st352_data_out       = tx_m_in_s ? 32'h01004a84 : 32'h01004b84;
                                tx_st352_line_f1_out    = 11'd10;
                                tx_st352_line_f2_out    = 0;
                                tx_st352_line_f2_en_out = 1'b0;
                            end
                        endcase
                    end

        MODE_SD:    begin //SD-SDI: Note ST 352 insertion is disabled in SD mode in this demo 
                          //because the TPG doesn't provide line numbers in SD mode.
                        if (tx_fmt[0])  // PAL
                        begin
                            tx_st352_data_out       = 32'h01000581;
                            tx_st352_line_f1_out    = 11'd9;
                            tx_st352_line_f2_out    = 11'd322;
                            tx_st352_line_f2_en_out = 1'b1;
                        end
                        else    // NTSC
                        begin
                            tx_st352_data_out       = 32'h01000681;
                            tx_st352_line_f1_out    = 11'd13;
                            tx_st352_line_f2_out    = 11'd276;
                            tx_st352_line_f2_en_out = 1'b1;
                        end
                    end

        MODE_3G:    begin //3G-SDI level A
                        if (~tx_level_b)
                        begin
                            if (tx_fmt[0])  // 108p50
                            begin
                                tx_st352_data_out       = 32'h0900c989;
                                tx_st352_line_f1_out    = 11'd10;
                                tx_st352_line_f2_out    = 11'd0;
                                tx_st352_line_f2_en_out = 1'b0;
                            end
                            else    // 1080p60/59.94
                            begin
                                tx_st352_data_out       = tx_m_in_s ? 32'h0900ca89 : 32'h0900cb89;
                                tx_st352_line_f1_out    = 11'd10;
                                tx_st352_line_f2_out    = 11'd0;
                                tx_st352_line_f2_en_out = 1'b0;
                            end
                        end
                        else //3G-SDI level B
                        begin
                            if (tx_fmt[0])  // 1080p25
                            begin
                                tx_st352_data_out       = 32'h0100c58c;
                                tx_st352_line_f1_out    = 11'd10;
                                tx_st352_line_f2_out    = 11'd0;
                                tx_st352_line_f2_en_out = 1'b0;
                            end
                            else    // 1080p30/29.97
                            begin
                                tx_st352_data_out       = tx_m_in_s ? 32'h0100c68c : 32'h0100c78c;
                                tx_st352_line_f1_out    = 11'd10;
                                tx_st352_line_f2_out    = 11'd0;
                                tx_st352_line_f2_en_out = 1'b0;
                            end
                        end
                    end

        MODE_6G:    begin //6G-SDI
                        if (tx_fmt[0])  // 2160p25
                        begin
                            tx_st352_data_out       = 32'h0180c5c0;
                            tx_st352_line_f1_out    = 11'd10;
                            tx_st352_line_f2_out    = 11'd0;
                            tx_st352_line_f2_en_out = 1'b0;
                        end
                        else    // 2160p30/29.97
                        begin
                            tx_st352_data_out       = tx_m_in_s ? 32'h0180c6c0 : 32'h0180c7c0;
                            tx_st352_line_f1_out    = 11'd10;
                            tx_st352_line_f2_out    = 11'd0;
                            tx_st352_line_f2_en_out = 1'b0;
                        end
                    end

        default:    begin   // 12G-SDI
                        if (tx_fmt == 3'b101)   //2160p25
                        begin
                            tx_st352_data_out       = 32'h0180c9ce;
                            tx_st352_line_f1_out    = 11'd10;
                            tx_st352_line_f2_out    = 11'd0;
                            tx_st352_line_f2_en_out = 1'b0;
                        end
                        else    // 2160p30/29.97
                        begin
                            tx_st352_data_out       = tx_m_in_s ? 32'h0180cace : 32'h0180cbce;
                            tx_st352_line_f1_out    = 11'd10;
                            tx_st352_line_f2_out    = 11'd0;
                            tx_st352_line_f2_en_out = 1'b0;
                        end
                    end
    endcase         
    
endmodule

    
