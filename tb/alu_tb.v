//my stimulus
/*module stimulus;
    reg [31:0] a, b;
    reg c_0;
    reg Const_Var;
    reg shift_direction;
    reg [1:0] Function_class;
    reg [1:0] Logic_function;
    reg [4:0] Const_amount;
    wire [31:0] s;
    
    ALU_32bits myALU32(s, a, b, c_0, Const_Var, shift_direction, Function_class, Logic_function, Const_amount);
    
    initial
    begin
    
    $monitor($time, "FuncClass=%b, Logic=%b | a=%h b=%h | s=%h", Function_class, Logic_function, a, b, s);
    
    a=32'b1000_0000_0000_0000_0000_0000_0000_0000;
    b=32'b0100_0000_0000_0000_0000_0000_0000_0000;
    
    Const_amount = 5'd2;
    Const_Var = 1'b1;
    
    //shift        EXPECT: h'10000000
    shift_direction = 1'b0;
    Function_class = 2'b00;
    Logic_function = 2'b00;
    c_0 = 1'b0; #5;
    //add       EXPECT h'c0000000
    Function_class = 2'b10;
    c_0 = 1'b0; #5;
    //subtract       EXPECT h'40000000
    c_0 = 1'b1; #5;
    //AND       EXPECT zeroes
    Function_class = 2'b11;
    Logic_function = 2'b00;
    #5;
    //OR         EXPECT h'c0000000
    Logic_function = 2'b01;
    #5;
    //XOR         EXPECT same as OR
    Logic_function = 2'b10;
    #5;
    //NOR          EXPECT h'3fffffff
    Logic_function = 2'b11;
    #5;
    
    $finish;
    end
endmodule*/

//provided-ALU-Stimulus
module stimulus;

	//inputs
	reg[31:0] A,B;	
	reg C_0,Const_Var,shift_direction;
	reg [1:0] Function_class;
	reg [1:0] Logic_function;
	reg [4:0] Const_amount; 

	//outputs
	wire[31:0] s;

	ALU_32bits my_ALU (s,  A, B,  C_0, Const_Var, shift_direction, Function_class, Logic_function, Const_amount);

	initial  
	  begin 

	    $monitor($time,"A=%d,B=%d,C_IN=%b,Function_class=%d,shift_direction=%b,Const_Var=%b,Const_amount=%d,shift_direction=%b,Logic_function=%d,OUTPUT=%d\n",A,B,C_0,Function_class,shift_direction,Const_Var,Const_amount,shift_direction,Logic_function,s);  
	  end
    initial
       begin
	A=4'd0; B=4'd0; C_0=1'b0;
	#5 A=8'd19; B=8'd55; Function_class[1]=1; Function_class[0]=0;  
	#5 A=8'd59; B=8'd38;C_0=1'b1; Function_class[1]=0; Function_class[0]=1;  
	#5 A=8'd39; B=8'd136; C_0=1'b1;  Function_class[1]=1; Function_class[0]=0; 
	#5 A=16'd9; B=16'd112; Function_class[1]=0; Function_class[0]=0; shift_direction=1; Const_Var=1; 
	#5 A=16'd129; B=16'd456;Function_class[1]=0; Function_class[0]=0;shift_direction=0;Const_Var=0;Const_amount=5'd7;  
	#5 A=16'd656; B=8'd218; C_0=1'b0;Function_class[1]=1; Function_class[0]=1;Logic_function=2'd0;  
	#5 A=8'd195; B=8'd228; C_0=1'b1;Function_class[1]=1; Function_class[0]=1;Logic_function=2'd1; 
	#5 A=8'd99; B=16'd286; C_0=1'b1;Function_class[1]=1; Function_class[0]=1;Logic_function=2'd2; 
	#5 A=8'd77; B=16'd486; C_0=1'b0;Function_class[1]=1; Function_class[0]=1;Logic_function=2'd3; 
       end
endmodule