function [HP] = update_HP(H,A,B)
%UPDATE_HP 此处显示有关此函数的摘要
%   此处显示详细说明
maxIter=5000;
A=A+64*eye(length(A));
flag = 1;
iter = 0;
WWW=H;
WWW1=WWW;
while flag
    iter=iter+1;
    M=2*A*WWW+B;
    [Up,Sp,Vp] = svd(M,'econ');
    WWW=Up*Vp';
    if(abs((WWW-WWW1)/WWW))<1e-4
        flag=0;
    end
    if iter> maxIter
        flag=0;
    end
    WWW1=WWW;
end
HP=WWW;
end


