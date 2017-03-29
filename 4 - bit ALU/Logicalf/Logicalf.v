`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Vidit Shah(1401078) and Mihir Gajjar(1401076).
// 
// Create Date:    22:16:40 04/17/2015 
// Design Name: 
// Module Name:    Logicalf 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
// This is the Logical Module.
//Main Module of Logical Module.
module Logicalf(A,B,Op,Outp);			//Collection of inputs and outputs.
input [3:0]A;			//4 - Bit inputs
input [3:0]B;			
input [3:0]Op;
output [3:0]Outp;		//4 - bit Output
reg [3:0]temp;		//Taking a temporary register temp to temporary store the values.
always @ (*)
begin
if(Op == 4'b1000)   //OpCode for And Operation.
temp = (A&B);
else if(Op == 4'b1010)  //OpCode for Or Operation.   
temp = (A|B); 
else if(Op == 4'b1100 || Op == 4'b1011 || Op == 4'b1001 || Op == 4'b1101 || Op == 4'b1111)    //Here we have taken the Opcodes for Xor as well as the Opcodes for Comparator block because we need the Xor as an input in the comparator block.
temp = (A^B);
else if(Op == 4'b1110)     //OpCode for Nor Operation. 
temp = (~(A|B));
else
temp = 4'b0000;				//Else the output will be zero for any other Opcodes.		
end
assign Outp = temp;		//Assigning our output Outp to temp which was used for temporary holding the values.
endmodule
