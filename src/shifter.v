//Shifter
module shifter(output [31:0] shifted_y, input[4:0] x, input [4:0] Const_amount,
               input const_var, input [31:0] y, input shift_direction);

	wire [4:0] amount, m, n;
	wire n_const;

	not(n_const, const_var);
	//select const_amount
    	and(m[0], Const_amount[0], n_const);
    	and(m[1], Const_amount[1], n_const);
    	and(m[2], Const_amount[2], n_const);
    	and(m[3], Const_amount[3], n_const);
    	and(m[4], Const_amount[4], n_const);
	//select x
    	and(n[0], x[0], const_var);
    	and(n[1], x[1], const_var);
    	and(n[2], x[2], const_var);
    	and(n[3], x[3], const_var);
    	and(n[4], x[4], const_var);
	//amount 
    	or(amount[0], m[0], n[0]);
    	or(amount[1], m[1], n[1]);
    	or(amount[2], m[2], n[2]);
    	or(amount[3], m[3], n[3]);
    	or(amount[4], m[4], n[4]);
	//shift left or right (dataflow)
	assign shifted_y = (shift_direction == 1'b1) ? y << amount : y >> amount ;
endmodule