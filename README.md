# UART_Controller_with_FIFO_Buffer_Function_Based_on_AXI_Lite

1. In order to use the AXI Lite we need to package the IP using Vivado.
2. Once the IP is created we need to connect the IP with AXI master.
3. The IP uses AXI Lite so if the SoC design uses AXI Master we need to make the use if AXI Interconnnect Bridge.

# Design Overview

![AXI Lite UART Concept Design](https://github.com/DevanshuGajjar/UART_Controller_with_FIFO_Buffer_Function_Based_on_AXI_Lite/blob/main/Images/AXI_LITE_UART_IP.jpg)

The design consists of the IP having AXI-Lite and UART with FIFO serving as the
buffer between the high-speed and low-speed protocols. 

#  AXI Lite UART IP

1. AXI Lite
2. Synchronous FIFO
3. Baudrate Generator
4. UART Tx
5. UART Rx