# Vivado_FIFO_Test
本项目用于测试Vivado提供的FIFO IP核不同配置的时序与逻辑，以供设计参考。

首先新建Vivado工程，配置如下：

![1](https://user-images.githubusercontent.com/95362898/213909600-24b07922-a4d5-44f9-ac8e-815966f764e7.PNG)

## 同步FIFO测试
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













