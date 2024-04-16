`timescale 1ns/1ps


module AXI_LITE_UART(
	// Clock and Reset
	input			clk,
	input			a_resetn,

	// AXI LITE Signals
	input		[15:0]	s_axi_awaddr,
	input			s_axi_awvalid,
	output	reg		s_axi_awready,

	input		[31:0]	s_axi_wdata,
	input		[3:0]	s_axi_wstrb,
	input			s_axi_wvalid,
	output	reg		s_axi_wready,

	output	reg	[1:0]	s_axi_bresp,
	output	reg		s_axi_bvalid,
	input			s_axi_bready,

	input		[15:0]	s_axi_araddr,
	input			s_axi_arvalid,
	output	reg		s_axi_arready,

	output	reg	[31:0]	s_axi_rdata,
	output	reg	[1:0]	s_axi_rresp,
	output	reg		s_axi_rvalid,
	input			s_axi_rready,

	// UART Sginals
	input			Rx,
	output	wire		Tx,

	// UART Interrupt
	output	wire		uart_interrupt
);
	
	// Addr Offset 0x0 (Write Only)
	reg	[7:0]	tx_byte;
	
	// Addr Offset 0x4 (Read Only)
	reg	[7:0]	rx_byte;
	
	// Addr Offset 0x8 (Write and Read)
	reg	[3:0]	baudrate;	// Register to configure the baudrate
					// 0  -> 9600   bps
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

	// Addr Offset 0xC (Write and Read)
	reg	[1:0]	parity;		// Register to configure the parity
					// 0 -> no parity
					// 1 -> even parity
					// 2 -> odd parity

	// Addr Offset 0x10 (Read Only)
	reg	[3:0]	fifo_status;


	//*******************************************************************
	// AXI LITE - Slave Interface Logic












	//*******************************************************************


	// Sub-Module Instances
	BAUDGEN baudgen_inst(
		.clk(),
		.a_resetn(),
		.baudrate(),
		.baudtick()
	);


	FIFO #(.DWIDTH(8), .AWIDTH(5))	tx_fifo_inst(
		.clk(),
		.a_resetn(),
		.rd(),
		.wr(),
		.w_data(),
		.empty(),
		.full(),
		.r_data()
	);


	FIFO #(.DWIDTH(8), .AWIDTH(5))	rx_fifo_inst(
		.clk(),
		.a_resetn(),
		.rd(),
		.wr(),
		.w_data(),
		.empty(),
		.full(),
		.r_data()
	);


	UART_TX uart_tx_inst(
		.clk(),
		.a_resetn(),
		.tx_start(),
		.b_tick(),
		.d_in(),
		.parity(),
		.tx_done(),
		.tx()
	);
	

	UART_RX uart_rx_inst(
		.clk(),
		.a_resetn(),
		.b_tick(),
		.rx(),
		.parity(),
		.rx_done(),
		.dout()
	);

endmodule

