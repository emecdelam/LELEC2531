module Exercise_4 (
input logic clk,
input logic reset,
input logic left, right, brake, fog, alarm,
output logic la, lb, lc, ra, rb, rc);

typedef enum logic[3:0] {NULL,R1,R2,R3,L1,L2,L3,BRAKE,FOG,ALARM} statetype;

statetype state, nextstate;

 

always_ff @(posedge clk, posedge reset)
	if (reset)		state <= NULL;
	else			state <= nextstate;

 

always_comb 
begin
	case (state)
		NULL: begin 
			if (right)				nextstate = R1;
			else if (left)			nextstate = L1;
			else if (left & right)	nextstate = NULL;
			else if (fog)			nextstate = FOG;
			else if (brake)			nextstate = BRAKE;
			else if (alarm)			nextstate = ALARM;
			else					nextstate = NULL;
		end
		R1:							nextstate = R2;
		R2:							nextstate = R3;
		R3:							nextstate = NULL;
		L1:							nextstate = L2;
		L2:							nextstate = L3;
		L3:							nextstate = NULL;
		BRAKE: begin
			if (fog) 				nextstate = FOG;
			else if (brake) 		nextstate = BRAKE;
			else if (alarm) 		nextstate = ALARM;
			else 					nextstate = NULL;
		end
		FOG: begin
			if (fog) 				nextstate = FOG;
			else if (brake)			nextstate = BRAKE;
			else if (alarm) 		nextstate = ALARM;
			else 					nextstate = NULL;
		end
		ALARM: begin
			if (fog)				nextstate = FOG;
			else if (brake)			nextstate = BRAKE;
			else 					nextstate = NULL;
		end
		default:					 nextstate = NULL;
	endcase
end

 

assign ra = (state == R1 || state == R2 || state == R3 || state == FOG || state == BRAKE || state == ALARM);
assign rb = (state == R2 || state == R3 || state == BRAKE || state == ALARM); 
assign rc = (state == R3 || state == BRAKE || state == ALARM);
assign la = (state == L1 || state == L2 || state == L3 || state == FOG || state == BRAKE || state == ALARM);
assign lb = (state == L2 || state == L3 || state == BRAKE || state == ALARM);
assign lc = (state == L3 || state == BRAKE || state == ALARM);

 

endmodule