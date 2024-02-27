`timescale 1ns/1ps

module mult18x18 (
    input              i_clk     ,
	input              i_rstn    ,
	input  wire        i_multa_ns,     // 0-multa is usigned, 1-multa is signed
	input  wire        i_multb_ns,     // 0-multb is usigned, 1-multb is signed
    input  wire [35:0] i_multa   ,     // Multiplicand 
    input  wire [35:0] i_multb   ,     // Multiplier
	output wire [35:0] o_product
);

assign o_product = i_multa+i_multb;

endmodule
