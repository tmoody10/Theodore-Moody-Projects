onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hexCount_testbench/dut/clk
add wave -noupdate /hexCount_testbench/dut/reset
add wave -noupdate /hexCount_testbench/dut/incrIn
add wave -noupdate /hexCount_testbench/dut/incrOut
add wave -noupdate /hexCount_testbench/dut/HEX
add wave -noupdate /hexCount_testbench/dut/ns
add wave -noupdate /hexCount_testbench/dut/ps
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {392 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {1 ns}
