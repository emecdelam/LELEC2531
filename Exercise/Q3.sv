module Exercise_3 (
Clock,
CounterOut,
CounterInMSB, CounterInLSB,
DoReset,
DoIncrement, DoDecrement,
DoShiftL2R, DoShiftR2L
);
input logic Clock;
output logic [7:0] CounterOut;
input logic CounterInMSB, CounterInLSB; // Input bit when loading serially
input logic DoReset; // DoReset = 1 -> CounterOut = 0
input logic DoIncrement; // DoIncrement = 1 -> CounterOut++
input logic DoDecrement; // DoDecrement = 1 -> CounterOut--
input logic DoShiftL2R; // DoShiftL2R = 1 -> CounterOut = (CounterOut >> 1) + CounterInMSB * (2**7)
input logic DoShiftR2L; // DoShiftR2L = 1 -> CounterOut = (CounterOut << 1) + CounterInLSB

always_ff @(posedge Clock)
	if (DoReset)	CounterOut <= 8'b0;
	else begin
		if (DoIncrement)
			CounterOut <= CounterOut + 1;
		else if (DoDecrement)
			CounterOut <= CounterOut - 1;
		else if (DoShiftL2R)
			CounterOut <= (CounterOut >> 1) | (CounterInMSB << 7); // | same as + since we shift them
		else if (DoShiftR2L)
			CounterOut <= (CounterOut << 1) | CounterInLSB; 
	end


endmodule

module testhw3;

logic Clock;
logic CounterInMSB;
logic CounterInLSB;
logic DoReset;
logic DoIncrement;
logic DoDecrement;
logic DoShiftL2R;
logic DoShiftR2L;

logic [7:0] out;

Exercise_3 ex (
	.Clock(Clock),
	.CounterOut(out),
	.CounterInMSB(CounterInMSB),
	.CounterInLSB(CounterInLSB),
	.DoReset(DoReset),
	.DoIncrement(DoIncrement),
	.DoDecrement(DoDecrement),
	.DoShiftL2R(DoShiftL2R),
	.DoShiftR2L(DoShiftR2L)
);
initial Clock = 0;
always begin
#5 Clock = 1;
#5 Clock = 0;
end
initial begin

	DoReset <= 1;
	CounterInMSB <= 0;
	CounterInLSB <= 0;
	DoIncrement <= 0;
	DoDecrement <= 0;
	DoShiftL2R <= 0;
	DoShiftR2L <= 0;
	#10;
	// 	-----------------------
	//	CounterOut : 0000_0000
	//	-----------------------	
	DoReset <= 0;
	DoIncrement <= 1;
	#10;
	// 	-----------------------
	//	CounterOut : 0000_0001
	//	-----------------------	
	#10;
	// 	-----------------------
	//	CounterOut : 0000_0010
	//	-----------------------	
	#10;
	// 	-----------------------
	//	CounterOut : 0000_0011
	//	-----------------------
	DoIncrement <= 0;
	DoShiftR2L <= 1;
	CounterInLSB <= 1;
	#10;
	// 	-----------------------
	//	CounterOut : 0000_0111
	//	-----------------------
	CounterInLSB <= 0;
	#10;
	// 	-----------------------
	//	CounterOut : 0000_1110
	//	-----------------------
	#10;
	// 	-----------------------
	//	CounterOut : 0001_1100
	//	-----------------------
	DoShiftR2L <= 0;
	DoShiftL2R <= 1;
	CounterInMSB <= 1;
	#10;
	// 	-----------------------
	//	CounterOut : 1000_1110
	//	-----------------------
	CounterInMSB <= 0;
	#10;
	// 	-----------------------
	//	CounterOut : 0100_0111
	//	-----------------------
	DoShiftL2R <= 0;
	DoDecrement <= 1;
	#10;
	// 	-----------------------
	//	CounterOut : 0100_0110
	//	-----------------------
	#10;
	// 	-----------------------
	//	CounterOut : 0100_0101
	//	-----------------------
	DoReset <= 1;
	#10;
	// 	-----------------------
	//	CounterOut : 0000_0000
	//	-----------------------
end



endmodule