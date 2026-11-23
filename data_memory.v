module data_memory(
 input wire i_clk,input wire i_we,input wire [31:0] i_data,
 input wire [9:0] i_addr,output wire [31:0] o_data
);
 reg [31:0] mem[0:1023]; integer i;
 initial begin
  for(i=0;i<1024;i=i+1) mem[i]=32'b0;
 end
 always @(posedge i_clk) begin
  if(i_we) mem[i_addr]<=i_data;
 end
 assign o_data=mem[i_addr];
endmodule
