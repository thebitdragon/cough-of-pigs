%����ط���ʱ���ӳ�tau
function    tau=zi_xiangguan(data)
%data:����ʱ������
%tau:�õ���ʱ���ӳ�
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
    if xiangguan<=(1-1/(exp(1)))*init_xiangguan%�����ֵС�ڳ�ʼֵ��1-1/e��ʱ����ʱ��t��Ϊʱ��
        tau=t;
        break
    else
        continue
    end
end
tau