`timescale 1ns/1ps

`include "mult32_def.v"
module wtree_3to2_32x32(
	input    wire        clk    ,
	input    wire        rstn   ,
	input    wire [33:0] pp1    , 
	input    wire [33:0] pp2    , 
	input    wire [33:0] pp3    , 
	input    wire [33:0] pp4    , 
	input    wire [33:0] pp5    , 
	input    wire [33:0] pp6    , 
	input    wire [33:0] pp7    , 
	input    wire [33:0] pp8    , 
	input    wire [33:0] pp9    , 
	input    wire [33:0] pp10   , 
	input    wire [33:0] pp11   , 
	input    wire [33:0] pp12   , 
	input    wire [33:0] pp13   , 
	input    wire [33:0] pp14   , 
	input    wire [33:0] pp15   , 
	input    wire [33:0] pp16   , 
	input    wire [33:0] pp17   , 
	output   wire [63:0] final_p
);

wire [33:0] pp1_w;
wire [33:0] pp2_w;
wire [33:0] pp3_w;
wire [33:0] pp4_w;
wire [33:0] pp5_w;
wire [33:0] pp6_w;
wire [33:0] pp7_w;
wire [33:0] pp8_w;
wire [33:0] pp9_w; 
wire [33:0] pp10_w;
wire [33:0] pp11_w;
wire [33:0] pp12_w;
wire [33:0] pp13_w;
wire [33:0] pp14_w;
wire [33:0] pp15_w;
wire [33:0] pp16_w; 
wire [31:0] pp17_w;
// ================ if necessary, pipeline pp1~pp17 here for timing ===============
`ifdef MULT32_PIPE_PPN
reg  [33:0] pp1_ff;
reg  [33:0] pp2_ff;
reg  [33:0] pp3_ff;
reg  [33:0] pp4_ff;
reg  [33:0] pp5_ff;
reg  [33:0] pp6_ff;
reg  [33:0] pp7_ff;
reg  [33:0] pp8_ff;
reg  [33:0] pp9_ff; 
reg  [33:0] pp10_ff; 
reg  [33:0] pp11_ff;
reg  [33:0] pp12_ff;
reg  [33:0] pp13_ff;
reg  [33:0] pp14_ff;
reg  [33:0] pp15_ff;
reg  [33:0] pp16_ff; 
reg  [31:0] pp17_ff;
always @(posedge clk or negedge rstn) begin
  if(~rstn) begin
    pp1_ff  <= 34'b0;
    pp2_ff  <= 34'b0;
    pp3_ff  <= 34'b0;
    pp4_ff  <= 34'b0;
    pp5_ff  <= 34'b0;
    pp6_ff  <= 34'b0;
    pp7_ff  <= 34'b0;
    pp8_ff  <= 34'b0;
    pp9_ff  <= 34'b0;
    pp10_ff <= 34'b0;
    pp11_ff <= 34'b0;
    pp12_ff <= 34'b0;
    pp13_ff <= 34'b0;
    pp14_ff <= 34'b0;
    pp15_ff <= 34'b0;
    pp16_ff <= 34'b0;
    pp17_ff <= 32'b0;

  end
  else begin
    pp1_ff  <= pp1       ;
    pp2_ff  <= pp2       ;
    pp3_ff  <= pp3       ;
    pp4_ff  <= pp4       ;
    pp5_ff  <= pp5       ;
    pp6_ff  <= pp6       ;
    pp7_ff  <= pp7       ;
    pp8_ff  <= pp8       ;
    pp9_ff  <= pp9       ;
    pp10_ff <= pp10      ;
    pp11_ff <= pp11      ;
    pp12_ff <= pp12      ;
    pp13_ff <= pp13      ;
    pp14_ff <= pp14      ;
    pp15_ff <= pp15      ;
    pp16_ff <= pp16[33:0];
    pp17_ff <= pp17[31:0];
  end
end

assign pp1_w  = pp1_ff ;
assign pp2_w  = pp2_ff ;
assign pp3_w  = pp3_ff ;
assign pp4_w  = pp4_ff ;
assign pp5_w  = pp5_ff ;
assign pp6_w  = pp6_ff ;
assign pp7_w  = pp7_ff ;
assign pp8_w  = pp8_ff ;
assign pp9_w  = pp9_ff ;
assign pp10_w = pp10_ff;
assign pp11_w = pp11_ff;
assign pp12_w = pp12_ff;
assign pp13_w = pp13_ff;
assign pp14_w = pp14_ff;
assign pp15_w = pp15_ff;
assign pp16_w = pp16_ff;
assign pp17_w = pp17_ff;

`else
assign pp1_w  = pp1       ;
assign pp2_w  = pp2       ;
assign pp3_w  = pp3       ;
assign pp4_w  = pp4       ;
assign pp5_w  = pp5       ;
assign pp6_w  = pp6       ;
assign pp7_w  = pp7       ;
assign pp8_w  = pp8       ;
assign pp9_w  = pp9       ;
assign pp10_w = pp10      ;
assign pp11_w = pp11      ;
assign pp12_w = pp12      ;
assign pp13_w = pp13      ;
assign pp14_w = pp14      ;
assign pp15_w = pp15      ;
assign pp16_w = pp16[33:0];
assign pp17_w = pp17[31:0];
`endif

// ================ first stage ================
wire [37:0] stg1_s1, stg1_c1;
wire [37:0] stg1_s2, stg1_c2;
wire [37:0] stg1_s3, stg1_c3;
wire [37:0] stg1_s4, stg1_c4;
wire [37:0] stg1_s5, stg1_c5;

assign stg1_s1[1:0]   = pp1_w[1:0];
assign stg1_c1[1:0]   = 2'b0;
half_adder u_a11_2 (.a(pp1_w[ 2]), .b(pp2_w[ 0]),                 .s(stg1_s1[ 2]), .co(stg1_c1[ 2]));
half_adder u_a11_3 (.a(pp1_w[ 3]), .b(pp2_w[ 1]),                 .s(stg1_s1[ 3]), .co(stg1_c1[ 3]));
full_adder u_a11_4 (.a(pp1_w[ 4]), .b(pp2_w[ 2]), .ci(pp3_w[ 0]), .s(stg1_s1[ 4]), .co(stg1_c1[ 4]));
full_adder u_a11_5 (.a(pp1_w[ 5]), .b(pp2_w[ 3]), .ci(pp3_w[ 1]), .s(stg1_s1[ 5]), .co(stg1_c1[ 5]));
full_adder u_a11_6 (.a(pp1_w[ 6]), .b(pp2_w[ 4]), .ci(pp3_w[ 2]), .s(stg1_s1[ 6]), .co(stg1_c1[ 6]));
full_adder u_a11_7 (.a(pp1_w[ 7]), .b(pp2_w[ 5]), .ci(pp3_w[ 3]), .s(stg1_s1[ 7]), .co(stg1_c1[ 7]));
full_adder u_a11_8 (.a(pp1_w[ 8]), .b(pp2_w[ 6]), .ci(pp3_w[ 4]), .s(stg1_s1[ 8]), .co(stg1_c1[ 8]));
full_adder u_a11_9 (.a(pp1_w[ 9]), .b(pp2_w[ 7]), .ci(pp3_w[ 5]), .s(stg1_s1[ 9]), .co(stg1_c1[ 9]));
full_adder u_a11_10(.a(pp1_w[10]), .b(pp2_w[ 8]), .ci(pp3_w[ 6]), .s(stg1_s1[10]), .co(stg1_c1[10]));
full_adder u_a11_11(.a(pp1_w[11]), .b(pp2_w[ 9]), .ci(pp3_w[ 7]), .s(stg1_s1[11]), .co(stg1_c1[11]));
full_adder u_a11_12(.a(pp1_w[12]), .b(pp2_w[10]), .ci(pp3_w[ 8]), .s(stg1_s1[12]), .co(stg1_c1[12]));
full_adder u_a11_13(.a(pp1_w[13]), .b(pp2_w[11]), .ci(pp3_w[ 9]), .s(stg1_s1[13]), .co(stg1_c1[13]));
full_adder u_a11_14(.a(pp1_w[14]), .b(pp2_w[12]), .ci(pp3_w[10]), .s(stg1_s1[14]), .co(stg1_c1[14]));
full_adder u_a11_15(.a(pp1_w[15]), .b(pp2_w[13]), .ci(pp3_w[11]), .s(stg1_s1[15]), .co(stg1_c1[15]));
full_adder u_a11_16(.a(pp1_w[16]), .b(pp2_w[14]), .ci(pp3_w[12]), .s(stg1_s1[16]), .co(stg1_c1[16]));
full_adder u_a11_17(.a(pp1_w[17]), .b(pp2_w[15]), .ci(pp3_w[13]), .s(stg1_s1[17]), .co(stg1_c1[17]));
full_adder u_a11_18(.a(pp1_w[18]), .b(pp2_w[16]), .ci(pp3_w[14]), .s(stg1_s1[18]), .co(stg1_c1[18]));
full_adder u_a11_19(.a(pp1_w[19]), .b(pp2_w[17]), .ci(pp3_w[15]), .s(stg1_s1[19]), .co(stg1_c1[19]));
full_adder u_a11_20(.a(pp1_w[20]), .b(pp2_w[18]), .ci(pp3_w[16]), .s(stg1_s1[20]), .co(stg1_c1[20]));
full_adder u_a11_21(.a(pp1_w[21]), .b(pp2_w[19]), .ci(pp3_w[17]), .s(stg1_s1[21]), .co(stg1_c1[21]));
full_adder u_a11_22(.a(pp1_w[22]), .b(pp2_w[20]), .ci(pp3_w[18]), .s(stg1_s1[22]), .co(stg1_c1[22]));
full_adder u_a11_23(.a(pp1_w[23]), .b(pp2_w[21]), .ci(pp3_w[19]), .s(stg1_s1[23]), .co(stg1_c1[23]));
full_adder u_a11_24(.a(pp1_w[24]), .b(pp2_w[22]), .ci(pp3_w[20]), .s(stg1_s1[24]), .co(stg1_c1[24]));
full_adder u_a11_25(.a(pp1_w[25]), .b(pp2_w[23]), .ci(pp3_w[21]), .s(stg1_s1[25]), .co(stg1_c1[25]));
full_adder u_a11_26(.a(pp1_w[26]), .b(pp2_w[24]), .ci(pp3_w[22]), .s(stg1_s1[26]), .co(stg1_c1[26]));
full_adder u_a11_27(.a(pp1_w[27]), .b(pp2_w[25]), .ci(pp3_w[23]), .s(stg1_s1[27]), .co(stg1_c1[27]));
full_adder u_a11_28(.a(pp1_w[28]), .b(pp2_w[26]), .ci(pp3_w[24]), .s(stg1_s1[28]), .co(stg1_c1[28]));
full_adder u_a11_29(.a(pp1_w[29]), .b(pp2_w[27]), .ci(pp3_w[25]), .s(stg1_s1[29]), .co(stg1_c1[29]));
full_adder u_a11_30(.a(pp1_w[30]), .b(pp2_w[28]), .ci(pp3_w[26]), .s(stg1_s1[30]), .co(stg1_c1[30]));
full_adder u_a11_31(.a(pp1_w[31]), .b(pp2_w[29]), .ci(pp3_w[27]), .s(stg1_s1[31]), .co(stg1_c1[31]));
full_adder u_a11_32(.a(pp1_w[32]), .b(pp2_w[30]), .ci(pp3_w[28]), .s(stg1_s1[32]), .co(stg1_c1[32]));
full_adder u_a11_33(.a(pp1_w[33]), .b(pp2_w[31]), .ci(pp3_w[29]), .s(stg1_s1[33]), .co(stg1_c1[33]));
full_adder u_a11_34(.a(pp1_w[33]), .b(pp2_w[32]), .ci(pp3_w[30]), .s(stg1_s1[34]), .co(stg1_c1[34]));
full_adder u_a11_35(.a(pp1_w[33]), .b(pp2_w[33]), .ci(pp3_w[31]), .s(stg1_s1[35]), .co(stg1_c1[35]));
full_adder u_a11_36(.a(pp1_w[33]), .b(pp2_w[33]), .ci(pp3_w[32]), .s(stg1_s1[36]), .co(stg1_c1[36]));
full_adder u_a11_37(.a(pp1_w[33]), .b(pp2_w[33]), .ci(pp3_w[33]), .s(stg1_s1[37]), .co(stg1_c1[37]));

//green
assign stg1_s2[1:0]   = pp4_w[1:0];
assign stg1_c2[1:0]   = 2'b0;
half_adder u_a12_2 (.a(pp4_w[ 2]), .b(pp5_w[ 0]),                 .s(stg1_s2[ 2]), .co(stg1_c2[ 2]));
half_adder u_a12_3 (.a(pp4_w[ 3]), .b(pp5_w[ 1]),                 .s(stg1_s2[ 3]), .co(stg1_c2[ 3]));
full_adder u_a12_4 (.a(pp4_w[ 4]), .b(pp5_w[ 2]), .ci(pp6_w[ 0]), .s(stg1_s2[ 4]), .co(stg1_c2[ 4]));
full_adder u_a12_5 (.a(pp4_w[ 5]), .b(pp5_w[ 3]), .ci(pp6_w[ 1]), .s(stg1_s2[ 5]), .co(stg1_c2[ 5]));
full_adder u_a12_6 (.a(pp4_w[ 6]), .b(pp5_w[ 4]), .ci(pp6_w[ 2]), .s(stg1_s2[ 6]), .co(stg1_c2[ 6]));
full_adder u_a12_7 (.a(pp4_w[ 7]), .b(pp5_w[ 5]), .ci(pp6_w[ 3]), .s(stg1_s2[ 7]), .co(stg1_c2[ 7]));
full_adder u_a12_8 (.a(pp4_w[ 8]), .b(pp5_w[ 6]), .ci(pp6_w[ 4]), .s(stg1_s2[ 8]), .co(stg1_c2[ 8]));
full_adder u_a12_9 (.a(pp4_w[ 9]), .b(pp5_w[ 7]), .ci(pp6_w[ 5]), .s(stg1_s2[ 9]), .co(stg1_c2[ 9]));
full_adder u_a12_10(.a(pp4_w[10]), .b(pp5_w[ 8]), .ci(pp6_w[ 6]), .s(stg1_s2[10]), .co(stg1_c2[10]));
full_adder u_a12_11(.a(pp4_w[11]), .b(pp5_w[ 9]), .ci(pp6_w[ 7]), .s(stg1_s2[11]), .co(stg1_c2[11]));
full_adder u_a12_12(.a(pp4_w[12]), .b(pp5_w[10]), .ci(pp6_w[ 8]), .s(stg1_s2[12]), .co(stg1_c2[12]));
full_adder u_a12_13(.a(pp4_w[13]), .b(pp5_w[11]), .ci(pp6_w[ 9]), .s(stg1_s2[13]), .co(stg1_c2[13]));
full_adder u_a12_14(.a(pp4_w[14]), .b(pp5_w[12]), .ci(pp6_w[10]), .s(stg1_s2[14]), .co(stg1_c2[14]));
full_adder u_a12_15(.a(pp4_w[15]), .b(pp5_w[13]), .ci(pp6_w[11]), .s(stg1_s2[15]), .co(stg1_c2[15]));
full_adder u_a12_16(.a(pp4_w[16]), .b(pp5_w[14]), .ci(pp6_w[12]), .s(stg1_s2[16]), .co(stg1_c2[16]));
full_adder u_a12_17(.a(pp4_w[17]), .b(pp5_w[15]), .ci(pp6_w[13]), .s(stg1_s2[17]), .co(stg1_c2[17]));
full_adder u_a12_18(.a(pp4_w[18]), .b(pp5_w[16]), .ci(pp6_w[14]), .s(stg1_s2[18]), .co(stg1_c2[18]));
full_adder u_a12_19(.a(pp4_w[19]), .b(pp5_w[17]), .ci(pp6_w[15]), .s(stg1_s2[19]), .co(stg1_c2[19]));
full_adder u_a12_20(.a(pp4_w[20]), .b(pp5_w[18]), .ci(pp6_w[16]), .s(stg1_s2[20]), .co(stg1_c2[20]));
full_adder u_a12_21(.a(pp4_w[21]), .b(pp5_w[19]), .ci(pp6_w[17]), .s(stg1_s2[21]), .co(stg1_c2[21]));
full_adder u_a12_22(.a(pp4_w[22]), .b(pp5_w[20]), .ci(pp6_w[18]), .s(stg1_s2[22]), .co(stg1_c2[22]));
full_adder u_a12_23(.a(pp4_w[23]), .b(pp5_w[21]), .ci(pp6_w[19]), .s(stg1_s2[23]), .co(stg1_c2[23]));
full_adder u_a12_24(.a(pp4_w[24]), .b(pp5_w[22]), .ci(pp6_w[20]), .s(stg1_s2[24]), .co(stg1_c2[24]));
full_adder u_a12_25(.a(pp4_w[25]), .b(pp5_w[23]), .ci(pp6_w[21]), .s(stg1_s2[25]), .co(stg1_c2[25]));
full_adder u_a12_26(.a(pp4_w[26]), .b(pp5_w[24]), .ci(pp6_w[22]), .s(stg1_s2[26]), .co(stg1_c2[26]));
full_adder u_a12_27(.a(pp4_w[27]), .b(pp5_w[25]), .ci(pp6_w[23]), .s(stg1_s2[27]), .co(stg1_c2[27]));
full_adder u_a12_28(.a(pp4_w[28]), .b(pp5_w[26]), .ci(pp6_w[24]), .s(stg1_s2[28]), .co(stg1_c2[28]));
full_adder u_a12_29(.a(pp4_w[29]), .b(pp5_w[27]), .ci(pp6_w[25]), .s(stg1_s2[29]), .co(stg1_c2[29]));
full_adder u_a12_30(.a(pp4_w[30]), .b(pp5_w[28]), .ci(pp6_w[26]), .s(stg1_s2[30]), .co(stg1_c2[30]));
full_adder u_a12_31(.a(pp4_w[31]), .b(pp5_w[29]), .ci(pp6_w[27]), .s(stg1_s2[31]), .co(stg1_c2[31]));
full_adder u_a12_32(.a(pp4_w[32]), .b(pp5_w[30]), .ci(pp6_w[28]), .s(stg1_s2[32]), .co(stg1_c2[32]));
full_adder u_a12_33(.a(pp4_w[33]), .b(pp5_w[31]), .ci(pp6_w[29]), .s(stg1_s2[33]), .co(stg1_c2[33]));
full_adder u_a12_34(.a(pp4_w[33]), .b(pp5_w[32]), .ci(pp6_w[30]), .s(stg1_s2[34]), .co(stg1_c2[34]));
full_adder u_a12_35(.a(pp4_w[33]), .b(pp5_w[33]), .ci(pp6_w[31]), .s(stg1_s2[35]), .co(stg1_c2[35]));
full_adder u_a12_36(.a(pp4_w[33]), .b(pp5_w[33]), .ci(pp6_w[32]), .s(stg1_s2[36]), .co(stg1_c2[36]));
full_adder u_a12_37(.a(pp4_w[33]), .b(pp5_w[33]), .ci(pp6_w[33]), .s(stg1_s2[37]), .co(stg1_c2[37]));

//blue
assign stg1_s3[1:0]   = pp7_w[1:0];
assign stg1_c3[1:0]   = 2'b0;
half_adder u_a13_2 (.a(pp7_w[ 2]), .b(pp8_w[ 0]),                 .s(stg1_s3[ 2]), .co(stg1_c3[ 2]));
half_adder u_a13_3 (.a(pp7_w[ 3]), .b(pp8_w[ 1]),                 .s(stg1_s3[ 3]), .co(stg1_c3[ 3]));
full_adder u_a13_4 (.a(pp7_w[ 4]), .b(pp8_w[ 2]), .ci(pp9_w[ 0]), .s(stg1_s3[ 4]), .co(stg1_c3[ 4]));
full_adder u_a13_5 (.a(pp7_w[ 5]), .b(pp8_w[ 3]), .ci(pp9_w[ 1]), .s(stg1_s3[ 5]), .co(stg1_c3[ 5]));
full_adder u_a13_6 (.a(pp7_w[ 6]), .b(pp8_w[ 4]), .ci(pp9_w[ 2]), .s(stg1_s3[ 6]), .co(stg1_c3[ 6]));
full_adder u_a13_7 (.a(pp7_w[ 7]), .b(pp8_w[ 5]), .ci(pp9_w[ 3]), .s(stg1_s3[ 7]), .co(stg1_c3[ 7]));
full_adder u_a13_8 (.a(pp7_w[ 8]), .b(pp8_w[ 6]), .ci(pp9_w[ 4]), .s(stg1_s3[ 8]), .co(stg1_c3[ 8]));
full_adder u_a13_9 (.a(pp7_w[ 9]), .b(pp8_w[ 7]), .ci(pp9_w[ 5]), .s(stg1_s3[ 9]), .co(stg1_c3[ 9]));
full_adder u_a13_10(.a(pp7_w[10]), .b(pp8_w[ 8]), .ci(pp9_w[ 6]), .s(stg1_s3[10]), .co(stg1_c3[10]));
full_adder u_a13_11(.a(pp7_w[11]), .b(pp8_w[ 9]), .ci(pp9_w[ 7]), .s(stg1_s3[11]), .co(stg1_c3[11]));
full_adder u_a13_12(.a(pp7_w[12]), .b(pp8_w[10]), .ci(pp9_w[ 8]), .s(stg1_s3[12]), .co(stg1_c3[12]));
full_adder u_a13_13(.a(pp7_w[13]), .b(pp8_w[11]), .ci(pp9_w[ 9]), .s(stg1_s3[13]), .co(stg1_c3[13]));
full_adder u_a13_14(.a(pp7_w[14]), .b(pp8_w[12]), .ci(pp9_w[10]), .s(stg1_s3[14]), .co(stg1_c3[14]));
full_adder u_a13_15(.a(pp7_w[15]), .b(pp8_w[13]), .ci(pp9_w[11]), .s(stg1_s3[15]), .co(stg1_c3[15]));
full_adder u_a13_16(.a(pp7_w[16]), .b(pp8_w[14]), .ci(pp9_w[12]), .s(stg1_s3[16]), .co(stg1_c3[16]));
full_adder u_a13_17(.a(pp7_w[17]), .b(pp8_w[15]), .ci(pp9_w[13]), .s(stg1_s3[17]), .co(stg1_c3[17]));
full_adder u_a13_18(.a(pp7_w[18]), .b(pp8_w[16]), .ci(pp9_w[14]), .s(stg1_s3[18]), .co(stg1_c3[18]));
full_adder u_a13_19(.a(pp7_w[19]), .b(pp8_w[17]), .ci(pp9_w[15]), .s(stg1_s3[19]), .co(stg1_c3[19]));
full_adder u_a13_20(.a(pp7_w[20]), .b(pp8_w[18]), .ci(pp9_w[16]), .s(stg1_s3[20]), .co(stg1_c3[20]));
full_adder u_a13_21(.a(pp7_w[21]), .b(pp8_w[19]), .ci(pp9_w[17]), .s(stg1_s3[21]), .co(stg1_c3[21]));
full_adder u_a13_22(.a(pp7_w[22]), .b(pp8_w[20]), .ci(pp9_w[18]), .s(stg1_s3[22]), .co(stg1_c3[22]));
full_adder u_a13_23(.a(pp7_w[23]), .b(pp8_w[21]), .ci(pp9_w[19]), .s(stg1_s3[23]), .co(stg1_c3[23]));
full_adder u_a13_24(.a(pp7_w[24]), .b(pp8_w[22]), .ci(pp9_w[20]), .s(stg1_s3[24]), .co(stg1_c3[24]));
full_adder u_a13_25(.a(pp7_w[25]), .b(pp8_w[23]), .ci(pp9_w[21]), .s(stg1_s3[25]), .co(stg1_c3[25]));
full_adder u_a13_26(.a(pp7_w[26]), .b(pp8_w[24]), .ci(pp9_w[22]), .s(stg1_s3[26]), .co(stg1_c3[26]));
full_adder u_a13_27(.a(pp7_w[27]), .b(pp8_w[25]), .ci(pp9_w[23]), .s(stg1_s3[27]), .co(stg1_c3[27]));
full_adder u_a13_28(.a(pp7_w[28]), .b(pp8_w[26]), .ci(pp9_w[24]), .s(stg1_s3[28]), .co(stg1_c3[28]));
full_adder u_a13_29(.a(pp7_w[29]), .b(pp8_w[27]), .ci(pp9_w[25]), .s(stg1_s3[29]), .co(stg1_c3[29]));
full_adder u_a13_30(.a(pp7_w[30]), .b(pp8_w[28]), .ci(pp9_w[26]), .s(stg1_s3[30]), .co(stg1_c3[30]));
full_adder u_a13_31(.a(pp7_w[31]), .b(pp8_w[29]), .ci(pp9_w[27]), .s(stg1_s3[31]), .co(stg1_c3[31]));
full_adder u_a13_32(.a(pp7_w[32]), .b(pp8_w[30]), .ci(pp9_w[28]), .s(stg1_s3[32]), .co(stg1_c3[32]));
full_adder u_a13_33(.a(pp7_w[33]), .b(pp8_w[31]), .ci(pp9_w[29]), .s(stg1_s3[33]), .co(stg1_c3[33]));
full_adder u_a13_34(.a(pp7_w[33]), .b(pp8_w[32]), .ci(pp9_w[30]), .s(stg1_s3[34]), .co(stg1_c3[34]));
full_adder u_a13_35(.a(pp7_w[33]), .b(pp8_w[33]), .ci(pp9_w[31]), .s(stg1_s3[35]), .co(stg1_c3[35]));
full_adder u_a13_36(.a(pp7_w[33]), .b(pp8_w[33]), .ci(pp9_w[32]), .s(stg1_s3[36]), .co(stg1_c3[36]));
full_adder u_a13_37(.a(pp7_w[33]), .b(pp8_w[33]), .ci(pp9_w[33]), .s(stg1_s3[37]), .co(stg1_c3[37]));

//orange
assign stg1_s4[1:0]   = pp10_w[1:0];
assign stg1_c4[1:0]   = 2'b0;
half_adder u_a14_2  (.a(pp10_w[ 2]), .b(pp11_w[ 0]),                  .s(stg1_s4[ 2]), .co(stg1_c4[ 2]));
half_adder u_a14_3  (.a(pp10_w[ 3]), .b(pp11_w[ 1]),                  .s(stg1_s4[ 3]), .co(stg1_c4[ 3]));
full_adder u_a14_4  (.a(pp10_w[ 4]), .b(pp11_w[ 2]), .ci(pp12_w[ 0]), .s(stg1_s4[ 4]), .co(stg1_c4[ 4]));
full_adder u_a14_5  (.a(pp10_w[ 5]), .b(pp11_w[ 3]), .ci(pp12_w[ 1]), .s(stg1_s4[ 5]), .co(stg1_c4[ 5]));
full_adder u_a14_6  (.a(pp10_w[ 6]), .b(pp11_w[ 4]), .ci(pp12_w[ 2]), .s(stg1_s4[ 6]), .co(stg1_c4[ 6]));
full_adder u_a14_7  (.a(pp10_w[ 7]), .b(pp11_w[ 5]), .ci(pp12_w[ 3]), .s(stg1_s4[ 7]), .co(stg1_c4[ 7]));
full_adder u_a14_8  (.a(pp10_w[ 8]), .b(pp11_w[ 6]), .ci(pp12_w[ 4]), .s(stg1_s4[ 8]), .co(stg1_c4[ 8]));
full_adder u_a14_9  (.a(pp10_w[ 9]), .b(pp11_w[ 7]), .ci(pp12_w[ 5]), .s(stg1_s4[ 9]), .co(stg1_c4[ 9]));
full_adder u_a14_10 (.a(pp10_w[10]), .b(pp11_w[ 8]), .ci(pp12_w[ 6]), .s(stg1_s4[10]), .co(stg1_c4[10]));
full_adder u_a14_11 (.a(pp10_w[11]), .b(pp11_w[ 9]), .ci(pp12_w[ 7]), .s(stg1_s4[11]), .co(stg1_c4[11]));
full_adder u_a14_12 (.a(pp10_w[12]), .b(pp11_w[10]), .ci(pp12_w[ 8]), .s(stg1_s4[12]), .co(stg1_c4[12]));
full_adder u_a14_13 (.a(pp10_w[13]), .b(pp11_w[11]), .ci(pp12_w[ 9]), .s(stg1_s4[13]), .co(stg1_c4[13]));
full_adder u_a14_14 (.a(pp10_w[14]), .b(pp11_w[12]), .ci(pp12_w[10]), .s(stg1_s4[14]), .co(stg1_c4[14]));
full_adder u_a14_15 (.a(pp10_w[15]), .b(pp11_w[13]), .ci(pp12_w[11]), .s(stg1_s4[15]), .co(stg1_c4[15]));
full_adder u_a14_16 (.a(pp10_w[16]), .b(pp11_w[14]), .ci(pp12_w[12]), .s(stg1_s4[16]), .co(stg1_c4[16]));
full_adder u_a14_17 (.a(pp10_w[17]), .b(pp11_w[15]), .ci(pp12_w[13]), .s(stg1_s4[17]), .co(stg1_c4[17]));
full_adder u_a14_18 (.a(pp10_w[18]), .b(pp11_w[16]), .ci(pp12_w[14]), .s(stg1_s4[18]), .co(stg1_c4[18]));
full_adder u_a14_19 (.a(pp10_w[19]), .b(pp11_w[17]), .ci(pp12_w[15]), .s(stg1_s4[19]), .co(stg1_c4[19]));
full_adder u_a14_20 (.a(pp10_w[20]), .b(pp11_w[18]), .ci(pp12_w[16]), .s(stg1_s4[20]), .co(stg1_c4[20]));
full_adder u_a14_21 (.a(pp10_w[21]), .b(pp11_w[19]), .ci(pp12_w[17]), .s(stg1_s4[21]), .co(stg1_c4[21]));
full_adder u_a14_22 (.a(pp10_w[22]), .b(pp11_w[20]), .ci(pp12_w[18]), .s(stg1_s4[22]), .co(stg1_c4[22]));
full_adder u_a14_23 (.a(pp10_w[23]), .b(pp11_w[21]), .ci(pp12_w[19]), .s(stg1_s4[23]), .co(stg1_c4[23]));
full_adder u_a14_24 (.a(pp10_w[24]), .b(pp11_w[22]), .ci(pp12_w[20]), .s(stg1_s4[24]), .co(stg1_c4[24]));
full_adder u_a14_25 (.a(pp10_w[25]), .b(pp11_w[23]), .ci(pp12_w[21]), .s(stg1_s4[25]), .co(stg1_c4[25]));
full_adder u_a14_26 (.a(pp10_w[26]), .b(pp11_w[24]), .ci(pp12_w[22]), .s(stg1_s4[26]), .co(stg1_c4[26]));
full_adder u_a14_27 (.a(pp10_w[27]), .b(pp11_w[25]), .ci(pp12_w[23]), .s(stg1_s4[27]), .co(stg1_c4[27]));
full_adder u_a14_28 (.a(pp10_w[28]), .b(pp11_w[26]), .ci(pp12_w[24]), .s(stg1_s4[28]), .co(stg1_c4[28]));
full_adder u_a14_29 (.a(pp10_w[29]), .b(pp11_w[27]), .ci(pp12_w[25]), .s(stg1_s4[29]), .co(stg1_c4[29]));
full_adder u_a14_30 (.a(pp10_w[30]), .b(pp11_w[28]), .ci(pp12_w[26]), .s(stg1_s4[30]), .co(stg1_c4[30]));
full_adder u_a14_31 (.a(pp10_w[31]), .b(pp11_w[29]), .ci(pp12_w[27]), .s(stg1_s4[31]), .co(stg1_c4[31]));
full_adder u_a14_32 (.a(pp10_w[32]), .b(pp11_w[30]), .ci(pp12_w[28]), .s(stg1_s4[32]), .co(stg1_c4[32]));
full_adder u_a14_33 (.a(pp10_w[33]), .b(pp11_w[31]), .ci(pp12_w[29]), .s(stg1_s4[33]), .co(stg1_c4[33]));
full_adder u_a14_34 (.a(pp10_w[33]), .b(pp11_w[32]), .ci(pp12_w[30]), .s(stg1_s4[34]), .co(stg1_c4[34]));
full_adder u_a14_35 (.a(pp10_w[33]), .b(pp11_w[33]), .ci(pp12_w[31]), .s(stg1_s4[35]), .co(stg1_c4[35]));
full_adder u_a14_36 (.a(pp10_w[33]), .b(pp11_w[33]), .ci(pp12_w[32]), .s(stg1_s4[36]), .co(stg1_c4[36]));
full_adder u_a14_37 (.a(pp10_w[33]), .b(pp11_w[33]), .ci(pp12_w[33]), .s(stg1_s4[37]), .co(stg1_c4[37]));

//little yellow
assign stg1_s5[1:0]   = pp13_w[1:0];
assign stg1_c5[1:0]   = 2'b0;
half_adder u_a15_2  (.a(pp13_w[  2]), .b(pp14_w[  0]),                   .s(stg1_s5[  2]), .co(stg1_c5[  2]));
half_adder u_a15_3  (.a(pp13_w[  3]), .b(pp14_w[  1]),                   .s(stg1_s5[  3]), .co(stg1_c5[  3]));
full_adder u_a15_4  (.a(pp13_w[  4]), .b(pp14_w[  2]), .ci(pp15_w[  0]), .s(stg1_s5[  4]), .co(stg1_c5[  4]));
full_adder u_a15_5  (.a(pp13_w[  5]), .b(pp14_w[  3]), .ci(pp15_w[  1]), .s(stg1_s5[  5]), .co(stg1_c5[  5]));
full_adder u_a15_6  (.a(pp13_w[  6]), .b(pp14_w[  4]), .ci(pp15_w[  2]), .s(stg1_s5[  6]), .co(stg1_c5[  6]));
full_adder u_a15_7  (.a(pp13_w[  7]), .b(pp14_w[  5]), .ci(pp15_w[  3]), .s(stg1_s5[  7]), .co(stg1_c5[  7]));
full_adder u_a15_8  (.a(pp13_w[  8]), .b(pp14_w[  6]), .ci(pp15_w[  4]), .s(stg1_s5[  8]), .co(stg1_c5[  8]));
full_adder u_a15_9  (.a(pp13_w[  9]), .b(pp14_w[  7]), .ci(pp15_w[  5]), .s(stg1_s5[  9]), .co(stg1_c5[  9]));
full_adder u_a15_10 (.a(pp13_w[ 10]), .b(pp14_w[  8]), .ci(pp15_w[  6]), .s(stg1_s5[ 10]), .co(stg1_c5[ 10]));
full_adder u_a15_11 (.a(pp13_w[ 11]), .b(pp14_w[  9]), .ci(pp15_w[  7]), .s(stg1_s5[ 11]), .co(stg1_c5[ 11]));
full_adder u_a15_12 (.a(pp13_w[ 12]), .b(pp14_w[ 10]), .ci(pp15_w[  8]), .s(stg1_s5[ 12]), .co(stg1_c5[ 12]));
full_adder u_a15_13 (.a(pp13_w[ 13]), .b(pp14_w[ 11]), .ci(pp15_w[  9]), .s(stg1_s5[ 13]), .co(stg1_c5[ 13]));
full_adder u_a15_14 (.a(pp13_w[ 14]), .b(pp14_w[ 12]), .ci(pp15_w[ 10]), .s(stg1_s5[ 14]), .co(stg1_c5[ 14]));
full_adder u_a15_15 (.a(pp13_w[ 15]), .b(pp14_w[ 13]), .ci(pp15_w[ 11]), .s(stg1_s5[ 15]), .co(stg1_c5[ 15]));
full_adder u_a15_16 (.a(pp13_w[ 16]), .b(pp14_w[ 14]), .ci(pp15_w[ 12]), .s(stg1_s5[ 16]), .co(stg1_c5[ 16]));
full_adder u_a15_17 (.a(pp13_w[ 17]), .b(pp14_w[ 15]), .ci(pp15_w[ 13]), .s(stg1_s5[ 17]), .co(stg1_c5[ 17]));
full_adder u_a15_18 (.a(pp13_w[ 18]), .b(pp14_w[ 16]), .ci(pp15_w[ 14]), .s(stg1_s5[ 18]), .co(stg1_c5[ 18]));
full_adder u_a15_19 (.a(pp13_w[ 19]), .b(pp14_w[ 17]), .ci(pp15_w[ 15]), .s(stg1_s5[ 19]), .co(stg1_c5[ 19]));
full_adder u_a15_20 (.a(pp13_w[ 20]), .b(pp14_w[ 18]), .ci(pp15_w[ 16]), .s(stg1_s5[ 20]), .co(stg1_c5[ 20]));
full_adder u_a15_21 (.a(pp13_w[ 21]), .b(pp14_w[ 19]), .ci(pp15_w[ 17]), .s(stg1_s5[ 21]), .co(stg1_c5[ 21]));
full_adder u_a15_22 (.a(pp13_w[ 22]), .b(pp14_w[ 20]), .ci(pp15_w[ 18]), .s(stg1_s5[ 22]), .co(stg1_c5[ 22]));
full_adder u_a15_23 (.a(pp13_w[ 23]), .b(pp14_w[ 21]), .ci(pp15_w[ 19]), .s(stg1_s5[ 23]), .co(stg1_c5[ 23]));
full_adder u_a15_24 (.a(pp13_w[ 24]), .b(pp14_w[ 22]), .ci(pp15_w[ 20]), .s(stg1_s5[ 24]), .co(stg1_c5[ 24]));
full_adder u_a15_25 (.a(pp13_w[ 25]), .b(pp14_w[ 23]), .ci(pp15_w[ 21]), .s(stg1_s5[ 25]), .co(stg1_c5[ 25]));
full_adder u_a15_26 (.a(pp13_w[ 26]), .b(pp14_w[ 24]), .ci(pp15_w[ 22]), .s(stg1_s5[ 26]), .co(stg1_c5[ 26]));
full_adder u_a15_27 (.a(pp13_w[ 27]), .b(pp14_w[ 25]), .ci(pp15_w[ 23]), .s(stg1_s5[ 27]), .co(stg1_c5[ 27]));
full_adder u_a15_28 (.a(pp13_w[ 28]), .b(pp14_w[ 26]), .ci(pp15_w[ 24]), .s(stg1_s5[ 28]), .co(stg1_c5[ 28]));
full_adder u_a15_29 (.a(pp13_w[ 29]), .b(pp14_w[ 27]), .ci(pp15_w[ 25]), .s(stg1_s5[ 29]), .co(stg1_c5[ 29]));
full_adder u_a15_30 (.a(pp13_w[ 30]), .b(pp14_w[ 28]), .ci(pp15_w[ 26]), .s(stg1_s5[ 30]), .co(stg1_c5[ 30]));
full_adder u_a15_31 (.a(pp13_w[ 31]), .b(pp14_w[ 29]), .ci(pp15_w[ 27]), .s(stg1_s5[ 31]), .co(stg1_c5[ 31]));
full_adder u_a15_32 (.a(pp13_w[ 32]), .b(pp14_w[ 30]), .ci(pp15_w[ 28]), .s(stg1_s5[ 32]), .co(stg1_c5[ 32]));
full_adder u_a15_33 (.a(pp13_w[ 33]), .b(pp14_w[ 31]), .ci(pp15_w[ 29]), .s(stg1_s5[ 33]), .co(stg1_c5[ 33]));
full_adder u_a15_34 (.a(pp13_w[ 33]), .b(pp14_w[ 32]), .ci(pp15_w[ 30]), .s(stg1_s5[ 34]), .co(stg1_c5[ 34]));
full_adder u_a15_35 (.a(pp13_w[ 33]), .b(pp14_w[ 33]), .ci(pp15_w[ 31]), .s(stg1_s5[ 35]), .co(stg1_c5[ 35]));
full_adder u_a15_36 (.a(pp13_w[ 33]), .b(pp14_w[ 33]), .ci(pp15_w[ 32]), .s(stg1_s5[ 36]), .co(stg1_c5[ 36]));
full_adder u_a15_37 (.a(pp13_w[ 33]), .b(pp14_w[ 33]), .ci(pp15_w[ 33]), .s(stg1_s5[ 37]), .co(stg1_c5[ 37]));



wire [37:0] stg1_s1_w, stg1_c1_w;
wire [37:0] stg1_s2_w, stg1_c2_w;
wire [37:0] stg1_s3_w, stg1_c3_w;
wire [37:0] stg1_s4_w, stg1_c4_w;
wire [37:0] stg1_s5_w, stg1_c5_w;
wire [33:0] pp16_w2;
wire [31:0] pp17_w2;
//================ if necessary, pipeline stg1_s* and stg1_c* here for timing ================
`ifdef MULT32_PIPE_STG1
reg [37:0] stg1_s1_ff, stg1_c1_ff;
reg [37:0] stg1_s2_ff, stg1_c2_ff;
reg [37:0] stg1_s3_ff, stg1_c3_ff;
reg [37:0] stg1_s4_ff, stg1_c4_ff;
reg [37:0] stg1_s5_ff, stg1_c5_ff;
reg [33:0] pp16_ff2;
reg [31:0] pp17_ff2;

