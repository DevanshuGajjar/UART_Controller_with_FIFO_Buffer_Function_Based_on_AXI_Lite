`timescale 1ns / 1ps

module uart_tx_tb();

reg clk;
reg b_tick;
reg [7:0] in_data;
reg reset;
reg tx_start;
reg [1:0]parity;
reg [3:0]b_tick_counter = 0;
wire tx_result;
wire tx_get_data;

UART_TX uart_tx1(.clk(clk),.a_resetn(reset),.tx_start(tx_start),.b_tick(b_tick),.d_in(in_data),.parity(parity),.tx_get_data(tx_get_data),.tx(tx_result));

always #20 clk = ~clk;

always@(posedge clk)begin
	//$display("btick");
	b_tick_counter = b_tick_counter + 1;
	if(b_tick_counter == 15)begin
		//$display("count 15");
		b_tick = 1'b1;
		b_tick_counter = 0;
	end
	else begin
		b_tick = 1'b0;
	end
end

initial begin
	clk = 0;
	reset = 1'b1;
	#2000
	reset = 1'b0;
	#2000
	tx_start = 1'b0;	
	in_data = 8'b01100110;
	parity = 2'b10;
	#200
	tx_start = 1'b1;
	#200000
	$finish;
	
end

initial begin
	$dumpfile("uart_tx_dump.vcd");
	$dumpvars();

end

endmodule