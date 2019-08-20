%小数据量法求李亚普诺夫指数主函数

clear all
close all
clc

load 'data_test.mat'
lya_pu=[];

tic
fs=44100.0;
ts=1.0/fs;
data=data_test;%数据

tau=4;
m=7;

%调用函数mean_cycle求出序列的平均周期
t_p=mean_cycle(data,fs);%fs为时间序列采样频率
t_p=50;
%采用小数据量法计算李亚普诺夫指数，主函数
data_chonggou=PhaSpaRecon(data,tau,m);%相空间重构
data_chonggou=data_chonggou';
[hang,lie]=size(data_chonggou);
M=hang;%重构相空间中的点的个数
weishu=lie;%相空间点的维数，其实就是m
nearest_lindian=zeros(2,M);%定义最近邻点对存放空间
juli_temp=zeros(M,M);%定义距离矩阵
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
%寻找每个点的最近邻点，从距离矩阵中寻找
dian_temp=[];
for i=1:M
    dian_temp(i)=find(juli_temp(i,:)==min(juli_temp(i,:)));
end%到此，已将相空间中每个点限制短暂分离后的最近邻点的标号取出
clear 'juli_temp'
xxxx=1:M;
nearest_lindian=[xxxx;dian_temp];%两行，一列对应一个最近邻点对
%对每一个邻点对，求出每一个离散时间i的距离
d_lisan=ones(M,M);%定义每个离散时间后的距离，即每行为邻点对M个，每列假设有i个离散时间，其实没有
for  ii=1:M
    j_temp1=nearest_lindian(1,ii);
    j_temp2=nearest_lindian(2,ii);%找出对应邻点对下标
    for jj=1:min(M-j_temp1,M-j_temp2)
        d_lisan(ii,jj)=norm(data_chonggou(j_temp1+jj,:)-data_chonggou(j_temp2+jj,:),inf);
    end
end%到目前为止，求出了每个邻点对在i个离散时间后的距离
%d_lisan=log(d_lisan);出现问题，d_lisan中有元素0，不能采用log(d_lisan),修改方法一：zeros改为ones，
%方法二：用循环修改
d_lisan=log(d_lisan);
I=1:M;
Y=zeros(1,M);
for i=1:length(I)
    d_jisuan=d_lisan(:,i);
    d_jisuan(d_jisuan==0)=[];
    Y(i)=mean(d_jisuan);
end


linear = [1:60]';  % 线性区域
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
    
