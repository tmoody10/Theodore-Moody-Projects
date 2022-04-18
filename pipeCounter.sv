module pipeCounter(clk, reset, out);
 input logic clk, reset;
 output logic out;
 logic [9:0] temp;
 
 //slow clock down to be true every 2^10th clock cycles
 always_ff @(posedge clk or posedge reset) begin
  if (reset) begin
  temp <= 0;
  out <= 0;
  end
  else begin
   temp <= temp + 1'b1;
	if (temp > 10'b0111111111) begin
 	 out <= 1;
	 end
	else out <= 0;
  end
 end
 
endmodule

module pipeCounter_testbench();
 logic clk, reset, out;
 
 pipeCounter dut (.clk, .reset, .out);
 
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
  @(posedge clk); repeat(3100) @(posedge clk);
  $stop; // End the simulation.  
 end  
 endmodule