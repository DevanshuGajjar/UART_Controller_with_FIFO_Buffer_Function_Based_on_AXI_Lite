`timescale 1ns/1ps


module BAUDGEN
(
	input			clk,
	input			a_resetn,
	input		[3:0]	baudrate,

	output	wire		b_tick
);

	reg	[15:0]	current_count;
	wire	[15:0]	next_count;
	reg	[15:0]	prescalar;

	always @(posedge clk or negedge a_resetn) begin
		if(~a_resetn)
			current_count <= 16'd0;
		else
			current_count <= next_count;
	end

	always @(*) begin
		case(baudrate)
			4'h0	: prescalar = 16'd650;	// 9600   bps
			4'h1	: prescalar = 16'd324;	// 19200  bps
			4'h2	: prescalar = 16'd216;	// 28800  bps
			4'h3	: prescalar = 16'd162;	// 38400  bps
			4'h4	: prescalar = 16'd107;	// 57600  bps
			4'h5	: prescalar = 16'd80; 	// 76800  bps
			4'h6	: prescalar = 16'd53; 	// 115200 bps
			4'h7	: prescalar = 16'd26; 	// 230400 bps
			4'h8	: prescalar = 16'd12; 	// 460800 bps
			4'h9	: prescalar = 16'd10; 	// 576000 bps
			4'ha	: prescalar = 16'd6;  	// 921600 bps
			default	: prescalar = 16'd650;	// 9600   bps
		endcase
	end

	assign next_count = (current_count < prescalar) ? (current_count + 16'd1) : 16'd0;

	assign b_tick = (current_count == prescalar) ? 1'b1 : 1'b0;

endmodule

