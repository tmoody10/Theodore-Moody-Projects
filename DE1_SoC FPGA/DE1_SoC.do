onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/dut/HEX0
add wave -noupdate /DE1_SoC_testbench/dut/HEX1
add wave -noupdate /DE1_SoC_testbench/dut/HEX2
add wave -noupdate /DE1_SoC_testbench/dut/HEX3
add wave -noupdate /DE1_SoC_testbench/dut/HEX4
add wave -noupdate /DE1_SoC_testbench/dut/HEX5
add wave -noupdate /DE1_SoC_testbench/dut/LEDR
add wave -noupdate /DE1_SoC_testbench/dut/KEY
add wave -noupdate /DE1_SoC_testbench/dut/SW
add wave -noupdate /DE1_SoC_testbench/dut/GPIO_1
add wave -noupdate /DE1_SoC_testbench/dut/CLOCK_50
add wave -noupdate /DE1_SoC_testbench/dut/clk
add wave -noupdate /DE1_SoC_testbench/dut/SYSTEM_CLOCK
add wave -noupdate /DE1_SoC_testbench/dut/RedPixels
add wave -noupdate /DE1_SoC_testbench/dut/pipesCall/clk
add wave -noupdate /DE1_SoC_testbench/dut/pipesCall/reset
add wave -noupdate -expand /DE1_SoC_testbench/dut/pipesCall/p
add wave -noupdate -expand /DE1_SoC_testbench/dut/GrnPixels
add wave -noupdate /DE1_SoC_testbench/dut/RST
add wave -noupdate /DE1_SoC_testbench/dut/doubleFFOut
add wave -noupdate /DE1_SoC_testbench/dut/in
add wave -noupdate /DE1_SoC_testbench/dut/hit
add wave -noupdate /DE1_SoC_testbench/dut/i
add wave -noupdate /DE1_SoC_testbench/dut/birdCount
add wave -noupdate /DE1_SoC_testbench/dut/pipeCount
add wave -noupdate /DE1_SoC_testbench/dut/incrOut0
add wave -noupdate /DE1_SoC_testbench/dut/incrOut1
add wave -noupdate /DE1_SoC_testbench/dut/incrOut2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {325182 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ps} {4939673 ps}
