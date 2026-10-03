//32-bit adder/subtractor
module adder_sub (sum1, cout, a, b, c);
	output cout;
	output [31:0] sum1;
	input[31:0] a, b;
	input c;
	wire [30:0] d; 
	wire [31:0] t;

      //instantiate
       //ugly but only way to avoid ‘width mismatch’ errors when using only gate-level modelling
	xor x0(t[0], b[0], c);
	fulladd as0(sum1[0], d[0], a[0], t[0], c);

	xor x1(t[1], b[1], c);
	fulladd as1(sum1[1], d[1], a[1], t[1], d[0]);

	xor x2(t[2], b[2], c);
	fulladd as2(sum1[2], d[2], a[2], t[2], d[1]);

	xor x3(t[3], b[3], c);
	fulladd as3(sum1[3], d[3], a[3], t[3], d[2]);

	xor x4(t[4], b[4], c);
	fulladd as4(sum1[4], d[4], a[4], t[4], d[3]);

	xor x5(t[5], b[5], c);
	fulladd as5(sum1[5], d[5], a[5], t[5], d[4]);

	xor x6(t[6], b[6], c);
	fulladd as6(sum1[6], d[6], a[6], t[6], d[5]);

	xor x7(t[7], b[7], c);
	fulladd as7(sum1[7], d[7], a[7], t[7], d[6]);

	xor x8(t[8], b[8], c);
	fulladd as8(sum1[8], d[8], a[8], t[8], d[7]);

	xor x9(t[9], b[9], c);
	fulladd as9(sum1[9], d[9], a[9], t[9], d[8]);

	xor x10(t[10], b[10], c);
	fulladd as10(sum1[10], d[10], a[10], t[10], d[9]);

	xor x11(t[11], b[11], c);
	fulladd as11(sum1[11], d[11], a[11], t[11], d[10]);

	xor x12(t[12], b[12], c);
	fulladd as12(sum1[12], d[12], a[12], t[12], d[11]);

	xor x13(t[13], b[13], c);
	fulladd as13(sum1[13], d[13], a[13], t[13], d[12]);

	xor x14(t[14], b[14], c);
	fulladd as14(sum1[14], d[14], a[14], t[14], d[13]);

	xor x15(t[15], b[15], c);
	fulladd as15(sum1[15], d[15], a[15], t[15], d[14]);

	xor x16(t[16], b[16], c);
	fulladd as16(sum1[16], d[16], a[16], t[16], d[15]);

	xor x17(t[17], b[17], c);
	fulladd as17(sum1[17], d[17], a[17], t[17], d[16]);

	xor x18(t[18], b[18], c);
	fulladd as18(sum1[18], d[18], a[18], t[18], d[17]);

	xor x19(t[19], b[19], c);
	fulladd as19(sum1[19], d[19], a[19], t[19], d[18]);

	xor x20(t[20], b[20], c);
	fulladd as20(sum1[20], d[20], a[20], t[20], d[19]);

	xor x21(t[21], b[21], c);
	fulladd as21(sum1[21], d[21], a[21], t[21], d[20]);

	xor x22(t[22], b[22], c);
	fulladd as22(sum1[22], d[22], a[22], t[22], d[21]);

	xor x23(t[23], b[23], c);
	fulladd as23(sum1[23], d[23], a[23], t[23], d[22]);

	xor x24(t[24], b[24], c);
	fulladd as24(sum1[24], d[24], a[24], t[24], d[23]);

	xor x25(t[25], b[25], c);
	fulladd as25(sum1[25], d[25], a[25], t[25], d[24]);

	xor x26(t[26], b[26], c);
	fulladd as26(sum1[26], d[26], a[26], t[26], d[25]);

	xor x27(t[27], b[27], c);
	fulladd as27(sum1[27], d[27], a[27], t[27], d[26]);

	xor x28(t[28], b[28], c);
	fulladd as28(sum1[28], d[28], a[28], t[28], d[27]);

	xor x29(t[29], b[29], c);
	fulladd as29(sum1[29], d[29], a[29], t[29], d[28]);

	xor x30(t[30], b[30], c);
	fulladd as30(sum1[30], d[30], a[30], t[30], d[29]);

	xor x31(t[31], b[31], c);
	fulladd as31(sum1[31], cout, a[31], t[31], d[30]);
endmodule