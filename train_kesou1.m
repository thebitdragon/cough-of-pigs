clear all
close all
clc

%ѵ��������
%��ȡ��Ƶ���ݣ�������ԭʼ�źŵ�ʱ��ͼ��Ƶ��ͼ������������Ե�����
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
title('ԭʼ�ź�')
figure,plot(abs(fft(y)))
title('ԭʼ�ź�Ƶ��')
sound(y,fs);


for i=1:5%24-26ѡ������������������Ϊѵ����
    tdata{i}=y;%tdate���������Ƶ������
end

N = 4;   % hmm��״̬��
M = [3,3,3,3]; % ÿ��״̬��Ӧ�Ļ��ģ�ͳɷ�������ʾÿ��״̬��ռ�ı���

for i = 1:length(tdata)  % ���ֵ�ѭ����ѭ��5�����������
    fprintf('\n��������%d��mfcc��������\n',i);   %ѵ�����ȵó����������÷������ϵ�������� 
    obs(i).sph = tdata{i};  % ����i�ĵ�k������
    obs(i).fea = mfcc(obs(i).sph,fs);  % ��������ȡmfcc��������
     
    fprintf('\nѵ������%d��hmm\n',i);
    hmm_temp=inithmm(obs,N,M); %��ʼ��hmmģ��
    hmm{i}=baum_welch(hmm_temp,obs); %��������hmm�ĸ�����
end
fprintf('\nѵ����ɣ�\n');










































