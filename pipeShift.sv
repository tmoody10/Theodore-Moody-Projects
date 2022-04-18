module pipeShift(clk, reset, pipes);
 input logic clk, reset;
 output logic [15:0][15:0] pipes;
 logic [15:0] p;
 
 //make a column pipe to load each bit into each row
 generatePipe newPipe(.clk, .reset, .out(p));
 
 //shift the array to the left and replace right column with new pipe
 always_ff @(posedge clk or posedge reset) begin
  if (reset) pipes <= 0;
  else begin
   pipes <= {pipes[14:0], p};
  end
 end
endmodule

module pipeShift_testbench();
 logic clk, reset;
 logic [15:0][15:0] pipes;
 logic [15:0] p;
 
 pipeShift dut(.clk, .reset, .pipes);
 
 // Set up a simulated clock.   
 parameter CLOCK_PERIOD=100;  
 initial begin   
  clk <= 0;  
  forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock 
 end  
 
 initial begin
  @(posedge clk);
  reset <= 1; @(posedge clk);
  reset <= 0; @(posedge clk);
  repeat(64) @(posedge clk);

  $stop; // End the simulation.  
 end  
endmodule  