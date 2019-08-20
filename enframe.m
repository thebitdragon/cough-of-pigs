function f=enframe(x,win,inc) 
 %将输入信号进行分帧子函数
nx=length(x); 
nwin=length(win); 
if (nwin == 1) 
   len = win; 
else 
   len = nwin; 
end 
if (nargin < 3) 
   inc = len; 
end 
nf = fix((nx-len+inc)/inc); 
f=zeros(nf,len); 
indf= inc*(0:(nf-1)).'; 
inds = (1:len); 
f(:) = x(indf(:,ones(1,len))+inds(ones(nf,1),:)); 
if (nwin > 1) 
    w = win(:)'; 
    f = f .* w(ones(nf,1),:); 
end 
 
