# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./LEDDriver.sv"
vlog "./clock_divider.sv"
vlog "./DE1_SoC.sv"
vlog "./cc.sv"
vlog "./birdCounter.sv"
vlog "./pipeCounter.sv"
vlog "./userInput.sv"
vlog "./doubleFlip.sv"
vlog "./generatePipe.sv"
vlog "./pipeShift.sv"
#vlog "./hit.sv"
vlog "./hexCount.sv"
vlog "./LFSR.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute. 
vsim -voptargs="+acc" -t 1ps -lib work DE1_SoC_testbench  
#vsim -voptargs="+acc" -t 1ps -lib work cc_testbench  
#vsim -voptargs="+acc" -t 1ps -lib work birdCounter_testbench  
#vsim -voptargs="+acc" -t 1ps -lib work pipeCounter_testbench 
#vsim -voptargs="+acc" -t 1ps -lib work generatePipe_testbench 
#vsim -voptargs="+acc" -t 1ps -lib work pipeShift_testbench 
#vsim -voptargs="+acc" -t 1ps -lib work hit_testbench 
#vsim -voptargs="+acc" -t 1ps -lib work hexCount_testbench 

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do DE1_SoC.do
#do cc.do
#do birdCounter.do
#do pipeCounter.do
#do generatePipe.do
#do pipeShift.do
#do hit.do
#do hexCount.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
