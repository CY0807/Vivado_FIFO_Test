# Vivado_FIFO_Test
本项目用于测试Vivado提供的FIFO IP核不同配置的时序与逻辑，以供设计参考。

首先新建Vivado工程，配置如下：

![1](https://user-images.githubusercontent.com/95362898/213909600-24b07922-a4d5-44f9-ac8e-815966f764e7.PNG)

## 1 同步FIFO测试
### 1.1 基本设计
例化同步FIFO IP核，参数如下图所示，输入输出使用同一时钟，位宽为4，深度32。

![1](https://user-images.githubusercontent.com/95362898/213972142-3bb5641a-9d14-4490-89db-9f9e941af311.PNG)

仿真测试代码见tb_FIFO_syn.v，其中核心代码如下：

````
initial begin
    rst = 1'b1;
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
````

### 1.2 整体仿真时序
![总体](https://user-images.githubusercontent.com/95362898/213973858-359b87c6-010a-43f8-a120-1d58a8205d46.PNG "整体仿真时序图")

### 1.3 时序分析
如下见两放大图：

![a](https://user-images.githubusercontent.com/95362898/213974845-88f4b4de-ad93-4b17-8a86-bb901bd25da7.PNG)
![b](https://user-images.githubusercontent.com/95362898/213974848-82985b10-9e44-439a-83db-9acd335680f3.PNG)

从仿真波形可以看出：

1、data_count的计数是准确且及时的，且对于深度为32的同步FIFO，data_count为4位，其最大值为31，故当FIFO满时count归0。

2、full和empty是准确的，almost_full和almost_empty信号都在数值差1时有效。

3、valid信号在输出数据有效时为高，当FIFO空了之后，即使有rd_en信号，valid信号仍然无效。

## 2 异步FIFO测试
### 2.1 基本设计
如下见异步FIFO IP核的配置参数：写位宽4， 深度63；读位宽8，深度31

在仿真中，写时钟为20ns，读时钟为12ns

![1](https://user-images.githubusercontent.com/95362898/214329125-7f75f219-199c-4870-95be-f4fe1752110b.PNG)

仿真代码见tb_FIFO_asyn.v，核心部分如下所示：

````
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
````

FIFO IP核的例化模板如下
````
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
````
其中从官方给的说明中可知：