always @(posedge clk or negedge rstn) begin
  if(~rstn) begin
    stg1_s1_ff <= 38'b0;
    stg1_c1_ff <= 38'b0;
    stg1_s2_ff <= 38'b0;
    stg1_c2_ff <= 38'b0;
    stg1_s3_ff <= 38'b0;
    stg1_c3_ff <= 38'b0;
    stg1_s4_ff <= 38'b0;
    stg1_c4_ff <= 38'b0;
    stg1_s5_ff <= 38'b0;
    stg1_c5_ff <= 38'b0;
    pp16_ff2 <= 34'b0;
    pp17_ff2 <= 32'b0;
  end
  else begin
    stg1_s1_ff <= stg1_s1;
    stg1_c1_ff <= stg1_c1;
    stg1_s2_ff <= stg1_s2;
    stg1_c2_ff <= stg1_c2;
    stg1_s3_ff <= stg1_s3;
    stg1_c3_ff <= stg1_c3;
    stg1_s4_ff <= stg1_s4;
    stg1_c4_ff <= stg1_c4;
    stg1_s5_ff <= stg1_s5;
    stg1_c5_ff <= stg1_c5;
    pp16_ff2   <= pp16_w[33:0];
    pp17_ff2   <= pp17_w[31:0];
  end
end
assign stg1_s1_w = stg1_s1_ff;
assign stg1_c1_w = stg1_c1_ff;
assign stg1_s2_w = stg1_s2_ff;
assign stg1_c2_w = stg1_c2_ff;
assign stg1_s3_w = stg1_s3_ff;
assign stg1_c3_w = stg1_c3_ff;
assign stg1_s4_w = stg1_s4_ff;
assign stg1_c4_w = stg1_c4_ff;
assign stg1_s5_w = stg1_s5_ff;
assign stg1_c5_w = stg1_c5_ff;
assign pp16_w2   = pp16_ff2;
assign pp17_w2   = pp17_ff2;
`else
assign stg1_s1_w = stg1_s1;
assign stg1_c1_w = stg1_c1;
assign stg1_s2_w = stg1_s2;
assign stg1_c2_w = stg1_c2;
assign stg1_s3_w = stg1_s3;
assign stg1_c3_w = stg1_c3;
assign stg1_s4_w = stg1_s4;
assign stg1_c4_w = stg1_c4;
assign stg1_s5_w = stg1_s5;
assign stg1_c5_w = stg1_c5;
assign pp16_w2   = pp16_w[33:0];
assign pp17_w2   = pp17_w[31:0];
`endif

