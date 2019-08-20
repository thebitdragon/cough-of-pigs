%计算关联积分子函数
function C_I=correlation_interal(m,data,r,tau)
%the function is used to calculate correlation integral
%C_I:关联积分返回值
%m:嵌入维数
%data:输入时间序列
%r:Heaviside函数的搜索半径
%tau:输入时间延迟
%M=r-(m-1)*tau;
M=length(data)-(m-1)*tau;
sum_H=0;
for i=1:M
%     fprintf('%d/%d\n',i,M);
    for j=i+1:M%M:相空间总点数
        d=norm((data(:,i)-data(:,j)),inf);%计算相空间中每2点之间的距离
        %sita=heaviside(r,d);%calculate the value of the heaviside function
        if(r>d)
            sum_H=sum_H+1;
        end
    end
end
C_I=2*sum_H/(M*(M-1));%关联积分的值