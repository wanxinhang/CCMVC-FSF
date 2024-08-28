function [H,HHH,iter,time] = xunhuan(Ht,numclass,numker,lambda)
%XUNHUAN �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% numker = size(KH,3);
num=size(Ht{1},1);
m_pos=2*ceil(num^(1/2));
m_neg=4*ceil(num^(1/2));
pos_par=3;
neg_par=5;
k=numclass;
maxIter = 100;
W=zeros(num,num);
time=zeros(numker,1);
iter=cell(numker,1);
H=Ht{1};
HHH=cell(numker,1);
for p =1:numker
    tic;
    W=W+get_pos_neg(Ht{p},numclass,m_pos,m_neg,pos_par,neg_par);
    [H,iter{p}]=update_H(H,Ht{p},W,lambda);
    time(p)=toc;
    HHH{p}=H;
end
H = H./ repmat(sqrt(sum(H.^2, 2)), 1,k);
end