//================ second stage ================

wire [43:0] stg2_s1, stg2_c1;
wire [43:0] stg2_s2, stg2_c2;
wire [43:0] stg2_s3, stg2_c3;
wire [38:0] stg2_s4, stg2_c4;

//yellow
assign stg2_s1[0] = stg1_s1_w[0];
assign stg2_c1[0] = 1'b0; 
half_adder u_a21_1 (.a(stg1_s1_w[ 1]), .b(stg1_c1_w[ 0]),                     .s(stg2_s1[ 1]), .co(stg2_c1[ 1]));
half_adder u_a21_2 (.a(stg1_s1_w[ 2]), .b(stg1_c1_w[ 1]),                     .s(stg2_s1[ 2]), .co(stg2_c1[ 2]));
half_adder u_a21_3 (.a(stg1_s1_w[ 3]), .b(stg1_c1_w[ 2]),                     .s(stg2_s1[ 3]), .co(stg2_c1[ 3]));
half_adder u_a21_4 (.a(stg1_s1_w[ 4]), .b(stg1_c1_w[ 3]),                     .s(stg2_s1[ 4]), .co(stg2_c1[ 4]));
half_adder u_a21_5 (.a(stg1_s1_w[ 5]), .b(stg1_c1_w[ 4]),                     .s(stg2_s1[ 5]), .co(stg2_c1[ 5]));
full_adder u_a21_6 (.a(stg1_s1_w[ 6]), .b(stg1_c1_w[ 5]), .ci(stg1_s2_w[ 0]), .s(stg2_s1[ 6]), .co(stg2_c1[ 6]));
full_adder u_a21_7 (.a(stg1_s1_w[ 7]), .b(stg1_c1_w[ 6]), .ci(stg1_s2_w[ 1]), .s(stg2_s1[ 7]), .co(stg2_c1[ 7]));
full_adder u_a21_8 (.a(stg1_s1_w[ 8]), .b(stg1_c1_w[ 7]), .ci(stg1_s2_w[ 2]), .s(stg2_s1[ 8]), .co(stg2_c1[ 8]));
full_adder u_a21_9 (.a(stg1_s1_w[ 9]), .b(stg1_c1_w[ 8]), .ci(stg1_s2_w[ 3]), .s(stg2_s1[ 9]), .co(stg2_c1[ 9]));
full_adder u_a21_10(.a(stg1_s1_w[10]), .b(stg1_c1_w[ 9]), .ci(stg1_s2_w[ 4]), .s(stg2_s1[10]), .co(stg2_c1[10]));
full_adder u_a21_11(.a(stg1_s1_w[11]), .b(stg1_c1_w[10]), .ci(stg1_s2_w[ 5]), .s(stg2_s1[11]), .co(stg2_c1[11]));
full_adder u_a21_12(.a(stg1_s1_w[12]), .b(stg1_c1_w[11]), .ci(stg1_s2_w[ 6]), .s(stg2_s1[12]), .co(stg2_c1[12]));
full_adder u_a21_13(.a(stg1_s1_w[13]), .b(stg1_c1_w[12]), .ci(stg1_s2_w[ 7]), .s(stg2_s1[13]), .co(stg2_c1[13]));
full_adder u_a21_14(.a(stg1_s1_w[14]), .b(stg1_c1_w[13]), .ci(stg1_s2_w[ 8]), .s(stg2_s1[14]), .co(stg2_c1[14]));
full_adder u_a21_15(.a(stg1_s1_w[15]), .b(stg1_c1_w[14]), .ci(stg1_s2_w[ 9]), .s(stg2_s1[15]), .co(stg2_c1[15]));
full_adder u_a21_16(.a(stg1_s1_w[16]), .b(stg1_c1_w[15]), .ci(stg1_s2_w[10]), .s(stg2_s1[16]), .co(stg2_c1[16]));
full_adder u_a21_17(.a(stg1_s1_w[17]), .b(stg1_c1_w[16]), .ci(stg1_s2_w[11]), .s(stg2_s1[17]), .co(stg2_c1[17]));
full_adder u_a21_18(.a(stg1_s1_w[18]), .b(stg1_c1_w[17]), .ci(stg1_s2_w[12]), .s(stg2_s1[18]), .co(stg2_c1[18]));
full_adder u_a21_19(.a(stg1_s1_w[19]), .b(stg1_c1_w[18]), .ci(stg1_s2_w[13]), .s(stg2_s1[19]), .co(stg2_c1[19]));
full_adder u_a21_20(.a(stg1_s1_w[20]), .b(stg1_c1_w[19]), .ci(stg1_s2_w[14]), .s(stg2_s1[20]), .co(stg2_c1[20]));
full_adder u_a21_21(.a(stg1_s1_w[21]), .b(stg1_c1_w[20]), .ci(stg1_s2_w[15]), .s(stg2_s1[21]), .co(stg2_c1[21]));
full_adder u_a21_22(.a(stg1_s1_w[22]), .b(stg1_c1_w[21]), .ci(stg1_s2_w[16]), .s(stg2_s1[22]), .co(stg2_c1[22]));
full_adder u_a21_23(.a(stg1_s1_w[23]), .b(stg1_c1_w[22]), .ci(stg1_s2_w[17]), .s(stg2_s1[23]), .co(stg2_c1[23]));
full_adder u_a21_24(.a(stg1_s1_w[24]), .b(stg1_c1_w[23]), .ci(stg1_s2_w[18]), .s(stg2_s1[24]), .co(stg2_c1[24]));
full_adder u_a21_25(.a(stg1_s1_w[25]), .b(stg1_c1_w[24]), .ci(stg1_s2_w[19]), .s(stg2_s1[25]), .co(stg2_c1[25]));
full_adder u_a21_26(.a(stg1_s1_w[26]), .b(stg1_c1_w[25]), .ci(stg1_s2_w[20]), .s(stg2_s1[26]), .co(stg2_c1[26]));
full_adder u_a21_27(.a(stg1_s1_w[27]), .b(stg1_c1_w[26]), .ci(stg1_s2_w[21]), .s(stg2_s1[27]), .co(stg2_c1[27]));
full_adder u_a21_28(.a(stg1_s1_w[28]), .b(stg1_c1_w[27]), .ci(stg1_s2_w[22]), .s(stg2_s1[28]), .co(stg2_c1[28]));
full_adder u_a21_29(.a(stg1_s1_w[29]), .b(stg1_c1_w[28]), .ci(stg1_s2_w[23]), .s(stg2_s1[29]), .co(stg2_c1[29]));
full_adder u_a21_30(.a(stg1_s1_w[30]), .b(stg1_c1_w[29]), .ci(stg1_s2_w[24]), .s(stg2_s1[30]), .co(stg2_c1[30]));
full_adder u_a21_31(.a(stg1_s1_w[31]), .b(stg1_c1_w[30]), .ci(stg1_s2_w[25]), .s(stg2_s1[31]), .co(stg2_c1[31]));
full_adder u_a21_32(.a(stg1_s1_w[32]), .b(stg1_c1_w[31]), .ci(stg1_s2_w[26]), .s(stg2_s1[32]), .co(stg2_c1[32]));
full_adder u_a21_33(.a(stg1_s1_w[33]), .b(stg1_c1_w[32]), .ci(stg1_s2_w[27]), .s(stg2_s1[33]), .co(stg2_c1[33]));
full_adder u_a21_34(.a(stg1_s1_w[34]), .b(stg1_c1_w[33]), .ci(stg1_s2_w[28]), .s(stg2_s1[34]), .co(stg2_c1[34]));
full_adder u_a21_35(.a(stg1_s1_w[35]), .b(stg1_c1_w[34]), .ci(stg1_s2_w[29]), .s(stg2_s1[35]), .co(stg2_c1[35]));
full_adder u_a21_36(.a(stg1_s1_w[36]), .b(stg1_c1_w[35]), .ci(stg1_s2_w[30]), .s(stg2_s1[36]), .co(stg2_c1[36]));
full_adder u_a21_37(.a(stg1_s1_w[37]), .b(stg1_c1_w[36]), .ci(stg1_s2_w[31]), .s(stg2_s1[37]), .co(stg2_c1[37]));
full_adder u_a21_38(.a(stg1_s1_w[37]), .b(stg1_c1_w[37]), .ci(stg1_s2_w[32]), .s(stg2_s1[38]), .co(stg2_c1[38]));
full_adder u_a21_39(.a(stg1_s1_w[37]), .b(stg1_c1_w[37]), .ci(stg1_s2_w[33]), .s(stg2_s1[39]), .co(stg2_c1[39]));
full_adder u_a21_40(.a(stg1_s1_w[37]), .b(stg1_c1_w[37]), .ci(stg1_s2_w[34]), .s(stg2_s1[40]), .co(stg2_c1[40]));
full_adder u_a21_41(.a(stg1_s1_w[37]), .b(stg1_c1_w[37]), .ci(stg1_s2_w[35]), .s(stg2_s1[41]), .co(stg2_c1[41]));
full_adder u_a21_42(.a(stg1_s1_w[37]), .b(stg1_c1_w[37]), .ci(stg1_s2_w[36]), .s(stg2_s1[42]), .co(stg2_c1[42]));
full_adder u_a21_43(.a(stg1_s1_w[37]), .b(stg1_c1_w[37]), .ci(stg1_s2_w[37]), .s(stg2_s1[43]), .co(stg2_c1[43]));

//green
assign stg2_s2[4:0] = stg1_s2_w[4:0];
assign stg2_c2[4:0] = 5'b0; 
half_adder u_a22_5 (.a(stg1_s2_w[ 5]), .b(stg1_c3_w[ 0]),                     .s(stg2_s2[ 5]), .co(stg2_c2[ 5]));
full_adder u_a22_6 (.a(stg1_s2_w[ 6]), .b(stg1_c3_w[ 1]), .ci(stg1_s3_w[ 0]), .s(stg2_s2[ 6]), .co(stg2_c2[ 6]));
full_adder u_a22_7 (.a(stg1_s2_w[ 7]), .b(stg1_c3_w[ 2]), .ci(stg1_s3_w[ 1]), .s(stg2_s2[ 7]), .co(stg2_c2[ 7]));
full_adder u_a22_8 (.a(stg1_s2_w[ 8]), .b(stg1_c3_w[ 3]), .ci(stg1_s3_w[ 2]), .s(stg2_s2[ 8]), .co(stg2_c2[ 8]));
full_adder u_a22_9 (.a(stg1_s2_w[ 9]), .b(stg1_c3_w[ 4]), .ci(stg1_s3_w[ 3]), .s(stg2_s2[ 9]), .co(stg2_c2[ 9]));
full_adder u_a22_10(.a(stg1_s2_w[10]), .b(stg1_c3_w[ 5]), .ci(stg1_s3_w[ 4]), .s(stg2_s2[10]), .co(stg2_c2[10]));
full_adder u_a22_11(.a(stg1_s2_w[11]), .b(stg1_c3_w[ 6]), .ci(stg1_s3_w[ 5]), .s(stg2_s2[11]), .co(stg2_c2[11]));
full_adder u_a22_12(.a(stg1_s2_w[12]), .b(stg1_c3_w[ 7]), .ci(stg1_s3_w[ 6]), .s(stg2_s2[12]), .co(stg2_c2[12]));
full_adder u_a22_13(.a(stg1_s2_w[13]), .b(stg1_c3_w[ 8]), .ci(stg1_s3_w[ 7]), .s(stg2_s2[13]), .co(stg2_c2[13]));
full_adder u_a22_14(.a(stg1_s2_w[14]), .b(stg1_c3_w[ 9]), .ci(stg1_s3_w[ 8]), .s(stg2_s2[14]), .co(stg2_c2[14]));
full_adder u_a22_15(.a(stg1_s2_w[15]), .b(stg1_c3_w[10]), .ci(stg1_s3_w[ 9]), .s(stg2_s2[15]), .co(stg2_c2[15]));
full_adder u_a22_16(.a(stg1_s2_w[16]), .b(stg1_c3_w[11]), .ci(stg1_s3_w[10]), .s(stg2_s2[16]), .co(stg2_c2[16]));
full_adder u_a22_17(.a(stg1_s2_w[17]), .b(stg1_c3_w[12]), .ci(stg1_s3_w[11]), .s(stg2_s2[17]), .co(stg2_c2[17]));
full_adder u_a22_18(.a(stg1_s2_w[18]), .b(stg1_c3_w[13]), .ci(stg1_s3_w[12]), .s(stg2_s2[18]), .co(stg2_c2[18]));
full_adder u_a22_19(.a(stg1_s2_w[19]), .b(stg1_c3_w[14]), .ci(stg1_s3_w[13]), .s(stg2_s2[19]), .co(stg2_c2[19]));
full_adder u_a22_20(.a(stg1_s2_w[20]), .b(stg1_c3_w[15]), .ci(stg1_s3_w[14]), .s(stg2_s2[20]), .co(stg2_c2[20]));
full_adder u_a22_21(.a(stg1_s2_w[21]), .b(stg1_c3_w[16]), .ci(stg1_s3_w[15]), .s(stg2_s2[21]), .co(stg2_c2[21]));
full_adder u_a22_22(.a(stg1_s2_w[22]), .b(stg1_c3_w[17]), .ci(stg1_s3_w[16]), .s(stg2_s2[22]), .co(stg2_c2[22]));
full_adder u_a22_23(.a(stg1_s2_w[23]), .b(stg1_c3_w[18]), .ci(stg1_s3_w[17]), .s(stg2_s2[23]), .co(stg2_c2[23]));
full_adder u_a22_24(.a(stg1_s2_w[24]), .b(stg1_c3_w[19]), .ci(stg1_s3_w[18]), .s(stg2_s2[24]), .co(stg2_c2[24]));
full_adder u_a22_25(.a(stg1_s2_w[25]), .b(stg1_c3_w[20]), .ci(stg1_s3_w[19]), .s(stg2_s2[25]), .co(stg2_c2[25]));
full_adder u_a22_26(.a(stg1_s2_w[26]), .b(stg1_c3_w[21]), .ci(stg1_s3_w[20]), .s(stg2_s2[26]), .co(stg2_c2[26]));
full_adder u_a22_27(.a(stg1_s2_w[27]), .b(stg1_c3_w[22]), .ci(stg1_s3_w[21]), .s(stg2_s2[27]), .co(stg2_c2[27]));
full_adder u_a22_28(.a(stg1_s2_w[28]), .b(stg1_c3_w[23]), .ci(stg1_s3_w[22]), .s(stg2_s2[28]), .co(stg2_c2[28]));
full_adder u_a22_29(.a(stg1_s2_w[29]), .b(stg1_c3_w[24]), .ci(stg1_s3_w[23]), .s(stg2_s2[29]), .co(stg2_c2[29]));
full_adder u_a22_30(.a(stg1_s2_w[30]), .b(stg1_c3_w[25]), .ci(stg1_s3_w[24]), .s(stg2_s2[30]), .co(stg2_c2[30]));
full_adder u_a22_31(.a(stg1_s2_w[31]), .b(stg1_c3_w[26]), .ci(stg1_s3_w[25]), .s(stg2_s2[31]), .co(stg2_c2[31]));
full_adder u_a22_32(.a(stg1_s2_w[32]), .b(stg1_c3_w[27]), .ci(stg1_s3_w[26]), .s(stg2_s2[32]), .co(stg2_c2[32]));
full_adder u_a22_33(.a(stg1_s2_w[33]), .b(stg1_c3_w[28]), .ci(stg1_s3_w[27]), .s(stg2_s2[33]), .co(stg2_c2[33]));
full_adder u_a22_34(.a(stg1_s2_w[34]), .b(stg1_c3_w[29]), .ci(stg1_s3_w[28]), .s(stg2_s2[34]), .co(stg2_c2[34]));
full_adder u_a22_35(.a(stg1_s2_w[35]), .b(stg1_c3_w[30]), .ci(stg1_s3_w[29]), .s(stg2_s2[35]), .co(stg2_c2[35]));
full_adder u_a22_36(.a(stg1_s2_w[36]), .b(stg1_c3_w[31]), .ci(stg1_s3_w[30]), .s(stg2_s2[36]), .co(stg2_c2[36]));
full_adder u_a22_37(.a(stg1_s2_w[37]), .b(stg1_c3_w[32]), .ci(stg1_s3_w[31]), .s(stg2_s2[37]), .co(stg2_c2[37]));
full_adder u_a22_38(.a(stg1_s2_w[37]), .b(stg1_c3_w[33]), .ci(stg1_s3_w[32]), .s(stg2_s2[38]), .co(stg2_c2[38]));
full_adder u_a22_39(.a(stg1_s2_w[37]), .b(stg1_c3_w[34]), .ci(stg1_s3_w[33]), .s(stg2_s2[39]), .co(stg2_c2[39]));
full_adder u_a22_40(.a(stg1_s2_w[37]), .b(stg1_c3_w[35]), .ci(stg1_s3_w[34]), .s(stg2_s2[40]), .co(stg2_c2[40]));
full_adder u_a22_41(.a(stg1_s2_w[37]), .b(stg1_c3_w[36]), .ci(stg1_s3_w[35]), .s(stg2_s2[41]), .co(stg2_c2[41]));
full_adder u_a22_42(.a(stg1_s2_w[37]), .b(stg1_c3_w[37]), .ci(stg1_s3_w[36]), .s(stg2_s2[42]), .co(stg2_c2[42]));
full_adder u_a22_43(.a(stg1_s2_w[37]), .b(stg1_c3_w[37]), .ci(stg1_s3_w[37]), .s(stg2_s2[43]), .co(stg2_c2[43]));

