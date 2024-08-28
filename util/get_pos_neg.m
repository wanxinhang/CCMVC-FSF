function [M] = get_pos_neg(H,numclass,m_pos,m_neg,pos_par,neg_par)
%GET_POS_NEG 此处显示有关此函数的摘要
%   此处显示详细说明
num=size(H,1);
M=zeros(num,num);
W=zeros(num,num);
H_normalized = H ./ repmat(sqrt(sum(H.^2, 2)), 1,size(H,2));
indx = litekmeans(H_normalized,numclass,'MaxIter',100, 'Replicates',1);
distance=zeros(num,num);
cluster_sample_set=cell(numclass,1);
cluster_neg_sample_set=cell(numclass,1);
len=zeros(numclass,1);
neg_len=zeros(numclass,1);
for k=1:numclass
    cluster_sample_set{k}=find(indx==k);
    cluster_neg_sample_set{k} = setdiff([1:num],cluster_sample_set{k});
    len(k)=length(cluster_sample_set{k});
    neg_len(k)=length(cluster_neg_sample_set{k});
end

for n=1:num
    sample_set=cluster_sample_set{indx(n)};
    sample_neg_set=cluster_neg_sample_set{indx(n)};
    this_len=len(indx(n));
    this_neg_len=neg_len(indx(n));
    random_arr = randperm(this_len);
    random_neg_arr = randperm(this_neg_len);
    select_number=min(m_pos,this_len);
    select_neg_number=min(m_neg,this_neg_len);
    this_dis=zeros(select_number,1);
    this_neg_dis=zeros(select_neg_number,1);
    for nn=1:select_number
        if distance(n,sample_set(random_arr(nn))) ~= 0
            this_dis(nn)=distance(n,sample_set(random_arr(nn)));
        else
            this_dis(nn)=pdist2(H(n,:),H(sample_set(random_arr(nn)),:),'Euclidean');
            distance(n,sample_set(random_arr(nn)))=this_dis(nn);
            distance(sample_set(random_arr(nn)),n)=this_dis(nn);
        end
    end
    pos_num=min(select_number,pos_par*numclass);
    [tmp_value,tmp_ind]=mink(this_dis,pos_num);
    for nn=1:pos_num
        M(n,sample_set(random_arr(tmp_ind(nn))))=1;
        M(sample_set(random_arr(tmp_ind(nn))),n)=1;
    end
    for nn=1:select_neg_number
        if distance(n,sample_neg_set(random_neg_arr (nn))) ~= 0
            this_neg_dis(nn)=distance(n,sample_neg_set(random_neg_arr (nn)));
        else
            this_neg_dis(nn)=pdist2(H(n,:),H(sample_neg_set(random_neg_arr (nn)),:),'Euclidean');
            distance(n,sample_neg_set(random_neg_arr (nn)))=this_neg_dis(nn);
            distance(sample_neg_set(random_neg_arr (nn)),n)=this_neg_dis(nn);
        end
    end
    neg_num=min(select_neg_number,neg_par*numclass);
    [tmp_value,tmp_ind]=maxk(this_neg_dis,neg_num);
    for nn=1:neg_num
        M(n,sample_neg_set((random_neg_arr(tmp_ind(nn)))))=-1;
        M(sample_neg_set((random_neg_arr(tmp_ind(nn)))),n)=-1;
    end
end
end