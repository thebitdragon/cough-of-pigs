% �������е���ռ��ع��Ӻ��� (phase space reconstruction)
function [xn,dn] = PhaSpaRecon(s,tau,m)
% [xn, dn, xn_cols] = PhaSpaRecon(s, tau, m)
% ���������    s          ��������(������)
%               tau        �ع�ʱ��
%               m          �ع�ά��
% ���������    xn         ��ռ��еĵ�����(ÿһ��Ϊһ����)
%               dn         һ��Ԥ���Ŀ��(������)

[rows,cols] = size(s);
if (rows>cols)
    len = rows;
    s = s';
else
    len = cols;
end

if (nargout==2)
    
    if (len-1-(m-1)*tau < 1)
        disp('err: delay time or the embedding dimension is too large!')
        xn = [];
        dn = [];
    else
        xn = zeros(m,len-1-(m-1)*tau);
        for i = 1:m
            xn(i,:) = s(1+(i-1)*tau : len-1-(m-i)*tau);   % ��ռ��ع���ÿһ��Ϊһ���� 
        end
        dn = s(2+(m-1)*tau : end);    % Ԥ���Ŀ��
    end
    
elseif (nargout==1)
    
    if (len-1-(m-1)*tau < 0)
        disp('err: delay time or the embedding dimension is too large!')
        xn = [];
    else
        xn = zeros(m,len-(m-1)*tau);
        for i = 1:m
            xn(i,:) = s(1+(i-1)*tau : len-(m-i)*tau);   % ��ռ��ع���ÿһ��Ϊһ���� 
        end
    end
    
end



