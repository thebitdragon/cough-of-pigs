%GP�㷨�����ά
function [ln_r,ln_C]=GP_func(data,N,tau,m)
%data:����ʱ������
%N:ʱ�����е���
%tau:����ʱ���ӳ�
%m:����Ƕ��ά��

% ��һ��
data = normalize_data(data);  
%�ع��ź�
data=reconstitution(data,N,m,tau);

logdelt = 0.2;
ln_r = [-7:logdelt:0];
delt = exp(ln_r);
for k=1:length(ln_r)
    r=delt(k); 
    C(k)=correlation_interal(m,data,r,tau);%  �������Ϊ��������
    k
    if (C(k)<0.0001)
        C(k)=0.0001;
    end
    ln_C(k)=log(C(k));%lnC(r)
end
C
subplot(211)
plot(ln_r,ln_C,'+:');grid;
xlabel('ln r'); ylabel('ln C(r)');
hold on;

subplot(212)
Y = diff(ln_C)./logdelt;
plot(Y,'+:'); grid;
xlabel('n'); ylabel('slope'); 
hold on;

%------------------------------------------------------
% �����������
ln_Cr=ln_C;
ln_r=ln_r;
LinearZone = [10:25];
F = polyfit(ln_r(LinearZone),ln_Cr(LinearZone),1);
CorrelationDimension = F(1)
