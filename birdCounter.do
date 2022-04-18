onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /birdCounter_testbench/dut/clk
add wave -noupdate /birdCounter_testbench/dut/reset
add wave -noupdate /birdCounter_testbench/dut/out
add wave -noupdate -expand /birdCounter_testbench/dut/temp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {102010 ps} 0}
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
WaveRestoreZoom {101800 ps} {102800 ps}
