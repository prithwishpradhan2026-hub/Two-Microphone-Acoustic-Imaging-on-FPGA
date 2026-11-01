# two_mic_grid.sdc
# Single clock domain: mic capture, filters, beamformer and the VGA renderer
# all run on CLOCK_50 (the VGA uses a 25 MHz pixel enable). VGA_CLK and the
# mic clock are register outputs, so no generated clocks are needed.

create_clock -name {CLOCK_50} -period 20.000 [get_ports {CLOCK_50}]
derive_clock_uncertainty

# Asynchronous / slow inputs
set_false_path -from [get_ports {KEY[0] SW[*] GPIO_MIC_DAT0}] -to [all_registers]

# Register-driven outputs (VGA data changes 20 ns before the VGA_CLK rising edge)
set_false_path -from [all_registers] -to [get_ports {GPIO_MIC_CLK VGA_* LEDR[*] LEDG[*] HEX*[*]}]
