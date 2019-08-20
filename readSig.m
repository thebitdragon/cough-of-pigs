clear all
close all
clc

%运行主程序

%读取音频数据
[yy,fs]= audioread('4_1_24_952.wav');
N=length(yy);
N=N/20;
%N=N/10;
%y=yy(1:N);
y=yy(N*2+1:N*2+N);
clear yy;
t=1/fs:1/fs:N/fs;
figure,plot(t,y,'r')
xlabel('t/s')
ylabel('Amp')
title('原始信号')
figure,plot(abs(fft(y)),'r')
title('原始信号频谱')
sound(y,fs);

% %添加高斯噪声
% noise=0.01*randn(1,N);
% y1=y+noise;
% figure,plot(t,y1,'r')
% xlabel('t/s')
% ylabel('Amp')
% title('加噪声信号')
% figure,plot(abs(fft(y1)),'r')
% title('加噪声信号频谱')
% sound(y1,fs);
% 
% % eemd(Y,Nstd,NE)
% S1=eemd(y,0.01,10);%eemd处理，子程序见eemd.m
% 
% figure,plot(t,S1(:,4),'r')
% xlabel('t/s')
% ylabel('Amp')
% title('EEMD恢复后的声信号')
% figure,plot(abs(fft(y)),'r')
% title('EEMD恢复后声信号频谱')
% sound(S1(:,4),fs);
% 
% %%%对比图
% figure,
% %时域
% subplot(2,3,1)
% plot(t,y)
% xlabel('t/s')
% ylabel('Amp')
% title('原始时域信号')
% subplot(2,3,2)
% plot(t,y1)
% xlabel('t/s')
% ylabel('Amp')
% title('加噪声时域信号')
% subplot(2,3,3)
% plot(t,S1(:,4))
% xlabel('t/s')
% ylabel('Amp')
% title('EEMD降噪后时域信号')
% 
% %频域
% subplot(2,3,4)
% plot(t,abs(fft(y)))
% title('原始信号频谱图')
% 
% subplot(2,3,5)
% plot(t,abs(fft(y1)))
% title('加噪声信号频谱图')
% 
% subplot(2,3,6)
% plot(t, abs(fft(S1(:,4))))
% title('EEMD降噪信号频谱图')
% 
% %--------------------------------------------------------------ICA--------------------------------------------------%
% %MixedS=[S1(:,2)';S1(:,3)';S1(:,4)'];%将混合矩阵重新排成列并输出
% MixedS=[S1(:,3)';S1(:,4)';S1(:,5)'];%将混合矩阵重新排成列并输出
% %subplot(3,3,1),plot(MixedS(1,:)),title('混合信号1'),%axis([0 100 -4 4])
% %subplot(3,3,2),plot(MixedS(2,:)),title('混合信号2'),%axis([0 100 -4 4])
% %subplot(3,3,3),plot(MixedS(3,:)),title('混合信号3'),%axis([0 100 -4 4])
% MixedS_back=MixedS;
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%% 标准化 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MixedS_mean=zeros(3,1);
% for i=1:3
%         MixedS_mean(i)=mean(MixedS(i,:));%计算均值
% end
% 
% for i=1:3
%     for j=1:size(MixedS,2)
%        MixedS(i,j)=MixedS(i,j)-MixedS_mean(i);%去均值
%     end
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%% 白化 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MixedS_cov=cov(MixedS');%cov为求协方差函数
% [E,D]=eig(MixedS_cov);%对信号矩阵的协方差函数进行特征值分解
% Q=inv(sqrt(D))*E';  %Q为白化矩阵
% MixedS_white=Q*MixedS;%MixedS_white为白化后的信号矩阵
% IsI=cov(MixedS_white');%IsI应为单位阵
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%% FASTICA算法 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% X=MixedS_white;%以下算法将对X进行操作
% [VariableNum,SampleNum]=size(X);
% numoFIC=VariableNum;%在此应用中，独立元个数等于变量个数
% B=zeros(numoFIC,VariableNum);%初始化列向量w的寄存矩阵，B=[b1 b2 ...bd]
% for r=1:numoFIC
%     i=1;maxIterationsNum=100;%设置最大迭代次数（即对于每个独立分量而言迭代均不超过此次数）
%     IterationsNum=0;
%     b=rand(numoFIC,1)-0.5;%随机设置b初值
%     b=b/norm(b);%对b标准化
%     while(i<=maxIterationsNum+1)
%         if(i==maxIterationsNum)%循环结束处理
%             fprintf('\n第%d分量在%d次迭代内并不收敛。',r,maxIterationsNum);
%             break;
%         end
%         b01d=b;
%         a2=1;
%         u=1;
%         t=X'*b;
%         g=t.*exp(-a2*t.^2/2);
%         dg=(1-a2*t.^2).*exp(-a2*t.^2/2);
%         b=((1-u)*t'*g*b+u*X*g)/SampleNum-mean(dg)*b;%核心公式
%         b=b-B*B'*b;%对b正交化
%         b=b/norm(b);%对b标准化
%         if(abs(abs(b'*b01d)-1)<1e-9)%如果收敛，则保存所得向量b
%             B(:,r)=b;
%             break;
%         end
%         i=i+1;
%     end
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%ICA计算的数据复原并构图%%%%%%%%%%%%%%%%%%
% ICAedS=B'*Q*MixedS_back;%计算ICA后的矩阵
% 
% %将混合矩阵重新排列并输出
% %subplot(3,3,4),plot(ICAedS(1,:)),title('ICA解混信号1'),%axis([0 100 -4 4])
% %subplot(3,3,5),plot(ICAedS(2,:)),title('ICA解混信号2'),%axis([0 100 -4 4])
% %subplot(3,3,6),plot(ICAedS(3,:)),title('ICA解混信号3'),%axis([0 100 -4 4])
% 
% %解混信号频谱
% %subplot(3,3,7),plot(abs(fft(ICAedS(1,:)))),title('解混信号1频谱'),%axis([0 100 -4 4])
% %subplot(3,3,8),plot(abs(fft(ICAedS(2,:)))),title('解混信号2频谱'),%axis([0 100 -4 4])
% %subplot(3,3,9),plot(abs(fft(ICAedS(3,:)))),title('解混信号3频谱'),%axis([0 100 -4 4])
% 
% ICAedS(1,:)=ICAedS(1,:)/30;
% sound(ICAedS(1,:),fs);
% 
% t=1/fs:1/fs:N/fs;
% figure,plot(t,ICAedS(1,:))
% xlabel('t/s')
% ylabel('Amp')
% title('ICA盲源分离后时域信号')
% figure,plot(abs(fft(ICAedS(1,:))))
% title('ICA盲源分离后声信号频谱')
% 
% 
% %----------------------------保存原始信号、加噪声信号、EEMD降噪后信号、ICA盲源分离后信号的时频对比图
% figure,
% %时域
% subplot(2,4,1)
% plot(t,y)
% xlabel('t/s')
% ylabel('Amp')
% title('原始时域信号')
% subplot(2,4,2)
% plot(t,y1)
% xlabel('t/s')
% ylabel('Amp')
% title('加噪声时域信号')
% subplot(2,4,3)
% plot(t,S1(:,4))
% xlabel('t/s')
% ylabel('Amp')
% title('EEMD降噪后时域信号')
% subplot(2,4,4)
% plot(t,ICAedS(1,:))
% xlabel('t/s')
% ylabel('Amp')
% title('ICA盲源分离后时域信号')
% 
% %频域
% subplot(2,4,5)
% plot(t,abs(fft(y)))
% title('原始信号频谱图')
% 
% subplot(2,4,6)
% plot(t,abs(fft(y1)))
% title('加噪声信号频谱图')
% 
% subplot(2,4,7)
% plot(t, abs(fft(S1(:,4))))
% title('EEMD降噪信号频谱图')
% 
% subplot(2,4,8)
% plot(t, abs(fft(ICAedS(1,:))))
% title('ICA盲源分离后声信号频谱')
% 
% 
% %-----------------------------------------------------------自相关函数求时延-------------------------------------------------%
% data=ICAedS(1,:);
% clear 'ICAedS';
% tau=zi_xiangguan(data);%得到最终时延值，tau=4
% 
% %绘出自相关函数随着时延的变化曲线
% [tau1 val_xiangguan]=zi_xiangguan_plot(data);
% figure,plot(tau1,val_xiangguan)
% xlabel('时延')
% ylabel('自相关函数')
% title('自相关函数法求得的时延')
% 
% 
% %-----------------------------------------------------------Cao方法求嵌入维数-------------------------------------------------%
% data=data(8820:13230);
% data_test=data;
% save 'data_test'
% %Cao_methond(data',4);%求得嵌入维数m=7
% 
% 
% %-----------------------------------------------------------G-P方法计算关联维数-------------------------------------------------%
% %GP_func(data,N,tau,m);
% tau=4;
% m=7;
% N=length(data)-(m-1)*tau;
% %GP_func(data,N,4,7);


%----------------------------------------------------------小数据量方法计算最大Lyapunov指数-------------------------------------------------%


%----------------------------------------------------------mfcc计算梅尔倒谱系数-------------------------------------------------%
coef_mel_1=mfcc(y,fs);






