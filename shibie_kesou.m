% ʶ��������
[yy,fs]= audioread('4_1_24_952.wav');%����һ����ʶ����������ݣ��ж��Ƿ������������
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


for i=1:5
    signal_shibie{i}=y;
end

fprintf('��ʼʶ��\n');
j = 3;% ���ѡ��һ����ʶ��������3��
rec_sph=signal_shibie{j}; %������������ȡ�������ŵ�rec_sph�������һ��ʶ����
fprintf('����������ʵֵΪ%d\n',j);
rec_fea = mfcc(rec_sph,fs);  % ������ȡ
 8  
 -
% �����ǰ�������ڸ�����hmm��p(X|M)
for i=1:5
  pxsm(i) = viterbi(hmm{i}, rec_fea); 
end
[d,n] = max(pxsm); % �о����������ֵ��Ӧ�������Ϊʶ����
fprintf('������ʶ����Ϊ%d\n',n)








