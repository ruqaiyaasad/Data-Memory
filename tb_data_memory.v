module tb_data_memory;
 reg i_clk=0,i_we=0; reg [31:0] i_data=0; reg [9:0] i_addr=0;
 wire [31:0] o_data; integer k; reg [31:0] expected;
 data_memory dut(i_clk,i_we,i_data,i_addr,o_data);
 always #5 i_clk=~i_clk;
 task write_word;
  input [9:0] addr; input [31:0] data;
  begin @(negedge i_clk);i_addr=addr;i_data=data;i_we=1;
   @(posedge i_clk);#1;i_we=0; end
 endtask
 task check_word;
  input [9:0] addr; input [31:0] data;
  begin i_addr=addr;#1;
   if(o_data===data) $display("PASS addr=%0d data=%h",addr,o_data);
   else $display("FAIL addr=%0d expected=%h got=%h",addr,data,o_data);
  end
 endtask
 initial begin
  #1;check_word(0,0);
  write_word(10,32'h12345678);check_word(10,32'h12345678);
  // Disabled write must not alter location 10
  @(negedge i_clk);i_addr=10;i_data=32'hFFFFFFFF;i_we=0;
  @(posedge i_clk);#1;check_word(10,32'h12345678);
  write_word(0,32'hA5A5A5A5);check_word(0,32'hA5A5A5A5);
  write_word(1023,32'hDEADBEEF);check_word(1023,32'hDEADBEEF);
  write_word(10,32'hCAFEBABE);check_word(10,32'hCAFEBABE);
  for(k=20;k<25;k=k+1) write_word(k,k*32'd3);
  for(k=20;k<25;k=k+1) check_word(k,k*32'd3);
  $display("Data memory directed tests completed.");
  $finish;
 end
endmodule
