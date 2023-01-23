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
![总体](https://user-images.githubusercontent.com/95362898/213973858-359b87c6-010a-43f8-a120-1d58a8205d46.PNG)

### 1.3 时序分析
如下见两放大图：

![a](https://user-images.githubusercontent.com/95362898/213974845-88f4b4de-ad93-4b17-8a86-bb901bd25da7.PNG)
![b](https://user-images.githubusercontent.com/95362898/213974848-82985b10-9e44-439a-83db-9acd335680f3.PNG)

可见data_count的计数是准确且及时的，且对于深度为32的同步FIFO，data_count为4位，其最大值为31，故当FIFO满时count归0。

此外，full和empty是准确的，almost_full和almost_empty信号都在数值差1时有效。

valid信号在输出数据有效时为高，当FIFO空了之后，及时有rd_en信号，valid信号仍然无效。

