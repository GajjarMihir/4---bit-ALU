`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:26:41 04/17/2015 
// Design Name: 
// Module Name:    Comparatorf 
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
//This is the Comparator Block.Here we have used the xor output from the logical block and the subtractor output and the overflow output from the adder subtractor block to compare A and B.
//Main Module of comparator block
module Comparatorf(Subtract,of,Xor,outp,Op);		//Collections of Inputs and outputs
input [3:0]Subtract,Xor,Op;	//Taking 4-bit input of the opcode and one input from logical block and other from Adder Subtractor Block
input of;		//1 Bit input of  Overflow from  Adder Subtractor Block.
reg AgB;			//1 Bit Register for A>B Condition
reg AlB;			//1 Bit Register for A<B Condition
reg AeB;			//1 Bit Register for A=B Condition
reg AneB;		//1 Bit Register for A!=B Condition
reg Nor;			//1 Bit register for storing nor value of Xor.
output reg [3:0]outp;	//4 - Bit Output.
reg compare;	//1 Bit register for storing the xor(ed) value of the MSB of the Subtractor input and the overflow.		
always @(*)
begin
compare = (of^Subtract[3]);	//XOR operation of Overflow and MSB of Subtractor input.
Nor = ~|Xor;				//Nor Operation of all the four bits of the Xor input.
if(Nor == 1'b1)	//If the Nor value is  1 then A will be equal to B hence AequalB is 1 and all other registers are 0.
begin
AgB = 0;
AlB = 0;
AeB = 1;
AneB =0;
end
else 			//Else AnotequalB will be 1.
begin
AeB =0; 
AneB =1;
AgB = 0;
AlB = 0; 
end
if(AneB && compare)	//Now if A is Not equal to B and compare is 1 then A will be less then B.
begin
AlB = 1;
AeB =0; 
AneB =1;
AgB = 0;
end
else if (AneB && (~compare))		//Now if A is Not equal to B and compare is 0 then A will be greater then B.
begin
AlB = 0;
AeB =0; 
AneB =1;
AgB = 1;
end
if(Op == 4'b1001)   //Now here depending upon the Opcode we are giving the outputs.We are assigning the zeroth bit to the required output and all other bits to 0.
begin
outp[0] = AeB;
outp[3:1]=3'b000;
end
else if(Op == 4'b1011)
begin
outp[0] = AneB;
outp[3:1]=3'b000;
end
else if(Op == 4'b1101)
begin
outp[0] = AgB;
outp[3:1]=3'b000;
end
else if(Op == 4'b1111)
begin
outp[3:1]=3'b000;
outp[0] = AlB;
end
else						//Else in every other Opcode the output will be zero.
outp = 4'b0000;
end
endmodule