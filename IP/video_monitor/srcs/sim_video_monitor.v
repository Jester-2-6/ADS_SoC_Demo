`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2019 10:11:09 AM
// Design Name: 
// Module Name: sim
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


module sim(

    );
    reg clk;
    reg reset;
    reg start;
    reg [9:0]   Y;
    reg [9:0]   CbCr;
    
    video_monitor video_monitor_inst(  
        .clk    (clk),
        .reset  (reset),
        .start  (start),
        .Y_in   (Y),
        .CbCr_in(CbCr)                   
    );
    
    always begin
        #5 clk = !clk;
    end
    
    initial begin
        clk     <= 1'b0;
        reset   <= 1'b1;
        start   <= 1'b0;
        Y       <= 10'h148;
        CbCr    <= 10'h098;
        repeat(100)@(posedge clk);
        reset   <= 1'b0;
        repeat(300)@(posedge clk);
        start   <= 1'b1;
        @(posedge clk);
        start   <= 1'b0;        
    end
endmodule
