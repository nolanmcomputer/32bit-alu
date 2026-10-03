//1-bit full-adder
module fulladd(sum1, cout, a, b, c);
	output sum1, cout;
	input a, b, c;
	wire s1, c1, c2;

	xor(s1, a, b);
	and(c1, a, b);
	xor(sum1, s1, c);
	and(c2, s1, c);
	or(cout, c2, c1);
endmodule