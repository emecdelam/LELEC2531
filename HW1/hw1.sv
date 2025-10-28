module Homework_1 (
    input  logic       CLK,
    input  logic       RST,
    input  logic [7:0] Input_1,
    input  logic [7:0] Input_2,
    input  logic [2:0] Control,
    output logic [7:0] Output
);

always_ff @ (posedge CLK, posedge RST) begin
    if (RST) begin
        Output <= 8'b00000000;
    end else begin
        if (Control[2]) begin
            if (Control[1])
                Output <= Input_1 + Input_2;
            else 
                Output <= Input_1 - Input_2;
	 
        end else begin
            if (Control[0])
                Output <= {Output[6:0], Output[7]};
	    else
                Output <= {Output[0], Output[7:1]};
          
	end
    end
end

endmodule

module testhw;

    // signals
    logic CLK;
    logic RST;
    logic [7:0] Input_1;
    logic [7:0] Input_2;
    logic [2:0] Control;
    logic [7:0] Output;


    Homework_1 hw (
        .CLK(CLK),
        .RST(RST),
        .Input_1(Input_1),
        .Input_2(Input_2),
        .Control(Control),
        .Output(Output)
    );

    // clock
    initial CLK = 0;
    always begin
	#5 CLK = 1;
	#5 CLK = 0;
    end

    
    initial begin

        RST = 0;
        Input_1 <= 8'b10000000;
        Input_2 <= 8'b00000001;
        Control <= 3'b110;
        #10;
	Input_1 <= 8'b10000000;
        Input_2 <= 8'b00000001;
        Control <= 3'b100;
        #10;
  	Input_1 <= 8'b00011000;
        Input_2 <= 8'b00000100;
        Control <= 3'b110;
	
        #10;


        Control <= 3'b001;
        #10;
	Control <= 3'b001;
	#10;
	Control <= 3'b001;
	#10;	
	Control <= 3'b001;
	#10;
	Control <= 3'b001;
	#10;
	Control <= 3'b001;
	#10;
	Control <= 3'b001;
	#10;
	Control <= 3'b001;
	#10;
	Control <= 3'b001;
	#10;
	Control <= 3'b001;
	#10;

    end

endmodule