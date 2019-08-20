%利用Cao方法求嵌入维数
function cao_methond(data,tau)
%data:输入时间序列
%tau:输入时间延迟
%m:得到的嵌入维数
min_m=1;
max_m=10;
k=1;

N=length(data);
for m=min_m:max_m
m;
Nm=N-tau*(m-1);
Y=reconstitution(data,N,m,tau);
 for i=1:N-m*tau
  i;
   for j=1:N-m*tau
   d(j)=norm(Y(:,i)-Y(:,j),inf);
   end
 temp=sort(d);
 D(i,1)=i;     
 temp1=find(temp>0);
 temp2=find(d==temp(temp1(1)));
 D(i,2)=temp2(1);  
 D(i,3)=temp(temp1(1));
 %计算a(i,m)
 Y1=[Y(:,i);data(m*tau+i)];
 Y2=[Y(:,D(i,2));data(D(i,2)+m*tau)];
 ad(i)=norm(Y1-Y2,inf)/D(i,3);
 clear d Y1 Y2 temp temp1 temp2
 end
 D;
%求E(d)
E(k,1)=m;
E(k,2)=sum(ad)/(N-m*tau);
%求E*(d)
En(k,1)=m;
 for kk=1:N-m*tau
     dd(kk)=abs(data(D(kk,1)+m*tau)-data(D(kk,2)+m*tau));
 end
En(k,2)=sum(dd)/(N-m*tau);
k=k+1;
clear D
end
%求E1(d)
for i=1:(max_m-min_m)
    E1(i,1)=E(i,1);
    E1(i,2)=E(i+1,2)/E(i,2);
end
%求E2(d)
for i=1:(max_m-min_m)
    E2(i,1)=En(i,1);
    E2(i,2)=En(i+1,2)/En(i,2);
end
figure(1)
plot(E1(:,1),E1(:,2),'-bs',E2(:,1),E2(:,2),'-r*');
xlabel('嵌入维数');
legend('E1(m)','E2(m)');
grid on


