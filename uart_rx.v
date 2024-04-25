`timescale 1ns / 1ps


module uart_rx 
  (
   input         clk,
   input         rx,
   input         b_tick,
   input         a_resetn,
   input         [1:0] parity,
   output   reg  rx_done,
   output   reg  [7:0] dout
   );
  
  parameter metastable_tick_count = 15;  
  parameter s_IDLE                = 3'b000;
  parameter s_RX_START_BIT        = 3'b001;
  parameter s_RX_DATA_BITS        = 3'b010;
  parameter s_RX_PARITY           = 3'b011;
  parameter s_RX_STOP_BIT         = 3'b100;
     

  reg           r_Rx_Data   = 1'b1;
  reg [3:0]     r_Bit_Index; //8 bits total
  reg [2:0]     r_SM_Main;
  reg [7:0]     b_tick_count;
  reg [7:0]     r_Rx_Byte;
  reg           parity_count;
  reg           parity_bit;
  reg           parity_flag;  //flag =0 is invalid //flag = 1 is valid data bit
  

    
  // Purpose: Control RX state machine
  always @(posedge clk or posedge a_resetn)begin
//      r_Rx_Data <= rx;
      if (a_resetn == 1'b1)begin
            r_SM_Main <= s_IDLE;
            b_tick_count <= 0;
            r_Bit_Index <= 0;
            r_Rx_Data <= 0;
            rx_done <= 0;
            dout <= 0;
            parity_flag <= 0;
            parity_count <= 0;
            parity_bit <= 0;
            r_Rx_Byte <= 0;
       end         
       else begin
            case (r_SM_Main)
                s_IDLE :
                  begin
                    rx_done <= 0;
                    b_tick_count <= 0;
                    r_Bit_Index   <= 0;                     
                    if (rx == 1'b0)begin // Start bit detected
//                      $display("Rx_serial %b",r_Rx_Data);
                      r_SM_Main <= s_RX_START_BIT;
                      end
                    else begin
                      r_SM_Main <= s_IDLE;
                    end
                  end
                 
                // Check middle of start bit to make sure it's still low
                s_RX_START_BIT :
                  if(b_tick == 1'b1)begin
                    if (b_tick_count == 7)begin
                        if (rx == 1'b0)
                          begin
                            b_tick_count <= 0;  // reset counter, found the middle
                            r_SM_Main     <= s_RX_DATA_BITS;
                          end
                        else
                          r_SM_Main <= s_IDLE;
                      end
                    else begin
                        b_tick_count <= b_tick_count + 1;
                        r_SM_Main     <= s_RX_START_BIT;
                      end
                   end // case: s_RX_START_BIT
                  else begin
                    b_tick_count <= b_tick_count;
                    r_SM_Main     <= s_RX_START_BIT;
                  end
              
                       
                 
                // Wait CLKS_PER_BIT-1 clock cycles to sample serial data
                s_RX_DATA_BITS: begin
                  if(b_tick == 1'b1)begin
                    if(b_tick_count < metastable_tick_count)begin
                        b_tick_count <= b_tick_count + 1;
                        r_SM_Main     <= s_RX_DATA_BITS;
                    end
  
                    else begin
                        b_tick_count          <= 0;
                        r_Rx_Byte[r_Bit_Index] <= rx;
                        // Check if we have received all bits
                        if(r_Bit_Index < 7)begin
                            r_Bit_Index <= r_Bit_Index + 1;
                            r_SM_Main   <= s_RX_DATA_BITS;;
                        end
                        else begin
                            r_Bit_Index <= 0;
                            r_SM_Main   <= s_RX_PARITY;
                        end
                    end
                  end
                  else begin
                      b_tick_count <= b_tick_count;
                      r_SM_Main     <= s_RX_DATA_BITS;
                  end
                end 
               
                s_RX_PARITY : begin	
                  parity_bit <= rx;
                  parity_count <= ^r_Rx_Byte;
                  if(b_tick == 1'b1)begin
                    //wait for 16 ticks to make sure data has been stable while sending
                    if(b_tick_count < metastable_tick_count)begin
                      b_tick_count <= b_tick_count + 1;
                      r_SM_Main <= s_RX_PARITY; 
                    end
                    else begin
                      b_tick_count <= 0;
                      parity_count <= 0;
//                      $display("parity_count %b",parity_count);
                      if(parity == 2'b01)begin    // ODD Parity 
                        if((parity_count == 1) && (parity_bit == 0))begin
//                              $display("even if parity count %b and parity bit %b",parity_count,parity_bit);                        
                              //Data is COrrect  
                            parity_flag <= 1'b1; 	
                            r_SM_Main <= s_RX_STOP_BIT;
                        end      
                        else if ((parity_count == 0) && (parity_bit == 1)) begin
//                              $display("even if parity count %b and parity bit %b",parity_count,parity_bit);                        
                          parity_flag <= 1'b1;
                          r_SM_Main <= s_RX_STOP_BIT;
                        end                                 
                        else begin
                          //data is incorrect
                          parity_flag <= 1'b0; 
                          r_SM_Main <= s_RX_STOP_BIT;
                        end
                      end
                      else if (parity == 2'b10) begin   //Even Parity
                          if((parity_count == 0) && (parity_bit == 0))begin
                              //data correct 
//                              $display("even if parity count %b and parity bit %b",parity_count,parity_bit);
                              parity_flag <= 1'b1; 
                              r_SM_Main <= s_RX_STOP_BIT;
                          end
                          else if((parity_count == 1) && (parity_bit == 1))begin
//                              $display("even if parity count %b and parity bit %b",parity_count,parity_bit);
                              parity_flag <= 1'b1; 
                            r_SM_Main <= s_RX_STOP_BIT;
                          end
                          else begin
                              //data is incorrects
                            parity_flag <= 1'b0; 
                            r_SM_Main <= s_RX_STOP_BIT;
                          end
                      end
                    end
                  end
                  else begin
                      b_tick_count <= b_tick_count;
                      r_SM_Main <= s_RX_PARITY;					
                  end
                end    
             
                // Receive Stop bit.  Stop bit = 1       
                s_RX_STOP_BIT: begin
                  if(b_tick == 1'b1)begin
                      //wait for 16 ticks to make sure data has been stable while sending
                      if(b_tick_count < 7)begin
                          b_tick_count <= b_tick_count + 1;
                          r_SM_Main     <= s_RX_STOP_BIT; 
                      end
                      else begin
                        b_tick_count <= 0;
                        if(rx == 1)begin
    
                            r_SM_Main     <= s_IDLE;
                            rx_done <= 1'b1; 
                            dout <= r_Rx_Byte;                                  
                        end
                        else begin
                            r_SM_Main <= s_RX_STOP_BIT;
                        end
                      end
                  end
                  else begin
                          b_tick_count <= b_tick_count;
                          r_SM_Main     <= s_RX_STOP_BIT;				
                  end        
                end // case: s_RX_STOP_BIT
 
                default :
                  r_SM_Main <= s_IDLE;
                 
              endcase
              end
    end   
   
endmodule // uart_rx
