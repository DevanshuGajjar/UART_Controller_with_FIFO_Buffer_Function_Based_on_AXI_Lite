onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {Clock & Reset} -radix unsigned /testbench/clk
add wave -noupdate -expand -group {Clock & Reset} -radix unsigned /testbench/a_resetn
add wave -noupdate -expand -group S_AXI_AW -radix hexadecimal /testbench/S_AXI_LITE_awaddr
add wave -noupdate -expand -group S_AXI_AW -radix unsigned /testbench/S_AXI_LITE_awvalid
add wave -noupdate -expand -group S_AXI_AW -radix unsigned /testbench/S_AXI_LITE_awready
add wave -noupdate -expand -group S_AXI_W -radix hexadecimal /testbench/S_AXI_LITE_wdata
add wave -noupdate -expand -group S_AXI_W -radix hexadecimal /testbench/S_AXI_LITE_wstrb
add wave -noupdate -expand -group S_AXI_W -radix unsigned /testbench/S_AXI_LITE_wvalid
add wave -noupdate -expand -group S_AXI_W -radix unsigned /testbench/S_AXI_LITE_wready
add wave -noupdate -expand -group S_AXI_BRESP -radix hexadecimal /testbench/S_AXI_LITE_bresp
add wave -noupdate -expand -group S_AXI_BRESP -radix unsigned /testbench/S_AXI_LITE_bvalid
add wave -noupdate -expand -group S_AXI_BRESP -radix unsigned /testbench/S_AXI_LITE_bready
add wave -noupdate -expand -group S_AXI_AR -radix hexadecimal /testbench/S_AXI_LITE_araddr
add wave -noupdate -expand -group S_AXI_AR -radix unsigned /testbench/S_AXI_LITE_arvalid
add wave -noupdate -expand -group S_AXI_AR -radix unsigned /testbench/S_AXI_LITE_arready
add wave -noupdate -expand -group S_AXI_R -radix hexadecimal /testbench/S_AXI_LITE_rdata
add wave -noupdate -expand -group S_AXI_R -radix hexadecimal /testbench/S_AXI_LITE_rresp
add wave -noupdate -expand -group S_AXI_R -radix unsigned /testbench/S_AXI_LITE_rvalid
add wave -noupdate -expand -group S_AXI_R -radix unsigned /testbench/S_AXI_LITE_rready
add wave -noupdate -expand -group UART_Signals -radix unsigned /testbench/Tx
add wave -noupdate -expand -group UART_Signals -radix unsigned /testbench/Rx
add wave -noupdate -expand -group UART_Signals -radix unsigned /testbench/uart_interrupt
add wave -noupdate -group AXI_LITE_UART -radix unsigned /testbench/AXI_LITE_UART_inst/b_tick
add wave -noupdate -group AXI_LITE_UART -radix unsigned /testbench/AXI_LITE_UART_inst/tx_fifo_rd
add wave -noupdate -group AXI_LITE_UART -radix unsigned /testbench/AXI_LITE_UART_inst/tx_fifo_wr
add wave -noupdate -group AXI_LITE_UART -radix unsigned /testbench/AXI_LITE_UART_inst/tx_fifo_empty
add wave -noupdate -group AXI_LITE_UART -radix unsigned /testbench/AXI_LITE_UART_inst/tx_fifo_full
add wave -noupdate -group AXI_LITE_UART -radix hexadecimal /testbench/AXI_LITE_UART_inst/tx_fifo_rdata
add wave -noupdate -group AXI_LITE_UART -radix unsigned /testbench/AXI_LITE_UART_inst/rx_fifo_rd
add wave -noupdate -group AXI_LITE_UART -radix unsigned /testbench/AXI_LITE_UART_inst/rx_fifo_wr
add wave -noupdate -group AXI_LITE_UART -radix hexadecimal /testbench/AXI_LITE_UART_inst/rx_fifo_wdata
add wave -noupdate -group AXI_LITE_UART -radix unsigned /testbench/AXI_LITE_UART_inst/rx_fifo_empty
add wave -noupdate -group AXI_LITE_UART -radix unsigned /testbench/AXI_LITE_UART_inst/rx_fifo_full
add wave -noupdate -group AXI_LITE_UART -radix hexadecimal /testbench/AXI_LITE_UART_inst/tx_byte
add wave -noupdate -group AXI_LITE_UART -radix hexadecimal /testbench/AXI_LITE_UART_inst/rx_byte
add wave -noupdate -group AXI_LITE_UART -radix hexadecimal /testbench/AXI_LITE_UART_inst/baudrate
add wave -noupdate -group AXI_LITE_UART -radix hexadecimal /testbench/AXI_LITE_UART_inst/parity
add wave -noupdate -group AXI_LITE_UART -radix hexadecimal /testbench/AXI_LITE_UART_inst/fifo_status
add wave -noupdate -group AXI_LITE_UART -radix unsigned /testbench/AXI_LITE_UART_inst/S_AXI_LITE_wr_state
add wave -noupdate -group AXI_LITE_UART -radix hexadecimal /testbench/AXI_LITE_UART_inst/wr_addr
add wave -noupdate -group AXI_LITE_UART -radix unsigned /testbench/AXI_LITE_UART_inst/S_AXI_LITE_rd_state
add wave -noupdate -group AXI_LITE_UART -radix hexadecimal /testbench/AXI_LITE_UART_inst/rd_addr
add wave -noupdate -group AXI_LITE_UART -radix unsigned /testbench/AXI_LITE_UART_inst/s_axi_lite_wr_pulse
add wave -noupdate -group AXI_LITE_UART -radix unsigned /testbench/AXI_LITE_UART_inst/s_axi_lite_rd_pulse
add wave -noupdate -group AXI_LITE_UART -radix unsigned /testbench/AXI_LITE_UART_inst/s_axi_lite_wvalid_delay
add wave -noupdate -group AXI_LITE_UART -radix unsigned /testbench/AXI_LITE_UART_inst/s_axi_lite_arvalid_delay
add wave -noupdate -group BAUDGEN -radix unsigned /testbench/AXI_LITE_UART_inst/baudgen_inst/clk
add wave -noupdate -group BAUDGEN -radix unsigned /testbench/AXI_LITE_UART_inst/baudgen_inst/a_resetn
add wave -noupdate -group BAUDGEN -radix unsigned /testbench/AXI_LITE_UART_inst/baudgen_inst/baudrate
add wave -noupdate -group BAUDGEN -radix unsigned /testbench/AXI_LITE_UART_inst/baudgen_inst/b_tick
add wave -noupdate -group BAUDGEN -radix unsigned /testbench/AXI_LITE_UART_inst/baudgen_inst/current_count
add wave -noupdate -group BAUDGEN -radix unsigned /testbench/AXI_LITE_UART_inst/baudgen_inst/next_count
add wave -noupdate -group BAUDGEN -radix unsigned /testbench/AXI_LITE_UART_inst/baudgen_inst/prescalar
add wave -noupdate -group TX_FIFO -radix unsigned /testbench/AXI_LITE_UART_inst/tx_fifo_inst/clk
add wave -noupdate -group TX_FIFO -radix unsigned /testbench/AXI_LITE_UART_inst/tx_fifo_inst/a_resetn
add wave -noupdate -group TX_FIFO -radix unsigned /testbench/AXI_LITE_UART_inst/tx_fifo_inst/rd
add wave -noupdate -group TX_FIFO -radix unsigned /testbench/AXI_LITE_UART_inst/tx_fifo_inst/wr
add wave -noupdate -group TX_FIFO -radix hexadecimal /testbench/AXI_LITE_UART_inst/tx_fifo_inst/w_data
add wave -noupdate -group TX_FIFO -radix unsigned /testbench/AXI_LITE_UART_inst/tx_fifo_inst/empty
add wave -noupdate -group TX_FIFO -radix unsigned /testbench/AXI_LITE_UART_inst/tx_fifo_inst/full
add wave -noupdate -group TX_FIFO -radix hexadecimal /testbench/AXI_LITE_UART_inst/tx_fifo_inst/r_data
add wave -noupdate -group TX_FIFO -radix hexadecimal /testbench/AXI_LITE_UART_inst/tx_fifo_inst/wr_ptr
add wave -noupdate -group TX_FIFO -radix hexadecimal /testbench/AXI_LITE_UART_inst/tx_fifo_inst/rd_ptr
add wave -noupdate -group TX_FIFO -radix unsigned /testbench/AXI_LITE_UART_inst/tx_fifo_inst/current_state
add wave -noupdate -group TX_FIFO -radix unsigned /testbench/AXI_LITE_UART_inst/tx_fifo_inst/next_state
add wave -noupdate -group TX_FIFO -radix hexadecimal /testbench/AXI_LITE_UART_inst/tx_fifo_inst/wr_ptr_next
add wave -noupdate -group TX_FIFO -radix hexadecimal /testbench/AXI_LITE_UART_inst/tx_fifo_inst/rd_ptr_next
add wave -noupdate -group TX_FIFO -radix unsigned /testbench/AXI_LITE_UART_inst/tx_fifo_inst/mem_wr_valid
add wave -noupdate -group TX_FIFO -radix hexadecimal -childformat {{{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/mem_dout[7]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/mem_dout[6]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/mem_dout[5]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/mem_dout[4]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/mem_dout[3]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/mem_dout[2]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/mem_dout[1]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/mem_dout[0]} -radix hexadecimal}} -subitemconfig {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/mem_dout[7]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/mem_dout[6]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/mem_dout[5]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/mem_dout[4]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/mem_dout[3]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/mem_dout[2]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/mem_dout[1]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/mem_dout[0]} {-height 15 -radix hexadecimal}} /testbench/AXI_LITE_UART_inst/tx_fifo_inst/mem_dout
add wave -noupdate -group TX_FIFO -childformat {{{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[31]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[30]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[29]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[28]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[27]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[26]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[25]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[24]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[23]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[22]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[21]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[20]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[19]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[18]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[17]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[16]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[15]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[14]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[13]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[12]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[11]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[10]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[9]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[8]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[7]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[6]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[5]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[4]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[3]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[2]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[1]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[0]} -radix hexadecimal}} -subitemconfig {{/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[31]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[30]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[29]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[28]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[27]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[26]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[25]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[24]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[23]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[22]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[21]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[20]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[19]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[18]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[17]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[16]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[15]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[14]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[13]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[12]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[11]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[10]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[9]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[8]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[7]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[6]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[5]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[4]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[3]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[2]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[1]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem[0]} {-height 15 -radix hexadecimal}} /testbench/AXI_LITE_UART_inst/tx_fifo_inst/fifo_mem
add wave -noupdate -expand -group UART_TX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_tx_inst/clk
add wave -noupdate -expand -group UART_TX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_tx_inst/a_resetn
add wave -noupdate -expand -group UART_TX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_tx_inst/tx_start
add wave -noupdate -expand -group UART_TX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_tx_inst/b_tick
add wave -noupdate -expand -group UART_TX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_tx_inst/d_in
add wave -noupdate -expand -group UART_TX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_tx_inst/parity
add wave -noupdate -expand -group UART_TX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_tx_inst/tx_get_data
add wave -noupdate -expand -group UART_TX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_tx_inst/tx
add wave -noupdate -expand -group UART_TX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_tx_inst/metastable_tick_count
add wave -noupdate -expand -group UART_TX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_tx_inst/r_SM_Current_State
add wave -noupdate -expand -group UART_TX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_tx_inst/r_bit_index
add wave -noupdate -expand -group UART_TX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_tx_inst/r_tx_data
add wave -noupdate -expand -group UART_TX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_tx_inst/b_tick_count
add wave -noupdate -expand -group UART_TX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_tx_inst/r_parity_buffer
add wave -noupdate -expand -group UART_TX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_tx_inst/parity_count
add wave -noupdate -expand -group UART_RX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_rx_inst/clk
add wave -noupdate -expand -group UART_RX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_rx_inst/rx
add wave -noupdate -expand -group UART_RX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_rx_inst/b_tick
add wave -noupdate -expand -group UART_RX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_rx_inst/a_resetn
add wave -noupdate -expand -group UART_RX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_rx_inst/parity
add wave -noupdate -expand -group UART_RX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_rx_inst/rx_done
add wave -noupdate -expand -group UART_RX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_rx_inst/dout
add wave -noupdate -expand -group UART_RX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_rx_inst/metastable_tick_count
add wave -noupdate -expand -group UART_RX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_rx_inst/r_SM_Main
add wave -noupdate -expand -group UART_RX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_rx_inst/r_Bit_Index
add wave -noupdate -expand -group UART_RX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_rx_inst/b_tick_count
add wave -noupdate -expand -group UART_RX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_rx_inst/r_Rx_Byte
add wave -noupdate -expand -group UART_RX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_rx_inst/rx_byte_parity
add wave -noupdate -expand -group UART_RX -radix hexadecimal /testbench/AXI_LITE_UART_inst/uart_rx_inst/parity_flag
add wave -noupdate -expand -group RX_FIFO -radix unsigned /testbench/AXI_LITE_UART_inst/rx_fifo_inst/clk
add wave -noupdate -expand -group RX_FIFO -radix unsigned /testbench/AXI_LITE_UART_inst/rx_fifo_inst/a_resetn
add wave -noupdate -expand -group RX_FIFO -radix unsigned /testbench/AXI_LITE_UART_inst/rx_fifo_inst/rd
add wave -noupdate -expand -group RX_FIFO -radix unsigned /testbench/AXI_LITE_UART_inst/rx_fifo_inst/wr
add wave -noupdate -expand -group RX_FIFO -radix hexadecimal /testbench/AXI_LITE_UART_inst/rx_fifo_inst/w_data
add wave -noupdate -expand -group RX_FIFO -radix unsigned /testbench/AXI_LITE_UART_inst/rx_fifo_inst/empty
add wave -noupdate -expand -group RX_FIFO -radix unsigned /testbench/AXI_LITE_UART_inst/rx_fifo_inst/full
add wave -noupdate -expand -group RX_FIFO -radix hexadecimal /testbench/AXI_LITE_UART_inst/rx_fifo_inst/r_data
add wave -noupdate -expand -group RX_FIFO -radix hexadecimal /testbench/AXI_LITE_UART_inst/rx_fifo_inst/wr_ptr
add wave -noupdate -expand -group RX_FIFO -radix hexadecimal /testbench/AXI_LITE_UART_inst/rx_fifo_inst/rd_ptr
add wave -noupdate -expand -group RX_FIFO -radix unsigned /testbench/AXI_LITE_UART_inst/rx_fifo_inst/current_state
add wave -noupdate -expand -group RX_FIFO -radix unsigned /testbench/AXI_LITE_UART_inst/rx_fifo_inst/next_state
add wave -noupdate -expand -group RX_FIFO -radix hexadecimal /testbench/AXI_LITE_UART_inst/rx_fifo_inst/wr_ptr_next
add wave -noupdate -expand -group RX_FIFO -radix hexadecimal /testbench/AXI_LITE_UART_inst/rx_fifo_inst/rd_ptr_next
add wave -noupdate -expand -group RX_FIFO -radix unsigned /testbench/AXI_LITE_UART_inst/rx_fifo_inst/mem_wr_valid
add wave -noupdate -expand -group RX_FIFO -radix unsigned -childformat {{{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/mem_dout[7]} -radix unsigned} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/mem_dout[6]} -radix unsigned} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/mem_dout[5]} -radix unsigned} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/mem_dout[4]} -radix unsigned} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/mem_dout[3]} -radix unsigned} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/mem_dout[2]} -radix unsigned} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/mem_dout[1]} -radix unsigned} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/mem_dout[0]} -radix unsigned}} -subitemconfig {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/mem_dout[7]} {-height 15 -radix unsigned} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/mem_dout[6]} {-height 15 -radix unsigned} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/mem_dout[5]} {-height 15 -radix unsigned} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/mem_dout[4]} {-height 15 -radix unsigned} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/mem_dout[3]} {-height 15 -radix unsigned} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/mem_dout[2]} {-height 15 -radix unsigned} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/mem_dout[1]} {-height 15 -radix unsigned} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/mem_dout[0]} {-height 15 -radix unsigned}} /testbench/AXI_LITE_UART_inst/rx_fifo_inst/mem_dout
add wave -noupdate -expand -group RX_FIFO -childformat {{{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[31]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[30]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[29]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[28]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[27]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[26]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[25]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[24]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[23]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[22]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[21]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[20]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[19]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[18]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[17]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[16]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[15]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[14]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[13]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[12]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[11]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[10]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[9]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[8]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[7]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[6]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[5]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[4]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[3]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[2]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[1]} -radix hexadecimal} {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[0]} -radix hexadecimal}} -subitemconfig {{/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[31]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[30]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[29]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[28]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[27]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[26]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[25]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[24]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[23]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[22]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[21]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[20]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[19]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[18]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[17]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[16]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[15]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[14]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[13]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[12]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[11]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[10]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[9]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[8]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[7]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[6]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[5]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[4]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[3]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[2]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[1]} {-height 15 -radix hexadecimal} {/testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem[0]} {-height 15 -radix hexadecimal}} /testbench/AXI_LITE_UART_inst/rx_fifo_inst/fifo_mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {22095000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 406
configure wave -valuecolwidth 75
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {897020250 ps}
