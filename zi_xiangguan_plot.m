%��������ط�����ӳ��������ֵ������
function    [tau1 val_xiangguan]=zi_xiangguan_plot(data)
%data:����ʱ������
%tau1:�õ���ʱ���ӳ�
%val_xiangguan:�õ��������ֵ
tau1=[];
val_xiangguan=[];
tau_init=1;
init_xiangguan=0;
for i=1:length(data)-1
        init_xiangguan=init_xiangguan+data(i)*data(i+1);
end
init_xiangguan=init_xiangguan/(length(init_xiangguan));%�õ���ʼ�����ֵ

tmax=50;
tau=0
for t=1:tmax
    xiangguan=0;
    for i=1:length(data)-t
               xiangguan=xiangguan+data(i)*data(i+t); 
    end
    xiangguan=xiangguan/(length(xiangguan));%�õ���Ӧt�µ�����غ���ֵ
    tau1(end+1)=t;%����ÿ�ε�ʱ��ֵ
    val_xiangguan(end+1)=xiangguan;%����ÿ�ε������ֵ
end











