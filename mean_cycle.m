%根据谱密度估计时间序列的平均周期
function T=mean_cycle(data,fs)
%data--时间序列
%fs--采样频率
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
