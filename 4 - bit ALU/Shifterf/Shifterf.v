`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:31:35 04/17/2015 
// Design Name: 
// Module Name:    Shifterf 
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
//There is only One module for shifter Block.Here we are shifting the input B.0th bit and 1th bit of input A is taken as Sa.
//Here we are shifting 0 bit for Sa=00 , 1 bit for Sa=01 , 2 bit for Sa = 10 and 3 bit for Sa = 11.
//Main Module.
module Shifterf(Sa,B,Cin,Op,fout);			//Collection of inputs and outputs.
input [1:0]Sa;			//Here Sa is of 2 bits for selecting the number of bits we want to shift.
input [3:0]B;			//4-bit input B and Opcode.
input [3:0]Op;			
input Cin;			//Cin from the adder Subtractor Block.
reg [3:0] X;		//A 4 bit register for storing the flipped value of B temporarily.
reg [3:0] out1;	//A 4 bit registers for temporarily storing the output.
reg [3:0] outp;	
reg [3:0] out;   
output [3:0]fout;  //4-Bit Shifted Output.
reg temp;  //A temporary 1 bit register for selecting the value which we want to fill in the (Shifted) vacancies.
//Flipping the inputs for right shifting
always @ (*)
//Flipping the inputs if we want to right shift else storing the same value in the temporary register X.
begin
if(Op[2] == 0)		//For Left Shift Op[2] will be 0.
 X = B;
else if(Op[2] == 1) //For Right Shift Op[2] will be 1.
begin
X[3] = B[0];
X[2] = B[1];
X[1] = B[2];
X[0] = B[3];
end
//Storing the value to be filled in the shifted vacancies to temp.
if(Op == 4'b0101)			//For arithmetic storing the MSB of the input B.
temp = X[0];		//Here for arithmetic we have to fill the MSB of the input B.But the inputs are flipped for arithmetic right shift and hence we have used X[0] which is the MSB of the input B.
else
temp = Cin;	//else carry will be filled in the shifted vacancies.
//Left Shift
if(Sa == 2'b00)		//Shifting the input as per Sa.
out = X;
if(Sa == 2'b01)
begin
out[0] = temp;
out[1] = X[0];
out[2] = X[1];
out[3] = X[2];
end
if(Sa == 2'b10)
begin
out[0] = temp;
out[1] = temp;
out[2] = X[0];
out[3] = X[1];
end
if(Sa == 2'b11)
begin
out[0] = temp;
out[1] = temp;
out[2] = temp;
out[3] = X[0];
end
//Here again if the Opcode is for right shift then we are flipping the left shifted output to perform the right shifting.
if(Op[2] == 1)
begin
outp[3] = out[0];
outp[2] = out[1];
outp[1] = out[2];
outp[0] = out[3];
end
else if(Op[2] == 0)	//If the Opcode is for Left shift then no flipping will take place.
begin
outp = out;
end
end
assign fout = outp;		//Assigning the outp to the final Output fout.
endmodule
