`timescale 1ns/1ps


module FIFO #(parameter DWIDTH=8, AWIDTH=5)(
	input				clk,
	input				a_resetn,
	input				rd,
	input				wr,
	input		[DWIDTH - 1:0]	w_data,

	output	wire			empty,
	output	wire			full,
	output	reg	[DWIDTH - 1:0]	r_data
);
	
	reg	[AWIDTH-1:0]	wr_ptr;
	reg	[AWIDTH-1:0]	rd_ptr;

	enum reg [1:0] {EMPTY, PARTIAL, FULL} current_state, next_state;

	reg [DWIDTH - 1:0] fifo_mem [2**AWIDTH - 1:0];
	wire [AWIDTH - 1:0] wr_ptr_next, rd_ptr_next;
	wire mem_wr_valid;
	reg [DWIDTH - 1:0] mem_dout;

	always @(posedge clk or negedge a_resetn) begin
		if(~a_resetn)	current_state <= EMPTY;
		else	current_state <= next_state;
	end

	always @(*) begin
		case(current_state)
			EMPTY	:	next_state = (wr == 1'b1) ? PARTIAL : EMPTY;
			PARTIAL	:	begin
						if(wr == 1'b1 && rd == 1'b1)	next_state = PARTIAL;
						else if(wr == 1'b1)		next_state = (wr_ptr_next == rd_ptr) ? FULL : PARTIAL;
						else if(rd == 1'b1)		next_state = (rd_ptr_next == wr_ptr) ? EMPTY : PARTIAL;
						else				next_state = PARTIAL;
					end
			FULL	:	next_state = (rd == 1'b1) ? PARTIAL : FULL;
			default	:	next_state = EMPTY;
		endcase
	end

	always @(posedge clk or negedge a_resetn) begin
		if(~a_resetn)	wr_ptr <= 4'd0;
		else begin
			if(current_state != FULL)	wr_ptr <= (wr == 1'b1) ? wr_ptr_next : wr_ptr;
			else				wr_ptr <= wr_ptr;
		end
	end

	always @(posedge clk or negedge a_resetn) begin
		if(~a_resetn)	rd_ptr <= 4'd0;
		else begin
			if(current_state != EMPTY)	rd_ptr <= (rd == 1'b1) ? rd_ptr_next : rd_ptr;
			else				rd_ptr <= rd_ptr;
		end
	end

	assign wr_ptr_next = (wr_ptr == 2**AWIDTH - 1) ? 4'd0 : (wr_ptr + 4'd1);
	assign rd_ptr_next = (rd_ptr == 2**AWIDTH - 1) ? 4'd0 : (rd_ptr + 4'd1);

	assign full = (current_state == FULL) ? 1'b1 : 1'b0;
	assign empty = (current_state == EMPTY) ? 1'b1 : 1'b0;

	always @(posedge clk or negedge a_resetn) begin
		if(~a_resetn) r_data <= 8'd0;
		else	r_data <= (current_state != EMPTY && rd == 1'b1) ? mem_dout : r_data;
	end

	// Memory
	assign mem_wr_valid = (full == 1'b0 && wr == 1'b1) ? 1'b1 : 1'b0;

	always @(posedge clk) begin
		mem_dout <= fifo_mem[rd_ptr];
		if(mem_wr_valid == 1'b1)
			fifo_mem[wr_ptr] <= w_data;
	end

endmodule

