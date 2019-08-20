% 识别主程序
[yy,fs]= audioread('4_1_24_952.wav');%读入一个待识别的语音数据，判断是否是猪咳嗽声音
N=length(yy);
N=N/20;
%N=N/10;
%y=yy(1:N);
y=yy(N*2+1:N*2+N);
clear yy;
t=1/fs:1/fs:N/fs;
figure,plot(t,y)
xlabel('t/s')
ylabel('Amp')
title('原始信号')
figure,plot(abs(fft(y)))
title('原始信号频谱')
sound(y,fs);


for i=1:5
    signal_shibie{i}=y;
end

fprintf('开始识别\n');
j = 3;% 随机选择一条待识别语音“3”
rec_sph=signal_shibie{j}; %将第三个语音取出来，放到rec_sph里，它就是一个识别函数
fprintf('该语音的真实值为%d\n',j);
rec_fea = mfcc(rec_sph,fs);  % 特征提取
 8  
 -
% 求出当前语音关于各数字hmm的p(X|M)
for i=1:5
  pxsm(i) = viterbi(hmm{i}, rec_fea); 
end
[d,n] = max(pxsm); % 判决，将该最大值对应的序号作为识别结果
fprintf('该语音识别结果为%d\n',n)








