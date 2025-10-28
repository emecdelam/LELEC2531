`timescale 1ns/1ps 	
module Homework_2 (input logic clk,
input logic reset,
input logic [2:0] buttons,
output logic [1:0] action);

typedef enum logic [1:0] {S , J, D, R} statetype;
statetype state, nextstate;

always_ff @(posedge clk)
	if (reset)	state <= S;
	else		state <= nextstate;
	
	
always_comb begin
	case (state)
		S: if (buttons[2])			nextstate = J;
			else if (buttons[1]) 		nextstate = R;
			else				nextstate = S;
		R: if (buttons[2])			nextstate = J;
			else if (buttons[1])		nextstate = R;
			else				nextstate = S;
		J: if ((buttons & 3'b101) == 3'b101)	nextstate = D;
			else if (buttons[1])		nextstate = R;
			else 				nextstate = S;
		D: 					nextstate = S;
		default:				nextstate = S;
	endcase
end

always_comb begin
	case (state)
		S: action = 2'b00;
		J: action = 2'b01;
		D: action = 2'b10;
		R: action = 2'b11;
		default: action = 2'b00;
	endcase
end

endmodule


module testhw;
	
	// signals
    	logic clk;
    	logic reset;
    	logic [2:0] buttons;
    	logic [1:0] action;


   	 Homework_2 hw (
        	.clk(clk),
        	.reset(reset),
        	.buttons(buttons),
        	.action(action)
    	);


    	// clock
   	initial clk = 0;
    	always begin
		#5 clk = 1;
		#5 clk = 0;
    	end

	initial begin
		reset = 0;
		#10
		reset = 1;
		#10
		reset = 0;
		#10
		buttons = 3'b100;
		#10
		buttons = 3'b101;
		#10
		buttons = 3'b000;
		#10
		buttons = 3'b010;
		#10
		buttons = 3'b100;
		#10
		buttons = 3'b010;
		#10
		buttons = 3'b100;
		#10
		buttons = 3'b000;
		#10
		buttons = 3'b100;
		#10
		reset = 1;
		buttons = 3'b101;
		#10
		reset = 0;
        	

    	end

endmodule