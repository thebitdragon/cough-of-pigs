clear all
close all
clc

%����������

%��ȡ��Ƶ����
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
title('ԭʼ�ź�')
figure,plot(abs(fft(y)),'r')
title('ԭʼ�ź�Ƶ��')
sound(y,fs);

% %��Ӹ�˹����
% noise=0.01*randn(1,N);
% y1=y+noise;
% figure,plot(t,y1,'r')
% xlabel('t/s')
% ylabel('Amp')
% title('�������ź�')
% figure,plot(abs(fft(y1)),'r')
% title('�������ź�Ƶ��')
% sound(y1,fs);
% 
% % eemd(Y,Nstd,NE)
% S1=eemd(y,0.01,10);%eemd�����ӳ����eemd.m
% 
% figure,plot(t,S1(:,4),'r')
% xlabel('t/s')
% ylabel('Amp')
% title('EEMD�ָ�������ź�')
% figure,plot(abs(fft(y)),'r')
% title('EEMD�ָ������ź�Ƶ��')
% sound(S1(:,4),fs);
% 
% %%%�Ա�ͼ
% figure,
% %ʱ��
% subplot(2,3,1)
% plot(t,y)
% xlabel('t/s')
% ylabel('Amp')
% title('ԭʼʱ���ź�')
% subplot(2,3,2)
% plot(t,y1)
% xlabel('t/s')
% ylabel('Amp')
% title('������ʱ���ź�')
% subplot(2,3,3)
% plot(t,S1(:,4))
% xlabel('t/s')
% ylabel('Amp')
% title('EEMD�����ʱ���ź�')
% 
% %Ƶ��
% subplot(2,3,4)
% plot(t,abs(fft(y)))
% title('ԭʼ�ź�Ƶ��ͼ')
% 
% subplot(2,3,5)
% plot(t,abs(fft(y1)))
% title('�������ź�Ƶ��ͼ')
% 
% subplot(2,3,6)
% plot(t, abs(fft(S1(:,4))))
% title('EEMD�����ź�Ƶ��ͼ')
% 
% %--------------------------------------------------------------ICA--------------------------------------------------%
% %MixedS=[S1(:,2)';S1(:,3)';S1(:,4)'];%����Ͼ��������ų��в����
% MixedS=[S1(:,3)';S1(:,4)';S1(:,5)'];%����Ͼ��������ų��в����
% %subplot(3,3,1),plot(MixedS(1,:)),title('����ź�1'),%axis([0 100 -4 4])
% %subplot(3,3,2),plot(MixedS(2,:)),title('����ź�2'),%axis([0 100 -4 4])
% %subplot(3,3,3),plot(MixedS(3,:)),title('����ź�3'),%axis([0 100 -4 4])
% MixedS_back=MixedS;
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%% ��׼�� %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MixedS_mean=zeros(3,1);
% for i=1:3
%         MixedS_mean(i)=mean(MixedS(i,:));%�����ֵ
% end
% 
% for i=1:3
%     for j=1:size(MixedS,2)
%        MixedS(i,j)=MixedS(i,j)-MixedS_mean(i);%ȥ��ֵ
%     end
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%% �׻� %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MixedS_cov=cov(MixedS');%covΪ��Э�����
% [E,D]=eig(MixedS_cov);%���źž����Э�������������ֵ�ֽ�
% Q=inv(sqrt(D))*E';  %QΪ�׻�����
% MixedS_white=Q*MixedS;%MixedS_whiteΪ�׻�����źž���
% IsI=cov(MixedS_white');%IsIӦΪ��λ��
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%% FASTICA�㷨 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% X=MixedS_white;%�����㷨����X���в���
% [VariableNum,SampleNum]=size(X);
% numoFIC=VariableNum;%�ڴ�Ӧ���У�����Ԫ�������ڱ�������
% B=zeros(numoFIC,VariableNum);%��ʼ��������w�ļĴ����B=[b1 b2 ...bd]
% for r=1:numoFIC
%     i=1;maxIterationsNum=100;%����������������������ÿ�������������Ե������������˴�����
%     IterationsNum=0;
%     b=rand(numoFIC,1)-0.5;%�������b��ֵ
%     b=b/norm(b);%��b��׼��
%     while(i<=maxIterationsNum+1)
%         if(i==maxIterationsNum)%ѭ����������
%             fprintf('\n��%d������%d�ε����ڲ���������',r,maxIterationsNum);
%             break;
%         end
%         b01d=b;
%         a2=1;
%         u=1;
%         t=X'*b;
%         g=t.*exp(-a2*t.^2/2);
%         dg=(1-a2*t.^2).*exp(-a2*t.^2/2);
%         b=((1-u)*t'*g*b+u*X*g)/SampleNum-mean(dg)*b;%���Ĺ�ʽ
%         b=b-B*B'*b;%��b������
%         b=b/norm(b);%��b��׼��
%         if(abs(abs(b'*b01d)-1)<1e-9)%����������򱣴���������b
%             B(:,r)=b;
%             break;
%         end
%         i=i+1;
%     end
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%ICA��������ݸ�ԭ����ͼ%%%%%%%%%%%%%%%%%%
% ICAedS=B'*Q*MixedS_back;%����ICA��ľ���
% 
% %����Ͼ����������в����
% %subplot(3,3,4),plot(ICAedS(1,:)),title('ICA����ź�1'),%axis([0 100 -4 4])
% %subplot(3,3,5),plot(ICAedS(2,:)),title('ICA����ź�2'),%axis([0 100 -4 4])
% %subplot(3,3,6),plot(ICAedS(3,:)),title('ICA����ź�3'),%axis([0 100 -4 4])
% 
% %����ź�Ƶ��
% %subplot(3,3,7),plot(abs(fft(ICAedS(1,:)))),title('����ź�1Ƶ��'),%axis([0 100 -4 4])
% %subplot(3,3,8),plot(abs(fft(ICAedS(2,:)))),title('����ź�2Ƶ��'),%axis([0 100 -4 4])
% %subplot(3,3,9),plot(abs(fft(ICAedS(3,:)))),title('����ź�3Ƶ��'),%axis([0 100 -4 4])
% 
% ICAedS(1,:)=ICAedS(1,:)/30;
% sound(ICAedS(1,:),fs);
% 
% t=1/fs:1/fs:N/fs;
% figure,plot(t,ICAedS(1,:))
% xlabel('t/s')
% ylabel('Amp')
% title('ICAäԴ�����ʱ���ź�')
% figure,plot(abs(fft(ICAedS(1,:))))
% title('ICAäԴ��������ź�Ƶ��')
% 
% 
% %----------------------------����ԭʼ�źš��������źš�EEMD������źš�ICAäԴ������źŵ�ʱƵ�Ա�ͼ
% figure,
% %ʱ��
% subplot(2,4,1)
% plot(t,y)
% xlabel('t/s')
% ylabel('Amp')
% title('ԭʼʱ���ź�')
% subplot(2,4,2)
% plot(t,y1)
% xlabel('t/s')
% ylabel('Amp')
% title('������ʱ���ź�')
% subplot(2,4,3)
% plot(t,S1(:,4))
% xlabel('t/s')
% ylabel('Amp')
% title('EEMD�����ʱ���ź�')
% subplot(2,4,4)
% plot(t,ICAedS(1,:))
% xlabel('t/s')
% ylabel('Amp')
% title('ICAäԴ�����ʱ���ź�')
% 
% %Ƶ��
% subplot(2,4,5)
% plot(t,abs(fft(y)))
% title('ԭʼ�ź�Ƶ��ͼ')
% 
% subplot(2,4,6)
% plot(t,abs(fft(y1)))
% title('�������ź�Ƶ��ͼ')
% 
% subplot(2,4,7)
% plot(t, abs(fft(S1(:,4))))
% title('EEMD�����ź�Ƶ��ͼ')
% 
% subplot(2,4,8)
% plot(t, abs(fft(ICAedS(1,:))))
% title('ICAäԴ��������ź�Ƶ��')
% 
% 
% %-----------------------------------------------------------����غ�����ʱ��-------------------------------------------------%
% data=ICAedS(1,:);
% clear 'ICAedS';
% tau=zi_xiangguan(data);%�õ�����ʱ��ֵ��tau=4
% 
% %�������غ�������ʱ�ӵı仯����
% [tau1 val_xiangguan]=zi_xiangguan_plot(data);
% figure,plot(tau1,val_xiangguan)
% xlabel('ʱ��')
% ylabel('����غ���')
% title('����غ�������õ�ʱ��')
% 
% 
% %-----------------------------------------------------------Cao������Ƕ��ά��-------------------------------------------------%
% data=data(8820:13230);
% data_test=data;
% save 'data_test'
% %Cao_methond(data',4);%���Ƕ��ά��m=7
% 
% 
% %-----------------------------------------------------------G-P�����������ά��-------------------------------------------------%
% %GP_func(data,N,tau,m);
% tau=4;
% m=7;
% N=length(data)-(m-1)*tau;
% %GP_func(data,N,4,7);


%----------------------------------------------------------С�����������������Lyapunovָ��-------------------------------------------------%


%----------------------------------------------------------mfcc����÷������ϵ��-------------------------------------------------%
coef_mel_1=mfcc(y,fs);






