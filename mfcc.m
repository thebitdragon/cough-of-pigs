function ccc = mfcc(x,fs)
%对输入的语音序列提取梅尔倒谱系数
%x:输入的语音序列
%fs:输入信号采样率
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


bank=melbankm(24,256,fs,0,0.5,'m');%Mel滤波器的阶数为24
% 归一化mel滤波器组系数
bank=full(bank);
bank=bank/max(bank(:));

% DCT系数,12*24
for k=1:12
  n=0:23;
  dctcoef(k,:)=cos((2*n+1)*k*pi/(2*24));
end

% 归一化倒谱提升窗口
w = 1 + 6 * sin(pi * [1:12] ./ 12);
w = w/max(w);

% 预加重滤波器
xx=double(x);
xx=filter([1 -0.9375],1,xx);

% 语音信号分帧
xx=enframe(xx,256,80);

% 计算每帧的MFCC参数
for i=1:size(xx,1)%size(xx,1)返回xx的维数
  y = xx(i,:);
  s = y' .* hamming(256);%乘窗
  t = abs(fft(s));%fft长度为256
  t = t.^2;%计算能量
  c1=dctcoef * log(bank * t(1:129));% dctcoef为DCT系数，bank归一化mel滤波器组系数
  c2 = c1.*w'; % w为归一化倒谱提升窗口
  m(i,:)=c2';
end


%差分系数
dtm = zeros(size(m));
for i=3:size(m,1)-2
  dtm(i,:) = -2*m(i-2,:) - m(i-1,:) + m(i+1,:) + 2*m(i+2,:);
end
dtm = dtm / 3;

%合并mfcc参数和一阶差分mfcc参数
ccc = [m dtm];
%去除首尾两帧，因为这两帧的一阶差分参数为0
ccc = ccc(3:size(m,1)-2,:);