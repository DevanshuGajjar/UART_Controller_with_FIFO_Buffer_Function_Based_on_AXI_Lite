`timescale 1ns/1ps

module UART_TX(
	input			clk,	// 50,000,000
	input			a_resetn,
	input			tx_start,
	input			b_tick,	// (50,000,000 / 16 / 115,200)
	input		[7:0]	d_in,
	input		[1:0]	parity,

	output	reg		tx_get_data,
	output	reg		tx
);

parameter metastable_tick_count = 16;
parameter S_IDLE_Bit = 3'b000;
parameter S_Start_Bit  = 3'b001;
parameter S_Data_Bit = 3'b010;
parameter S_Parity = 3'b011;
parameter S_Stop_Bit = 3'b100;

reg [2:0] r_SM_Current_State = 0;
reg [2:0] r_bit_index = 0;
reg [7:0] r_tx_data = 0;
reg [7:0] b_tick_count = 0;
reg [3:0] parity_count =0;

always@(posedge clk)begin   //clk = 50000000 

	if(a_resetn == 1)begin
		tx <= 1'b1;
	end

	else begin
		case (r_SM_Current_State)
			S_IDLE_Bit: begin
				tx <= 1'b1; //Drive line high for idle state
				b_tick_count <= 0; 
				r_bit_index <= 0;
				if(tx_start == 1'b0)begin
					tx_get_data = 1'b1;
					r_tx_data <= d_in; //sending the data frame to buffer
					r_SM_Current_State <= S_Start_Bit;
				end
				else begin
					r_SM_Current_State <= S_IDLE_Bit;
				end
			end

			S_Start_Bit: begin
				tx <= 1'b0; //sending start of frame
				tx_get_data = 1'b0;
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
				tx <= r_tx_data[r_bit_index];
				if(d_in == 1)begin
					parity_count = parity_count + 1;
				end
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
							r_SM_Current_State <= S_Data_Bit;
						end
						else begin
							r_bit_index <= 0;
							r_SM_Current_State <= S_Parity;
							$display("CS %b",r_SM_Current_State);
						end
					end
				end
				else begin
					b_tick_count <= b_tick_count;
					r_SM_Current_State <= S_Data_Bit;
				end
			end

			S_Parity: begin
					
					if(parity == 2'b01)begin    // ODD Parity 
						if((parity_count % 2) == 0)begin
							tx <= 1'b1;    	
						end
						else if ((parity_count % 2) != 0) begin
							tx <= 1'b0;
						end
					end
					else if (parity == 2'b10) begin   //Even Parity
						if((parity_count % 2) == 0)begin
							tx <= 1'b0;    	
						end
						else if ((parity_count % 2) != 0) begin
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
						r_SM_Current_State <= S_IDLE_Bit;
					end
				end
				else begin
						b_tick_count <= b_tick_count;
						r_SM_Current_State <= S_Stop_Bit;				
				end
			end
			
			default: 
				r_SM_Current_State <= S_IDLE_Bit;

		endcase
	end
end

endmodule