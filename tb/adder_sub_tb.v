//1-bit full-adder stimulus
module fulladd_stim;
	reg a, b, c;
	wire sum1, cout;
	
	fulladd my_add(sum1, cout, a, b, c);
	
	initial
	begin
	$monitor($time, "a=%b, b=%b, c=%b", a, b, c, sum1, cout);
	
	a=0; b=0; c=0; #5;
	a=0; b=1; c=0; #5;
	a=1; b=1; c=0; #5; 
	a=1; b=1; c=1; #5;
	$finish;
	end
endmodule

//32-bit adder-subtractor stimulus
/*module adder_sub_stim;
	reg [31:0] a, b;
	reg c;
	wire [31:0] sum1;
	wire cout;

	adder_sub myadder(sum1, cout, a, b, c);

	initial
	begin
	$monitor($time, "c=%b a=%0d b=%0d | sum1=%0d cout=%b", c, a, b, sum1, cout);
	//5 + 4 = 9
	a = 32'd5; b = 32'd4; c = 1'b0; #5
	//6 – 2 = 4
	a = 32'd6; b = 32'd2; c = 1'b1; #5
	$finish;
	end
endmodule*/
