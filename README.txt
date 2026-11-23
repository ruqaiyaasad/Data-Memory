LAB 11 - OPEN ENDED DATA MEMORY
Implements data_memory exactly with the specified ports: i_clk, i_we, i_data[31:0],
i_addr[9:0], o_data[31:0]. Capacity is 1024 x 32-bit words.
Writes occur on rising edge only when i_we=1. Reads are asynchronous. All memory
locations are initialized to zero in simulation to avoid X values at startup.
Testbench covers startup zero, ordinary write/read, disabled write, first and last
addresses, overwrite, and multiple addresses.
Compile and simulate:
vlib work
vlog data_memory.v tb_data_memory.v
vsim work.tb_data_memory
add wave *
run -all
The initialization loop is intended to make simulation deterministic; check your FPGA
tool's synthesis support if you intend to infer a physical memory with initialized contents.
