module doubleFlip (clk, reset, in, out);
 input logic clk, reset, in;
 output logic out;
 logic mid;
 
 always_ff @(posedge clk) begin
  if(reset) begin
   out <= 0;
	mid <= 0;
  end
  else
  mid <= in;
  out <= mid;
 end
 
endmodule

module doubleFlip_testbench();
 logic clk, reset, in, out, mid;
 
 doubleFlip dut (.clk, .reset, .in, .out);
 
  // Set up a simulated clock.   
 parameter CLOCK_PERIOD=100;  
 initial begin  
  clk <= 0;  
  forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock 
 end  
 
 initial begin
  in = 0; @(posedge clk);
  in = 1; @(posedge clk);
  @(posedge clk);
  @(posedge clk);
  @(posedge clk);
 end
endmodule