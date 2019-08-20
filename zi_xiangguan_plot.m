%利用自相关法绘出延迟与自相关值的曲线
function    [tau1 val_xiangguan]=zi_xiangguan_plot(data)
%data:输入时间序列
%tau1:得到的时间延迟
%val_xiangguan:得到的自相关值
tau1=[];
val_xiangguan=[];
tau_init=1;
init_xiangguan=0;
for i=1:length(data)-1
        init_xiangguan=init_xiangguan+data(i)*data(i+1);
end
init_xiangguan=init_xiangguan/(length(init_xiangguan));%得到初始自相关值

tmax=50;
tau=0
for t=1:tmax
    xiangguan=0;
    for i=1:length(data)-t
               xiangguan=xiangguan+data(i)*data(i+t); 
    end
    xiangguan=xiangguan/(length(xiangguan));%得到对应t下的自相关函数值
    tau1(end+1)=t;%保存每次的时延值
    val_xiangguan(end+1)=xiangguan;%保存每次的自相关值
end











