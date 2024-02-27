`timescale 1ns/1ps

module mult32x32 (
    input              i_clk     ,
	input              i_rstn    ,
	input  wire        i_multa_ns,     // 0-multa is usigned, 1-multa is signed
	input  wire        i_multb_ns,     // 0-multb is usigned, 1-multb is signed
    input  wire [31:0] i_multa   ,     // Multiplicand 
    input  wire [31:0] i_multb   ,     // Multiplier
	output wire [63:0] o_product
);

// internal connection
// partical product
wire [33:0] pp1, pp2, pp3, pp4, pp5, pp6, pp7, pp8, pp9, pp10;
wire [63:0] final_p;

booth_r4_32x32 U_BOOTH_R4_32X32(
  .i_multa_ns  (i_multa_ns),
  .i_multb_ns  (i_multb_ns),
  .i_multa     (i_multa   ),
  .i_multb     (i_multb   ),
  .o_pp1       (pp1       ),
  .o_pp2       (pp2       ),
  .o_pp3       (pp3       ),
  .o_pp4       (pp4       ),
  .o_pp5       (pp5       ),
  .o_pp6       (pp6       ),
  .o_pp7       (pp7       ),
  .o_pp8       (pp8       ),
  .o_pp9       (pp9       ),
  .o_pp10      (pp10      )
);

wtree_3to2_32x32 U_WALLACE_TREE(
  .clk         (i_clk      ),
  .rstn        (i_rstn     ),
  .pp1         (pp1        ),
  .pp2         (pp2        ),
  .pp3         (pp3        ),
  .pp4         (pp4        ),
  .pp5         (pp5        ),
  .pp6         (pp6        ),
  .pp7         (pp7        ),
  .pp8         (pp8        ),
  .pp9         (pp9        ),
  .pp10        (pp10       ),
  .final_p     (final_p    )
);

assign o_product = final_p[63:0];

endmodule
