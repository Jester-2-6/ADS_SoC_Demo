# ADS_SoC_Demo
SoC design using Zynq 7000 series FPGA. 
The task is to take a 1920X1080 video stream and apply a 7X7 convolution kernel and output in realtime.
The system is controlled by a microblaze core.
Convolution is handled via a set of custom SIMD cores.
A memory is used to buffer the video and R/W is handled via DMA
