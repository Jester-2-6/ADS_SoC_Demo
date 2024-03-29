
// ************************************************************************************************
//
// PROJECT      :   AXI_ADDRESS_READ
// PRODUCT      :   AXI meomory slave
// FILE         :   <File Name/Module Name>
// AUTHOR       :   <Author's name>
// DESCRIPTION  :   Accepts the read_address from master nand holds it. If data read is not busy pass module
//
// ************************************************************************************************
//
// REVISIONS:
//
//	Date			Developer	Description
//	----			---------	-----------
//  09 Apr 2014		Start date
//
//**************************************************************************************************

`timescale 1ns / 1ps

module data_read_write
    (
      clk,
      reset,

      rid,
      rdata,
      rresp,
      rlast,
      rvalid,
      rready,

      raddr_in,
      rlen_in,
      rsize_in,
      rburst_in,
      rid_in,

      read_mod1_ready_out,
      read_mod1_valid_in,

      awid,


      wid,
      wdata,
      wstrb,
      wlast,
      wvalid,
      wready,

      write_mod1_valid_in,
      write_mod1_ready_out,
      mod3_ready_in,
      mod3_valid_out,


      addr_in,
      id_in,
      write_burst_length_in,
      write_burst_size_in,
      write_burst_type_in,
      id_out,
      resp_out

    );

//---------------------------------------------------------------------------------------------------------------------
// Global constant headers
//---------------------------------------------------------------------------------------------------------------------
   //`include "../sim/param.v"
	parameter DUMMY_MEM = 0;
    parameter READ_DATA_DEBUG = 0;
    parameter WRITE_DATA_DEBUG = 0;
  
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

  localparam STATE_IDLE = 0;
  localparam STATE_TASK = 1;
  localparam STATE_WAIT = 2;
  localparam STATE_BUSY = 3;
//---------------------------------------------------------------------------------------------------------------------
// I/O signals
//---------------------------------------------------------------------------------------------------------------------
    input clk;
    input reset;

    output reg[ADD_ID_WIDTH-1:0]rid;
    output reg[DATA_WIDTH-1:0]rdata;
    output reg[1:0]rresp;
    output reg rlast;
    output reg rvalid;
    input rready;


    input [ADD_WIDTH-1:0]raddr_in;
    input [BURST_LEN-1:0]rlen_in;
    input [BURST_SIZE-1:0]rsize_in;
    input [BURST_TYPE-1:0]rburst_in;
    input [ADD_ID_WIDTH-1:0]rid_in;


    //Sub Module IO signals
    output reg read_mod1_ready_out;
    input read_mod1_valid_in;
    reg [ADD_WIDTH-1:0] read_address;
    //reg [REGISTER_SIZE-1:0] data;


	// write interface---------------------------------
    input [ADD_ID_WIDTH-1:0]awid;

    //output reg awready;

    input [ADD_ID_WIDTH-1:0]wid;
    input [DATA_WIDTH-1:0]wdata;
    input [(DATA_WIDTH>>3)-1:0]wstrb;
    input wlast;
    input wvalid;
    output reg wready;

    //Sub Module IO signals

    input mod3_ready_in;
    input write_mod1_valid_in;
    output reg mod3_valid_out;
    output reg write_mod1_ready_out;

    input [ADD_WIDTH-1:0] addr_in;
    input [BURST_LEN-1:0] 	write_burst_length_in;
    input [BURST_SIZE-1:0] 	write_burst_size_in;
    input [BURST_TYPE-1:0] 	write_burst_type_in;
    input [ADD_ID_WIDTH-1:0]id_in;

    output reg[ADD_ID_WIDTH-1:0]id_out;
    output reg[1:0]resp_out;
//---------------------------------------------------------------------------------------------------------------------
// Internal wires and registers
//---------------------------------------------------------------------------------------------------------------------
reg [1:0] read_state;
reg [1:0] read_next_state;
reg [BURST_LEN:0] read_burst_length;
reg [2**BURST_SIZE-1:0] read_burst_size;
reg [BURST_TYPE-1:0] read_burst_type;

reg [7:0]read_mem_data = 8'd0;


//write interface


reg [1:0] write_state;
reg [1:0] write_next_state;
reg [DATA_WIDTH-1:0] wr_data;
reg [ADD_WIDTH-1:0] write_add_data;
reg [BURST_LEN-1:0] write_burst_length;
reg [2**BURST_SIZE-1:0] write_burst_size;
reg [BURST_TYPE-1:0] write_burst_type;
reg [(DATA_WIDTH>>3)-1:0]write_strobe;

reg write_last;
reg [7:0] write_rdata ;



//---------------------------------------------------------------------------------------------------------------------
// Implementation
//---------------------------------------------------------------------------------------------------------------------
	memory_module_virtual_memory #(
        .ADD_ID_WIDTH 	(ADD_ID_WIDTH 	),
        .ADD_WIDTH 		(ADD_WIDTH 		),
        .BURST_LEN 		(BURST_LEN 		),
        .BURST_SIZE 	(BURST_SIZE 	),
        .DATA_WIDTH 	(DATA_WIDTH 	),
        .BURST_TYPE 	(BURST_TYPE 	),
        .MAX_BYTE_SIZE 	(MAX_BYTE_SIZE 	),
        .MAX_BIT_SIZE 	(MAX_BIT_SIZE 	)
    )memory();



	initial begin
		if(DUMMY_MEM == 0)
		memory.memory_initialize();
	end


