%С����������������ŵ��ָ��������

clear all
close all
clc

load 'data_test.mat'
lya_pu=[];

tic
fs=44100.0;
ts=1.0/fs;
data=data_test;%����

tau=4;
m=7;

%���ú���mean_cycle������е�ƽ������
t_p=mean_cycle(data,fs);%fsΪʱ�����в���Ƶ��
t_p=50;
%����С������������������ŵ��ָ����������
data_chonggou=PhaSpaRecon(data,tau,m);%��ռ��ع�
data_chonggou=data_chonggou';
[hang,lie]=size(data_chonggou);
M=hang;%�ع���ռ��еĵ�ĸ���
weishu=lie;%��ռ���ά������ʵ����m
nearest_lindian=zeros(2,M);%��������ڵ�Դ�ſռ�
juli_temp=zeros(M,M);%����������
for i=1:M
  for j=1:M
    if i==j
        juli_temp(i,j)=inf;
    elseif abs(i-j)<=t_p
        juli_temp(i,j)=inf;
    else
        juli_temp(i,j)=norm(data_chonggou(i,:)-data_chonggou(j,:),inf);
    end
  end
end
%Ѱ��ÿ���������ڵ㣬�Ӿ��������Ѱ��
dian_temp=[];
for i=1:M
    dian_temp(i)=find(juli_temp(i,:)==min(juli_temp(i,:)));
end%���ˣ��ѽ���ռ���ÿ�������ƶ��ݷ���������ڵ�ı��ȡ��
clear 'juli_temp'
xxxx=1:M;
nearest_lindian=[xxxx;dian_temp];%���У�һ�ж�Ӧһ������ڵ��
%��ÿһ���ڵ�ԣ����ÿһ����ɢʱ��i�ľ���
d_lisan=ones(M,M);%����ÿ����ɢʱ���ľ��룬��ÿ��Ϊ�ڵ��M����ÿ�м�����i����ɢʱ�䣬��ʵû��
for  ii=1:M
    j_temp1=nearest_lindian(1,ii);
    j_temp2=nearest_lindian(2,ii);%�ҳ���Ӧ�ڵ���±�
    for jj=1:min(M-j_temp1,M-j_temp2)
        d_lisan(ii,jj)=norm(data_chonggou(j_temp1+jj,:)-data_chonggou(j_temp2+jj,:),inf);
    end
end%��ĿǰΪֹ�������ÿ���ڵ����i����ɢʱ���ľ���
%d_lisan=log(d_lisan);�������⣬d_lisan����Ԫ��0�����ܲ���log(d_lisan),�޸ķ���һ��zeros��Ϊones��
%����������ѭ���޸�
d_lisan=log(d_lisan);
I=1:M;
Y=zeros(1,M);
for i=1:length(I)
    d_jisuan=d_lisan(:,i);
    d_jisuan(d_jisuan==0)=[];
    Y(i)=mean(d_jisuan);
end


linear = [1:60]';  % ��������
F1 = polyfit(I(linear),Y(linear),1);
Y1 = polyval(F1,I(linear),1);

lya_pu=[lya_pu,F1(1)];
plot(lya_pu,'b-');
hold on

toc

figure
subplot(211); 
plot(I,Y,'k-'); grid; xlabel('i'); ylabel('y(i)'); hold on;
plot(I(linear),Y1,'r-'); hold off;
subplot(212); 
plot(I(1:end-1),diff(Y),'k-'); grid; xlabel('n'); ylabel('slope');
    
