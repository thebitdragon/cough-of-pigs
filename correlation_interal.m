%������������Ӻ���
function C_I=correlation_interal(m,data,r,tau)
%the function is used to calculate correlation integral
%C_I:�������ַ���ֵ
%m:Ƕ��ά��
%data:����ʱ������
%r:Heaviside�����������뾶
%tau:����ʱ���ӳ�
%M=r-(m-1)*tau;
M=length(data)-(m-1)*tau;
sum_H=0;
for i=1:M
%     fprintf('%d/%d\n',i,M);
    for j=i+1:M%M:��ռ��ܵ���
        d=norm((data(:,i)-data(:,j)),inf);%������ռ���ÿ2��֮��ľ���
        %sita=heaviside(r,d);%calculate the value of the heaviside function
        if(r>d)
            sum_H=sum_H+1;
        end
    end
end
C_I=2*sum_H/(M*(M-1));%�������ֵ�ֵ