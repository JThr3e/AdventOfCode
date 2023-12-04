
module calc_gear_val_lhs(num0, num1, num2, valid, value);
  parameter WIDTH = 8;
  input [WIDTH-1:0] num0, num1, num2;
  output valid;
  output [31:0] value;
  wire valid_3, valid_2, valid_1;
  wire [31:0] value_3, value_2, value_1;
  // valid if it sees [ddd]
  assign valid_3 = (num0 >= 8'h30) & (num0 <= 8'h39) & (num1 >= 8'h30) & (num1 <= 8'h39) & (num2 >= 8'h30) & (num2 <= 8'h39);
  // valid if it sees [.dd]
  assign valid_2 = (~((num0 >= 8'h30) & (num0 <= 8'h39))) & (num1 >= 8'h30) & (num1 <= 8'h39) & (num2 >= 8'h30) & (num2 <= 8'h39);
  // valid if it sees [..d]
  assign valid_1 = (~((num0 >= 8'h30) & (num0 <= 8'h39))) & (~((num1 >= 8'h30) & (num1 <= 8'h39))) & (num2 >= 8'h30) & (num2 <= 8'h39);
  assign value_1 = (num2-8'h30);
  assign value_2 = ((num1-8'h30)*10) + value_1;
  assign value_3 = ((num0-8'h30)*100) + value_2;
  assign value = valid_3 ? value_3 : (valid_2 ? value_2 : (valid_1 ? value_1 : 1));
  assign valid = valid_1 | valid_2 | valid_3;
endmodule

module calc_gear_val_lhs_lite(num0, num1, num2, valid, value);
  parameter WIDTH = 8;
  input [WIDTH-1:0] num0, num1, num2;
  output valid;
  output [31:0] value;
  wire valid_3, valid_2, valid_1;
  wire [31:0] value_3, value_2, value_1;
  // valid if it sees [ddd]
  assign valid_3 = (num0 >= 8'h30) & (num0 <= 8'h39) & (num1 >= 8'h30) & (num1 <= 8'h39) & (num2 >= 8'h30) & (num2 <= 8'h39);
  assign value_1 = (num2-8'h30);
  assign value_2 = ((num1-8'h30)*10) + value_1;
  assign value_3 = ((num0-8'h30)*100) + value_2;
  assign value = valid_3 ? value_3 : 1;
  assign valid = valid_3;
endmodule

module calc_gear_val_rhs(num0, num1, num2, valid, value);
  parameter WIDTH = 8;
  input [WIDTH-1:0] num0, num1, num2;
  output valid;
  output [31:0] value;
  wire valid_3, valid_2, valid_1;
  wire [31:0] value_3, value_2, value_1;
  // valid if it sees [ddd]
  assign valid_3 = (num0 >= 8'h30) & (num0 <= 8'h39) & (num1 >= 8'h30) & (num1 <= 8'h39) & (num2 >= 8'h30) & (num2 <= 8'h39);
  // valid if it sees [dd.]
  assign valid_2 = (num0 >= 8'h30) & (num0 <= 8'h39) & (num1 >= 8'h30) & (num1 <= 8'h39) & (~((num2 >= 8'h30) & (num2 <= 8'h39)));
  // valid if it sees [d..]
  assign valid_1 = (num0 >= 8'h30) & (num0 <= 8'h39) & (~((num1 >= 8'h30) & (num1 <= 8'h39))) & (~((num2 >= 8'h30) & (num2 <= 8'h39)));
  assign value_1 = (num0-8'h30);
  assign value_2 = ((num0-8'h30)*10) + (num1-8'h30);
  assign value_3 = ((num0-8'h30)*100) + ((num1-8'h30)*10) + (num2-8'h30);
  assign value = valid_3 ? value_3 : (valid_2 ? value_2 : (valid_1 ? value_1 : 1));
  assign valid = valid_1 | valid_2 | valid_3;
endmodule

module calc_gear_val_rhs_lite(num0, num1, num2, valid, value);
  parameter WIDTH = 8;
  input [WIDTH-1:0] num0, num1, num2;
  output valid;
  output [31:0] value;
  wire valid_3, valid_2, valid_1;
  wire [31:0] value_3, value_2, value_1;
  // valid if it sees [ddd]
  assign valid_3 = (num0 >= 8'h30) & (num0 <= 8'h39) & (num1 >= 8'h30) & (num1 <= 8'h39) & (num2 >= 8'h30) & (num2 <= 8'h39);
  assign value_3 = ((num0-8'h30)*100) + ((num1-8'h30)*10) + (num2-8'h30);
  assign value = valid_3 ? value_3 : 1;
  assign valid = valid_3;
endmodule

module calc_gear_val_mid(num0, num1, num2, valid, value);
  parameter WIDTH = 8;
  input [WIDTH-1:0] num0, num1, num2;
  output valid;
  output [31:0] value;
  wire valid_3, valid_1;
  wire [31:0] value_3, value_1;
  // valid if it sees [ddd]
  assign valid_3 = (num0 >= 8'h30) & (num0 <= 8'h39) & (num1 >= 8'h30) & (num1 <= 8'h39) & (num2 >= 8'h30) & (num2 <= 8'h39);
  // valid if it sees [.d.]
  assign valid_1 = (~((num0 >= 8'h30) & (num0 <= 8'h39))) & (num1 >= 8'h30) & (num1 <= 8'h39) & (~((num2 >= 8'h30) & (num2 <= 8'h39)));
  assign value_1 = (num1-8'h30);
  assign value_3 = ((num0-8'h30)*100) + ((num1-8'h30)*10) + (num2-8'h30);
  assign value = valid_3 ? value_3 : (valid_1 ? value_1 : 1);
  assign valid = valid_1 | valid_3;
endmodule


module gears(clk, reset, counter, part_val, valid, prod_val_sum, test);

  parameter WIDTH = 8;
  parameter IPT_SIZE = 19599;
  parameter IPT_ROW_SIZE = 140;
  parameter IPT_COL_SIZE = 140;

  input 	       clk, reset;
  output [WIDTH-1: 0] part_val;
  output [7:0] state;
  output [31:0] counter, test;
  output [63:0] prod_val_sum;
  output valid;

  reg [31: 0]   counter;

  wire 	       clk, reset;

  reg [WIDTH-1:0] mem[IPT_SIZE:0];
  initial begin
     $readmemb("input.bin",mem);
  end

  reg [63:0] prod_val_sum;
  always @(posedge clk or posedge reset)
      if(reset)
      begin
	      counter <= 0;
              prod_val_sum <= 0;
      end
      else if (counter < IPT_SIZE)
      begin
	      counter <= counter+1;
	      if(valid)
		      prod_val_sum <= prod_val_sum + prod_vals;
      end      
      else 
      begin
	      counter <= counter;
	      prod_val_sum <= prod_val_sum;
      end

  assign part_val = mem[counter];
  assign is_gear = part_val == 8'h2A;
  
  wire [31:0] gear_values [11:0];
  wire gear_valids [11:0];
  wire [7:0] sum_valids;
  wire [63:0] prod_vals;

  // If this was real HW would probably read from mem over many clk cycles
  // instead of using many many read ports
  calc_gear_val_lhs u0(mem[counter-IPT_ROW_SIZE-3], mem[counter-IPT_ROW_SIZE-2], mem[counter-IPT_ROW_SIZE-1], gear_valids[0], gear_values[0]);
  calc_gear_val_lhs_lite u1(mem[counter-IPT_ROW_SIZE-2], mem[counter-IPT_ROW_SIZE-1], mem[counter-IPT_ROW_SIZE], gear_valids[1], gear_values[1]);
  calc_gear_val_mid u2(mem[counter-IPT_ROW_SIZE-1], mem[counter-IPT_ROW_SIZE], mem[counter-IPT_ROW_SIZE+1], gear_valids[2], gear_values[2]);
  calc_gear_val_rhs u3(mem[counter-IPT_ROW_SIZE+1], mem[counter-IPT_ROW_SIZE+2], mem[counter-IPT_ROW_SIZE+3], gear_valids[3], gear_values[3]);
  calc_gear_val_rhs_lite u4(mem[counter-IPT_ROW_SIZE], mem[counter-IPT_ROW_SIZE+1], mem[counter-IPT_ROW_SIZE+2], gear_valids[4], gear_values[4]);
  calc_gear_val_lhs u5(mem[counter-3], mem[counter-2], mem[counter-1], gear_valids[5], gear_values[5]);
  calc_gear_val_rhs u6(mem[counter+1], mem[counter+2], mem[counter+1], gear_valids[6], gear_values[6]);
  calc_gear_val_lhs u7(mem[counter+IPT_ROW_SIZE-3], mem[counter+IPT_ROW_SIZE-2], mem[counter+IPT_ROW_SIZE-1], gear_valids[7], gear_values[7]);
  calc_gear_val_lhs_lite u8(mem[counter+IPT_ROW_SIZE-2], mem[counter+IPT_ROW_SIZE-1], mem[counter+IPT_ROW_SIZE], gear_valids[8], gear_values[8]);
  calc_gear_val_mid u9(mem[counter+IPT_ROW_SIZE-1], mem[counter+IPT_ROW_SIZE], mem[counter+IPT_ROW_SIZE+1], gear_valids[9], gear_values[9]);
  calc_gear_val_rhs u10(mem[counter+IPT_ROW_SIZE+1], mem[counter+IPT_ROW_SIZE+2], mem[counter+IPT_ROW_SIZE+3], gear_valids[10], gear_values[10]);
  calc_gear_val_rhs_lite u11(mem[counter+IPT_ROW_SIZE], mem[counter+IPT_ROW_SIZE+1], mem[counter+IPT_ROW_SIZE+2], gear_valids[11], gear_values[11]);

  //genvar i;
  //generate
  //  for (i = 0; i < 5; i=i+1) begin
  //  end
  //endgenerate
  //calc_gear_val u1(mem[counter-3], mem[counter-2], mem[counter-1], gear_valids[5], gear_values[5]);
  //calc_gear_val u2(mem[counter+1], mem[counter+2], mem[counter+3], gear_valids[6], gear_values[6]);
  //generate
  //  for (i = 0; i < 5; i=i+1) begin
  //      calc_gear_val u3(mem[counter+IPT_ROW_SIZE-3+i], mem[counter+IPT_ROW_SIZE-2+i], mem[counter+IPT_ROW_SIZE-1+i], gear_valids[i+7], gear_values[i+7]);
  //  end
  //endgenerate
  //
  wire [31:0] gear_values_adj [11:0]; 
  assign gear_values_adj[0] = (~gear_valids[1]) ? gear_values[0] : 1;
  assign gear_values_adj[1] = gear_values[1];
  assign gear_values_adj[2] = gear_values[2];
  assign gear_values_adj[3] = (~gear_valids[2]) ? gear_values[3] : 1;
  assign gear_values_adj[4] = gear_values[4];
  assign gear_values_adj[5] = gear_values[5];
  assign gear_values_adj[6] = gear_values[6];
  assign gear_values_adj[7] = (~gear_valids[8]) ? gear_values[7] : 1;
  assign gear_values_adj[8] = gear_values[8];
  assign gear_values_adj[9] = gear_values[9];
  assign gear_values_adj[10] = (~gear_valids[11]) ? gear_values[10] : 1;
  assign gear_values_adj[11] = gear_values[11];

  wire gear_valids_adj [11:0];
  assign gear_valids_adj[0] = (~gear_valids[1]) ? gear_valids[0] : 0;
  assign gear_valids_adj[1] = gear_valids[1];
  assign gear_valids_adj[2] = gear_valids[2];
  assign gear_valids_adj[3] = (~gear_valids[2]) ? gear_valids[3] : 0;
  assign gear_valids_adj[4] = gear_valids[4];
  assign gear_valids_adj[5] = gear_valids[5];
  assign gear_valids_adj[6] = gear_valids[6];
  assign gear_valids_adj[7] = (~gear_valids[8]) ? gear_valids[7] : 0;
  assign gear_valids_adj[8] = gear_valids[8];
  assign gear_valids_adj[9] = gear_valids[9];
  assign gear_valids_adj[10] = (~gear_valids[11]) ? gear_valids[10] : 0;
  assign gear_valids_adj[11] = gear_valids[11];

  assign sum_valids = gear_valids_adj[0]+gear_valids_adj[1]+gear_valids_adj[2]+gear_valids_adj[3]+gear_valids_adj[4]+gear_valids_adj[5]
               +gear_valids_adj[6]+gear_valids_adj[7]+gear_valids_adj[8]+gear_valids_adj[9]+gear_valids_adj[10]+gear_valids_adj[11];
  // If this was real HW would mux out the valid gear values and then mul them because
  // otherwise this would be very wasteful
  assign prod_vals = gear_values_adj[0]*gear_values_adj[1]*gear_values_adj[2]*gear_values_adj[3]*gear_values_adj[4]*gear_values_adj[5]
               *gear_values_adj[6]*gear_values_adj[7]*gear_values_adj[8]*gear_values_adj[9]*gear_values_adj[10]*gear_values_adj[11];

  //assign test = gear_values[4];
  assign test = gear_values[10];

  assign valid = (sum_valids == 2) & is_gear;

  endmodule 
