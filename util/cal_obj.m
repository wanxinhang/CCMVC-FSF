function [obj] = cal_obj(H_this,H,W)
%CAL_OBJ �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
num=size(H,1);
obj=0;
obj=obj+trace(H_this'*H);
[r1,c1,~]= find(W);
for i=1:length(r1)
    obj=obj+ W(r1(i),c1(i))*(H_this(c1(i),:)*H_this(r1(i),:)');
end
end

