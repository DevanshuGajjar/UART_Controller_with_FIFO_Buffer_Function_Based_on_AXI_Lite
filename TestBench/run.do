vlib work
vdel -all

vlib work
vlog -sv AXI_LITE_UART.sv +acc
vlog -sv uart_tx.sv +acc
vlog -sv uart_rx.sv +acc
vlog -sv fifo.sv +acc
vlog -sv baudgen.sv +acc
vlog -sv testbench.sv +acc
vsim work.testbench

#	add wave -r *
do wave.do
run -all
