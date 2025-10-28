module Homework_3(
    input  logic [31:0] a, b,
    input  logic [1:0]  ALUControl,
    output logic [31:0] Result,
    output logic [3:0]  ALUFlags
);
logic carry;
logic [31:0] b_mux_out;
logic [31:0] sum;

assign b_mux_out = ALUControl[0] ? ~b : b;
assign {carry, sum} = a + b_mux_out + ALUControl[0];

always_comb begin
    case (ALUControl)
        2'b00: Result = sum;  			// ADD
        2'b01: Result = sum;           		// SUB
        2'b10: Result = a & b;           	// AND
	2'b11: Result = a | b;           	// OR
    endcase
end

assign ALUFlags[0] = (ALUControl[1] == 1'b0) & ~(a[31] ^ b[31] ^ ALUControl[0]) & (a[31] ^ sum[31]);	// Overflow
assign ALUFlags[1] = (ALUControl[1] == 1'b0) & carry;     						// Carry for ADD
assign ALUFlags[2] = (Result == 32'b0);                           					// Zero
assign ALUFlags[3] = Result[31];                                					// Negative


endmodule

