`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:29:28 04/20/2015 
// Design Name: 
// Module Name:    Mux 
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
//This is the modue of MUX.
//Here we are setting our final output according the opcodes.
//The output of all the 4 blocks are set according to the Opcodes and hence we need to set the final output according to the blocks.
module Mux(outp,shifter,adder,logical,comparator,Op,Cin,Cout); 
input [3:0]shifter,adder,logical,comparator,Op; //Taking the 4-Bit Outputs from all the four blocks and also the Opcode of 4 Bits as Inputs.
input Cin;		//Taking 1 bit Carry as Input.
output reg Cout;		// 1 - bit output register of Carry.
output reg [3:0]outp;	//4 - bit otuput register of final Output.
//According to the Opcodes the Final Output and the Carry will be assigned. 
always @(*)
begin
if(Op == 4'b0000 || Op == 4'b0001 || Op == 4'b0100 || Op == 4'b0101)		//Opcodes for Shifter Block
begin
outp = shifter;
Cout = Cin;
end
else if(Op == 4'b0010 || Op == 4'b0011 || Op == 4'b0110 || Op == 4'b0111)	//Opcodes for Adder Subtractor Block
begin
outp = adder;
Cout = Cin;
end
else if(Op == 4'b1000 || Op == 4'b1010 || Op == 4'b1100 || Op == 4'b1110)  	//Opcodes for Logical Block
begin
outp = logical;
Cout = 0;
end
else if(Op == 4'b1001 || Op == 4'b1011 || Op == 4'b1101 || Op == 4'b1111) 	//Opcodes for Comparator Block
begin
outp = comparator;
Cout = Cin;
end
else				//Else the Output and the Carry will be zero.
begin		
outp = 4'b0000;
Cout = 0;
end
end
endmodule 