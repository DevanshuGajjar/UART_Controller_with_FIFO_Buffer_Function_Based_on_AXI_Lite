`timescale 1ns/1ps


module UART_TX(
	input			clk,
	input			a_resetn,
	input			tx_start,
	input			b_tick,
	input		[7:0]	d_in,
	input		[1:0]	parity,

	output	reg		tx_done,
	output	reg		tx
);



endmodule
