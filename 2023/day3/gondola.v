module is_symbol(part_val, is_symbol);
  parameter WIDTH = 8;
  input [WIDTH-1: 0] part_val;
  output is_symbol;
  assign is_symbol = ((part_val >= 8'h21) & (part_val <= 8'h2D)) |
          ((part_val >= 8'h3A) & (part_val <= 8'h40)) |
          ((part_val >= 8'h5B) & (part_val <= 8'h60)) |
          ((part_val >= 8'h7B) & (part_val <= 8'h7F)) |
          (part_val == 8'h2F);
endmodule

module gondola(clk, reset, counter, part_val, is_digit, side_valid, part_of_part_num, part_sum);

  parameter WIDTH = 8;
  parameter IPT_SIZE = 19599;
  parameter IPT_ROW_SIZE = 140;
  parameter IPT_COL_SIZE = 140;

  input 	       clk, reset;
  output [WIDTH-1: 0] part_val;
  output [7:0] state;
  output is_digit, side_valid, part_of_part_num, top_valid, bot_valid;
  output [31:0] counter;
  output [31:0] part_sum;

  reg [31: 0]   counter;
  reg [31: 0]   part_sum;
  reg [7:0]     state;

  wire 	       clk, reset, is_digit;

  reg [WIDTH-1:0] mem[IPT_SIZE:0];
  initial begin
     $readmemb("input.bin",mem);
  end

  assign part_val = mem[counter];
  assign is_digit = (part_val >= 8'h30) & (part_val <= 8'h39);
  assign side_valid = (counter%IPT_ROW_SIZE > 0) & (counter%IPT_ROW_SIZE < (IPT_ROW_SIZE-1));
  assign top_valid = counter > IPT_ROW_SIZE;
  assign bot_valid = (counter < IPT_ROW_SIZE*(IPT_COL_SIZE-1));
  
  wire left,right,top,top_left,top_right,bot,bot_left,bot_right;
  // Gonna just use an obscene number of read ports ~becasue i can~
  is_symbol left_sym(mem[counter-1], left);
  is_symbol right_sym(mem[counter+1], right);
  is_symbol top_sym(mem[counter-IPT_ROW_SIZE], top);
  is_symbol top_left_sym(mem[counter-IPT_ROW_SIZE-1], top_left);
  is_symbol top_right_sym(mem[counter-IPT_ROW_SIZE+1], top_right);
  is_symbol bot_sym(mem[counter+IPT_ROW_SIZE], bot);
  is_symbol bot_left_sym(mem[counter+IPT_ROW_SIZE-1], bot_left);
  is_symbol bot_right_sym(mem[counter+IPT_ROW_SIZE+1], bot_right);

  wire top_is_sym, bot_is_sym;
  assign top_is_sym = top_valid & (top|top_left|top_right);
  assign bot_is_sym = bot_valid & (bot|bot_left|bot_right);
  assign part_of_part_num = side_valid & (left|right|top_is_sym|bot_is_sym);

  reg [WIDTH-1: 0]  num0;
  reg [WIDTH-1: 0]  num1;
  reg [WIDTH-1: 0]  num2;
  reg part_num_detected;
  // State Machine Next State Logic
  parameter detect_one=0, detect_two=1, detect_three=2, compute_one=3, compute_two=4, compute_three=5;
  always @(posedge clk or posedge reset)
    if (reset)
      begin
      state <= 0;
      counter <= 0;
      part_sum <= 0;
      end
    else if (counter < IPT_SIZE)
      case (state)
	  detect_one:
	      if (~is_digit)
		begin
	        state <= detect_one;
	        counter <= counter + 1;
	        end
	      else
		begin 
	        state <= detect_two;
	        counter <= counter + 1;
		num0 <= part_val-8'h30;
	        part_num_detected <= part_num_detected | part_of_part_num;
	        end
	  detect_two:
	      if (~is_digit)
		begin
		state <= compute_one;
	        counter <= counter + 1;
	        end
	      else
		begin
		state <= detect_three;
                counter <= counter + 1;
		num1 <= part_val-8'h30;
	        part_num_detected <= part_num_detected | part_of_part_num;
		end
          detect_three:
	      if (~is_digit)
		begin
		state <= compute_two;
	        counter <= counter + 1;
	        end
	      else
		begin
		state <= compute_three;
                counter <= counter + 1;
		num2 <= part_val-8'h30;
	        part_num_detected <= part_num_detected | part_of_part_num;
	        end
	  compute_one:
	      begin
	      state <= detect_one;
	      part_num_detected <= 0;
	      if (part_num_detected)
	        part_sum <= part_sum + num0;
              end
          compute_two:
	      begin
	      state <= detect_one;
	      part_num_detected <= 0;
	      if (part_num_detected)
	        part_sum <= part_sum + (10*num0) + num1;
              end
          compute_three:
	      begin
              part_num_detected <= 0;
	      state <= detect_one;
	      if (part_num_detected)
	        part_sum <= part_sum + (100*num0) + (10*num1) + num2;	        	
	      end
	endcase
    else
      begin
      counter <= counter;
      state <= state;
      end

endmodule 