//blue
assign stg2_s3[0] = stg1_s4_w[0];
assign stg2_c3[0] = 1'b0; 
half_adder u_a23_1  (.a(stg1_s4_w[ 1]), .b(stg1_c4_w[ 0]),                     .s(stg2_s3[ 1]), .co(stg2_c3[ 1]));
half_adder u_a23_2  (.a(stg1_s4_w[ 2]), .b(stg1_c4_w[ 1]),                     .s(stg2_s3[ 2]), .co(stg2_c3[ 2]));
half_adder u_a23_3  (.a(stg1_s4_w[ 3]), .b(stg1_c4_w[ 2]),                     .s(stg2_s3[ 3]), .co(stg2_c3[ 3]));
half_adder u_a23_4  (.a(stg1_s4_w[ 4]), .b(stg1_c4_w[ 3]),                     .s(stg2_s3[ 4]), .co(stg2_c3[ 4]));
half_adder u_a23_5  (.a(stg1_s4_w[ 5]), .b(stg1_c4_w[ 4]),                     .s(stg2_s3[ 5]), .co(stg2_c3[ 5]));
full_adder u_a23_6  (.a(stg1_s4_w[ 6]), .b(stg1_c4_w[ 5]), .ci(stg1_s5_w[ 0]), .s(stg2_s3[ 6]), .co(stg2_c3[ 6]));
full_adder u_a23_7  (.a(stg1_s4_w[ 7]), .b(stg1_c4_w[ 6]), .ci(stg1_s5_w[ 1]), .s(stg2_s3[ 7]), .co(stg2_c3[ 7]));
full_adder u_a23_8  (.a(stg1_s4_w[ 8]), .b(stg1_c4_w[ 7]), .ci(stg1_s5_w[ 2]), .s(stg2_s3[ 8]), .co(stg2_c3[ 8]));
full_adder u_a23_9  (.a(stg1_s4_w[ 9]), .b(stg1_c4_w[ 8]), .ci(stg1_s5_w[ 3]), .s(stg2_s3[ 9]), .co(stg2_c3[ 9]));
full_adder u_a23_10 (.a(stg1_s4_w[10]), .b(stg1_c4_w[ 9]), .ci(stg1_s5_w[ 4]), .s(stg2_s3[10]), .co(stg2_c3[10]));
full_adder u_a23_11 (.a(stg1_s4_w[11]), .b(stg1_c4_w[10]), .ci(stg1_s5_w[ 5]), .s(stg2_s3[11]), .co(stg2_c3[11]));
full_adder u_a23_12 (.a(stg1_s4_w[12]), .b(stg1_c4_w[11]), .ci(stg1_s5_w[ 6]), .s(stg2_s3[12]), .co(stg2_c3[12]));
full_adder u_a23_13 (.a(stg1_s4_w[13]), .b(stg1_c4_w[12]), .ci(stg1_s5_w[ 7]), .s(stg2_s3[13]), .co(stg2_c3[13]));
full_adder u_a23_14 (.a(stg1_s4_w[14]), .b(stg1_c4_w[13]), .ci(stg1_s5_w[ 8]), .s(stg2_s3[14]), .co(stg2_c3[14]));
full_adder u_a23_15 (.a(stg1_s4_w[15]), .b(stg1_c4_w[14]), .ci(stg1_s5_w[ 9]), .s(stg2_s3[15]), .co(stg2_c3[15]));
full_adder u_a23_16 (.a(stg1_s4_w[16]), .b(stg1_c4_w[15]), .ci(stg1_s5_w[10]), .s(stg2_s3[16]), .co(stg2_c3[16]));
full_adder u_a23_17 (.a(stg1_s4_w[17]), .b(stg1_c4_w[16]), .ci(stg1_s5_w[11]), .s(stg2_s3[17]), .co(stg2_c3[17]));
full_adder u_a23_18 (.a(stg1_s4_w[18]), .b(stg1_c4_w[17]), .ci(stg1_s5_w[12]), .s(stg2_s3[18]), .co(stg2_c3[18]));
full_adder u_a23_19 (.a(stg1_s4_w[19]), .b(stg1_c4_w[18]), .ci(stg1_s5_w[13]), .s(stg2_s3[19]), .co(stg2_c3[19]));
full_adder u_a23_20 (.a(stg1_s4_w[20]), .b(stg1_c4_w[19]), .ci(stg1_s5_w[14]), .s(stg2_s3[20]), .co(stg2_c3[20]));
full_adder u_a23_21 (.a(stg1_s4_w[21]), .b(stg1_c4_w[20]), .ci(stg1_s5_w[15]), .s(stg2_s3[21]), .co(stg2_c3[21]));
full_adder u_a23_22 (.a(stg1_s4_w[22]), .b(stg1_c4_w[21]), .ci(stg1_s5_w[16]), .s(stg2_s3[22]), .co(stg2_c3[22]));
full_adder u_a23_23 (.a(stg1_s4_w[23]), .b(stg1_c4_w[22]), .ci(stg1_s5_w[17]), .s(stg2_s3[23]), .co(stg2_c3[23]));
full_adder u_a23_24 (.a(stg1_s4_w[24]), .b(stg1_c4_w[23]), .ci(stg1_s5_w[18]), .s(stg2_s3[24]), .co(stg2_c3[24]));
full_adder u_a23_25 (.a(stg1_s4_w[25]), .b(stg1_c4_w[24]), .ci(stg1_s5_w[19]), .s(stg2_s3[25]), .co(stg2_c3[25]));
full_adder u_a23_26 (.a(stg1_s4_w[26]), .b(stg1_c4_w[25]), .ci(stg1_s5_w[20]), .s(stg2_s3[26]), .co(stg2_c3[26]));
full_adder u_a23_27 (.a(stg1_s4_w[27]), .b(stg1_c4_w[26]), .ci(stg1_s5_w[21]), .s(stg2_s3[27]), .co(stg2_c3[27]));
full_adder u_a23_28 (.a(stg1_s4_w[28]), .b(stg1_c4_w[27]), .ci(stg1_s5_w[22]), .s(stg2_s3[28]), .co(stg2_c3[28]));
full_adder u_a23_29 (.a(stg1_s4_w[29]), .b(stg1_c4_w[28]), .ci(stg1_s5_w[23]), .s(stg2_s3[29]), .co(stg2_c3[29]));
full_adder u_a23_30 (.a(stg1_s4_w[30]), .b(stg1_c4_w[29]), .ci(stg1_s5_w[24]), .s(stg2_s3[30]), .co(stg2_c3[30]));
full_adder u_a23_31 (.a(stg1_s4_w[31]), .b(stg1_c4_w[30]), .ci(stg1_s5_w[25]), .s(stg2_s3[31]), .co(stg2_c3[31]));
full_adder u_a23_32 (.a(stg1_s4_w[32]), .b(stg1_c4_w[31]), .ci(stg1_s5_w[26]), .s(stg2_s3[32]), .co(stg2_c3[32]));
full_adder u_a23_33 (.a(stg1_s4_w[33]), .b(stg1_c4_w[32]), .ci(stg1_s5_w[27]), .s(stg2_s3[33]), .co(stg2_c3[33]));
full_adder u_a23_34 (.a(stg1_s4_w[34]), .b(stg1_c4_w[33]), .ci(stg1_s5_w[28]), .s(stg2_s3[34]), .co(stg2_c3[34]));
full_adder u_a23_35 (.a(stg1_s4_w[35]), .b(stg1_c4_w[34]), .ci(stg1_s5_w[29]), .s(stg2_s3[35]), .co(stg2_c3[35]));
full_adder u_a23_36 (.a(stg1_s4_w[36]), .b(stg1_c4_w[35]), .ci(stg1_s5_w[30]), .s(stg2_s3[36]), .co(stg2_c3[36]));
full_adder u_a23_37 (.a(stg1_s4_w[37]), .b(stg1_c4_w[36]), .ci(stg1_s5_w[31]), .s(stg2_s3[37]), .co(stg2_c3[37]));
full_adder u_a23_38 (.a(stg1_s4_w[37]), .b(stg1_c4_w[37]), .ci(stg1_s5_w[32]), .s(stg2_s3[38]), .co(stg2_c3[38]));
full_adder u_a23_39 (.a(stg1_s4_w[37]), .b(stg1_c4_w[37]), .ci(stg1_s5_w[33]), .s(stg2_s3[39]), .co(stg2_c3[39]));
full_adder u_a23_40 (.a(stg1_s4_w[37]), .b(stg1_c4_w[37]), .ci(stg1_s5_w[34]), .s(stg2_s3[40]), .co(stg2_c3[40]));
full_adder u_a23_41 (.a(stg1_s4_w[37]), .b(stg1_c4_w[37]), .ci(stg1_s5_w[35]), .s(stg2_s3[41]), .co(stg2_c3[41]));
full_adder u_a23_42 (.a(stg1_s4_w[37]), .b(stg1_c4_w[37]), .ci(stg1_s5_w[36]), .s(stg2_s3[42]), .co(stg2_c3[42]));
full_adder u_a23_43 (.a(stg1_s4_w[37]), .b(stg1_c4_w[37]), .ci(stg1_s5_w[37]), .s(stg2_s3[43]), .co(stg2_c3[43]));

//orange
assign stg2_s4[4:0] = stg1_c5_w[4:0];
assign stg2_c4[4:0] = 5'b0; 
half_adder u_a24_5  (.a(stg1_c5_w[ 5]), .b(pp16_w2[ 0]),                   .s(stg2_s4[ 5]), .co(stg2_c4[ 5]));
full_adder u_a24_6  (.a(stg1_c5_w[ 6]), .b(pp16_w2[ 1]),                   .s(stg2_s4[ 6]), .co(stg2_c4[ 6]));
full_adder u_a24_7  (.a(stg1_c5_w[ 7]), .b(pp16_w2[ 2]), .ci(pp17_w2[ 0]), .s(stg2_s4[ 7]), .co(stg2_c4[ 7]));
full_adder u_a24_8  (.a(stg1_c5_w[ 8]), .b(pp16_w2[ 3]), .ci(pp17_w2[ 1]), .s(stg2_s4[ 8]), .co(stg2_c4[ 8]));
full_adder u_a24_9  (.a(stg1_c5_w[ 9]), .b(pp16_w2[ 4]), .ci(pp17_w2[ 2]), .s(stg2_s4[ 9]), .co(stg2_c4[ 9]));
full_adder u_a24_10 (.a(stg1_c5_w[10]), .b(pp16_w2[ 5]), .ci(pp17_w2[ 3]), .s(stg2_s4[10]), .co(stg2_c4[10]));
full_adder u_a24_11 (.a(stg1_c5_w[11]), .b(pp16_w2[ 6]), .ci(pp17_w2[ 4]), .s(stg2_s4[11]), .co(stg2_c4[11]));
full_adder u_a24_12 (.a(stg1_c5_w[12]), .b(pp16_w2[ 7]), .ci(pp17_w2[ 5]), .s(stg2_s4[12]), .co(stg2_c4[12]));
full_adder u_a24_13 (.a(stg1_c5_w[13]), .b(pp16_w2[ 8]), .ci(pp17_w2[ 6]), .s(stg2_s4[13]), .co(stg2_c4[13]));
full_adder u_a24_14 (.a(stg1_c5_w[14]), .b(pp16_w2[ 9]), .ci(pp17_w2[ 7]), .s(stg2_s4[14]), .co(stg2_c4[14]));
full_adder u_a24_15 (.a(stg1_c5_w[15]), .b(pp16_w2[10]), .ci(pp17_w2[ 8]), .s(stg2_s4[15]), .co(stg2_c4[15]));
full_adder u_a24_16 (.a(stg1_c5_w[16]), .b(pp16_w2[11]), .ci(pp17_w2[ 9]), .s(stg2_s4[16]), .co(stg2_c4[16]));
full_adder u_a24_17 (.a(stg1_c5_w[17]), .b(pp16_w2[12]), .ci(pp17_w2[10]), .s(stg2_s4[17]), .co(stg2_c4[17]));
full_adder u_a24_18 (.a(stg1_c5_w[18]), .b(pp16_w2[13]), .ci(pp17_w2[11]), .s(stg2_s4[18]), .co(stg2_c4[18]));
full_adder u_a24_19 (.a(stg1_c5_w[19]), .b(pp16_w2[14]), .ci(pp17_w2[12]), .s(stg2_s4[19]), .co(stg2_c4[19]));
full_adder u_a24_20 (.a(stg1_c5_w[20]), .b(pp16_w2[15]), .ci(pp17_w2[13]), .s(stg2_s4[20]), .co(stg2_c4[20]));
full_adder u_a24_21 (.a(stg1_c5_w[21]), .b(pp16_w2[16]), .ci(pp17_w2[14]), .s(stg2_s4[21]), .co(stg2_c4[21]));
full_adder u_a24_22 (.a(stg1_c5_w[22]), .b(pp16_w2[17]), .ci(pp17_w2[15]), .s(stg2_s4[22]), .co(stg2_c4[22]));
full_adder u_a24_23 (.a(stg1_c5_w[23]), .b(pp16_w2[18]), .ci(pp17_w2[16]), .s(stg2_s4[23]), .co(stg2_c4[23]));
full_adder u_a24_24 (.a(stg1_c5_w[24]), .b(pp16_w2[19]), .ci(pp17_w2[17]), .s(stg2_s4[24]), .co(stg2_c4[24]));
full_adder u_a24_25 (.a(stg1_c5_w[25]), .b(pp16_w2[20]), .ci(pp17_w2[18]), .s(stg2_s4[25]), .co(stg2_c4[25]));
full_adder u_a24_26 (.a(stg1_c5_w[26]), .b(pp16_w2[21]), .ci(pp17_w2[19]), .s(stg2_s4[26]), .co(stg2_c4[26]));
full_adder u_a24_27 (.a(stg1_c5_w[27]), .b(pp16_w2[22]), .ci(pp17_w2[20]), .s(stg2_s4[27]), .co(stg2_c4[27]));
full_adder u_a24_28 (.a(stg1_c5_w[28]), .b(pp16_w2[23]), .ci(pp17_w2[21]), .s(stg2_s4[28]), .co(stg2_c4[28]));
full_adder u_a24_29 (.a(stg1_c5_w[29]), .b(pp16_w2[24]), .ci(pp17_w2[22]), .s(stg2_s4[29]), .co(stg2_c4[29]));
full_adder u_a24_30 (.a(stg1_c5_w[30]), .b(pp16_w2[25]), .ci(pp17_w2[23]), .s(stg2_s4[30]), .co(stg2_c4[30]));
full_adder u_a24_31 (.a(stg1_c5_w[31]), .b(pp16_w2[26]), .ci(pp17_w2[24]), .s(stg2_s4[31]), .co(stg2_c4[31]));
full_adder u_a24_32 (.a(stg1_c5_w[32]), .b(pp16_w2[27]), .ci(pp17_w2[25]), .s(stg2_s4[32]), .co(stg2_c4[32]));
full_adder u_a24_33 (.a(stg1_c5_w[33]), .b(pp16_w2[28]), .ci(pp17_w2[26]), .s(stg2_s4[33]), .co(stg2_c4[33]));
full_adder u_a24_34 (.a(stg1_c5_w[34]), .b(pp16_w2[29]), .ci(pp17_w2[27]), .s(stg2_s4[34]), .co(stg2_c4[34]));
full_adder u_a24_35 (.a(stg1_c5_w[35]), .b(pp16_w2[30]), .ci(pp17_w2[28]), .s(stg2_s4[35]), .co(stg2_c4[35]));
full_adder u_a24_36 (.a(stg1_c5_w[36]), .b(pp16_w2[31]), .ci(pp17_w2[29]), .s(stg2_s4[36]), .co(stg2_c4[36]));
full_adder u_a24_37 (.a(stg1_c5_w[37]), .b(pp16_w2[32]), .ci(pp17_w2[30]), .s(stg2_s4[37]), .co(stg2_c4[37]));
full_adder u_a24_38 (.a(stg1_c5_w[37]), .b(pp16_w2[33]), .ci(pp17_w2[31]), .s(stg2_s4[38]), .co(stg2_c4[38]));



