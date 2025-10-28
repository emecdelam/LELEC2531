module Exercise_2 (MyInput,MyConstantSelect,MyOperation,MyStatus,MyOutput); 
input [7:0] MyInput; 
input [1:0] MyConstantSelect; // 0: Constant = 1, 1: Constant = 3, // 2: Constant = 5, 3: Constant = 7 
input [2:0] MyOperation; // 0 for Addition : MyOutput = MyInput + Constant // 1 for Subtract : MyOutput = MyInput - Constant // 2 for NAND : MyOutput = MyInput NAND Constant // 3 for NOR : MyOutput = MyInput NOR Constant // 4 for XOR : MyOutput = MyInput XOR Constant // 5-7 : not used 
output MyStatus; // if MyOutput is equal to 0 then MyStatus = 1 // else MyStatus = 0 
output [7:0] MyOutput; 



logic [3:0] cons; 
logic status; 
logic [7:0] out; 
always_comb begin 

	cons = (2'b10 *MyConstantSelect) + 1; 
	case (MyOperation) 3'b000: out = MyInput + cons; 
		3'b001: out = MyInput + ~cons +1; 
		3'b010: out = ~(MyInput & cons); 
		3'b011: out = ~(MyInput | cons); 
		3'b100: out = MyInput ^ cons; 
	endcase status = (out == 8'b0); 
end 
assign MyOutput = out; 
assign MyStatus = status; 
endmodule 







module testhw2; 


logic [7:0] in; 
logic [1:0] sel; 
logic [2:0] op; 
logic stat; 
logic [7:0] out; 
Exercise_2 ex ( 
.MyInput(in), 
.MyConstantSelect(sel), 
.MyOperation(op), 
.MyStatus(stat), 
.MyOutput(out) ); 

initial begin 
in = 8'b00000101; 
sel = 2'b10; 
op = 3'b000; 
#10 op = 3'b001; 
#10 sel = 2'b01; 
#10 sel = 2'b00; 
#10 op = 3'b000;
#10 op = 3'b001;
#10 op = 3'b010;
#10 op = 3'b011;
#10 op = 3'b100;
end

endmodule



