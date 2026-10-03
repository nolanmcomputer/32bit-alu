//ALU
module ALU_32bits(output [31:0] s, input [31:0] a, b, input c_0, 
input Const_Var, shift_direction, input [1:0] Function_class, input [1:0] Logic_function, input [4:0] Const_amount);

  wire [31:0] adder_out, shifter_out, logic_out;
  wire [31:0] diff_slt;
  wire        cout_add, cout_slt;
  wire [1:0]  sel;

  assign sel = Function_class;

  mux32bit  mux_output(s, shifter_out, /*SLT*/{31'b0, slt_bit}, adder_out, logic_out, sel);
  shifter   shifter_output(shifter_out, a[4:0], Const_amount, Const_Var, b, shift_direction);
  adder_sub addersub_output(adder_out, cout_add, a, b, c_0);
  adder_sub sub_for_slt   (diff_slt,  cout_slt, a, b, 1'b1);
  logic_unit logicoutput  (logic_out, a, b, Logic_function);

  // slt_bit = (a[31]^b[31]) ? a[31] : (A-B)[31]
  wire sign_a, sign_b, sign_diff, ab_sign_diff, n_ab_sign_diff, w0, w1, slt_bit;
  assign sign_a   = a[31];
  assign sign_b   = b[31];
  assign sign_diff= diff_slt[31];

  xor (ab_sign_diff,    sign_a, sign_b);
  not (n_ab_sign_diff,  ab_sign_diff);
  and (w0,              sign_diff,      n_ab_sign_diff); // same signs → use diff sign
  and (w1,              sign_a,         ab_sign_diff);   // different signs → a's sign
  or  (slt_bit,         w0, w1);

endmodule