wire [43:0] stg2_s1_w, stg2_c1_w;
wire [43:0] stg2_s2_w, stg2_c2_w;
wire [43:0] stg2_s3_w, stg2_c3_w;
wire [38:0] stg2_s4_w, stg2_c4_w;
//================ if necessary, pipeline stg2_s* and stg2_c* here for timing ================
`ifdef MULT32_PIPE_STG2
reg [43:0] stg2_s1_ff, stg2_c1_ff;
reg [43:0] stg2_s2_ff, stg2_c2_ff;
reg [43:0] stg2_s3_ff, stg2_c3_ff;
reg [38:0] stg2_s4_ff, stg2_c4_ff;

always @(posedge clk or negedge rstn) begin
  if(~rstn) begin
    stg2_s1_ff <= 44'b0;
    stg2_c1_ff <= 44'b0;
    stg2_s2_ff <= 44'b0;
    stg2_c2_ff <= 44'b0;
    stg2_s3_ff <= 44'b0;
    stg2_c3_ff <= 44'b0;
    stg2_s4_ff <= 39'b0;
    stg2_c4_ff <= 39'b0;
  end
  else begin
    stg2_s1_ff <= stg2_s1;
    stg2_c1_ff <= stg2_c1;
    stg2_s2_ff <= stg2_s2;
    stg2_c2_ff <= stg2_c2;
    stg2_s3_ff <= stg2_s3;
    stg2_c3_ff <= stg2_c3;
    stg2_s4_ff <= stg2_s4;
    stg2_c4_ff <= stg2_c4;
  end
end
assign stg2_s1_w = stg2_s1_ff;
assign stg2_c1_w = stg2_c1_ff;
assign stg2_s2_w = stg2_s2_ff;
assign stg2_c2_w = stg2_c2_ff;
assign stg2_s3_w = stg2_s3_ff;
assign stg2_c3_w = stg2_c3_ff;
assign stg2_s4_w = stg2_s4_ff;
assign stg2_c4_w = stg2_c4_ff;
`else
assign stg2_s1_w = stg2_s1;
assign stg2_c1_w = stg2_c1;
assign stg2_s2_w = stg2_s2;
assign stg2_c2_w = stg2_c2;
assign stg2_s3_w = stg2_s3;
assign stg2_c3_w = stg2_c3;
assign stg2_s4_w = stg2_s4;
assign stg2_c4_w = stg2_c4;
`endif

//================ third stage ================

wire [50:0] stg3_s1, stg3_c1;
wire [54:0] stg3_s2, stg3_c2;

//yellow
assign stg3_s1[0] = stg2_s1_w[0];
assign stg3_c1[0] = 1'b0;
half_adder u_a31_1 (.a(stg2_s1_w[ 1]), .b(stg2_c1_w[ 0]),                     .s(stg3_s1[ 1]), .co(stg3_c1[ 1]));
half_adder u_a31_2 (.a(stg2_s1_w[ 2]), .b(stg2_c1_w[ 1]),                     .s(stg3_s1[ 2]), .co(stg3_c1[ 2]));
half_adder u_a31_3 (.a(stg2_s1_w[ 3]), .b(stg2_c1_w[ 2]),                     .s(stg3_s1[ 3]), .co(stg3_c1[ 3]));
half_adder u_a31_4 (.a(stg2_s1_w[ 4]), .b(stg2_c1_w[ 3]),                     .s(stg3_s1[ 4]), .co(stg3_c1[ 4]));
half_adder u_a31_5 (.a(stg2_s1_w[ 5]), .b(stg2_c1_w[ 4]),                     .s(stg3_s1[ 5]), .co(stg3_c1[ 5]));
half_adder u_a31_6 (.a(stg2_s1_w[ 6]), .b(stg2_c1_w[ 5]),                     .s(stg3_s1[ 6]), .co(stg3_c1[ 6]));
full_adder u_a31_7 (.a(stg2_s1_w[ 7]), .b(stg2_c1_w[ 6]), .ci(stg2_s2_w[ 0]), .s(stg3_s1[ 7]), .co(stg3_c1[ 7]));
full_adder u_a31_8 (.a(stg2_s1_w[ 8]), .b(stg2_c1_w[ 7]), .ci(stg2_s2_w[ 1]), .s(stg3_s1[ 8]), .co(stg3_c1[ 8]));
full_adder u_a31_9 (.a(stg2_s1_w[ 9]), .b(stg2_c1_w[ 8]), .ci(stg2_s2_w[ 2]), .s(stg3_s1[ 9]), .co(stg3_c1[ 9]));
full_adder u_a31_10(.a(stg2_s1_w[10]), .b(stg2_c1_w[ 9]), .ci(stg2_s2_w[ 3]), .s(stg3_s1[10]), .co(stg3_c1[10]));
full_adder u_a31_11(.a(stg2_s1_w[11]), .b(stg2_c1_w[10]), .ci(stg2_s2_w[ 4]), .s(stg3_s1[11]), .co(stg3_c1[11]));
full_adder u_a31_12(.a(stg2_s1_w[12]), .b(stg2_c1_w[11]), .ci(stg2_s2_w[ 5]), .s(stg3_s1[12]), .co(stg3_c1[12]));
full_adder u_a31_13(.a(stg2_s1_w[13]), .b(stg2_c1_w[12]), .ci(stg2_s2_w[ 6]), .s(stg3_s1[13]), .co(stg3_c1[13]));
full_adder u_a31_14(.a(stg2_s1_w[14]), .b(stg2_c1_w[13]), .ci(stg2_s2_w[ 7]), .s(stg3_s1[14]), .co(stg3_c1[14]));
full_adder u_a31_15(.a(stg2_s1_w[15]), .b(stg2_c1_w[14]), .ci(stg2_s2_w[ 8]), .s(stg3_s1[15]), .co(stg3_c1[15]));
full_adder u_a31_16(.a(stg2_s1_w[16]), .b(stg2_c1_w[15]), .ci(stg2_s2_w[ 9]), .s(stg3_s1[16]), .co(stg3_c1[16]));
full_adder u_a31_17(.a(stg2_s1_w[17]), .b(stg2_c1_w[16]), .ci(stg2_s2_w[10]), .s(stg3_s1[17]), .co(stg3_c1[17]));
full_adder u_a31_18(.a(stg2_s1_w[18]), .b(stg2_c1_w[17]), .ci(stg2_s2_w[11]), .s(stg3_s1[18]), .co(stg3_c1[18]));
full_adder u_a31_19(.a(stg2_s1_w[19]), .b(stg2_c1_w[18]), .ci(stg2_s2_w[12]), .s(stg3_s1[19]), .co(stg3_c1[19]));
full_adder u_a31_20(.a(stg2_s1_w[20]), .b(stg2_c1_w[19]), .ci(stg2_s2_w[13]), .s(stg3_s1[20]), .co(stg3_c1[20]));
full_adder u_a31_21(.a(stg2_s1_w[21]), .b(stg2_c1_w[20]), .ci(stg2_s2_w[14]), .s(stg3_s1[21]), .co(stg3_c1[21]));
full_adder u_a31_22(.a(stg2_s1_w[22]), .b(stg2_c1_w[21]), .ci(stg2_s2_w[15]), .s(stg3_s1[22]), .co(stg3_c1[22]));
full_adder u_a31_23(.a(stg2_s1_w[23]), .b(stg2_c1_w[22]), .ci(stg2_s2_w[16]), .s(stg3_s1[23]), .co(stg3_c1[23]));
full_adder u_a31_24(.a(stg2_s1_w[24]), .b(stg2_c1_w[23]), .ci(stg2_s2_w[17]), .s(stg3_s1[24]), .co(stg3_c1[24]));
full_adder u_a31_25(.a(stg2_s1_w[25]), .b(stg2_c1_w[24]), .ci(stg2_s2_w[18]), .s(stg3_s1[25]), .co(stg3_c1[25]));
full_adder u_a31_26(.a(stg2_s1_w[26]), .b(stg2_c1_w[25]), .ci(stg2_s2_w[19]), .s(stg3_s1[26]), .co(stg3_c1[26]));
full_adder u_a31_27(.a(stg2_s1_w[27]), .b(stg2_c1_w[26]), .ci(stg2_s2_w[20]), .s(stg3_s1[27]), .co(stg3_c1[27]));
full_adder u_a31_28(.a(stg2_s1_w[28]), .b(stg2_c1_w[27]), .ci(stg2_s2_w[21]), .s(stg3_s1[28]), .co(stg3_c1[28]));
full_adder u_a31_29(.a(stg2_s1_w[29]), .b(stg2_c1_w[28]), .ci(stg2_s2_w[22]), .s(stg3_s1[29]), .co(stg3_c1[29]));
full_adder u_a31_30(.a(stg2_s1_w[30]), .b(stg2_c1_w[29]), .ci(stg2_s2_w[23]), .s(stg3_s1[30]), .co(stg3_c1[30]));
full_adder u_a31_31(.a(stg2_s1_w[31]), .b(stg2_c1_w[30]), .ci(stg2_s2_w[24]), .s(stg3_s1[31]), .co(stg3_c1[31]));
full_adder u_a31_32(.a(stg2_s1_w[32]), .b(stg2_c1_w[31]), .ci(stg2_s2_w[25]), .s(stg3_s1[32]), .co(stg3_c1[32]));
full_adder u_a31_33(.a(stg2_s1_w[33]), .b(stg2_c1_w[32]), .ci(stg2_s2_w[26]), .s(stg3_s1[33]), .co(stg3_c1[33]));
full_adder u_a31_34(.a(stg2_s1_w[34]), .b(stg2_c1_w[33]), .ci(stg2_s2_w[27]), .s(stg3_s1[34]), .co(stg3_c1[34]));
full_adder u_a31_35(.a(stg2_s1_w[35]), .b(stg2_c1_w[34]), .ci(stg2_s2_w[28]), .s(stg3_s1[35]), .co(stg3_c1[35]));
full_adder u_a31_36(.a(stg2_s1_w[36]), .b(stg2_c1_w[35]), .ci(stg2_s2_w[29]), .s(stg3_s1[36]), .co(stg3_c1[36]));
full_adder u_a31_37(.a(stg2_s1_w[37]), .b(stg2_c1_w[36]), .ci(stg2_s2_w[30]), .s(stg3_s1[37]), .co(stg3_c1[37]));
full_adder u_a31_38(.a(stg2_s1_w[38]), .b(stg2_c1_w[37]), .ci(stg2_s2_w[31]), .s(stg3_s1[38]), .co(stg3_c1[38]));
full_adder u_a31_39(.a(stg2_s1_w[39]), .b(stg2_c1_w[38]), .ci(stg2_s2_w[32]), .s(stg3_s1[39]), .co(stg3_c1[39]));
full_adder u_a31_40(.a(stg2_s1_w[40]), .b(stg2_c1_w[39]), .ci(stg2_s2_w[33]), .s(stg3_s1[40]), .co(stg3_c1[40]));
full_adder u_a31_41(.a(stg2_s1_w[41]), .b(stg2_c1_w[40]), .ci(stg2_s2_w[34]), .s(stg3_s1[41]), .co(stg3_c1[41]));
full_adder u_a31_42(.a(stg2_s1_w[42]), .b(stg2_c1_w[41]), .ci(stg2_s2_w[35]), .s(stg3_s1[42]), .co(stg3_c1[42]));
full_adder u_a31_43(.a(stg2_s1_w[43]), .b(stg2_c1_w[42]), .ci(stg2_s2_w[36]), .s(stg3_s1[43]), .co(stg3_c1[43]));
full_adder u_a31_44(.a(stg2_s1_w[43]), .b(stg2_c1_w[43]), .ci(stg2_s2_w[37]), .s(stg3_s1[44]), .co(stg3_c1[44]));
full_adder u_a31_45(.a(stg2_s1_w[43]), .b(stg2_c1_w[43]), .ci(stg2_s2_w[38]), .s(stg3_s1[45]), .co(stg3_c1[45]));
full_adder u_a31_46(.a(stg2_s1_w[43]), .b(stg2_c1_w[43]), .ci(stg2_s2_w[39]), .s(stg3_s1[46]), .co(stg3_c1[46]));
full_adder u_a31_47(.a(stg2_s1_w[43]), .b(stg2_c1_w[43]), .ci(stg2_s2_w[40]), .s(stg3_s1[47]), .co(stg3_c1[47]));
full_adder u_a31_48(.a(stg2_s1_w[43]), .b(stg2_c1_w[43]), .ci(stg2_s2_w[41]), .s(stg3_s1[48]), .co(stg3_c1[48]));
full_adder u_a31_49(.a(stg2_s1_w[43]), .b(stg2_c1_w[43]), .ci(stg2_s2_w[42]), .s(stg3_s1[49]), .co(stg3_c1[49]));
full_adder u_a31_50(.a(stg2_s1_w[43]), .b(stg2_c1_w[43]), .ci(stg2_s2_w[43]), .s(stg3_s1[50]), .co(stg3_c1[50]));

//green
assign stg3_s2[9:0] = stg2_c2_w[9:0];
assign stg3_c2[9:0] = 10'b0;
half_adder u_a32_10 (.a(stg2_c2_w[10]), .b(stg2_s3_w[ 0]),                     .s(stg3_s2[10]), .co(stg3_c2[10]));
full_adder u_a32_11 (.a(stg2_c2_w[11]), .b(stg2_s3_w[ 1]), .ci(stg2_c3_w[ 0]), .s(stg3_s2[11]), .co(stg3_c2[11]));
full_adder u_a32_12 (.a(stg2_c2_w[12]), .b(stg2_s3_w[ 2]), .ci(stg2_c3_w[ 1]), .s(stg3_s2[12]), .co(stg3_c2[12]));
full_adder u_a32_13 (.a(stg2_c2_w[13]), .b(stg2_s3_w[ 3]), .ci(stg2_c3_w[ 2]), .s(stg3_s2[13]), .co(stg3_c2[13]));
full_adder u_a32_14 (.a(stg2_c2_w[14]), .b(stg2_s3_w[ 4]), .ci(stg2_c3_w[ 3]), .s(stg3_s2[14]), .co(stg3_c2[14]));
full_adder u_a32_15 (.a(stg2_c2_w[15]), .b(stg2_s3_w[ 5]), .ci(stg2_c3_w[ 4]), .s(stg3_s2[15]), .co(stg3_c2[15]));
full_adder u_a32_16 (.a(stg2_c2_w[16]), .b(stg2_s3_w[ 6]), .ci(stg2_c3_w[ 5]), .s(stg3_s2[16]), .co(stg3_c2[16]));
full_adder u_a32_17 (.a(stg2_c2_w[17]), .b(stg2_s3_w[ 7]), .ci(stg2_c3_w[ 6]), .s(stg3_s2[17]), .co(stg3_c2[17]));
full_adder u_a32_18 (.a(stg2_c2_w[18]), .b(stg2_s3_w[ 8]), .ci(stg2_c3_w[ 7]), .s(stg3_s2[18]), .co(stg3_c2[18]));
full_adder u_a32_19 (.a(stg2_c2_w[19]), .b(stg2_s3_w[ 9]), .ci(stg2_c3_w[ 8]), .s(stg3_s2[19]), .co(stg3_c2[19]));
full_adder u_a32_20 (.a(stg2_c2_w[20]), .b(stg2_s3_w[10]), .ci(stg2_c3_w[ 9]), .s(stg3_s2[20]), .co(stg3_c2[20]));
full_adder u_a32_21 (.a(stg2_c2_w[21]), .b(stg2_s3_w[11]), .ci(stg2_c3_w[10]), .s(stg3_s2[21]), .co(stg3_c2[21]));
full_adder u_a32_22 (.a(stg2_c2_w[22]), .b(stg2_s3_w[12]), .ci(stg2_c3_w[11]), .s(stg3_s2[22]), .co(stg3_c2[22]));
full_adder u_a32_23 (.a(stg2_c2_w[23]), .b(stg2_s3_w[13]), .ci(stg2_c3_w[12]), .s(stg3_s2[23]), .co(stg3_c2[23]));
full_adder u_a32_24 (.a(stg2_c2_w[24]), .b(stg2_s3_w[14]), .ci(stg2_c3_w[13]), .s(stg3_s2[24]), .co(stg3_c2[24]));
full_adder u_a32_25 (.a(stg2_c2_w[25]), .b(stg2_s3_w[15]), .ci(stg2_c3_w[14]), .s(stg3_s2[25]), .co(stg3_c2[25]));
full_adder u_a32_26 (.a(stg2_c2_w[26]), .b(stg2_s3_w[16]), .ci(stg2_c3_w[15]), .s(stg3_s2[26]), .co(stg3_c2[26]));
full_adder u_a32_27 (.a(stg2_c2_w[27]), .b(stg2_s3_w[17]), .ci(stg2_c3_w[16]), .s(stg3_s2[27]), .co(stg3_c2[27]));
full_adder u_a32_28 (.a(stg2_c2_w[28]), .b(stg2_s3_w[18]), .ci(stg2_c3_w[17]), .s(stg3_s2[28]), .co(stg3_c2[28]));
full_adder u_a32_29 (.a(stg2_c2_w[29]), .b(stg2_s3_w[19]), .ci(stg2_c3_w[18]), .s(stg3_s2[29]), .co(stg3_c2[29]));
full_adder u_a32_30 (.a(stg2_c2_w[30]), .b(stg2_s3_w[20]), .ci(stg2_c3_w[19]), .s(stg3_s2[30]), .co(stg3_c2[30]));
full_adder u_a32_31 (.a(stg2_c2_w[31]), .b(stg2_s3_w[21]), .ci(stg2_c3_w[20]), .s(stg3_s2[31]), .co(stg3_c2[31]));
full_adder u_a32_32 (.a(stg2_c2_w[32]), .b(stg2_s3_w[22]), .ci(stg2_c3_w[21]), .s(stg3_s2[32]), .co(stg3_c2[32]));
full_adder u_a32_33 (.a(stg2_c2_w[33]), .b(stg2_s3_w[23]), .ci(stg2_c3_w[22]), .s(stg3_s2[33]), .co(stg3_c2[33]));
full_adder u_a32_34 (.a(stg2_c2_w[34]), .b(stg2_s3_w[24]), .ci(stg2_c3_w[23]), .s(stg3_s2[34]), .co(stg3_c2[34]));
full_adder u_a32_35 (.a(stg2_c2_w[35]), .b(stg2_s3_w[25]), .ci(stg2_c3_w[24]), .s(stg3_s2[35]), .co(stg3_c2[35]));
full_adder u_a32_36 (.a(stg2_c2_w[36]), .b(stg2_s3_w[26]), .ci(stg2_c3_w[25]), .s(stg3_s2[36]), .co(stg3_c2[36]));
full_adder u_a32_37 (.a(stg2_c2_w[37]), .b(stg2_s3_w[27]), .ci(stg2_c3_w[26]), .s(stg3_s2[37]), .co(stg3_c2[37]));
full_adder u_a32_38 (.a(stg2_c2_w[38]), .b(stg2_s3_w[28]), .ci(stg2_c3_w[27]), .s(stg3_s2[38]), .co(stg3_c2[38]));
full_adder u_a32_39 (.a(stg2_c2_w[39]), .b(stg2_s3_w[29]), .ci(stg2_c3_w[28]), .s(stg3_s2[39]), .co(stg3_c2[39]));
full_adder u_a32_40 (.a(stg2_c2_w[40]), .b(stg2_s3_w[30]), .ci(stg2_c3_w[29]), .s(stg3_s2[40]), .co(stg3_c2[40]));
full_adder u_a32_41 (.a(stg2_c2_w[41]), .b(stg2_s3_w[31]), .ci(stg2_c3_w[30]), .s(stg3_s2[41]), .co(stg3_c2[41]));
full_adder u_a32_42 (.a(stg2_c2_w[42]), .b(stg2_s3_w[32]), .ci(stg2_c3_w[31]), .s(stg3_s2[42]), .co(stg3_c2[42]));
full_adder u_a32_43 (.a(stg2_c2_w[43]), .b(stg2_s3_w[33]), .ci(stg2_c3_w[32]), .s(stg3_s2[43]), .co(stg3_c2[43]));
full_adder u_a32_44 (.a(stg2_c2_w[43]), .b(stg2_s3_w[34]), .ci(stg2_c3_w[33]), .s(stg3_s2[44]), .co(stg3_c2[44]));
full_adder u_a32_45 (.a(stg2_c2_w[43]), .b(stg2_s3_w[35]), .ci(stg2_c3_w[34]), .s(stg3_s2[45]), .co(stg3_c2[45]));
full_adder u_a32_46 (.a(stg2_c2_w[43]), .b(stg2_s3_w[36]), .ci(stg2_c3_w[35]), .s(stg3_s2[46]), .co(stg3_c2[46]));
full_adder u_a32_47 (.a(stg2_c2_w[43]), .b(stg2_s3_w[37]), .ci(stg2_c3_w[36]), .s(stg3_s2[47]), .co(stg3_c2[47]));
full_adder u_a32_48 (.a(stg2_c2_w[43]), .b(stg2_s3_w[38]), .ci(stg2_c3_w[37]), .s(stg3_s2[48]), .co(stg3_c2[48]));
full_adder u_a32_49 (.a(stg2_c2_w[43]), .b(stg2_s3_w[39]), .ci(stg2_c3_w[38]), .s(stg3_s2[49]), .co(stg3_c2[49]));
full_adder u_a32_50 (.a(stg2_c2_w[43]), .b(stg2_s3_w[40]), .ci(stg2_c3_w[39]), .s(stg3_s2[50]), .co(stg3_c2[50]));
full_adder u_a32_51 (.a(stg2_c2_w[43]), .b(stg2_s3_w[41]), .ci(stg2_c3_w[40]), .s(stg3_s2[51]), .co(stg3_c2[51]));
full_adder u_a32_52 (.a(stg2_c2_w[43]), .b(stg2_s3_w[42]), .ci(stg2_c3_w[41]), .s(stg3_s2[52]), .co(stg3_c2[52]));
full_adder u_a32_53 (.a(stg2_c2_w[43]), .b(stg2_s3_w[43]), .ci(stg2_c3_w[42]), .s(stg3_s2[53]), .co(stg3_c2[53]));
full_adder u_a32_54 (.a(stg2_c2_w[43]), .b(stg2_s3_w[43]), .ci(stg2_c3_w[43]), .s(stg3_s2[54]), .co(stg3_c2[54]));

wire [50:0] stg3_s1_w, stg3_c1_w;
wire [54:0] stg3_s2_w, stg3_c2_w;
wire [38:0] stg2_s4_w2;
wire [37:0] stg2_c4_w2;
//================ if necessary, pipeline stg3_s* and stg3_c* here for timing ================
//in the next stage
`ifdef MULT32_PIPE_STG3
reg [50:0] stg3_s1_ff, stg3_c1_ff;
reg [54:0] stg3_s2_ff, stg3_c2_ff;
reg [38:0] stg2_s4_ff2;
reg [37:0] stg2_c4_ff2;

