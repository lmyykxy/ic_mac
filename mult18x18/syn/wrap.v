module wrap(input  wire         i_clk,
            input  wire         i_rstn,
	    input  wire         i_multa_ns,
	    input  wire         i_multb_ns,
	    input  wire [17:0]  i_multa,
	    input  wire [17:0]  i_multb,
	    output wire [35:0]  o_product);
  
  reg        multa_ns;
  reg        multb_ns;
  reg [17:0] multa;
  reg [17:0] multb;
  reg [35:0] product;

  wire [35:0] product_w;

  always @(posedge i_clk or negedge i_rstn) begin
    if(~i_rstn) begin
      multa_ns <= 1'b0;
      multb_ns <= 1'b0;
      multa    <= 18'b0;
      multb    <= 18'b0;
      product  <= 36'b0;
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

  mult18x18 U_MULT_TOP(
    .i_clk      (i_clk     ),
    .i_rstn     (i_rstn    ),
    .i_multa_ns (i_multa_ns),
    .i_multb_ns (i_multb_ns),
    .i_multa    (multa     ),
    .i_multb    (multb     ),
    .o_product  (product   )
  );
endmodule

