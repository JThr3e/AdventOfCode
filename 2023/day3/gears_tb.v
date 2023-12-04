module test;

  /* Make a reset that pulses once. */
  reg reset = 0;
  initial begin
     # 0 reset = 1;
     # 7 reset = 0;
     # 310000 $stop;
     //# 2000 $stop;
  end

  /* Make a regular pulsing clock. */
  reg clk = 0;
  always #5 clk = !clk;

  wire [31:0] counter, test;
  wire [63:0] prod_sum;
  wire [7:0] value;
  wire is_digit, is_symbol, valid, part_of_part_num, bot;
  gears c1 (clk, reset, counter, value, valid, prod_sum, test);

  initial
     $monitor("At time %t, counter = %d, value = %h, valid = %h, prod_sum = %d, test = %d",
              $time, counter, value, valid, prod_sum, test);
endmodule // test
