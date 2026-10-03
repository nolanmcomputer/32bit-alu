//32-bit multiplexer stimulus
module mux32bit_stim;
	reg [31:0] i0, i1, i2, i3;
	reg [1:0] sel;
	wire [31:0] out;

	mux32bit mymux(out, i0, i1, i2, i3, sel);
	
	initial
	begin
	$monitor($time, "sel=%b | out=%b", sel, out);
	i0 = 32'b1000_0000_0000_0000_0000_0000_0000_0000;
	i1 = 32'b0100_0000_0000_0000_0000_0000_0000_0000;
	i2 = 32'b0010_0000_0000_0000_0000_0000_0000_0000;
	i3 = 32'b0001_0000_0000_0000_0000_0000_0000_0000;
	//EXPECT same order
	sel = 2'b00; #5;
	sel = 2'b01; #5;
	sel = 2'b10; #5;
	sel = 2'b11; #5;
	$finish;
	end
endmodule