`timescale 1ns/1ps

module UART_TX(	
	input			clk,
	input			a_resetn,
	input			tx_start,
	input			b_tick,
	input		[7:0]	d_in,
	input		[1:0]	parity,
	output	reg		tx_get_data,
	output	reg		tx
);

parameter metastable_tick_count = 15;

enum reg [2:0] {S_IDLE = 3'b000, S_Start_Bit = 3'b001, S_Data_Bit = 3'b010, S_Parity = 3'b011, S_Stop_Bit = 3'b100} r_SM_Current_State;

reg [2:0] r_bit_index;
reg [7:0] r_tx_data;
reg [15:0] b_tick_count;
reg [1:0] r_parity_buffer;
reg	  parity_count;

always@(posedge clk or negedge a_resetn)begin 
	if(~a_resetn)begin
		tx <= 1'b1;
		tx_get_data <= 1'b0;
		r_SM_Current_State <= S_IDLE;
		r_bit_index <= 3'd0;
		r_tx_data <= 8'd0;
		b_tick_count <= 16'd0;
		r_parity_buffer <= 2'd0;
		parity_count <= 1'b0;
	end
	else begin
		case (r_SM_Current_State)
			S_IDLE: begin
				tx <= 1'b1; //Drive line high for idle state
				b_tick_count <= 0; 
				r_bit_index <= 0;
				if(tx_start == 1'b1 && b_tick == 1'b1)begin
					tx_get_data <= 1'b1;
					r_parity_buffer <= parity; //storing the parity bit into the temporary buffer
					r_SM_Current_State <= S_Start_Bit;
				end
				else begin
					r_SM_Current_State <= S_IDLE;
				end
			end

			S_Start_Bit: begin
				tx_get_data <= 1'b0;
				r_tx_data <= d_in; 	//sending the data frame to buffer
				parity_count <= ^d_in;
				tx <= 1'b0; 	//sending start of frame

				if(b_tick == 1'b1) begin
					if(b_tick_count < metastable_tick_count)begin
						b_tick_count <= b_tick_count + 1;
						r_SM_Current_State <= S_Start_Bit;
					end
					else begin
						b_tick_count <= 0;
						r_SM_Current_State <= S_Data_Bit;
					end
				end
				else begin
					b_tick_count <= b_tick_count;
					r_SM_Current_State <= S_Start_Bit;
				end
			end

			S_Data_Bit: begin
				tx <= r_tx_data[0];
				//wait for 16 ticks to make sure data has been stable while sending
				if(b_tick == 1'b1)begin
					if(b_tick_count < metastable_tick_count)begin
						b_tick_count <= b_tick_count + 1;
						r_SM_Current_State <= S_Data_Bit; 
					end

					else begin

						b_tick_count <= 0;

						//check if we have send all the bits
						if(r_bit_index < 7)begin
							r_bit_index <= r_bit_index + 1;
							r_tx_data <= r_tx_data >> 1;
							r_SM_Current_State <= S_Data_Bit;
						end
						else if(r_parity_buffer == 2'b00) begin
							r_bit_index <= 0;
							r_SM_Current_State <= S_Stop_Bit;
						end
						else begin
							r_bit_index <= 0;
							r_SM_Current_State <= S_Parity;
						end
					end
				end
				else begin
					b_tick_count <= b_tick_count;
					r_SM_Current_State <= S_Data_Bit;
				end
			end

			S_Parity: begin
					
					if(r_parity_buffer == 2'b01)begin    // ODD Parity 
						if(!parity_count)begin
							tx <= 1'b1;    	
						end
						else if (parity_count) begin
							tx <= 1'b0;
						end
					end
					else if (r_parity_buffer == 2'b10) begin   //Even Parity
						if(!parity_count)begin
							tx <= 1'b0;    	
						end
						else if (parity_count) begin
							tx <= 1'b1;
						end 

					else begin
						b_tick_count <= 0;
						parity_count <= 0;
						r_SM_Current_State <= S_Stop_Bit;				
					end		
					end

					if(b_tick == 1'b1)begin
						//wait for 16 ticks to make sure data has been stable while sending
						if(b_tick_count < metastable_tick_count)begin
							b_tick_count <= b_tick_count + 1;
							r_SM_Current_State <= S_Parity; 
						end

						else begin
							b_tick_count <= 0;
							parity_count <= 0;
							r_SM_Current_State <= S_Stop_Bit;
						end
					end

					else begin
						b_tick_count <= b_tick_count;
						r_SM_Current_State <= S_Parity;					
					end
			end


			S_Stop_Bit: begin
				tx <= 1'b1;  //sending the stop bit
				if(b_tick == 1'b1)begin
					//wait for 16 ticks to make sure data has been stable while sending
					if(b_tick_count < metastable_tick_count)begin
						b_tick_count <= b_tick_count + 1;
						r_SM_Current_State <= S_Stop_Bit; 
					end
					else begin
						b_tick_count <= 0;
						r_SM_Current_State <= S_IDLE;
					end
				end
				else begin
						b_tick_count <= b_tick_count;
						r_SM_Current_State <= S_Stop_Bit;				
				end
			end
			
			default: 
				r_SM_Current_State <= S_IDLE;

		endcase
	end
end

endmodule
