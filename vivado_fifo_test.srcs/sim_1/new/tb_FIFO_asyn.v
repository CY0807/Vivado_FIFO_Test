`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/23 12:57:11
// Design Name: 
// Module Name: tb_FIFO_asyn
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Vivado异步FIFO IP核的时序逻辑测试仿真程序
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_FIFO_asyn(

    );

reg rst, wr_clk, rd_clk, wr_en, rd_en;
reg [3:0] din;
wire [7:0] dout;
wire full, almost_full, empty, almost_empty;
wire valid, wr_rst_busy, rd_rst_busy;
wire [4:0] rd_data_count;
wire [5:0] wr_data_count;

always #10 wr_clk = ~wr_clk;
always #6  rd_clk = ~rd_clk;

always@(posedge wr_clk or posedge rst) 
if(rst)    din <= 4'd0;
else     din <= din + 4'd1;

initial begin
    wr_clk = 1'b1;
    rd_clk = 1'b1;
    rst = 1'b1;
    wr_en = 1'b0;
    rd_en = 1'b0;
    # 30
    
    rst = 1'b0;
    wait((~wr_rst_busy)&(~wr_clk));    
    wr_en = 1'b1;
    # 1500
    
    rd_en = 1'b1;
    # 200
    
    wr_en = 1'b0;
    # 300
    
    $finish;
end

FIFO_2 FIFO_2_asyn (
  .rst(rst),                      // input wire rst
  .wr_clk(wr_clk),                // input wire wr_clk
  .rd_clk(rd_clk),                // input wire rd_clk
  .din(din),                      // input wire [3 : 0] din
  .wr_en(wr_en),                  // input wire wr_en
  .rd_en(rd_en),                  // input wire rd_en
  .dout(dout),                    // output wire [7 : 0] dout
  .full(full),                    // output wire full
  .almost_full(almost_full),      // output wire almost_full
  .empty(empty),                  // output wire empty
  .almost_empty(almost_empty),    // output wire almost_empty
  .valid(valid),                  // output wire valid
  .rd_data_count(rd_data_count),  // output wire [4 : 0] rd_data_count
  .wr_data_count(wr_data_count),  // output wire [5 : 0] wr_data_count
  .wr_rst_busy(wr_rst_busy),      // output wire wr_rst_busy
  .rd_rst_busy(rd_rst_busy)      // output wire rd_rst_busy
);


endmodule
