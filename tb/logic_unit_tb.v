//Logic unit stimulus
module logic1bit_stim;
	reg a, b;
	reg [1:0] s;
	wire out;
	
	logic1bit mylogic(out, a, b, s);
	
	initial
	begin
	$monitor($time, "a=%b b=%b s=%b | out=%b", a, b, s, out);
	a = 1'b0; 
	b = 1'b1;

	//AND
	s = 2'b00; #5;
	//OR
	s = 2'b01; #5;
	//XOR
	s = 2'b10; #5;
	//NOR
	s = 2'b11; #5;
	$finish;
	end
endmodule