%自相关法求时间延迟tau
function    tau=zi_xiangguan(data)
%data:输入时间序列
%tau:得到的时间延迟
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
    if xiangguan<=(1-1/(exp(1)))*init_xiangguan%当相关值小于初始值的1-1/e倍时，此时的t即为时延
        tau=t;
        break
    else
        continue
    end
end
tau