`timescale 1ns/1ps


module testbench();

	//*******************************************************************
	// AXI-LITE UART Peripheral Ports
	//*******************************************************************

	reg 		clk = 1'b0;
	reg		a_resetn = 1'b1;
	
	reg	[15:0]	S_AXI_LITE_awaddr = 16'd0;
	reg		S_AXI_LITE_awvalid = 1'b0;
	wire		S_AXI_LITE_awready;

	reg	[31:0]	S_AXI_LITE_wdata = 32'd0;
	reg	[3:0]	S_AXI_LITE_wstrb = 4'd0;
	reg		S_AXI_LITE_wvalid = 1'b0;
	wire		S_AXI_LITE_wready;

	wire	[1:0]	S_AXI_LITE_bresp;
	wire		S_AXI_LITE_bvalid;
	reg		S_AXI_LITE_bready = 1'b0;

	reg	[15:0]	S_AXI_LITE_araddr = 16'd0;
	reg		S_AXI_LITE_arvalid = 1'b0;
	wire		S_AXI_LITE_arready;

	wire	[31:0]	S_AXI_LITE_rdata;
	wire	[1:0]	S_AXI_LITE_rresp;
	wire		S_AXI_LITE_rvalid;
	reg		S_AXI_LITE_rready = 1'b0;

	wire		Tx;
	reg		Rx;

	wire		uart_interrupt;
	
	//*******************************************************************
	
	always @(*)	Rx <= Tx;

	AXI_LITE_UART	AXI_LITE_UART_inst(.*);

	always #5 clk = ~clk;

	// To be removed after integrating uart_tx and uart_rx modules
	initial begin
		//	force testbench.AXI_LITE_UART_inst.rx_fifo_inst.wr = 1'b0;
		//	force testbench.AXI_LITE_UART_inst.rx_fifo_inst.w_data = 8'd0;
		//	force testbench.AXI_LITE_UART_inst.tx_fifo_rd = 1'b0;
	end
	
	reg [31:0] w_data = 32'd1;
	reg [31:0] read_data = 32'd0;

	reg [15:0] clk_count = 16'd0;
	wire b_tick_tb = 1'b0;

	always @(posedge clk or negedge a_resetn) begin
		if(~a_resetn) clk_count <= 16'd0;
		else	      clk_count <= (clk_count == 16'd53) ? 16'd0 : clk_count + 16'd1;
	end

	assign b_tick_tb = (clk_count == 16'd53);

	initial begin
		reset();
		
		// Set Baud Rate
		axi_lite_write(16'h0008, 32'h8);
		axi_lite_read(16'h0008, read_data);
		
		// Set Parity Mode
		axi_lite_write(16'h000C, 32'h2);
		axi_lite_read(16'h000C, read_data);

		// Write Data into TX FIFO
		while(w_data <= 32'd35) begin
			axi_lite_write(16'h0000, w_data);
			axi_lite_read(16'h0000, read_data);
			w_data = w_data + 32'd1;
		end
		
		// Read Fifo Status Register
		axi_lite_read(16'h0010, read_data);

		// Wait until Rx FIFO is empty i.e. all the data bytes are transmitted via UART TX in Loopback
		wait(testbench.AXI_LITE_UART_inst.rx_fifo_inst.full == 1'b1);
		
		// Read the Rx FIFO until empty
		repeat(32) begin
			axi_lite_read(16'h0004, read_data);
			$display("Value of Rx Data : %h", read_data);
		end
		
		wait(testbench.AXI_LITE_UART_inst.rx_fifo_inst.empty == 1'b0);
		
		axi_lite_read(16'h0004, read_data);
		$display("Value of Rx Data : %h", read_data);
		
		repeat(10000) @(posedge clk);
		$finish();
	end

	task reset();
		a_resetn = 1'b1;
		#1;
		a_resetn = 1'b0;
		#2;
		a_resetn = 1'b1;
	endtask

	task axi_lite_write(input [15:0] addr, input [31:0] data);
		@(posedge clk);

		S_AXI_LITE_awaddr <= addr;
		S_AXI_LITE_awvalid <= 1'b1;
		wait(S_AXI_LITE_awready == 1'b1);
		@(posedge clk);
		S_AXI_LITE_awaddr <= 16'd0;
		S_AXI_LITE_awvalid <= 1'b0;

		S_AXI_LITE_wdata <= data;
		S_AXI_LITE_wvalid <= 1'b1;
		wait(S_AXI_LITE_wready == 1'b1);
		@(posedge clk);
		S_AXI_LITE_wdata <= 32'd0;
		S_AXI_LITE_wvalid <= 1'b0;

		S_AXI_LITE_bready <= 1'b1;
		wait(S_AXI_LITE_bvalid == 1'b1);
		@(posedge clk);
		S_AXI_LITE_bready <= 1'b0;

		@(posedge clk);
	endtask

	task axi_lite_read(input [15:0] addr, output [31:0] data);
		@(posedge clk);

		S_AXI_LITE_araddr <= addr;
		S_AXI_LITE_arvalid <= 1'b1;
		wait(S_AXI_LITE_arready == 1'b1);
		@(posedge clk);
		S_AXI_LITE_araddr <= 16'd0;
		S_AXI_LITE_arvalid <= 1'b0;

		S_AXI_LITE_rready <= 1'b1;
		wait(S_AXI_LITE_rvalid == 1'b1);
		@(posedge clk);
		S_AXI_LITE_rready <= 1'b0;
		data <= S_AXI_LITE_rdata;
		
		@(posedge clk);
	endtask

	task tb_uart_tx(input [7:0] data);
		@(posedge clk);

		@(posedge b_tick_tb);
		Rx <= 1'b0;

		for(int i = 0; i<= 7; i++) begin
			Rx <= data[i];
			@(posedge b_tick_tb);
		end

		Rx <= 1'b1;
		@(posedge b_tick_tb);

	endtask


endmodule
