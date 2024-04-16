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

parameter metastable_tick_count = 16;
parameter S_IDLE = 3'b000;
parameter S_Start_Bit  = 3'b001;
parameter S_Data_Bits = 3'b010;
parameter S_Stop_Bit = 3'b011;
parameter S_Cleanup = 3'b100;

reg [2:0] r_SM_Current_State = 0;
reg [2:0] r_bit_index = 0;
reg [10:0] r_tx_data = 0;
reg tx_done = 0;
reg [7:0] b_tick_count = 0;

always@(posedge b_tick)begin

	case (r_SM_Current_State)
	S_IDLE: begin
		tx <= 1'b1; //Drive line high for idle state
		tx_done <= 1'b0; //Data Send is pending
		b_tick_count <= 0; 
		r_bit_index <= 0;

		if(tx_start == 0)begin
			r_tx_data <= d_in; //sending the data frame to buffer
			r_SM_Current_State <= S_Start_Bit;
		end
		else begin
			r_SM_Current_State <= S_IDLE;
		end
	end

	S_Start_Bit: begin
		tx <= 1'b0; //sending start of frame

		if(b_tick_count < metastable_tick_count)begin
			b_tick_count <= b_tick_count + 1;
			r_SM_Current_State <= S_Start_Bits;
		end
		else begin
			b_tick_count <= 0;
			r_SM_Current_State <= S_Data_Bits;
		end
	end

	S_Data_Bits: begin
		tx <= d_in[r_bit_index];

		//wait for 16 ticks to make sure data has been stable while sending
		if(b_tick_count < metastable_tick_count)begin
			b_tick_count <= b_tick_count + 1;
			r_SM_Current_State <= S_Data_Bits; 
		end

		else begin
			b_tick_count <= 0;

			//check if we have send all the bits
			if(r_bit_index < 8)begin
				r_bit_index <= r_bit_index + 1;
				r_SM_Current_State <= S_Data_Bits;
			end
			else begin
				r_bit_index <= 0;
				r_SM_Current_State <= S_Stop_Bit;
			end
	end
	end

	S_Stop_Bit: begin
		tx <= 1'b1;  //sending the stop bit

		//wait for 16 ticks to make sure data has been stable while sending
		if(b_tick_count < metastable_tick_count)begin
			b_tick_count <= b_tick_count + 1;
			r_SM_Current_State <= S_Stop_Bit; 
		end
		else begin
			tx_done <= 1'b1;  //informing Tx Buffer that data has been sent
			b_tick_count <= 0;
			r_SM_Current_State <= S_Cleanup;
		end
	end
	
	S_Cleanup: begin
		tx_done <= 1'b1;
		r_SM_Current_State <= S_IDLE;
	end

	default: 
		r_SM_Current_State <= S_IDLE;

	endcase
end

endmodule
