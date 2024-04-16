`timescale 1ns/1ps


module UART_RX(
	input			clk,
	input			a_resetn,
	input			b_tick,
	input			rx,
	input		[1:0]	parity,

	output	reg 		rx_done,
	output	reg	[7:0]	dout
);



endmodule
