`timescale 1ns/1ps


module AXI_LITE_UART(
	// Clock and Reset
	input			clk,
	input			a_resetn,

	// AXI LITE Signals
	input		[15:0]	S_AXI_LITE_awaddr,
	input			S_AXI_LITE_awvalid,
	output	reg		S_AXI_LITE_awready,

	input		[31:0]	S_AXI_LITE_wdata,
	input		[3:0]	S_AXI_LITE_wstrb,
	input			S_AXI_LITE_wvalid,
	output	reg		S_AXI_LITE_wready,

	output	reg	[1:0]	S_AXI_LITE_bresp,
	output	reg		S_AXI_LITE_bvalid,
	input			S_AXI_LITE_bready,

	input		[15:0]	S_AXI_LITE_araddr,
	input			S_AXI_LITE_arvalid,
	output	reg		S_AXI_LITE_arready,

	output	reg	[31:0]	S_AXI_LITE_rdata,
	output	wire	[1:0]	S_AXI_LITE_rresp,
	output	reg		S_AXI_LITE_rvalid,
	input			S_AXI_LITE_rready,

	// UART Sginals
	output	wire		Tx,
	input			Rx,

	// UART Interrupt
	output	wire		uart_interrupt
);
	
	//*******************************************************************
	// Peripheral Internal Registers
	//*******************************************************************

	// Data input to TX FIFO	// Addr Offset 0x0 (Write Only)
	reg	[7:0]	tx_byte;
	
	// Data output from RX FIFO	// Addr Offset 0x4 (Read Only)
	reg	[7:0]	rx_byte;
	
	// Baudrate Selection Register	// Addr Offset 0x8 (Write and Read)
	reg	[3:0]	baudrate;	// 0  -> 9600   bps
					// 1  -> 19200  bps
					// 2  -> 28800  bps
					// 3  -> 38400  bps
					// 4  -> 57600  bps
					// 5  -> 76800  bps
					// 6  -> 115200 bps
					// 7  -> 230400 bps
					// 8  -> 460800 bps
					// 9  -> 576000 bps
					// 10 -> 921600 bps

	// Parity Selection Register	// Addr Offset 0xC (Write and Read)
	reg	[1:0]	parity;		// 0 -> no parity
					// 1 -> odd parity
					// 2 -> even parity

	// Register Storing the FIFO Statuses	// Addr Offset 0x10 (Read Only)
	wire	[3:0]	fifo_status;		// fifo_status[3] -> tx_fifo_full
						// fifo_status[2] -> tx_fifo_empty
						// fifo_status[1] -> rx_fifo_full
						// fifo_status[0] -> rx_fifo_empty


	//*******************************************************************
	// Auxilary & Internal Signals
	//*******************************************************************
	wire 		b_tick;
	
	wire		tx_fifo_rd;
	wire		tx_fifo_wr;
	wire		tx_fifo_empty;
	wire		tx_fifo_full;
	wire	[7:0]	tx_fifo_rdata;

	wire		rx_fifo_rd;
	wire		rx_fifo_wr;
	wire	[7:0]	rx_fifo_wdata;
	wire		rx_fifo_empty;
	wire		rx_fifo_full;


	//*******************************************************************
	// AXI LITE - Slave Interface Logic
	//*******************************************************************

	// Write Channel State Machine
	enum reg [1:0] {W_IDLE = 2'b00, AW_STATE = 2'b01, W_STATE = 2'b10, RESP_STATE = 2'b11} S_AXI_LITE_wr_state;
	reg [15:0] wr_addr;

	always @(posedge clk or negedge a_resetn) begin
		if(~a_resetn) begin
			S_AXI_LITE_wr_state <= W_IDLE;
			wr_addr <= 16'd0;
		end
		else begin
			case(S_AXI_LITE_wr_state)
				W_IDLE		:	begin
								S_AXI_LITE_wr_state <= AW_STATE;
								wr_addr	<= 16'd0;
							end
				AW_STATE	:	begin
								if(S_AXI_LITE_awvalid && S_AXI_LITE_awready) begin
									S_AXI_LITE_wr_state <= W_STATE;
									wr_addr <= S_AXI_LITE_awaddr;
								end
							end
				W_STATE		:	begin
								if(S_AXI_LITE_wvalid && S_AXI_LITE_wready)
									S_AXI_LITE_wr_state <= RESP_STATE;
							end
				RESP_STATE	:	begin
								if(S_AXI_LITE_bvalid && S_AXI_LITE_bready)
									S_AXI_LITE_wr_state <= W_IDLE;
							end
				default		:	begin
								S_AXI_LITE_wr_state <= W_IDLE;
								wr_addr <= 16'd0;
							end
			endcase
		end
	end

	always @(*) begin
		S_AXI_LITE_awready = 1'b0;
		S_AXI_LITE_wready = 1'b0;
		S_AXI_LITE_bvalid = 1'b0;
		
		case(S_AXI_LITE_wr_state)
			AW_STATE	: S_AXI_LITE_awready = (S_AXI_LITE_awvalid) ? 1'b1 : 1'b0;
			W_STATE		: S_AXI_LITE_wready = (S_AXI_LITE_wvalid) ? 1'b1 : 1'b0;
			RESP_STATE	: S_AXI_LITE_bvalid = 1'b1;
		endcase
	end

	assign S_AXI_LITE_bresp = 2'b00;


	// Read Channel State Machine
	enum reg [1:0] {R_IDLE = 2'b00, AR_STATE = 2'b01, R_STATE = 2'b10} S_AXI_LITE_rd_state;
	reg [15:0] rd_addr;

	always @(posedge clk or negedge a_resetn) begin
		if(~a_resetn) begin
			S_AXI_LITE_rd_state <= R_IDLE;
			rd_addr <= 16'd0;
		end
		else begin
			case(S_AXI_LITE_rd_state)
				R_IDLE		:	S_AXI_LITE_rd_state <= AR_STATE;
				AR_STATE	:	begin
								if(S_AXI_LITE_arvalid && S_AXI_LITE_arready) begin
									S_AXI_LITE_rd_state <= R_STATE;
									rd_addr <= S_AXI_LITE_araddr;
								end
							end
				R_STATE		:	begin
								if(S_AXI_LITE_rvalid && S_AXI_LITE_rready)
									S_AXI_LITE_rd_state <= R_IDLE;
							end
				default		:	begin
								S_AXI_LITE_rd_state <= R_IDLE;
								rd_addr <= 16'd0;
							end
			endcase
		end
	end

	always @(*) begin
		S_AXI_LITE_arready = 1'b0;
		S_AXI_LITE_rvalid = 1'b0;

		if(rd_addr == 16'h0000)		S_AXI_LITE_rdata = {24'd0, tx_byte};
		else if(rd_addr == 16'h0004)	S_AXI_LITE_rdata = {24'd0, rx_byte};
		else if(rd_addr == 16'h0008)	S_AXI_LITE_rdata = {28'd0, baudrate};
		else if(rd_addr == 16'h000C)	S_AXI_LITE_rdata = {30'd0, parity};
		else if(rd_addr == 16'h0010)	S_AXI_LITE_rdata = {28'd0, fifo_status};
		else				S_AXI_LITE_rdata = 32'd0;
		
		case(S_AXI_LITE_rd_state)
			AR_STATE	: S_AXI_LITE_arready = (S_AXI_LITE_arvalid) ? 1'b1 : 1'b0;
			R_STATE		: S_AXI_LITE_rvalid = 1'b1;
		endcase
	end
	
	assign S_AXI_LITE_rresp = 2'b00;
	
	
	//*******************************************************************
	// Logic for Peripheral's Internal Signals
	//*******************************************************************

	wire s_axi_lite_wr_pulse;
	wire s_axi_lite_rd_pulse;

	reg s_axi_lite_wvalid_delay;
	reg s_axi_lite_arvalid_delay;


	always @(posedge clk or negedge a_resetn) begin
		if(~a_resetn) begin
			s_axi_lite_wvalid_delay <= 1'b0;
			s_axi_lite_arvalid_delay <= 1'b0;
		end
		else begin
			s_axi_lite_wvalid_delay <= S_AXI_LITE_wvalid;
			s_axi_lite_arvalid_delay <= S_AXI_LITE_arvalid;
		end
	end

	assign s_axi_lite_wr_pulse = S_AXI_LITE_wvalid & (~s_axi_lite_wvalid_delay);
	assign s_axi_lite_rd_pulse = S_AXI_LITE_arvalid & (~s_axi_lite_arvalid_delay);

	assign tx_fifo_wr = (wr_addr == 16'h0000 && s_axi_lite_wr_pulse) ? 1'b1 : 1'b0;
	assign rx_fifo_rd = (S_AXI_LITE_araddr == 16'h0004 && s_axi_lite_rd_pulse) ? 1'b1 : 1'b0;

	always @(posedge clk or negedge a_resetn) begin
		if(~a_resetn)
			tx_byte <= 8'd0;
		else
			tx_byte <= (!tx_fifo_full && tx_fifo_wr) ? S_AXI_LITE_wdata[7:0] : tx_byte;
	end

	always @(posedge clk or negedge a_resetn) begin
		if(~a_resetn)
			baudrate <= 4'd0;
		else
			baudrate <= (wr_addr == 16'h0008 && S_AXI_LITE_wvalid) ? S_AXI_LITE_wdata[3:0] : baudrate;
	end

	always @(posedge clk or negedge a_resetn) begin
		if(~a_resetn)
			parity <= 2'd0;
		else
			parity <= (wr_addr == 16'h000C && S_AXI_LITE_wvalid) ? S_AXI_LITE_wdata[1:0] : parity;
	end

	assign fifo_status = {tx_fifo_full, tx_fifo_empty, rx_fifo_full, rx_fifo_empty};

	assign uart_interrupt = ~rx_fifo_empty;


	//*******************************************************************
	// Sub-Module Instantiations
	//*******************************************************************

	BAUDGEN baudgen_inst(
		.clk(clk),
		.a_resetn(a_resetn),
		.baudrate(baudrate),
		.b_tick(b_tick)
	);

	FIFO #(.DWIDTH(8), .AWIDTH(5))	tx_fifo_inst(
		.clk(clk),
		.a_resetn(a_resetn),
		.rd(tx_fifo_rd),
		.wr(tx_fifo_wr),
		.w_data(S_AXI_LITE_wdata[7:0]),
		.empty(tx_fifo_empty),
		.full(tx_fifo_full),
		.r_data(tx_fifo_rdata)
	);

	FIFO #(.DWIDTH(8), .AWIDTH(5))	rx_fifo_inst(
		.clk(clk),
		.a_resetn(a_resetn),
		.rd(rx_fifo_rd),
		.wr(rx_fifo_wr),
		.w_data(rx_fifo_wdata),
		.empty(rx_fifo_empty),
		.full(rx_fifo_full),
		.r_data(rx_byte)
	);

	UART_TX uart_tx_inst(
		.clk(clk),
		.a_resetn(a_resetn),
		.tx_start(~tx_fifo_empty),
		.b_tick(b_tick),
		.d_in(tx_fifo_rdata),
		.parity(parity),
		.tx_get_data(tx_fifo_rd),
		.tx(Tx)
	);

	UART_RX uart_rx_inst(
		.clk(clk),
		.a_resetn(a_resetn),
		.b_tick(b_tick),
		.rx(Rx),
		.parity(parity),
		.rx_done(rx_fifo_wr),
		.dout(rx_fifo_wdata)
	);

endmodule

