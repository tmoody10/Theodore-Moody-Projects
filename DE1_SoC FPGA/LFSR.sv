module LFSR (clk, reset, rnd);
 input logic clk, reset;
 output logic [2:0] rnd; 
 logic XNOR;

 assign XNOR = (rnd[1] ~^ rnd[2]);

 //shift to the right, creates random number
 always_ff @(posedge clk) begin
  if (reset) rnd = 3'b000;
  else rnd = {rnd[1:0], XNOR};
 end
endmodule

module LFSR_testbench ();
 logic clk, reset;
 logic [2:0] rnd;

 LFSR dut (.clk, .reset, .rnd);
 
 // Set up a simulated clock.   
 parameter CLOCK_PERIOD=100;  
 initial begin  
  clk <= 0;  
  forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock 
 end   

  integer i;
 initial begin
 reset = 1; @(posedge clk);
 @(posedge clk);
 @(posedge clk);
 @(posedge clk);
 @(posedge clk);
 reset = 0; @(posedge clk);
  for (i = 0; i<1024; i++) begin
   @(posedge clk);
  end
 $stop; // End the simulation.  
 end
endmodule