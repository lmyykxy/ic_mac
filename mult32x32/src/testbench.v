`timescale 1ns/1ps

module testbench;
  parameter OPWIDTH = 32;
  reg rstn;
  reg clk;

  initial begin
    rstn = 1'b0;
    clk  = 1'b0;
    #100;
    rstn = 1'b1;
  end 

  always #1 clk = ~clk;

  bit[OPWIDTH-1:0]     oper_a;
  bit[OPWIDTH-1:0]     oper_b;
  bit                  tc;
  wire [2*OPWIDTH-1:0] product;
  wire [2*OPWIDTH-1:0] product_ref;
  reg [2*OPWIDTH-1:0] product_ref_d1,product_ref_d2,product_ref_d3;

  always @(posedge clk or rstn) begin
    if(~rstn) begin
      oper_a <= {OPWIDTH{1'b0}};
      oper_b <= {OPWIDTH{1'b0}};
      tc     <= 1'b0;
    end
    else begin
      oper_a <= $random();
      oper_b <= $random();
    //   tc     <= $random();
    //   oper_a <= 'h8484_d609;
    //   oper_b <= 'hb1f0_5663;
      tc     <= 0;
    end
  end


  mult32x32 U_DUV(
    .o_product (product),
    .i_multa_ns(tc     ),
    .i_multb_ns(tc     ),
    .i_multa   (oper_a ),
    .i_multb   (oper_b ),
    .i_rstn    (rstn   ),
    .i_clk     (clk    )
  );

  DW02_mult_6_stage #(.A_width(OPWIDTH),
                      .B_width(OPWIDTH)) U_DW_MODEL (
                      .A       (oper_a),
		      .B       (oper_b),
		      .TC      (tc    ),
		      .CLK     (clk   ),
		      .PRODUCT (product_ref)
		      );

always @(posedge clk or rstn) begin
    if(~rstn) begin
		product_ref_d1 <= 'd0;
		product_ref_d2 <= 'd0;
		product_ref_d3 <= 'd0;
    end
    else begin
		product_ref_d1 <= product_ref;
		product_ref_d2 <= product_ref_d1;
		product_ref_d3 <= product_ref_d2;
    end
  end

  initial begin
    $fsdbDumpfile("../wave/wave.fsdb");
    $fsdbDumpvars(0, testbench);
  end
endmodule

