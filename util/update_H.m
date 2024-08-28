function [H_this,obj] = update_H(H,Ht,W,lambda)
%UPDATE_H 此处显示有关此函数的摘要
%   此处显示详细说明
maxIter=100;
pos_value=5;
neg_value=-1;
W(W>0)=pos_value;
W(W<0)=neg_value;
numclass=size(H,2);
M=eye(numclass);
H_this=Ht;
flag = 1;
iter = 0;
%%
while flag
    iter = iter + 1
    H_this=update_HP(H,lambda*W,H+Ht*M);
    A=Ht'*H_this;
    [U,~,V] = svd(A,'econ');
    M = U*V';
    cal_obj(H_this,H+Ht*M,lambda*W)
    
    obj(iter) = cal_obj(H_this,H+Ht*M,lambda*W);
    if (iter>2) && (abs((obj(iter)-obj(iter-1))/(obj(iter)))<1e-4 || iter>maxIter)
        flag =0;
    end
end
end

