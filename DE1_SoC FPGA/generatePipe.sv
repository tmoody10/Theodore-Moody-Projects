module generatePipe (clk, reset, out);
 input logic clk, reset;
 output logic [15:0] out;
 logic [15:0] pipe; 
 enum logic [3:0] {g1=4'b0000,g2=4'b0001,g3=4'b0010,g4=4'b0011,g5=4'b0100,g6=4'b0101,g7=4'b0110,g8=4'b0111,g9=4'b1000} ps, ns;
 enum {one, two, three, four, five} ps2, ns2;
 logic rndQueue;
 logic [2:0] rnd;

 //counter with 5 states
 always_comb begin
  case(ps2)
   one:   ns2 = two;
   two:   ns2 = three;
   three: ns2 = four;
   four:  ns2 = five;
   five:  ns2 = one;
  endcase
 end 

 //counter ouputs true every five states
 always_ff @(posedge clk) begin
  if (reset) begin 
   ps2 <= one;
	rndQueue <= 0;
  end
  else if (ps2 == five) begin 
   ps2 <= ns2;
	rndQueue <= 1;
  end
  else begin 
   ps2 <= ns2;
	rndQueue <= 0;
  end
 end
 
 //generate a random number
 LFSR randomState(.clk, .reset, .rnd);
 logic [3:0] temp;
 
 //convert to 4 bits to match the state enumerations
 assign temp = {1'b0, rnd}; 
 
 //pipe shape logic
 always_comb begin
  case(temp)
	g1: pipe = 16'b1110000111111111;
   g2: pipe = 16'b1111000011111111;
	g3: pipe = 16'b1111100001111111;	
   g4: pipe = 16'b1111110000111111;
	g5: pipe = 16'b1111111000011111;
   g6: pipe = 16'b1111111100001111;
	g7: pipe = 16'b1111111110000111;		
	g8: pipe = 16'b1111111111000011; 
   g9: pipe = 0;
	default: pipe = 16'b0;
  endcase
 end
 
 //if variable is true, randomly select a pipe height as the present state
 //if variable is false, pipe column should be empty
 always_comb begin
  if (rndQueue) out = pipe;
  else out = 16'b0;
 end
 
endmodule

module generatePipe_testbench();
 logic clk, reset;
 logic [15:0] out;  
 
 generatePipe dut(clk, reset, out);
 
  // Set up a simulated clock.   
 parameter CLOCK_PERIOD=100;  
 initial begin  
  clk <= 0;  
  forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock 
 end  
   
 // Set up the inputs to the design.  Each line is a clock cycle.  
 initial begin  
                      @(posedge clk);   
  reset <= 1;         @(posedge clk); 
  reset <= 0;         @(posedge clk);
  repeat(50) @(posedge clk);
  $stop; // End the simulation.  
 end  
endmodule   