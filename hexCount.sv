module hexCount(clk, reset, resetField, incrIn, incrOut, HEX);
 input logic clk, reset, resetField,incrIn;
 output logic incrOut;
 output logic [6:0] HEX;
 enum {zero, one, two, three, four, five, six, seven, eight, nine} ns, ps;
 
 //increment through numbers 0-9, then repeat
 always_comb begin
   case(ps)
    zero:  if(incrIn) ns = one;
	        else ns = zero;
	 one:   if(incrIn) ns = two;  
	        else ns = one;	 
	 two:   if(incrIn) ns = three;
	        else ns = two;	 	 
	 three: if(incrIn) ns = four;
	        else ns = three;	 	 
	 four:  if(incrIn) ns = five;
	        else ns = four;	 	 
	 five:  if(incrIn) ns = six;
	        else ns = five;	 
	 six:   if(incrIn) ns = seven;
	        else ns = six;	 
	 seven: if(incrIn) ns = eight;
	        else ns = seven;	 
	 eight: if(incrIn) ns = nine;
	        else ns = eight;	 
	 nine:  if(incrIn) ns = zero;
	        else ns = nine;	 
   endcase
 end
 
 assign incrOut = (incrIn & (ps == nine));
 
 //assign each digit to hex display
 always_comb begin
  case(ps)
   zero:  HEX = 7'b1000000;
	one:   HEX = 7'b1111001; 
	two:   HEX = 7'b0100100; 
	three: HEX = 7'b0110000; 
	four:  HEX = 7'b0011001; 
	five:  HEX = 7'b0010010; 
	six:   HEX = 7'b0000010; 
	seven: HEX = 7'b1111000; 
	eight: HEX = 7'b0000000; 
	nine:  HEX = 7'b0011000; 
	default: HEX = 7'bX;
  endcase	
 end
 
 //if hard reset, go to zero, if soft reset, keep the same digit until hard reset
 always_ff @(posedge clk or posedge reset) begin
  if(reset) ps <= zero;
  else if (resetField) ps <= ps;
  else ps <= ns;
 end
 
endmodule

module hexCount_testbench();
 logic clk, reset, resetField, incrIn;
 logic incrOut;
 logic [6:0] HEX;
 
 hexCount dut(.clk, .reset, .resetField,.incrIn, .incrOut, .HEX);
 
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
  incrIn <= 1; @(posedge clk);
  repeat(10) @(posedge clk);
  incrIn <= 0; @(posedge clk);
  repeat(10) @(posedge clk);
  $stop; // End the simulation.  
 end  
endmodule