% 混沌序列的相空间重构子函数 (phase space reconstruction)
function [xn,dn] = PhaSpaRecon(s,tau,m)
% [xn, dn, xn_cols] = PhaSpaRecon(s, tau, m)
% 输入参数：    s          混沌序列(列向量)
%               tau        重构时延
%               m          重构维数
% 输出参数：    xn         相空间中的点序列(每一列为一个点)
%               dn         一步预测的目标(行向量)

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
            xn(i,:) = s(1+(i-1)*tau : len-1-(m-i)*tau);   % 相空间重构，每一行为一个点 
        end
        dn = s(2+(m-1)*tau : end);    % 预测的目标
    end
    
elseif (nargout==1)
    
    if (len-1-(m-1)*tau < 0)
        disp('err: delay time or the embedding dimension is too large!')
        xn = [];
    else
        xn = zeros(m,len-(m-1)*tau);
        for i = 1:m
            xn(i,:) = s(1+(i-1)*tau : len-(m-i)*tau);   % 相空间重构，每一行为一个点 
        end
    end
    
end