always @(posedge clk or negedge rstn) begin
  if(~rstn) begin
    stg3_s1_ff  <= 51'b0;
    stg3_c1_ff  <= 51'b0;
    stg3_s2_ff  <= 55'b0;
    stg3_c2_ff  <= 55'b0;
    stg2_s4_ff2 <= 39'b0;
    stg2_c4_ff2 <= 38'b0;
  end
  else begin
    stg3_s1_ff  <= stg3_s1         ;
    stg3_c1_ff  <= stg3_c1         ;
    stg3_s2_ff  <= stg3_s2         ;
    stg3_c2_ff  <= stg3_c2         ;
    stg2_s4_ff2 <= stg2_s4_w[38:0] ;
    stg2_c4_ff2 <= stg2_c4_w[37:0] ;
  end
end
assign stg3_s1_w  = stg3_s1_ff ;
assign stg3_c1_w  = stg3_c1_ff ;
assign stg3_s2_w  = stg3_s2_ff ;
assign stg3_c2_w  = stg3_c2_ff ;
assign stg2_s4_w2 = stg2_s4_ff2;
assign stg2_c4_w2 = stg2_c4_ff2;
`else
assign stg3_s1_w  = stg3_s1;
assign stg3_c1_w  = stg3_c1;
assign stg3_s2_w  = stg3_s2;
assign stg3_c2_w  = stg3_c2;
assign stg2_s4_w2 = stg2_s4_w[38:0];
assign stg2_c4_w2 = stg2_c4_w[37:0];
`endif

//================ forth stage ===============
wire [62:0] stg4_s1, stg4_c1;
wire [54:0] stg4_s2, stg4_c2;

//yellow
assign stg4_s1[0] = stg3_s1_w[0];
assign stg4_c1[0] = 1'b0;
half_adder u_a41_1  (.a(stg3_s1_w[ 1]), .b(stg3_c1_w[ 0]),                     .s(stg4_s1[ 1]), .co(stg4_c1[ 1]));
half_adder u_a41_2  (.a(stg3_s1_w[ 2]), .b(stg3_c1_w[ 1]),                     .s(stg4_s1[ 2]), .co(stg4_c1[ 2]));
half_adder u_a41_3  (.a(stg3_s1_w[ 3]), .b(stg3_c1_w[ 2]),                     .s(stg4_s1[ 4]), .co(stg4_c1[ 4]));
half_adder u_a41_5  (.a(stg3_s1_w[ 5]), .b(stg3_c1_w[ 4]),                     .s(stg4_s1[ 5]), .co(stg4_c1[ 5]));
half_adder u_a41_6  (.a(stg3_s1_w[ 6]), .b(stg3_c1_w[ 5]),                     .s(stg4_s1[ 6]), .co(stg4_c1[ 6]));
half_adder u_a41_7  (.a(stg3_s1_w[ 7]), .b(stg3_c1_w[ 6]),                     .s(stg4_s1[ 7]), .co(stg4_c1[ 7]));
full_adder u_a41_8  (.a(stg3_s1_w[ 8]), .b(stg3_c1_w[ 7]), .ci(stg3_s2_w[ 0]), .s(stg4_s1[ 8]), .co(stg4_c1[ 8]));
full_adder u_a41_9  (.a(stg3_s1_w[ 9]), .b(stg3_c1_w[ 8]), .ci(stg3_s2_w[ 1]), .s(stg4_s1[ 9]), .co(stg4_c1[ 9]));
full_adder u_a41_10 (.a(stg3_s1_w[10]), .b(stg3_c1_w[ 9]), .ci(stg3_s2_w[ 2]), .s(stg4_s1[10]), .co(stg4_c1[10]));
full_adder u_a41_11 (.a(stg3_s1_w[11]), .b(stg3_c1_w[10]), .ci(stg3_s2_w[ 3]), .s(stg4_s1[11]), .co(stg4_c1[11]));
full_adder u_a41_12 (.a(stg3_s1_w[12]), .b(stg3_c1_w[11]), .ci(stg3_s2_w[ 4]), .s(stg4_s1[12]), .co(stg4_c1[12]));
full_adder u_a41_13 (.a(stg3_s1_w[13]), .b(stg3_c1_w[12]), .ci(stg3_s2_w[ 5]), .s(stg4_s1[13]), .co(stg4_c1[13]));
full_adder u_a41_14 (.a(stg3_s1_w[14]), .b(stg3_c1_w[13]), .ci(stg3_s2_w[ 6]), .s(stg4_s1[14]), .co(stg4_c1[14]));
full_adder u_a41_15 (.a(stg3_s1_w[15]), .b(stg3_c1_w[14]), .ci(stg3_s2_w[ 7]), .s(stg4_s1[15]), .co(stg4_c1[15]));
full_adder u_a41_16 (.a(stg3_s1_w[16]), .b(stg3_c1_w[15]), .ci(stg3_s2_w[ 8]), .s(stg4_s1[16]), .co(stg4_c1[16]));
full_adder u_a41_17 (.a(stg3_s1_w[17]), .b(stg3_c1_w[16]), .ci(stg3_s2_w[ 9]), .s(stg4_s1[17]), .co(stg4_c1[17]));
full_adder u_a41_18 (.a(stg3_s1_w[18]), .b(stg3_c1_w[17]), .ci(stg3_s2_w[10]), .s(stg4_s1[18]), .co(stg4_c1[18]));
full_adder u_a41_19 (.a(stg3_s1_w[19]), .b(stg3_c1_w[18]), .ci(stg3_s2_w[11]), .s(stg4_s1[19]), .co(stg4_c1[19]));
full_adder u_a41_20 (.a(stg3_s1_w[20]), .b(stg3_c1_w[19]), .ci(stg3_s2_w[12]), .s(stg4_s1[20]), .co(stg4_c1[20]));
full_adder u_a41_21 (.a(stg3_s1_w[21]), .b(stg3_c1_w[20]), .ci(stg3_s2_w[13]), .s(stg4_s1[21]), .co(stg4_c1[21]));
full_adder u_a41_22 (.a(stg3_s1_w[22]), .b(stg3_c1_w[21]), .ci(stg3_s2_w[14]), .s(stg4_s1[22]), .co(stg4_c1[22]));
full_adder u_a41_23 (.a(stg3_s1_w[23]), .b(stg3_c1_w[22]), .ci(stg3_s2_w[15]), .s(stg4_s1[23]), .co(stg4_c1[23]));
full_adder u_a41_24 (.a(stg3_s1_w[24]), .b(stg3_c1_w[23]), .ci(stg3_s2_w[16]), .s(stg4_s1[24]), .co(stg4_c1[24]));
full_adder u_a41_25 (.a(stg3_s1_w[25]), .b(stg3_c1_w[24]), .ci(stg3_s2_w[17]), .s(stg4_s1[25]), .co(stg4_c1[25]));
full_adder u_a41_26 (.a(stg3_s1_w[26]), .b(stg3_c1_w[25]), .ci(stg3_s2_w[18]), .s(stg4_s1[26]), .co(stg4_c1[26]));
full_adder u_a41_27 (.a(stg3_s1_w[27]), .b(stg3_c1_w[26]), .ci(stg3_s2_w[19]), .s(stg4_s1[27]), .co(stg4_c1[27]));
full_adder u_a41_28 (.a(stg3_s1_w[28]), .b(stg3_c1_w[27]), .ci(stg3_s2_w[20]), .s(stg4_s1[28]), .co(stg4_c1[28]));
full_adder u_a41_29 (.a(stg3_s1_w[29]), .b(stg3_c1_w[28]), .ci(stg3_s2_w[21]), .s(stg4_s1[29]), .co(stg4_c1[29]));
full_adder u_a41_30 (.a(stg3_s1_w[30]), .b(stg3_c1_w[29]), .ci(stg3_s2_w[22]), .s(stg4_s1[30]), .co(stg4_c1[30]));
full_adder u_a41_31 (.a(stg3_s1_w[31]), .b(stg3_c1_w[30]), .ci(stg3_s2_w[23]), .s(stg4_s1[31]), .co(stg4_c1[31]));
full_adder u_a41_32 (.a(stg3_s1_w[32]), .b(stg3_c1_w[31]), .ci(stg3_s2_w[24]), .s(stg4_s1[32]), .co(stg4_c1[32]));
full_adder u_a41_33 (.a(stg3_s1_w[33]), .b(stg3_c1_w[32]), .ci(stg3_s2_w[25]), .s(stg4_s1[33]), .co(stg4_c1[33]));
full_adder u_a41_34 (.a(stg3_s1_w[34]), .b(stg3_c1_w[33]), .ci(stg3_s2_w[26]), .s(stg4_s1[34]), .co(stg4_c1[34]));
full_adder u_a41_35 (.a(stg3_s1_w[35]), .b(stg3_c1_w[34]), .ci(stg3_s2_w[27]), .s(stg4_s1[35]), .co(stg4_c1[35]));
full_adder u_a41_36 (.a(stg3_s1_w[36]), .b(stg3_c1_w[35]), .ci(stg3_s2_w[28]), .s(stg4_s1[36]), .co(stg4_c1[36]));
full_adder u_a41_37 (.a(stg3_s1_w[37]), .b(stg3_c1_w[36]), .ci(stg3_s2_w[29]), .s(stg4_s1[37]), .co(stg4_c1[37]));
full_adder u_a41_38 (.a(stg3_s1_w[38]), .b(stg3_c1_w[37]), .ci(stg3_s2_w[30]), .s(stg4_s1[38]), .co(stg4_c1[38]));
full_adder u_a41_39 (.a(stg3_s1_w[39]), .b(stg3_c1_w[38]), .ci(stg3_s2_w[31]), .s(stg4_s1[39]), .co(stg4_c1[39]));
full_adder u_a41_40 (.a(stg3_s1_w[40]), .b(stg3_c1_w[39]), .ci(stg3_s2_w[32]), .s(stg4_s1[40]), .co(stg4_c1[40]));
full_adder u_a41_41 (.a(stg3_s1_w[41]), .b(stg3_c1_w[40]), .ci(stg3_s2_w[33]), .s(stg4_s1[41]), .co(stg4_c1[41]));
full_adder u_a41_42 (.a(stg3_s1_w[42]), .b(stg3_c1_w[41]), .ci(stg3_s2_w[34]), .s(stg4_s1[42]), .co(stg4_c1[42]));
full_adder u_a41_43 (.a(stg3_s1_w[43]), .b(stg3_c1_w[42]), .ci(stg3_s2_w[35]), .s(stg4_s1[43]), .co(stg4_c1[43]));
full_adder u_a41_44 (.a(stg3_s1_w[44]), .b(stg3_c1_w[43]), .ci(stg3_s2_w[36]), .s(stg4_s1[44]), .co(stg4_c1[44]));
full_adder u_a41_45 (.a(stg3_s1_w[45]), .b(stg3_c1_w[44]), .ci(stg3_s2_w[37]), .s(stg4_s1[45]), .co(stg4_c1[45]));
full_adder u_a41_46 (.a(stg3_s1_w[46]), .b(stg3_c1_w[45]), .ci(stg3_s2_w[38]), .s(stg4_s1[46]), .co(stg4_c1[46]));
full_adder u_a41_47 (.a(stg3_s1_w[47]), .b(stg3_c1_w[46]), .ci(stg3_s2_w[39]), .s(stg4_s1[47]), .co(stg4_c1[47]));
full_adder u_a41_48 (.a(stg3_s1_w[48]), .b(stg3_c1_w[47]), .ci(stg3_s2_w[40]), .s(stg4_s1[48]), .co(stg4_c1[48]));
full_adder u_a41_49 (.a(stg3_s1_w[49]), .b(stg3_c1_w[48]), .ci(stg3_s2_w[41]), .s(stg4_s1[49]), .co(stg4_c1[49]));
full_adder u_a41_50 (.a(stg3_s1_w[50]), .b(stg3_c1_w[49]), .ci(stg3_s2_w[42]), .s(stg4_s1[50]), .co(stg4_c1[50]));
full_adder u_a41_51 (.a(stg3_s1_w[50]), .b(stg3_c1_w[50]), .ci(stg3_s2_w[43]), .s(stg4_s1[51]), .co(stg4_c1[51]));
full_adder u_a41_52 (.a(stg3_s1_w[50]), .b(stg3_c1_w[50]), .ci(stg3_s2_w[44]), .s(stg4_s1[52]), .co(stg4_c1[52]));
full_adder u_a41_53 (.a(stg3_s1_w[50]), .b(stg3_c1_w[50]), .ci(stg3_s2_w[45]), .s(stg4_s1[53]), .co(stg4_c1[53]));
full_adder u_a41_54 (.a(stg3_s1_w[50]), .b(stg3_c1_w[50]), .ci(stg3_s2_w[46]), .s(stg4_s1[54]), .co(stg4_c1[54]));
full_adder u_a41_55 (.a(stg3_s1_w[50]), .b(stg3_c1_w[50]), .ci(stg3_s2_w[47]), .s(stg4_s1[55]), .co(stg4_c1[55]));
full_adder u_a41_56 (.a(stg3_s1_w[50]), .b(stg3_c1_w[50]), .ci(stg3_s2_w[48]), .s(stg4_s1[56]), .co(stg4_c1[56]));
full_adder u_a41_57 (.a(stg3_s1_w[50]), .b(stg3_c1_w[50]), .ci(stg3_s2_w[49]), .s(stg4_s1[57]), .co(stg4_c1[57]));
full_adder u_a41_58 (.a(stg3_s1_w[50]), .b(stg3_c1_w[50]), .ci(stg3_s2_w[50]), .s(stg4_s1[58]), .co(stg4_c1[58]));
full_adder u_a41_59 (.a(stg3_s1_w[50]), .b(stg3_c1_w[50]), .ci(stg3_s2_w[51]), .s(stg4_s1[59]), .co(stg4_c1[59]));
full_adder u_a41_60 (.a(stg3_s1_w[50]), .b(stg3_c1_w[50]), .ci(stg3_s2_w[52]), .s(stg4_s1[60]), .co(stg4_c1[60]));
full_adder u_a41_61 (.a(stg3_s1_w[50]), .b(stg3_c1_w[50]), .ci(stg3_s2_w[53]), .s(stg4_s1[61]), .co(stg4_c1[61]));
full_adder u_a41_62 (.a(stg3_s1_w[50]), .b(stg3_c1_w[50]), .ci(stg3_s2_w[54]), .s(stg4_s1[62]), .co(stg4_c1[62]));

