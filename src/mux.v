// 1-bit 4-to-1 mux (for 32 bit)
module mux4_1_1bit(out, i0, i1, i2, i3, s1, s0);
    output out;
    input i0, i1, i2, i3;
    input s1, s0;

    wire ns1, ns0;
    wire w0, w1, w2, w3;

    not(ns1, s1);
    not(ns0, s0);

    // out = i0 when 00, i1 when 01 etc.
    and(w0, i0, ns1, ns0);
    and(w1, i1, ns1, s0);
    and(w2, i2, s1, ns0);
    and(w3, i3, s1, s0);

    or  (out, w0, w1, w2, w3);
endmodule

//32-bit multiplexer
module mux32bit (output [31:0] out, input [31:0] i0, i1, i2, i3, input [1:0] sel);
   //Ugly, but the only gate-level way to avoid certain 'width mismatch' errors
    mux4_1_1bit m00 (out[0], i0[0], i1[0], i2[0], i3[0], sel[1], sel[0]);
    mux4_1_1bit m01 (out[1], i0[1], i1[1], i2[1], i3[1], sel[1], sel[0]);
    mux4_1_1bit m02 (out[2], i0[2], i1[2], i2[2], i3[2], sel[1], sel[0]);
    mux4_1_1bit m03 (out[3], i0[3], i1[3], i2[3], i3[3], sel[1], sel[0]);
    mux4_1_1bit m04 (out[4], i0[4], i1[4], i2[4], i3[4], sel[1], sel[0]);
    mux4_1_1bit m05 (out[5], i0[5], i1[5], i2[5], i3[5], sel[1], sel[0]);
    mux4_1_1bit m06 (out[6], i0[6], i1[6], i2[6], i3[6], sel[1], sel[0]);
    mux4_1_1bit m07 (out[7], i0[7], i1[7], i2[7], i3[7], sel[1], sel[0]);
    mux4_1_1bit m08 (out[8], i0[8], i1[8], i2[8], i3[8], sel[1], sel[0]);
    mux4_1_1bit m09 (out[9], i0[9], i1[9], i2[9], i3[9], sel[1], sel[0]);
    mux4_1_1bit m10 (out[10], i0[10], i1[10], i2[10], i3[10], sel[1], sel[0]);
    mux4_1_1bit m11 (out[11], i0[11], i1[11], i2[11], i3[11], sel[1], sel[0]);
    mux4_1_1bit m12 (out[12], i0[12], i1[12], i2[12], i3[12], sel[1], sel[0]);
    mux4_1_1bit m13 (out[13], i0[13], i1[13], i2[13], i3[13], sel[1], sel[0]);
    mux4_1_1bit m14 (out[14], i0[14], i1[14], i2[14], i3[14], sel[1], sel[0]);
    mux4_1_1bit m15 (out[15], i0[15], i1[15], i2[15], i3[15], sel[1], sel[0]);
    mux4_1_1bit m16 (out[16], i0[16], i1[16], i2[16], i3[16], sel[1], sel[0]);
    mux4_1_1bit m17 (out[17], i0[17], i1[17], i2[17], i3[17], sel[1], sel[0]);
    mux4_1_1bit m18 (out[18], i0[18], i1[18], i2[18], i3[18], sel[1], sel[0]);
    mux4_1_1bit m19 (out[19], i0[19], i1[19], i2[19], i3[19], sel[1], sel[0]);
    mux4_1_1bit m20 (out[20], i0[20], i1[20], i2[20], i3[20], sel[1], sel[0]);
    mux4_1_1bit m21 (out[21], i0[21], i1[21], i2[21], i3[21], sel[1], sel[0]);
    mux4_1_1bit m22 (out[22], i0[22], i1[22], i2[22], i3[22], sel[1], sel[0]);
    mux4_1_1bit m23 (out[23], i0[23], i1[23], i2[23], i3[23], sel[1], sel[0]);
    mux4_1_1bit m24 (out[24], i0[24], i1[24], i2[24], i3[24], sel[1], sel[0]);
    mux4_1_1bit m25 (out[25], i0[25], i1[25], i2[25], i3[25], sel[1], sel[0]);
    mux4_1_1bit m26 (out[26], i0[26], i1[26], i2[26], i3[26], sel[1], sel[0]);
    mux4_1_1bit m27 (out[27], i0[27], i1[27], i2[27], i3[27], sel[1], sel[0]);
    mux4_1_1bit m28 (out[28], i0[28], i1[28], i2[28], i3[28], sel[1], sel[0]);
    mux4_1_1bit m29 (out[29], i0[29], i1[29], i2[29], i3[29], sel[1], sel[0]);
    mux4_1_1bit m30 (out[30], i0[30], i1[30], i2[30], i3[30], sel[1], sel[0]);
    mux4_1_1bit m31 (out[31], i0[31], i1[31], i2[31], i3[31], sel[1], sel[0]);
endmodule