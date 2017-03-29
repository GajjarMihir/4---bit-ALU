`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mihir Gajjar(1401076) and Vidit Shah(1401078).
// 
// Create Date:    22:01:16 04/17/2015 
// Design Name: 4 - Bit Adder Subtractor.
// Module Name:    Addf 
// Project Name: 4 - Bit Alu
// Target Devices: Spartan3E
// Tool versions: Xillinx 14.2
// Description: Here we are doing the addition and subtraction with only a single adder and without Duplication.
//Here Sum(Addition or Subtraction),Carry and overflow are produced as outputs.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: Here Depending upon the Opcode only the specific Calculations will be produced as output.
//
//////////////////////////////////////////////////////////////////////////////////
//Four Bit Adder Subtractor.
module Test(A,B,S,Cout,V,Op);	//Collection of Inputs and Outputs.
input [3:0]A;						//4 - Bit Input of A.
input [3:0]B;						//4 - Bit Input of B.
input [3:0]Op;						//4 - Bit Input of Opcode.
reg [3:0]X;							// A 4- Bit register to take 1's Complement of the Subtrahend(input B).
output [3:0]S;						//4-Bit Output of Addition or Subtraction depending upon the Opcode.
output Cout;						//Single Bit Output Carry.
output V;							//Single bit output of overflow.
wire [2:0]w;						//Taking 3 bit wire for passing the carry to the next stage.
always @(*)							
begin
if(Op == 4'b0110 || Op == 4'b0111 || Op == 4'b1101 || Op == 4'b1111) //These are the opcodes for subtraction,greater than and less than.
//In the Comparator Block for greater than and less than we are using the MSB but of subtraction and the overflow and hence the Opcodes for 
//greater than and less than are written.
X = (~B);  //Here it will take the 1's Complement of the input and store it in the reg X when the above Opcodes are for Subtraction or greater then or less then.
else
X = B;  //else the inputs will not be complemented.
end
onebitfulladder a0(A[0],X[0],Op[2],S[0],w[0]);	//here if the Op[2] that is for subtraction is 1 then 1 will be taken as an input carry and it will be added to the one's complements and hence 2's complement will take place.Else if Op[2] will be 0 that is for addition then neither the ones complement will take place and neither 1 will be taken as an input carry and hence no change will take Place.
onebitfulladder a1(A[1],X[1],w[0],S[1],w[1]);	//Passing the Carry via wire.
onebitfulladder a2(A[2],X[2],w[1],S[2],w[2]);
onebitfulladder a3(A[3],X[3],w[2],S[3],Cout);
assign V = (w[2] ^ Cout) & ~Op[3] & Op[1] ;  //If last both carries are different then there will be overflow , if both the carries are same then then there will be no overflow and hence we are using a xor gate.
endmodule
//One Bit Full Adder.
module onebitfulladder(a,b,cin,s,cout);
input a,b,cin;					//Taking one bit inputs.
output reg s,cout;			//Output of Sum and Carry of one bit.
always @*
begin	
{cout,s } = (a + b + cin);		//Here the sum will be assigned to the sum(s) and if there is a carry then it will be assigned to the carry(cout).
end
endmodule


//Four Bit Adder Subtracter. 
//Main Module of Adder Subtractor Block.
module Addf(A,B,Op,Carry,C,V);
input [3:0]A;			//Four Bit Inputs of A, B and Opcode.
input [3:0]B;
input [3:0]Op;
output Carry,V;			// Output of 1 bit of Carry and overflow.
output [3:0] C;			// Output of four bit of the Addition or Subtraction depending upon the Opcode.
Test fa(A,B,C,Carry,V,Op);   //Creating an instance of the Test module.
endmodule