//green
assign stg4_s2[15:0] = stg3_c2_w[15:0];
assign stg4_c2[15:0] = 16'b0;
half_adder u_a42_16 (.a(stg3_c2_w[16]), .b(stg2_s4_w2[ 0]),                      .s(stg4_s2[16]), .co(stg4_c2[16]));
full_adder u_a42_17 (.a(stg3_c2_w[17]), .b(stg2_s4_w2[ 1]), .ci(stg2_c4_w2[ 0]), .s(stg4_s2[17]), .co(stg4_c2[17]));
full_adder u_a42_18 (.a(stg3_c2_w[18]), .b(stg2_s4_w2[ 2]), .ci(stg2_c4_w2[ 1]), .s(stg4_s2[18]), .co(stg4_c2[18]));
full_adder u_a42_19 (.a(stg3_c2_w[19]), .b(stg2_s4_w2[ 3]), .ci(stg2_c4_w2[ 2]), .s(stg4_s2[19]), .co(stg4_c2[19]));
full_adder u_a42_20 (.a(stg3_c2_w[20]), .b(stg2_s4_w2[ 4]), .ci(stg2_c4_w2[ 3]), .s(stg4_s2[20]), .co(stg4_c2[20]));
full_adder u_a42_21 (.a(stg3_c2_w[21]), .b(stg2_s4_w2[ 5]), .ci(stg2_c4_w2[ 4]), .s(stg4_s2[21]), .co(stg4_c2[21]));
full_adder u_a42_22 (.a(stg3_c2_w[22]), .b(stg2_s4_w2[ 6]), .ci(stg2_c4_w2[ 5]), .s(stg4_s2[22]), .co(stg4_c2[22]));
full_adder u_a42_23 (.a(stg3_c2_w[23]), .b(stg2_s4_w2[ 7]), .ci(stg2_c4_w2[ 6]), .s(stg4_s2[23]), .co(stg4_c2[23]));
full_adder u_a42_24 (.a(stg3_c2_w[24]), .b(stg2_s4_w2[ 8]), .ci(stg2_c4_w2[ 7]), .s(stg4_s2[24]), .co(stg4_c2[24]));
full_adder u_a42_25 (.a(stg3_c2_w[25]), .b(stg2_s4_w2[ 9]), .ci(stg2_c4_w2[ 8]), .s(stg4_s2[25]), .co(stg4_c2[25]));
full_adder u_a42_26 (.a(stg3_c2_w[26]), .b(stg2_s4_w2[10]), .ci(stg2_c4_w2[ 9]), .s(stg4_s2[26]), .co(stg4_c2[26]));
full_adder u_a42_27 (.a(stg3_c2_w[27]), .b(stg2_s4_w2[11]), .ci(stg2_c4_w2[10]), .s(stg4_s2[27]), .co(stg4_c2[27]));
full_adder u_a42_28 (.a(stg3_c2_w[28]), .b(stg2_s4_w2[12]), .ci(stg2_c4_w2[11]), .s(stg4_s2[28]), .co(stg4_c2[28]));
full_adder u_a42_29 (.a(stg3_c2_w[29]), .b(stg2_s4_w2[13]), .ci(stg2_c4_w2[12]), .s(stg4_s2[29]), .co(stg4_c2[29]));
full_adder u_a42_30 (.a(stg3_c2_w[30]), .b(stg2_s4_w2[14]), .ci(stg2_c4_w2[13]), .s(stg4_s2[30]), .co(stg4_c2[30]));
full_adder u_a42_31 (.a(stg3_c2_w[31]), .b(stg2_s4_w2[15]), .ci(stg2_c4_w2[14]), .s(stg4_s2[31]), .co(stg4_c2[31]));
full_adder u_a42_32 (.a(stg3_c2_w[32]), .b(stg2_s4_w2[16]), .ci(stg2_c4_w2[15]), .s(stg4_s2[32]), .co(stg4_c2[32]));
full_adder u_a42_33 (.a(stg3_c2_w[33]), .b(stg2_s4_w2[17]), .ci(stg2_c4_w2[16]), .s(stg4_s2[33]), .co(stg4_c2[33]));
full_adder u_a42_34 (.a(stg3_c2_w[34]), .b(stg2_s4_w2[18]), .ci(stg2_c4_w2[17]), .s(stg4_s2[34]), .co(stg4_c2[34]));
full_adder u_a42_35 (.a(stg3_c2_w[35]), .b(stg2_s4_w2[19]), .ci(stg2_c4_w2[18]), .s(stg4_s2[35]), .co(stg4_c2[35]));
full_adder u_a42_36 (.a(stg3_c2_w[36]), .b(stg2_s4_w2[20]), .ci(stg2_c4_w2[19]), .s(stg4_s2[36]), .co(stg4_c2[36]));
full_adder u_a42_37 (.a(stg3_c2_w[37]), .b(stg2_s4_w2[21]), .ci(stg2_c4_w2[20]), .s(stg4_s2[37]), .co(stg4_c2[37]));
full_adder u_a42_38 (.a(stg3_c2_w[38]), .b(stg2_s4_w2[22]), .ci(stg2_c4_w2[21]), .s(stg4_s2[38]), .co(stg4_c2[38]));
full_adder u_a42_39 (.a(stg3_c2_w[39]), .b(stg2_s4_w2[23]), .ci(stg2_c4_w2[22]), .s(stg4_s2[39]), .co(stg4_c2[39]));
full_adder u_a42_40 (.a(stg3_c2_w[40]), .b(stg2_s4_w2[24]), .ci(stg2_c4_w2[23]), .s(stg4_s2[40]), .co(stg4_c2[40]));
full_adder u_a42_41 (.a(stg3_c2_w[41]), .b(stg2_s4_w2[25]), .ci(stg2_c4_w2[24]), .s(stg4_s2[41]), .co(stg4_c2[41]));
full_adder u_a42_42 (.a(stg3_c2_w[42]), .b(stg2_s4_w2[26]), .ci(stg2_c4_w2[25]), .s(stg4_s2[42]), .co(stg4_c2[42]));
full_adder u_a42_43 (.a(stg3_c2_w[43]), .b(stg2_s4_w2[27]), .ci(stg2_c4_w2[26]), .s(stg4_s2[43]), .co(stg4_c2[43]));
full_adder u_a42_44 (.a(stg3_c2_w[44]), .b(stg2_s4_w2[28]), .ci(stg2_c4_w2[27]), .s(stg4_s2[44]), .co(stg4_c2[44]));
full_adder u_a42_45 (.a(stg3_c2_w[45]), .b(stg2_s4_w2[29]), .ci(stg2_c4_w2[28]), .s(stg4_s2[45]), .co(stg4_c2[45]));
full_adder u_a42_46 (.a(stg3_c2_w[46]), .b(stg2_s4_w2[30]), .ci(stg2_c4_w2[29]), .s(stg4_s2[46]), .co(stg4_c2[46]));
full_adder u_a42_47 (.a(stg3_c2_w[47]), .b(stg2_s4_w2[31]), .ci(stg2_c4_w2[30]), .s(stg4_s2[47]), .co(stg4_c2[47]));
full_adder u_a42_48 (.a(stg3_c2_w[48]), .b(stg2_s4_w2[32]), .ci(stg2_c4_w2[31]), .s(stg4_s2[48]), .co(stg4_c2[48]));
full_adder u_a42_49 (.a(stg3_c2_w[49]), .b(stg2_s4_w2[33]), .ci(stg2_c4_w2[32]), .s(stg4_s2[49]), .co(stg4_c2[49]));
full_adder u_a42_50 (.a(stg3_c2_w[50]), .b(stg2_s4_w2[34]), .ci(stg2_c4_w2[33]), .s(stg4_s2[50]), .co(stg4_c2[50]));
full_adder u_a42_51 (.a(stg3_c2_w[51]), .b(stg2_s4_w2[35]), .ci(stg2_c4_w2[34]), .s(stg4_s2[51]), .co(stg4_c2[51]));
full_adder u_a42_52 (.a(stg3_c2_w[52]), .b(stg2_s4_w2[36]), .ci(stg2_c4_w2[35]), .s(stg4_s2[52]), .co(stg4_c2[52]));
full_adder u_a42_53 (.a(stg3_c2_w[53]), .b(stg2_s4_w2[37]), .ci(stg2_c4_w2[36]), .s(stg4_s2[53]), .co(stg4_c2[53]));
full_adder u_a42_54 (.a(stg3_c2_w[54]), .b(stg2_s4_w2[38]), .ci(stg2_c4_w2[37]), .s(stg4_s2[54]), .co(stg4_c2[54]));

wire [62:0] stg4_s1_w, stg4_c1_w;
wire [54:0] stg4_s2_w, stg4_c2_w;
//================ if necessary, pipeline stg4_s* and stg4_c* here for timing ================
`ifdef MULT32_PIPE_STG4
reg [62:0] stg4_s1_ff, stg4_c1_ff;
reg [54:0] stg4_s2_ff, stg4_c2_ff;

always @(posedge clk or negedge rstn) begin
  if(~rstn) begin
    stg4_s1_ff <= 63'b0;
    stg4_c1_ff <= 63'b0;
	  stg4_s2_ff <= 55'b0;
    stg4_c2_ff <= 55'b0;
  end
  else begin
    stg4_s1_ff <= stg4_s1;
    stg4_c1_ff <= stg4_c1;
    stg4_s2_ff <= stg4_s2;
    stg4_c2_ff <= stg4_c2;
  end
end
assign stg4_s1_w = stg4_s1_ff;
assign stg4_c1_w = stg4_c1_ff;
assign stg4_s2_w = stg4_s2_ff;
assign stg4_c2_w = stg4_c2_ff;
`else
assign stg4_s1_w = stg4_s1;
assign stg4_c1_w = stg4_c1;
assign stg4_s2_w = stg4_s2;
assign stg4_c2_w = stg4_c2;
`endif

//================ fifth stage ===============
wire [63:0] stg5_s1, stg5_c1;

//yellow
assign stg5_s1[0] = stg4_s1_w[0];
assign stg5_c1[0] = 1'b0;
half_adder u_a51_1  (.a(stg4_s1_w[ 1]), .b(stg4_c1_w[ 0]),                     .s(stg5_s1[ 1]), .co(stg5_c1[ 1]));
half_adder u_a51_2  (.a(stg4_s1_w[ 2]), .b(stg4_c1_w[ 1]),                     .s(stg5_s1[ 2]), .co(stg5_c1[ 2]));
half_adder u_a51_3  (.a(stg4_s1_w[ 3]), .b(stg4_c1_w[ 2]),                     .s(stg5_s1[ 3]), .co(stg5_c1[ 3]));
half_adder u_a51_4  (.a(stg4_s1_w[ 4]), .b(stg4_c1_w[ 3]),                     .s(stg5_s1[ 4]), .co(stg5_c1[ 4]));
half_adder u_a51_5  (.a(stg4_s1_w[ 5]), .b(stg4_c1_w[ 4]),                     .s(stg5_s1[ 5]), .co(stg5_c1[ 5]));
half_adder u_a51_6  (.a(stg4_s1_w[ 6]), .b(stg4_c1_w[ 5]),                     .s(stg5_s1[ 6]), .co(stg5_c1[ 6]));
half_adder u_a51_7  (.a(stg4_s1_w[ 7]), .b(stg4_c1_w[ 6]),                     .s(stg5_s1[ 7]), .co(stg5_c1[ 7]));
half_adder u_a51_8  (.a(stg4_s1_w[ 8]), .b(stg4_c1_w[ 7]),                     .s(stg5_s1[ 8]), .co(stg5_c1[ 8]));
full_adder u_a51_9  (.a(stg4_s1_w[ 9]), .b(stg4_c1_w[ 8]), .ci(stg4_s2_w[ 0]), .s(stg5_s1[ 9]), .co(stg5_c1[ 9]));
full_adder u_a51_10 (.a(stg4_s1_w[10]), .b(stg4_c1_w[ 9]), .ci(stg4_s2_w[ 1]), .s(stg5_s1[10]), .co(stg5_c1[10]));
full_adder u_a51_11 (.a(stg4_s1_w[11]), .b(stg4_c1_w[10]), .ci(stg4_s2_w[ 2]), .s(stg5_s1[11]), .co(stg5_c1[11]));
full_adder u_a51_12 (.a(stg4_s1_w[12]), .b(stg4_c1_w[11]), .ci(stg4_s2_w[ 3]), .s(stg5_s1[12]), .co(stg5_c1[12]));
full_adder u_a51_13 (.a(stg4_s1_w[13]), .b(stg4_c1_w[12]), .ci(stg4_s2_w[ 4]), .s(stg5_s1[13]), .co(stg5_c1[13]));
full_adder u_a51_14 (.a(stg4_s1_w[14]), .b(stg4_c1_w[13]), .ci(stg4_s2_w[ 5]), .s(stg5_s1[14]), .co(stg5_c1[14]));
full_adder u_a51_15 (.a(stg4_s1_w[15]), .b(stg4_c1_w[14]), .ci(stg4_s2_w[ 6]), .s(stg5_s1[15]), .co(stg5_c1[15]));
full_adder u_a51_16 (.a(stg4_s1_w[16]), .b(stg4_c1_w[15]), .ci(stg4_s2_w[ 7]), .s(stg5_s1[16]), .co(stg5_c1[16]));
full_adder u_a51_17 (.a(stg4_s1_w[17]), .b(stg4_c1_w[16]), .ci(stg4_s2_w[ 8]), .s(stg5_s1[17]), .co(stg5_c1[17]));
full_adder u_a51_18 (.a(stg4_s1_w[18]), .b(stg4_c1_w[17]), .ci(stg4_s2_w[ 9]), .s(stg5_s1[18]), .co(stg5_c1[18]));
full_adder u_a51_19 (.a(stg4_s1_w[19]), .b(stg4_c1_w[18]), .ci(stg4_s2_w[10]), .s(stg5_s1[19]), .co(stg5_c1[19]));
full_adder u_a51_20 (.a(stg4_s1_w[20]), .b(stg4_c1_w[19]), .ci(stg4_s2_w[11]), .s(stg5_s1[20]), .co(stg5_c1[20]));
full_adder u_a51_21 (.a(stg4_s1_w[21]), .b(stg4_c1_w[20]), .ci(stg4_s2_w[12]), .s(stg5_s1[21]), .co(stg5_c1[21]));
full_adder u_a51_22 (.a(stg4_s1_w[22]), .b(stg4_c1_w[21]), .ci(stg4_s2_w[13]), .s(stg5_s1[22]), .co(stg5_c1[22]));
full_adder u_a51_23 (.a(stg4_s1_w[23]), .b(stg4_c1_w[22]), .ci(stg4_s2_w[14]), .s(stg5_s1[23]), .co(stg5_c1[23]));
full_adder u_a51_24 (.a(stg4_s1_w[24]), .b(stg4_c1_w[23]), .ci(stg4_s2_w[15]), .s(stg5_s1[24]), .co(stg5_c1[24]));
full_adder u_a51_25 (.a(stg4_s1_w[25]), .b(stg4_c1_w[24]), .ci(stg4_s2_w[16]), .s(stg5_s1[25]), .co(stg5_c1[25]));
full_adder u_a51_26 (.a(stg4_s1_w[26]), .b(stg4_c1_w[25]), .ci(stg4_s2_w[17]), .s(stg5_s1[26]), .co(stg5_c1[26]));
full_adder u_a51_27 (.a(stg4_s1_w[27]), .b(stg4_c1_w[26]), .ci(stg4_s2_w[18]), .s(stg5_s1[27]), .co(stg5_c1[27]));
full_adder u_a51_28 (.a(stg4_s1_w[28]), .b(stg4_c1_w[27]), .ci(stg4_s2_w[19]), .s(stg5_s1[28]), .co(stg5_c1[28]));
full_adder u_a51_29 (.a(stg4_s1_w[29]), .b(stg4_c1_w[28]), .ci(stg4_s2_w[20]), .s(stg5_s1[29]), .co(stg5_c1[29]));
full_adder u_a51_30 (.a(stg4_s1_w[30]), .b(stg4_c1_w[29]), .ci(stg4_s2_w[21]), .s(stg5_s1[30]), .co(stg5_c1[30]));
full_adder u_a51_31 (.a(stg4_s1_w[31]), .b(stg4_c1_w[30]), .ci(stg4_s2_w[22]), .s(stg5_s1[31]), .co(stg5_c1[31]));
full_adder u_a51_32 (.a(stg4_s1_w[32]), .b(stg4_c1_w[31]), .ci(stg4_s2_w[23]), .s(stg5_s1[32]), .co(stg5_c1[32]));
full_adder u_a51_33 (.a(stg4_s1_w[33]), .b(stg4_c1_w[32]), .ci(stg4_s2_w[24]), .s(stg5_s1[33]), .co(stg5_c1[33]));
full_adder u_a51_34 (.a(stg4_s1_w[34]), .b(stg4_c1_w[33]), .ci(stg4_s2_w[25]), .s(stg5_s1[34]), .co(stg5_c1[34]));
full_adder u_a51_35 (.a(stg4_s1_w[35]), .b(stg4_c1_w[34]), .ci(stg4_s2_w[26]), .s(stg5_s1[35]), .co(stg5_c1[35]));
full_adder u_a51_36 (.a(stg4_s1_w[36]), .b(stg4_c1_w[35]), .ci(stg4_s2_w[27]), .s(stg5_s1[36]), .co(stg5_c1[36]));
full_adder u_a51_37 (.a(stg4_s1_w[37]), .b(stg4_c1_w[36]), .ci(stg4_s2_w[28]), .s(stg5_s1[37]), .co(stg5_c1[37]));
full_adder u_a51_38 (.a(stg4_s1_w[38]), .b(stg4_c1_w[37]), .ci(stg4_s2_w[29]), .s(stg5_s1[38]), .co(stg5_c1[38]));
full_adder u_a51_39 (.a(stg4_s1_w[39]), .b(stg4_c1_w[38]), .ci(stg4_s2_w[30]), .s(stg5_s1[39]), .co(stg5_c1[39]));
full_adder u_a51_40 (.a(stg4_s1_w[40]), .b(stg4_c1_w[39]), .ci(stg4_s2_w[31]), .s(stg5_s1[40]), .co(stg5_c1[40]));
full_adder u_a51_41 (.a(stg4_s1_w[41]), .b(stg4_c1_w[40]), .ci(stg4_s2_w[32]), .s(stg5_s1[41]), .co(stg5_c1[41]));
full_adder u_a51_42 (.a(stg4_s1_w[42]), .b(stg4_c1_w[41]), .ci(stg4_s2_w[33]), .s(stg5_s1[42]), .co(stg5_c1[42]));
full_adder u_a51_43 (.a(stg4_s1_w[43]), .b(stg4_c1_w[42]), .ci(stg4_s2_w[34]), .s(stg5_s1[43]), .co(stg5_c1[43]));
full_adder u_a51_44 (.a(stg4_s1_w[44]), .b(stg4_c1_w[43]), .ci(stg4_s2_w[35]), .s(stg5_s1[44]), .co(stg5_c1[44]));
full_adder u_a51_45 (.a(stg4_s1_w[45]), .b(stg4_c1_w[44]), .ci(stg4_s2_w[36]), .s(stg5_s1[45]), .co(stg5_c1[45]));
full_adder u_a51_46 (.a(stg4_s1_w[46]), .b(stg4_c1_w[45]), .ci(stg4_s2_w[37]), .s(stg5_s1[46]), .co(stg5_c1[46]));
full_adder u_a51_47 (.a(stg4_s1_w[47]), .b(stg4_c1_w[46]), .ci(stg4_s2_w[38]), .s(stg5_s1[47]), .co(stg5_c1[47]));
full_adder u_a51_48 (.a(stg4_s1_w[48]), .b(stg4_c1_w[47]), .ci(stg4_s2_w[39]), .s(stg5_s1[48]), .co(stg5_c1[48]));
full_adder u_a51_49 (.a(stg4_s1_w[49]), .b(stg4_c1_w[48]), .ci(stg4_s2_w[40]), .s(stg5_s1[49]), .co(stg5_c1[49]));
full_adder u_a51_50 (.a(stg4_s1_w[50]), .b(stg4_c1_w[49]), .ci(stg4_s2_w[41]), .s(stg5_s1[50]), .co(stg5_c1[50]));
full_adder u_a51_51 (.a(stg4_s1_w[51]), .b(stg4_c1_w[50]), .ci(stg4_s2_w[42]), .s(stg5_s1[51]), .co(stg5_c1[51]));
full_adder u_a51_52 (.a(stg4_s1_w[52]), .b(stg4_c1_w[51]), .ci(stg4_s2_w[43]), .s(stg5_s1[52]), .co(stg5_c1[52]));
full_adder u_a51_53 (.a(stg4_s1_w[53]), .b(stg4_c1_w[52]), .ci(stg4_s2_w[44]), .s(stg5_s1[53]), .co(stg5_c1[53]));
full_adder u_a51_54 (.a(stg4_s1_w[54]), .b(stg4_c1_w[53]), .ci(stg4_s2_w[45]), .s(stg5_s1[54]), .co(stg5_c1[54]));
full_adder u_a51_55 (.a(stg4_s1_w[55]), .b(stg4_c1_w[54]), .ci(stg4_s2_w[46]), .s(stg5_s1[55]), .co(stg5_c1[55]));
full_adder u_a51_56 (.a(stg4_s1_w[56]), .b(stg4_c1_w[55]), .ci(stg4_s2_w[47]), .s(stg5_s1[56]), .co(stg5_c1[56]));
full_adder u_a51_57 (.a(stg4_s1_w[57]), .b(stg4_c1_w[56]), .ci(stg4_s2_w[48]), .s(stg5_s1[57]), .co(stg5_c1[57]));
full_adder u_a51_58 (.a(stg4_s1_w[58]), .b(stg4_c1_w[57]), .ci(stg4_s2_w[49]), .s(stg5_s1[58]), .co(stg5_c1[58]));
full_adder u_a51_59 (.a(stg4_s1_w[59]), .b(stg4_c1_w[58]), .ci(stg4_s2_w[50]), .s(stg5_s1[59]), .co(stg5_c1[59]));
full_adder u_a51_60 (.a(stg4_s1_w[60]), .b(stg4_c1_w[59]), .ci(stg4_s2_w[51]), .s(stg5_s1[60]), .co(stg5_c1[60]));
full_adder u_a51_61 (.a(stg4_s1_w[61]), .b(stg4_c1_w[60]), .ci(stg4_s2_w[52]), .s(stg5_s1[61]), .co(stg5_c1[61]));
full_adder u_a51_62 (.a(stg4_s1_w[62]), .b(stg4_c1_w[61]), .ci(stg4_s2_w[53]), .s(stg5_s1[62]), .co(stg5_c1[62]));
full_adder u_a51_63 (.a(stg4_s1_w[62]), .b(stg4_c1_w[62]), .ci(stg4_s2_w[54]), .s(stg5_s1[63]), .co(stg5_c1[63]));

wire [63:0] stg5_s1_w, stg5_c1_w;
wire [53:0] stg4_c2_w2;
//================ if necessary, pipeline stg5_s* and stg5_c* here for timing ================
`ifdef MULT32_PIPE_STG4
reg [63:0] stg5_s1_ff, stg5_c1_ff;
reg [53:0] stg4_c2_ff2;

