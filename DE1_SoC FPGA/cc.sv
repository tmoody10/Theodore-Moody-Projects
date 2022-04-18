module cc(clk, reset, dir, brdArray);
 input logic clk, reset, dir;
 output logic [15:0] brdArray;

 //if user input is true, shift to the left
 //if user input is false, shift to the right
 always_ff @(posedge clk or posedge reset) begin
  if (reset) brdArray <= 16'b0000000100000000;
  else begin
   case(dir)
	 1: brdArray <= {brdArray[14:0], 1'b0};
	 0: brdArray <= {1'b0, brdArray[15:1]};
	endcase
  end
 end
endmodule

module cc_testbench();
 logic clk, reset, dir;
 logic [15:0] brdArray;
 
 cc dut(.clk, .reset, .dir, .brdArray);
 
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
  dir <= 1; @(posedge clk);
  @(posedge clk);
  @(posedge clk);
  @(posedge clk);
  @(posedge clk);
  @(posedge clk);
  dir <= 0; @(posedge clk);
  @(posedge clk);
  @(posedge clk);
  @(posedge clk);
  @(posedge clk);
  @(posedge clk);
  @(posedge clk);
  @(posedge clk);
  @(posedge clk);
  @(posedge clk);
  @(posedge clk);
  @(posedge clk);
  @(posedge clk);  
  $stop; // End the simulation.  
 end  
endmodule  