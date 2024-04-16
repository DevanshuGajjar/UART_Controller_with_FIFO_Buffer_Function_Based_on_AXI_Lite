`timescale 1ns/1ps


module FIFO #(parameter DWIDTH=8, AWIDTH=5)(
	input				clk,
	input				a_resetn,
	input				rd,
	input				wr,
	input		[DWIDTH-1:0]	w_data,
	
	output	wire			empty,
	output	wire			full,
	output	wire	[DWIDTH-1:0]	r_data
);



endmodule