always @(posedge clk or negedge rstn) begin
  if(~rstn) begin
    stg5_s1_ff  <= 64'b0;
    stg5_c1_ff  <= 64'b0;
    stg4_c2_ff2 <= 54'b0;
  end
  else begin
    stg5_s1_ff  <= stg5_s1;
    stg5_c1_ff  <= stg5_c1;
    stg4_c2_ff2 <= stg4_c2_w[53:0] ;
  end
end
assign stg5_s1_w = stg5_s1_ff;
assign stg5_c1_w = stg5_c1_ff;
assign stg4_c2_w2 = stg4_c2_ff2;
`else
assign stg5_s1_w = stg5_s1;
assign stg5_c1_w = stg5_c1;
assign stg4_c2_w2 = stg4_c2_w[53:0];
`endif

//================ sixth stage ===============
wire [63:0] stg6_s1, stg6_c1;

//yellow
assign stg6_s1[0] = stg5_s1_w[0];
assign stg6_c1[0] = 1'b0;
half_adder u_a61_1  (.a(stg5_s1_w[ 1]), .b(stg5_c1_w[ 0]),                      .s(stg6_s1[ 1]), .co(stg6_c1[ 1]));
half_adder u_a61_2  (.a(stg5_s1_w[ 2]), .b(stg5_c1_w[ 1]),                      .s(stg6_s1[ 2]), .co(stg6_c1[ 2]));
half_adder u_a61_3  (.a(stg5_s1_w[ 3]), .b(stg5_c1_w[ 2]),                      .s(stg6_s1[ 3]), .co(stg6_c1[ 3]));
half_adder u_a61_4  (.a(stg5_s1_w[ 4]), .b(stg5_c1_w[ 3]),                      .s(stg6_s1[ 4]), .co(stg6_c1[ 4]));
half_adder u_a61_5  (.a(stg5_s1_w[ 5]), .b(stg5_c1_w[ 4]),                      .s(stg6_s1[ 5]), .co(stg6_c1[ 5]));
half_adder u_a61_6  (.a(stg5_s1_w[ 6]), .b(stg5_c1_w[ 5]),                      .s(stg6_s1[ 6]), .co(stg6_c1[ 6]));
half_adder u_a61_7  (.a(stg5_s1_w[ 7]), .b(stg5_c1_w[ 6]),                      .s(stg6_s1[ 7]), .co(stg6_c1[ 7]));
half_adder u_a61_8  (.a(stg5_s1_w[ 8]), .b(stg5_c1_w[ 7]),                      .s(stg6_s1[ 8]), .co(stg6_c1[ 8]));
half_adder u_a61_9  (.a(stg5_s1_w[ 9]), .b(stg5_c1_w[ 8]),                      .s(stg6_s1[ 9]), .co(stg6_c1[ 9]));
full_adder u_a61_10 (.a(stg5_s1_w[10]), .b(stg5_c1_w[ 9]), .ci(stg4_c2_w2[ 0]), .s(stg6_s1[10]), .co(stg6_c1[10]));
full_adder u_a61_11 (.a(stg5_s1_w[11]), .b(stg5_c1_w[10]), .ci(stg4_c2_w2[ 1]), .s(stg6_s1[11]), .co(stg6_c1[11]));
full_adder u_a61_12 (.a(stg5_s1_w[12]), .b(stg5_c1_w[11]), .ci(stg4_c2_w2[ 2]), .s(stg6_s1[12]), .co(stg6_c1[12]));
full_adder u_a61_13 (.a(stg5_s1_w[13]), .b(stg5_c1_w[12]), .ci(stg4_c2_w2[ 3]), .s(stg6_s1[13]), .co(stg6_c1[13]));
full_adder u_a61_14 (.a(stg5_s1_w[14]), .b(stg5_c1_w[13]), .ci(stg4_c2_w2[ 4]), .s(stg6_s1[14]), .co(stg6_c1[14]));
full_adder u_a61_15 (.a(stg5_s1_w[15]), .b(stg5_c1_w[14]), .ci(stg4_c2_w2[ 5]), .s(stg6_s1[15]), .co(stg6_c1[15]));
full_adder u_a61_16 (.a(stg5_s1_w[16]), .b(stg5_c1_w[15]), .ci(stg4_c2_w2[ 6]), .s(stg6_s1[16]), .co(stg6_c1[16]));
full_adder u_a61_17 (.a(stg5_s1_w[17]), .b(stg5_c1_w[16]), .ci(stg4_c2_w2[ 7]), .s(stg6_s1[17]), .co(stg6_c1[17]));
full_adder u_a61_18 (.a(stg5_s1_w[18]), .b(stg5_c1_w[17]), .ci(stg4_c2_w2[ 8]), .s(stg6_s1[18]), .co(stg6_c1[18]));
full_adder u_a61_19 (.a(stg5_s1_w[19]), .b(stg5_c1_w[18]), .ci(stg4_c2_w2[ 9]), .s(stg6_s1[19]), .co(stg6_c1[19]));
full_adder u_a61_20 (.a(stg5_s1_w[20]), .b(stg5_c1_w[19]), .ci(stg4_c2_w2[10]), .s(stg6_s1[20]), .co(stg6_c1[20]));
full_adder u_a61_21 (.a(stg5_s1_w[21]), .b(stg5_c1_w[20]), .ci(stg4_c2_w2[11]), .s(stg6_s1[21]), .co(stg6_c1[21]));
full_adder u_a61_22 (.a(stg5_s1_w[22]), .b(stg5_c1_w[21]), .ci(stg4_c2_w2[12]), .s(stg6_s1[22]), .co(stg6_c1[22]));
full_adder u_a61_23 (.a(stg5_s1_w[23]), .b(stg5_c1_w[22]), .ci(stg4_c2_w2[13]), .s(stg6_s1[23]), .co(stg6_c1[23]));
full_adder u_a61_24 (.a(stg5_s1_w[24]), .b(stg5_c1_w[23]), .ci(stg4_c2_w2[14]), .s(stg6_s1[24]), .co(stg6_c1[24]));
full_adder u_a61_25 (.a(stg5_s1_w[25]), .b(stg5_c1_w[24]), .ci(stg4_c2_w2[15]), .s(stg6_s1[25]), .co(stg6_c1[25]));
full_adder u_a61_26 (.a(stg5_s1_w[26]), .b(stg5_c1_w[25]), .ci(stg4_c2_w2[16]), .s(stg6_s1[26]), .co(stg6_c1[26]));
full_adder u_a61_27 (.a(stg5_s1_w[27]), .b(stg5_c1_w[26]), .ci(stg4_c2_w2[17]), .s(stg6_s1[27]), .co(stg6_c1[27]));
full_adder u_a61_28 (.a(stg5_s1_w[28]), .b(stg5_c1_w[27]), .ci(stg4_c2_w2[18]), .s(stg6_s1[28]), .co(stg6_c1[28]));
full_adder u_a61_29 (.a(stg5_s1_w[29]), .b(stg5_c1_w[28]), .ci(stg4_c2_w2[19]), .s(stg6_s1[29]), .co(stg6_c1[29]));
full_adder u_a61_30 (.a(stg5_s1_w[30]), .b(stg5_c1_w[29]), .ci(stg4_c2_w2[20]), .s(stg6_s1[30]), .co(stg6_c1[30]));
full_adder u_a61_31 (.a(stg5_s1_w[31]), .b(stg5_c1_w[30]), .ci(stg4_c2_w2[21]), .s(stg6_s1[31]), .co(stg6_c1[31]));
full_adder u_a61_32 (.a(stg5_s1_w[32]), .b(stg5_c1_w[31]), .ci(stg4_c2_w2[22]), .s(stg6_s1[32]), .co(stg6_c1[32]));
full_adder u_a61_33 (.a(stg5_s1_w[33]), .b(stg5_c1_w[32]), .ci(stg4_c2_w2[23]), .s(stg6_s1[33]), .co(stg6_c1[33]));
full_adder u_a61_34 (.a(stg5_s1_w[34]), .b(stg5_c1_w[33]), .ci(stg4_c2_w2[24]), .s(stg6_s1[34]), .co(stg6_c1[34]));
full_adder u_a61_35 (.a(stg5_s1_w[35]), .b(stg5_c1_w[34]), .ci(stg4_c2_w2[25]), .s(stg6_s1[35]), .co(stg6_c1[35]));
full_adder u_a61_36 (.a(stg5_s1_w[36]), .b(stg5_c1_w[35]), .ci(stg4_c2_w2[26]), .s(stg6_s1[36]), .co(stg6_c1[36]));
full_adder u_a61_37 (.a(stg5_s1_w[37]), .b(stg5_c1_w[36]), .ci(stg4_c2_w2[27]), .s(stg6_s1[37]), .co(stg6_c1[37]));
full_adder u_a61_38 (.a(stg5_s1_w[38]), .b(stg5_c1_w[37]), .ci(stg4_c2_w2[28]), .s(stg6_s1[38]), .co(stg6_c1[38]));
full_adder u_a61_39 (.a(stg5_s1_w[39]), .b(stg5_c1_w[38]), .ci(stg4_c2_w2[29]), .s(stg6_s1[39]), .co(stg6_c1[39]));
full_adder u_a61_40 (.a(stg5_s1_w[40]), .b(stg5_c1_w[39]), .ci(stg4_c2_w2[30]), .s(stg6_s1[40]), .co(stg6_c1[40]));
full_adder u_a61_41 (.a(stg5_s1_w[41]), .b(stg5_c1_w[40]), .ci(stg4_c2_w2[31]), .s(stg6_s1[41]), .co(stg6_c1[41]));
full_adder u_a61_42 (.a(stg5_s1_w[42]), .b(stg5_c1_w[41]), .ci(stg4_c2_w2[32]), .s(stg6_s1[42]), .co(stg6_c1[42]));
full_adder u_a61_43 (.a(stg5_s1_w[43]), .b(stg5_c1_w[42]), .ci(stg4_c2_w2[33]), .s(stg6_s1[43]), .co(stg6_c1[43]));
full_adder u_a61_44 (.a(stg5_s1_w[44]), .b(stg5_c1_w[43]), .ci(stg4_c2_w2[34]), .s(stg6_s1[44]), .co(stg6_c1[44]));
full_adder u_a61_45 (.a(stg5_s1_w[45]), .b(stg5_c1_w[44]), .ci(stg4_c2_w2[35]), .s(stg6_s1[45]), .co(stg6_c1[45]));
full_adder u_a61_46 (.a(stg5_s1_w[46]), .b(stg5_c1_w[45]), .ci(stg4_c2_w2[36]), .s(stg6_s1[46]), .co(stg6_c1[46]));
full_adder u_a61_47 (.a(stg5_s1_w[47]), .b(stg5_c1_w[46]), .ci(stg4_c2_w2[37]), .s(stg6_s1[47]), .co(stg6_c1[47]));
full_adder u_a61_48 (.a(stg5_s1_w[48]), .b(stg5_c1_w[47]), .ci(stg4_c2_w2[38]), .s(stg6_s1[48]), .co(stg6_c1[48]));
full_adder u_a61_49 (.a(stg5_s1_w[49]), .b(stg5_c1_w[48]), .ci(stg4_c2_w2[39]), .s(stg6_s1[49]), .co(stg6_c1[49]));
full_adder u_a61_50 (.a(stg5_s1_w[50]), .b(stg5_c1_w[49]), .ci(stg4_c2_w2[40]), .s(stg6_s1[50]), .co(stg6_c1[50]));
full_adder u_a61_51 (.a(stg5_s1_w[51]), .b(stg5_c1_w[50]), .ci(stg4_c2_w2[41]), .s(stg6_s1[51]), .co(stg6_c1[51]));
full_adder u_a61_52 (.a(stg5_s1_w[52]), .b(stg5_c1_w[51]), .ci(stg4_c2_w2[42]), .s(stg6_s1[52]), .co(stg6_c1[52]));
full_adder u_a61_53 (.a(stg5_s1_w[53]), .b(stg5_c1_w[52]), .ci(stg4_c2_w2[43]), .s(stg6_s1[53]), .co(stg6_c1[53]));
full_adder u_a61_54 (.a(stg5_s1_w[54]), .b(stg5_c1_w[53]), .ci(stg4_c2_w2[44]), .s(stg6_s1[54]), .co(stg6_c1[54]));
full_adder u_a61_55 (.a(stg5_s1_w[55]), .b(stg5_c1_w[54]), .ci(stg4_c2_w2[45]), .s(stg6_s1[55]), .co(stg6_c1[55]));
full_adder u_a61_56 (.a(stg5_s1_w[56]), .b(stg5_c1_w[55]), .ci(stg4_c2_w2[46]), .s(stg6_s1[56]), .co(stg6_c1[56]));
full_adder u_a61_57 (.a(stg5_s1_w[57]), .b(stg5_c1_w[56]), .ci(stg4_c2_w2[47]), .s(stg6_s1[57]), .co(stg6_c1[57]));
full_adder u_a61_58 (.a(stg5_s1_w[58]), .b(stg5_c1_w[57]), .ci(stg4_c2_w2[48]), .s(stg6_s1[58]), .co(stg6_c1[58]));
full_adder u_a61_59 (.a(stg5_s1_w[59]), .b(stg5_c1_w[58]), .ci(stg4_c2_w2[49]), .s(stg6_s1[59]), .co(stg6_c1[59]));
full_adder u_a61_60 (.a(stg5_s1_w[60]), .b(stg5_c1_w[59]), .ci(stg4_c2_w2[50]), .s(stg6_s1[60]), .co(stg6_c1[60]));
full_adder u_a61_61 (.a(stg5_s1_w[61]), .b(stg5_c1_w[60]), .ci(stg4_c2_w2[51]), .s(stg6_s1[61]), .co(stg6_c1[61]));
full_adder u_a61_62 (.a(stg5_s1_w[62]), .b(stg5_c1_w[61]), .ci(stg4_c2_w2[52]), .s(stg6_s1[62]), .co(stg6_c1[62]));
full_adder u_a61_63 (.a(stg5_s1_w[63]), .b(stg5_c1_w[62]), .ci(stg4_c2_w2[53]), .s(stg6_s1[63]), .co(stg6_c1[63]));

wire [63:0] stg6_s1_w, stg6_c1_w;
//================ if necessary, pipeline stg6_s* and stg6_c* here for timing ================
`ifdef MULT32_PIPE_STG4
reg [63:0] stg6_s1_ff, stg6_c1_ff;

always @(posedge clk or negedge rstn) begin
  if(~rstn) begin
    stg6_s1_ff <= 64'b0;
    stg6_c1_ff <= 64'b0;
  end
  else begin
    stg6_s1_ff <= stg6_s1;
    stg6_c1_ff <= stg6_c1;
  end
end
assign stg6_s1_w = stg6_s1_ff;
assign stg6_c1_w = stg6_c1_ff;
`else
assign stg6_s1_w = stg6_s1;
assign stg6_c1_w = stg6_c1;
`endif

//================ final stage ===============
wire [63:0] stg7_s;
assign stg7_s = stg6_s1_w + {stg6_c1_w[62:0], 1'b0};  

//================ if necessary, pipeline stg7_s here for timing ================
`ifdef MULT32_PIPE_STG5
reg [63:0] stg7_s_ff;
always @(posedge clk or negedge rstn) begin
  if(~rstn)
    stg7_s_ff <= 64'b0;
  else
    stg7_s_ff <= stg7_s;
end
assign final_p = stg7_s_ff;                    
`else
assign final_p = stg7_s;                      
`endif

endmodule

