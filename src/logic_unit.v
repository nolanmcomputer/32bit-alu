//Logic unit
module logic1bit(output out, input a, b, input [1:0] s);

  wire ns0, ns1;
  wire w0,w1,w2,w3;
  wire t1,t2,t3,t4;

  and i0(t1, a, b);
  or i1(t2, a, b);
  xor i2(t3, a, b);
  nor i3(t4, a, b);

  not mux0 (ns0, s[0]);
  not mux1 (ns1, s[1]);
  and mux2 (w0, t1, ns0, ns1);
  and mux3 (w1, t2, ns1, s[0]);
  and mux4 (w2, t3, ns0, s[1]);
  and mux5 (w3, t4, s[0], s[1]);
  or  mux6 (out, w0, w1, w2, w3);
endmodule

//32-bit logic unit instantiation
module logic_unit(output [31:0] out,
                  input  [31:0] a, b,
                  input  [1:0]  s);
  logic1bit u0 (out[0], a[0], b[0], s);
  logic1bit u1 (out[1], a[1], b[1], s);
  logic1bit u2 (out[2], a[2], b[2], s);
  logic1bit u3 (out[3], a[3], b[3], s);
  logic1bit u4 (out[4], a[4], b[4], s);
  logic1bit u5 (out[5], a[5], b[5], s);
  logic1bit u6 (out[6], a[6], b[6], s);
  logic1bit u7 (out[7], a[7], b[7], s);
  logic1bit u8 (out[8], a[8], b[8], s);
  logic1bit u9 (out[9], a[9], b[9], s);
  logic1bit u10(out[10], a[10], b[10], s);
  logic1bit u11(out[11], a[11], b[11], s);
  logic1bit u12(out[12], a[12], b[12], s);
  logic1bit u13(out[13], a[13], b[13], s);
  logic1bit u14(out[14], a[14], b[14], s);
  logic1bit u15(out[15], a[15], b[15], s);
  logic1bit u16(out[16], a[16], b[16], s);
  logic1bit u17(out[17], a[17], b[17], s);
  logic1bit u18(out[18], a[18], b[18], s);
  logic1bit u19(out[19], a[19], b[19], s);
  logic1bit u20(out[20], a[20], b[20], s);
  logic1bit u21(out[21], a[21], b[21], s);
  logic1bit u22(out[22], a[22], b[22], s);
  logic1bit u23(out[23], a[23], b[23], s);
  logic1bit u24(out[24], a[24], b[24], s);
  logic1bit u25(out[25], a[25], b[25], s);
  logic1bit u26(out[26], a[26], b[26], s);
  logic1bit u27(out[27], a[27], b[27], s);
  logic1bit u28(out[28], a[28], b[28], s);
  logic1bit u29(out[29], a[29], b[29], s);
  logic1bit u30(out[30], a[30], b[30], s);
  logic1bit u31(out[31], a[31], b[31], s);
endmodule