module Exercise_1 ( MyInput, MyConstantSelect, MyOperation, MyOutput ); 
	input [7:0] MyInput;
	input [1:0] MyConstantSelect; // 0: Constant = 1, 1: Constant = 3, 2: Constant = 5, 3: Constant = 7 
	input MyOperation; // 1 for Subtraction, 0 for Addition 
	output [7:0] MyOutput; 

logic [7:0] out;
logic [3:0] cons;
always_comb begin
	cons = (2'b10 *MyConstantSelect) + 1;
	out = (MyOperation ? MyInput + 1 + ~cons : MyInput + cons);
end 
assign MyOutput = out;

endmodule


module testhw1;

	logic [7:0] in;
	logic [1:0] sel;
	logic op;
	logic [7:0] out;



	Exercise_1 ex (
		.MyInput(in),
		.MyConstantSelect(sel),
		.MyOperation(op),
		.MyOutput(out)
	);

	initial begin
		in = 8'b00000101;
		sel = 2'b10;
		op = 1'b0;

		#10

		op = 1'b1;

		#10

		sel = 2'b01;

		#10

		sel = 2'b00;




	end


endmodule



