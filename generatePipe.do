onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /generatePipe_testbench/clk
add wave -noupdate /generatePipe_testbench/reset
add wave -noupdate -expand /generatePipe_testbench/pipe
add wave -noupdate /generatePipe_testbench/dut/ps
add wave -noupdate /generatePipe_testbench/dut/ns
add wave -noupdate /generatePipe_testbench/dut/ps2
add wave -noupdate /generatePipe_testbench/dut/ns2
add wave -noupdate /generatePipe_testbench/dut/out
add wave -noupdate /generatePipe_testbench/dut/rndQueue
add wave -noupdate -expand /generatePipe_testbench/dut/temp
add wave -noupdate /generatePipe_testbench/dut/randomState/clk
add wave -noupdate /generatePipe_testbench/dut/randomState/reset
add wave -noupdate /generatePipe_testbench/dut/randomState/rnd
add wave -noupdate /generatePipe_testbench/dut/randomState/XNOR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1262 ps} 0}
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
WaveRestoreZoom {0 ps} {5513 ps}
