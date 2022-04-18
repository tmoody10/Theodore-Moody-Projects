module userInput(clk, reset, in, out);
 input logic clk, reset, in;
 output logic out;
 
 enum logic {pressed = 1'b1, unpressed = 1'b0} ps, ns;

 //only true for the first instance of true value
 always_comb begin
  case(ps)
   unpressed: if (in) ns = pressed;
	 else ns = unpressed;
	pressed: if (in) ns = pressed;
	 else ns = unpressed;
  endcase
 end
 
 assign out = (in * ~ps);

 always_ff @(posedge clk) begin
  if (reset) ps <= unpressed;
  else ps <= ns;
 end
 
endmodule

module userInput_testbench();
 logic  clk, reset, in;  
 logic  out;  
  
 userInput dut (.clk, .reset, .in, .out);   
   
 // Set up a simulated clock.   
 parameter CLOCK_PERIOD=100;  
 initial begin  
  clk <= 0;  
  forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock 
 end  
   
 // Set up the inputs to the design.  Each line is a clock cycle.  
 initial begin  
                      @(posedge clk);   
  reset <= 1;         @(posedge clk); // Always reset FSMs at start (out should be 0)
  reset <= 0; in <= 0; repeat(3) @(posedge clk); //out should be 0
              in <= 1; @(posedge clk);   //out should be 1
              in <= 0; @(posedge clk);   //out should be 0
              in <= 1; repeat(5) @(posedge clk); //out should be 1, only once
              in <= 0; @(posedge clk);   //out shoud be 0
				  in <= 1; @(posedge clk)   //out should be 1, only once
                      @(posedge clk);
                      @(posedge clk);   		 

  $stop; // End the simulation.  
 end  
endmodule    