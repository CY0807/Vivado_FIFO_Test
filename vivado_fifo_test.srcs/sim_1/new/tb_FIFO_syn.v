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
// Description: Vivado同步FIFO IP核的时序逻辑测试仿真程序
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_FIFO_syn(

    );

reg clk, rst;
reg [3:0] din;
wire [3:0] dout;
reg wr_en, rd_en;
wire full, almost_full, empty, almost_empty, valid;
wire [4:0] data_count;

always #10 clk = ~clk;

always@(posedge clk or posedge rst) begin
    if(rst) din <= 4'd0;
    else din <= din + 4'd1;
end

initial begin
    clk = 1'b1;
    rst = 1'b1;
    din = 4'd0;
    wr_en = 1'b0;
    rd_en = 1'b0;
    
    # 1010
    rst = 1'b0;
    wr_en = 1'b1;
    # 10
    
    # 700
    rd_en = 1'b1;
    
    # 300
    wr_en = 1'b0;
    
    # 800
    $finish;
end

FIFO_1 FIFO_1_syn (
  .clk(clk),                    // input wire clk
  .srst(rst),                  // input wire srst
  .din(din),                    // input wire [3 : 0] din
  .wr_en(wr_en),                // input wire wr_en
  .rd_en(rd_en),                // input wire rd_en
  .dout(dout),                  // output wire [3 : 0] dout
  .full(full),                  // output wire full
  .almost_full(almost_full),    // output wire almost_full
  .empty(empty),                // output wire empty
  .almost_empty(almost_empty),  // output wire almost_empty
  .valid(valid),                // output wire valid
  .data_count(data_count)      // output wire [5 : 0] data_count
);




endmodule