initial begin
    read_state = STATE_IDLE;
  end
initial begin
	write_state = STATE_IDLE;
end


 always @(posedge clk) begin
	if(reset) begin
		read_state <= STATE_IDLE;
	end
	else begin
     read_state<=read_next_state;
	 end
  end

 always @(posedge clk) begin : Next_state_and_driving_outputs
 	if(reset) begin
		write_state<= STATE_IDLE;
	end
	else begin
		write_state<= write_next_state;
	end

  end


  always @(*) begin :read_next_state_logic
      case (read_state)
        STATE_IDLE :begin
          rvalid =0;
          read_mod1_ready_out = 1;
          rlast=0;
          if (read_mod1_valid_in==1) begin
            read_next_state=STATE_TASK;
          end
          else begin
            read_next_state=STATE_IDLE;
          end
        end

        STATE_TASK :begin
          //top_test.uut.memory.data_read(read_address,rdata);
          rvalid =1;
          if (rready==1) begin


            if(read_mod1_valid_in==0 && read_burst_length == 4'b0000) begin
              read_next_state=STATE_IDLE;
            end
            else begin
              read_next_state=STATE_TASK;
            end

            if(read_burst_length==4'b0000) begin
                read_mod1_ready_out=1;
                rlast=1;
            end
            else begin
                read_mod1_ready_out=0;
                rlast = 0;
            end

          end
          else begin
            //rvalid=0;
            rlast=0;
            read_mod1_ready_out=0;
            read_next_state=STATE_WAIT;
          end
        end

        STATE_WAIT :begin
          rvalid=1;
          if (rready==1) begin
            if(read_mod1_valid_in==0 && read_burst_length==4'b0000) begin
              read_next_state=STATE_IDLE;
            end
            else begin
              read_next_state=STATE_TASK;
            end

            if(read_burst_length==4'b0000) begin
                read_mod1_ready_out=1;
                rlast=1;
            end
            else begin
                read_mod1_ready_out=0;
                rlast=0;
            end
          end
          else begin
            //rvalid=0;
            rlast=0;
            read_mod1_ready_out=0;
            read_next_state=STATE_WAIT;
          end
        end

        endcase

    end

integer i;
  always @(posedge clk) begin
    if(read_next_state==STATE_TASK) begin

        if(read_burst_length==4'b0000) begin
          read_address = raddr_in[ADD_WIDTH-1:0];
          rid = rid_in;
          read_burst_length = rlen_in+1;
          read_burst_size = 2**rsize_in;
          read_burst_type = rburst_in;
        end
        //else begin
          //read_address = read_address+read_burst_size;
        //end
        //top_test.uut.memory.data_read(read_address,rdata);
        //NISAL'S MEMORY
//`ifdef READ_DATA_DEBUG
      if(READ_DATA_DEBUG == 1) begin
        $display("Read read_address :  %d @ t = %d", read_address,$time);
      end
// `endif

        for (i = 0; i < read_burst_size; i=i+1)
        begin
			if(DUMMY_MEM==0) begin
				memory.data_read(read_address,read_mem_data);
			end
          rdata[8*i] <= read_mem_data[0];
          rdata[8*i+1] <= read_mem_data[1];
          rdata[8*i+2] <= read_mem_data[2];
          rdata[8*i+3] <= read_mem_data[3];
          rdata[8*i+4] <= read_mem_data[4];
          rdata[8*i+5] <= read_mem_data[5];
          rdata[8*i+6] <= read_mem_data[6];
          rdata[8*i+7] <= read_mem_data[7];
// `ifdef READ_DATA_DEBUG
        if(READ_DATA_DEBUG == 1) begin
          if(i==0)
          $display("Address : %d , data :  %d",read_address,read_mem_data);
        end
        //else begin
        //    if(read_address >= 32'h4000000 ) begin
        //      $stop();
        //    end
        //end
// `endif
          read_address= read_address+1;
        end
        read_burst_length = read_burst_length-1;
        rresp = 2'b00;
//`ifdef READ_DATA_DEBUG
      if(READ_DATA_DEBUG == 1) begin
        $display("Read data :  %x", rdata[512-1:0]);
      end
//`endif
    end
    else if(read_next_state==STATE_IDLE) begin
      rid = 3'b000;
      read_burst_length = 4'b0000; //0 indicates 1 burst
      read_burst_size  = 3'b000;
      read_burst_type = 2'b00;
    end
  end

    always @(*) begin : write_next_state_logic
      case (write_state)

        STATE_IDLE :begin

          write_mod1_ready_out=1;
          wready = write_mod1_valid_in;
          mod3_valid_out =0;

          if (write_mod1_valid_in==1) begin
            if (wvalid==1) begin
              write_next_state=STATE_TASK;
            end
            else begin
              write_next_state=STATE_WAIT;
            end
          end
          else begin
            write_next_state=STATE_IDLE;
          end
        end

        STATE_TASK :begin

          write_mod1_ready_out = write_last && mod3_ready_in;
          wready = (~write_last || (write_last && mod3_ready_in && write_mod1_valid_in));
          mod3_valid_out = write_last;

          if ((mod3_ready_in==1 && write_mod1_valid_in==1 && wvalid==1 && write_last==1) || (wvalid==1 && write_last ==0)) begin
            write_next_state=STATE_TASK;
          end
           if (write_last==1 && mod3_ready_in ==0) begin
            write_next_state=STATE_BUSY;
          end
          if((mod3_ready_in==1 && write_last ==1 && write_mod1_valid_in==0) ) begin
            write_next_state=STATE_IDLE;
          end
          if((wvalid==0 && write_last==0) || (mod3_ready_in==1 && write_last ==1 && write_mod1_valid_in==1 && wvalid==0))  begin
            write_next_state=STATE_WAIT;
          end
        end

        STATE_BUSY: begin

          write_mod1_ready_out = mod3_ready_in;
          wready = mod3_ready_in && write_mod1_valid_in;
          mod3_valid_out = 1;

          if (mod3_ready_in==0) begin
            write_next_state=STATE_BUSY;
          end
          else if(write_mod1_valid_in==0) begin
            write_next_state=STATE_IDLE;
          end
          else if(wvalid==1)begin
            write_next_state=STATE_TASK;
          end
          else begin
            write_next_state=STATE_WAIT;
          end
        end

        STATE_WAIT: begin

          write_mod1_ready_out = 0;
          wready = 1;
          mod3_valid_out = 0;

          if(wvalid==1) begin
            write_next_state=STATE_TASK;

          end
          else
            write_next_state=STATE_WAIT;
        end

        endcase

    end

always @(posedge clk) begin
    if(write_next_state==STATE_TASK) begin
        if(write_burst_length==4'b0000) begin
          write_add_data = addr_in[ADD_WIDTH-1:0];
          wr_data = wdata;
          write_strobe=wstrb;
          id_out = id_in;
          write_burst_length = write_burst_length_in+1;
          write_burst_size = 2**write_burst_size_in;
          write_burst_type = write_burst_type_in;
          wr_data = wdata;
          resp_out=2'b00;
        end
        else begin
          wr_data = wdata;
          write_strobe=wstrb;
        end

// `ifdef WRITE_DATA_DEBUG
    if(WRITE_DATA_DEBUG == 1) begin
        
        $display("Write address :  %d @ t = %d", write_add_data,$time);
        if(write_add_data < 32'h8800000 ) begin
            //$stop();
        end
        $display("Write data :  %x", wr_data[512-1:0]);
    end
    else begin
        //if(write_add_data >= 32'h4000000 ) begin
        //    $stop();
        //end
    end

// `endif
        if(id_out!=wid) begin
          resp_out = 2'b01;
        end
        for (i = 0; i < write_burst_size; i=i+1)
        begin
          if(write_strobe[i]==1) begin

            write_rdata[0] = wr_data[8*i];
            write_rdata[1] = wr_data[8*i+1];
            write_rdata[2] = wr_data[8*i+2];
            write_rdata[3] = wr_data[8*i+3];
            write_rdata[4] = wr_data[8*i+4];
            write_rdata[5] = wr_data[8*i+5];
            write_rdata[6] = wr_data[8*i+6];
            write_rdata[7] = wr_data[8*i+7];
            //top_test.uut.memory.memory_initilaize();
			if(DUMMY_MEM==0) begin
				memory.data_write(write_add_data,write_rdata);
				if(write_add_data != 32'hFFFFFFFF) begin
				  
				end
				else begin
				    $stop();
			  end
			end
// `ifdef WRITE_DATA_DEBUG
    if(WRITE_DATA_DEBUG == 1) begin
            if(i==0)
            $display("Address : %d , data :  %d",write_add_data,write_rdata);
        if(write_add_data == 32'h30000010 ) begin

            $stop();
        end
    end
// `endif
          end
          write_add_data = write_add_data+1;
        end
        write_burst_length = write_burst_length-1;
        //top_test.uut.memory.data_read(address,write_rdata);
        //NISAL'S MEMORY
    end

    else if(write_next_state == STATE_WAIT) begin
       if(write_burst_length==4'b0000) begin
          write_add_data = addr_in;
          id_out = id_in;
          write_burst_length = write_burst_length_in+1;
          write_burst_size = 2**write_burst_size_in;
          write_burst_type = write_burst_type_in;
          resp_out = 2'b00;
        end
    end

    else if(write_next_state==STATE_IDLE) begin
      id_out = 3'b000;
      write_burst_length = 4'b000; //0 indicates 1 write_burst
      write_burst_size  = 3'b000;
      write_burst_type = 2'b00;
      resp_out = 2'b00;
    end

  end

always @(*) begin
  if(write_burst_length==4'b0000) begin
    write_last = 1;
  end
  else begin
    write_last = 0;
  end
end


endmodule