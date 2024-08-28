clear
clc
warning off;
clear
clc
warning off;
lamda=1;
path = './';
addpath(genpath(path));
MaxResSavePath = 'final_res1/';
% dataName = 'citeseer'; %%% flower17; flower102; CCV; caltech101_numofbasekernel_10;football_9view_Kmatrix
%3Sources_3view;olympics_9view_Kmatrix;SUNRGBD_fea;bbcsport;Handwritten_numerals
%% %% washington; wisconsin; texas; cornell
% datasetName = {'proteinFold','bbcsport_2view','mfeat','citeseer','cora'};
datasetName = {'3Sources_3view','mfeat'};
for dataIndex = 1 : length(datasetName)
    dataName = [ datasetName{dataIndex}];
    load(['F:\work2015\datasets\',dataName ,'_Kmatrix'],'Y');
    load(['F:\mydata\',dataName,'_Ht','.mat'],'Ht');
    numclass = length(unique(Y));
    numker = size(Ht,2);
    num = size(Ht{1},1);
    qnorm = 2;
    lambda = 2.^(-10:1:0);
    avg_time=0;
    k=numclass;
    opt.disp = 0;
    
    best_acc=0;
    best_nmi=0;
    best_pur=0;
    best_f=0;
    
    for lam = 1:length(lambda)
        [H_normalized,HHH,iter,time]= xunhuan(Ht,numclass,numker,lambda(lam));
        res = myNMIACCwithmean(H_normalized, Y, numclass);
        
        resFile2 = [MaxResSavePath,dataName,'-lam=', num2str(lam), '-ACC=', num2str(res(1)), '.mat'];
        save(resFile2,  'res','iter','time','HHH');
        resFile2 = [MaxResSavePath,dataName,'-lam=', num2str(lam), '.mat'];
        save(resFile2,  'res','iter','time','HHH');
    end
end
