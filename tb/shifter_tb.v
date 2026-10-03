//Shifter stimulus
module shifter_stimulus;
	reg [4:0] x;
	reg [4:0] Const_amount;
	reg const_var;
	reg [31:0] y;
	reg shift_direction;
	wire [31:0] shifter_y;

	shifter shifty(shifter_y, x, Const_amount, const_var, y, shift_direction);
	
	initial
	begin
	$monitor($time,"y=%h, x=%0d, Const_amount=%0d, const_var=%b, dir=%b, shifted_y=%h", 
	y, x, Const_amount, const_var, shift_direction, shifter_y);
	
	//shift left
	y = 32'b0000_0000_0000_0000_0000_0000_0000_0010;
	x = 5'd2;
	Const_amount = 5'd1;
	const_var = 1'b1;
	shift_direction = 1'b1;
	#5

	//shift right
	const_var = 1'b0;
	shift_direction = 1'b0;
	#5
    $finish;
	end
endmodule