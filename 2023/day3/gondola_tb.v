module test;

  /* Make a reset that pulses once. */
  reg reset = 0;
  initial begin
     # 0 reset = 1;
     # 7 reset = 0;
     # 300000 $stop;
     //# 2000 $stop;
  end

  /* Make a regular pulsing clock. */
  reg clk = 0;
  always #5 clk = !clk;

  wire [31:0] counter;
  wire [31:0] part_sum;
  wire [7:0] value;
  wire is_digit, is_symbol, valid, part_of_part_num, bot;
  gondola c1 (clk, reset, counter, value, is_digit, valid, part_of_part_num, part_sum);

  initial
     $monitor("At time %t, counter = %d, value = %h, is_digit = %h, valid = %h, part_of_part_num = %h, part_sum = %d",
              $time, counter, value, is_digit, valid, part_of_part_num, part_sum);
endmodule // test
