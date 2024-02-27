module wrap(
	input  wire         i_clk,
	input  wire         i_rstn,
	input  wire         i_multa_ns,
	input  wire         i_multb_ns,
	input  wire [31:0]  i_multa,
	input  wire [31:0]  i_multb,
	output wire [63:0]  o_product
);
  
  reg        multa_ns;
  reg        multb_ns;
  reg [31:0] multa;
  reg [31:0] multb;
  reg [63:0] product;

  wire [63:0] product_w;

  always @(posedge i_clk or negedge i_rstn) begin
    if(~i_rstn) begin
      multa_ns <= 1'b0;
      multb_ns <= 1'b0;
      multa    <= 32'b0;
      multb    <= 32'b0;
      product  <= 64'b0;
    end
    else begin
      multa_ns <= i_multa_ns;
      multb_ns <= i_multb_ns;
      multa    <= i_multa;
      multb    <= i_multa;
      product  <= product_w;
    end
  end

  assign o_product     = product;

  mult32x32 U_MULT_TOP(
    .i_clk      (i_clk     ),
    .i_rstn     (i_rstn    ),
    .i_multa_ns (i_multa_ns),
    .i_multb_ns (i_multb_ns),
    .i_multa    (multa     ),
    .i_multb    (multb     ),
    .o_product  (product   )
  );
endmodule

