%�������ܶȹ���ʱ�����е�ƽ������
function T=mean_cycle(data,fs)
%data--ʱ������
%fs--����Ƶ��
y = fft(data);
N=length(y);
y(1)=[];
power_init=log(real(y).^2+imag(y).^2);
power=power_init(1:length(power_init)/2);
ny=1/2;
f=(0:N/2)'*fs/N;
index=find(power==max(power));
f_temp=f(index);
T=1/f_temp;
