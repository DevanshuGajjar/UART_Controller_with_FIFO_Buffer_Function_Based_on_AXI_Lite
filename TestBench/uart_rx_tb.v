`timescale 1ns / 1ps

 
module rx_testbench ();
 
 reg clk;
 reg Rx_Serial;
 reg b_tick;
 reg [3:0]b_tick_counter = 0;
 reg a_resetn;
 reg [1:0]parity;
 wire rx_write_data;
 wire [7:0] Rx_Byte;
 
 
 
 uart_rx uart_rx1(.clk(clk),.rx(Rx_Serial),.a_resetn(a_resetn),.parity(parity),.b_tick(b_tick),.rx_done(rx_write_data),.dout(Rx_Byte));
 
 always #10 clk = ~clk;

 always@(posedge clk)begin    
    b_tick_counter = b_tick_counter + 1;
    if(b_tick_counter == 15)begin
       b_tick = 1'b1;
       b_tick_counter = 0;
    end
   else begin
       b_tick = 1'b0;
   end  
   end   
   
   initial begin
	clk = 0;
	Rx_Serial = 1'b1;
	a_resetn = 1'b1;
	#1000
//	repeat(16) @(posedge b_tick);
	a_resetn = 1'b0;
	repeat(16) @(posedge b_tick);
	parity = 2'b01;   //odd parity 
	repeat(16) @(posedge b_tick);
    Rx_Serial = 1'b0;  //start bit
    repeat(16) @(posedge b_tick);
    Rx_Serial = 1'b0;  //data start
    repeat(16) @(posedge b_tick);
    Rx_Serial = 1'b1;
    repeat(16) @(posedge b_tick);
    Rx_Serial = 1'b1;
    repeat(16) @(posedge b_tick);
    Rx_Serial = 1'b0;
    repeat(16) @(posedge b_tick);
    Rx_Serial = 1'b0;
    repeat(16) @(posedge b_tick);
    Rx_Serial = 1'b1;
    repeat(16) @(posedge b_tick);
    Rx_Serial = 1'b1;
    repeat(16) @(posedge b_tick);
    Rx_Serial = 1'b1;  //data end 
    repeat(16) @(posedge b_tick);
    Rx_Serial = 1'b0;  //parity
    repeat(16) @(posedge b_tick);
    Rx_Serial = 1'b1;  //stop
    #30000
    
    $display("Rx_data: %b",Rx_Byte);
    #20000
	$finish;
	
end

initial begin
	$dumpfile("uart_rx_dump.vcd");
	$dumpvars(0);

end

endmodule