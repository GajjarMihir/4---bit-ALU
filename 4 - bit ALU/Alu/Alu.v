`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mihir Gajjar(1401076) and Vidit Shah(1401078) 
// 
// Create Date:    17:55:07 04/20/2015 
// Design Name:  4 - Bit ALU.
// Module Name:    Alu 
// Project Name: 4 - Bit Alu using Verilog
// Target Devices: Nexys 2.
// Tool versions: Xillinx 14.2
// Description: This is a Verilog Code for 4 - Bit ALU.
//
// Dependencies: This Bit file is generated using Xillinx 14.2 verion in windows 8.If there is any conflict please tell us.
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: Here the outputs of all the five modules are set according the Opcodes and hence Precise Operations
// 							will take place.Here the inputs of the modules will increase(because of the Opcode) but the inputs
//							   of the Mux will decrease.Also the output of the other four modules other then the Mux module will decrease.
//				
//////////////////////////////////////////////////////////////////////////////////
//Here we are combining all the Modules and using the wire we are giving the output of one module as an input to the other module.
module Alu(A,B,Op,C,V,Carry);	
input [3:0]A;				//4 - Bit Inputs of A,B and Op.
input [3:0]B;
input [3:0]Op;
output [3:0]C;				//4-Bit Output from the Mux.
wire of;		//wire to connect the of(overflow) from adder subtractor block to the comparator block.
wire [3:0]Sum,out,Outp,ooutp;	//wire to connect the appropriate modules.
wire Car;		//wire to connect the carry from adder subtractor block to the Shifter Block and Mux.
output V,Carry;  //1-Bit Output of Overflow and Carry.
//Here we are creating instances of all the 5 modules.
Addf Add(A,B,Op,Car,Sum,of);  
Comparatorf Comparator(Sum,of,Outp,ooutp,Op);  
Logicalf Logical(A,B,Op,Outp);
Shifterf Shift(A[1:0],B,Car,Op,out);
Mux muxf(C,out,Sum,Outp,ooutp,Op,Car,Carry);
assign V = ((of)&(Op[1])&(~Op[3]));		//Here we need overflow only for adder subtractor block and for all other blocks it will be set to zero.
endmodule
