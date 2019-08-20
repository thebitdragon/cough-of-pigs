clear all
close all
clc

%训练主程序
%读取音频数据，绘制了原始信号的时域图与频谱图，发出了猪咳嗽的声音
[yy,fs]= audioread('4_1_24_952.wav');
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


for i=1:5%24-26选了五个猪咳嗽声音来作为训练集
    tdata{i}=y;%tdate就是五个音频的数据
end

N = 4;   % hmm的状态数
M = [3,3,3,3]; % 每个状态对应的混合模型成分数，表示每个状态所占的比例

for i = 1:length(tdata)  % 数字的循环，循环5个猪咳嗽声音
    fprintf('\n计算数字%d的mfcc特征参数\n',i);   %训练首先得出猪咳嗽声的梅尔倒谱系数的特征 
    obs(i).sph = tdata{i};  % 数字i的第k个语音
    obs(i).fea = mfcc(obs(i).sph,fs);  % 对语音提取mfcc特征参数
     
    fprintf('\n训练数字%d的hmm\n',i);
    hmm_temp=inithmm(obs,N,M); %初始化hmm模型
    hmm{i}=baum_welch(hmm_temp,obs); %迭代更新hmm的各参数
end
fprintf('\n训练完成！\n');










































