`timescale 1ns / 1ps


module UART_RX (
	input			clk,
	input			rx,
	input			b_tick,
	input			a_resetn,
	input		[1:0]	parity,
	output	reg		rx_done,
	output	reg	[7:0]	dout
);

	parameter metastable_tick_count	= 15;

	enum reg [2:0] {s_IDLE = 3'b000, s_RX_START_BIT = 3'b001, s_RX_DATA_BITS = 3'b010, s_RX_PARITY = 3'b011, s_RX_STOP_BIT = 3'b100} r_SM_Main;

	reg	[3:0]	r_Bit_Index;
	reg	[15:0]	b_tick_count;
	reg	[7:0]	r_Rx_Byte;
	reg		rx_byte_parity;
	reg		parity_flag;

	always @(posedge clk or negedge a_resetn) begin
		if (!a_resetn) begin
			r_SM_Main	<= s_IDLE;
			b_tick_count	<= 16'd0;
			r_Bit_Index	<= 4'd0;
			rx_done		<= 1'b0;
			dout		<= 8'd0;
			parity_flag	<= 1'b0;
			rx_byte_parity	<= 1'b0;
			r_Rx_Byte	<= 1'b0;
		end
		else begin
			case (r_SM_Main)
				s_IDLE :	 begin
						 	rx_done		<= 0;
						 	b_tick_count	<= 0;
						 	r_Bit_Index	<= 0;
							r_Rx_Byte	<= 0;

						 	if (rx == 1'b0)	r_SM_Main <= s_RX_START_BIT;
						 	else		r_SM_Main <= s_IDLE;
						 end
				s_RX_START_BIT : begin
						 	if (b_tick == 1'b1) begin
						 		if (b_tick_count == 7) begin
						 			b_tick_count	<= 0;
						 			r_SM_Main	<= s_RX_DATA_BITS;
						 		end
						 		else	b_tick_count	<= b_tick_count + 1;
						 	end
						 end
				s_RX_DATA_BITS : begin
						 	if (b_tick == 1'b1) begin
						 		if (b_tick_count < metastable_tick_count)
						 			b_tick_count	<= b_tick_count + 1;
						 		else begin
						 			b_tick_count <= 0;
						 			r_Rx_Byte <= {rx, r_Rx_Byte[7:1]};
						 			
									if (r_Bit_Index < 7)
										r_Bit_Index <= r_Bit_Index + 1;
						 			else begin
						 				if (parity != 2'b00)	r_SM_Main <= s_RX_PARITY;
						 				else			r_SM_Main <= s_RX_STOP_BIT;

										parity_flag <= 1'b1;
						 			end
						 		end
						 	end
						 end 
				s_RX_PARITY :	 begin	
						 	rx_byte_parity <= ^r_Rx_Byte;
						 	if (b_tick == 1'b1) begin
						 		if (b_tick_count < metastable_tick_count)
						 			b_tick_count <= b_tick_count + 1;
						 		else begin
						 			b_tick_count <= 0;

						 			if (parity == 2'b01) begin	// Odd Parity
						 				if ((rx_byte_parity == 1 && rx == 0) || (rx_byte_parity == 0 && rx == 1))
						 					parity_flag <= 1'b1;
						 				else
						 					parity_flag <= 1'b0;
						 			end
						 			else if (parity == 2'b10) begin	// Even Parity
						 				if ((rx_byte_parity == 0 && rx == 0) || (rx_byte_parity == 1 && rx == 1))
						 					parity_flag <= 1'b1;
						 				else
						 					parity_flag <= 1'b0;
						 			end
						 			
									r_SM_Main <= s_RX_STOP_BIT;
						 		end
						 	end
						 end
				s_RX_STOP_BIT :	 begin
						 	if (b_tick == 1'b1) begin
						 		if (b_tick_count < metastable_tick_count)
						 			b_tick_count <= b_tick_count + 1;
						 		else begin
						 			b_tick_count <= 0;

						 			r_SM_Main <= s_IDLE;
						 			dout <= r_Rx_Byte;

									if (rx == 1 && parity_flag == 1'b1)
						 				rx_done	<= 1'b1;
						 		end
						 	end
						 end
				default :	 r_SM_Main <= s_IDLE;
			endcase
			end
	end

endmodule
