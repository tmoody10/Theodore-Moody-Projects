// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
    output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output logic [9:0]  LEDR;
    input  logic [3:0]  KEY;
    input  logic [9:0]  SW;
    output logic [35:0] GPIO_1;
    input logic CLOCK_50;

	 // Turn off HEX displays
    assign HEX3 = '1;
    assign HEX4 = '1;
    assign HEX5 = '1;
	 
	 
	 /* Set up system base clock to 1526 Hz (50 MHz / 2**(14+1))
	    ===========================================================*/
	 logic [31:0] clk;
	 logic SYSTEM_CLOCK;
	 
	 clock_divider divider (.clock(CLOCK_50), .divided_clocks(clk));
	 
	 assign SYSTEM_CLOCK = clk[13];	 
	 
	 /* Set up LED board driver
	    ================================================================== */
	 logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs
    logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
	 logic RST;                   // reset - toggle this on startup
	 
	 assign RST = SW[0];
	 
	 
	 /* Standard LED Driver instantiation - set once and 'forget it'. 
	    See LEDDriver.sv for more info. Do not modify unless you know what you are doing! */
	 LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST, .EnableCount(1'b1), .RedPixels, .GrnPixels, .GPIO_1);
	 
	 
	 /* LED board test submodule - paints the board with a static pattern.
	    Replace with your own code driving RedPixels and GrnPixels.
		 
	 	 KEY0      : Reset
		 =================================================================== */
		 
	 logic doubleFFOut;
	 //double flip flop to avoid metastability
	 doubleFlip flippy (.clk(SYSTEM_CLOCK), .reset(RST), .in(~KEY[3]), .out(doubleFFOut));	 
		 
	 //hit detection	 
	 logic hit;
	 integer i;
	 always_ff @(posedge SYSTEM_CLOCK) begin
	  for (i=0; i<16; i++) begin
	   if(RST) hit<= 0;
		else begin
		 if (((RedPixels[13][i]) & (GrnPixels[13][i])) | (RedPixels[13][15] & doubleFFOut) | (RedPixels[13][0] & ~doubleFFOut)) hit <= 1;
		end
	  end
	 end 
	 
	 //Create a slower clock to sync up circuit with the LED refresh rate
    logic birdCount;	 
	 birdCounter birdClock(.clk(SYSTEM_CLOCK), .reset(RST), .out(birdCount));	 	
    logic pipeCount;
    pipeCounter pipeClock(.clk(SYSTEM_CLOCK), .reset(RST), .out(pipeCount));
 
	 cc bird (.clk(birdCount), .reset(RST | hit), .dir(doubleFFOut), .brdArray(RedPixels[13]));
	 
    pipeShift pipesCall(.clk(pipeCount), .reset(RST | hit), .pipes(GrnPixels));
	 
	 logic pipeMark;
    userInput hitMark(.clk(SYSTEM_CLOCK), .reset(RST), .in(GrnPixels[14][0]), .out(pipeMark));			 	 
	 
	 logic incrOut0;
	 hexCount score0(.clk(pipeMark), .reset(RST), .resetField(hit), .incrIn(1'b1), .incrOut(incrOut0), .HEX(HEX0));
	 
	 logic incrOut1;
	 hexCount score1(.clk(pipeMark), .reset(RST), .resetField(hit), .incrIn(incrOut0), .incrOut(incrOut1), .HEX(HEX1));
	 
	 logic incrOut2;
	 hexCount score2(.clk(pipeMark), .reset(RST), .resetField(hit), .incrIn(incrOut1), .incrOut(incrOut2), .HEX(HEX2));
     
endmodule

module DE1_SoC_testbench();
 logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 logic [9:0]  LEDR;
 logic [3:0]  KEY;
 logic [9:0]  SW;
 logic [35:0] GPIO_1;
 logic CLOCK_50;
	
 DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .SW, .LEDR, .GPIO_1, .CLOCK_50);
	
 // Set up a simulated clock.   
 parameter CLOCK_PERIOD=100;  

 initial begin   
  CLOCK_50 <= 0;  
  forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock 
 end  
 
 initial begin   
  KEY[3] <= 1;
  repeat(1) @(posedge CLOCK_50);  
  SW[0] <= 1; repeat(2) @(posedge CLOCK_50); // Always reset FSMs at start  
  SW[0] <= 0; repeat(1) @(posedge CLOCK_50);
  KEY[3] <= 0; @(posedge CLOCK_50);
  repeat(3000) @(posedge CLOCK_50);
  KEY[3] <= 1; @(posedge CLOCK_50);
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 0; @(posedge CLOCK_50);  
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 1; @(posedge CLOCK_50);
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 0; @(posedge CLOCK_50); 
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 1; @(posedge CLOCK_50);
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 0; @(posedge CLOCK_50);  
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 1; @(posedge CLOCK_50);
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 0; @(posedge CLOCK_50);  
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 1; @(posedge CLOCK_50);
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 0; @(posedge CLOCK_50); 
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 1; @(posedge CLOCK_50);
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 0; @(posedge CLOCK_50);
  repeat(3000) @(posedge CLOCK_50);
  KEY[3] <= 1; @(posedge CLOCK_50);
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 0; @(posedge CLOCK_50);  
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 1; @(posedge CLOCK_50);
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 0; @(posedge CLOCK_50); 
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 1; @(posedge CLOCK_50);
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 0; @(posedge CLOCK_50);  
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 1; @(posedge CLOCK_50);
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 0; @(posedge CLOCK_50);  
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 1; @(posedge CLOCK_50);
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 0; @(posedge CLOCK_50); 
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 1; @(posedge CLOCK_50);
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 0; @(posedge CLOCK_50);
  repeat(3000) @(posedge CLOCK_50);
  KEY[3] <= 1; @(posedge CLOCK_50);
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 0; @(posedge CLOCK_50);  
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 1; @(posedge CLOCK_50);
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 0; @(posedge CLOCK_50); 
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 1; @(posedge CLOCK_50);
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 0; @(posedge CLOCK_50);  
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 1; @(posedge CLOCK_50);
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 0; @(posedge CLOCK_50);  
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 1; @(posedge CLOCK_50);
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 0; @(posedge CLOCK_50); 
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 1; @(posedge CLOCK_50);
  repeat(1000) @(posedge CLOCK_50);
  KEY[3] <= 0; @(posedge CLOCK_50);  
  SW[0] <= 1; repeat(2) @(posedge CLOCK_50);
  SW[0] <= 0; repeat(1) @(posedge CLOCK_50); 
  KEY[3] <= 0; @(posedge CLOCK_50);   
  repeat(5000) @(posedge CLOCK_50);   
  $stop; // End the simulation.  
 end
endmodule