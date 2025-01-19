function obj=SVMr_DA1_lev(x)
global X Y Xn a c k Mdlb  Yn ep Mdl1b RMSEbes datmi es idxTrn idxTest
%datmi=xlsread('base.xlsx');

%tt=ones(size(Yn(train),1),1);
a=1;
c=x(1);k=x(2);ep=0;%gamma
RMSEbe=10000;
for et=1:3 %'BoxConstraint',c,'gaussian linear false ISDA SMO L1QP
    %c = cvpartition(10,'Leaveout')
      N=length(datmi);
      [train,test] = crossvalind('LeaveMOut',N,N*0.2);
      Mdl = fitrsvm(Xn(train,:),Yn(train),'KernelFunction','gaussian','BoxConstraint',c,'Standardize',true,'KernelScale',k,'KernelOffset',0,...
      'DeltaGradientTolerance',0.001,'GapTolerance',0,'IterationLimit',1e30,...
      'KKTTolerance',1e-4,'Solver','SMO','ClipAlphas',true,'Epsilon',ep,...
      'CacheSize','maximal','CategoricalPredictors',[],'NumPrint',10000,'OutlierFraction',0,...
      'ShrinkagePeriod',0,'Verbose',0);

    %Mdl=Mdl1.Trained{1,1};
    %cvp=Mdl1.Partition;    
    %idxTest = test(cvp);

    ycaln = predict(Mdl,Xn);
    %ycal=10.^(ycaln)./a;
    ycal=(ycaln);
    RMSE=(((sum((ycal-Y).^2))/length(Y)))^(1/2); 
    %RMSE=(((sum((ycal(idxTest)-Y(idxTest)).^2))/length(Y(idxTest))))^(1/2);
    %RMSE1=(sum((ycal(idxTest)-Y(idxTest)).^2)/sum((ycal(idxTest)-mean(Y(idxTest))).^2));
    %RMSE=(sum((ycal-Yn).^2)/sum((ycal-mean(Yn))).^2);
%RMSE=(RMSE1+RMSE2*2)/3;
    %RMSE=(RMSE02+RMSE01)/2;
         if RMSE< RMSEbe;
            RMSEbe=RMSE;
            Mdlbe=Mdl;
            %Mdl1be=Mdl;          
         end
end
          if RMSEbe<RMSEbes
            RMSEbes=RMSEbe;
            Mdlb=Mdlbe;
            %Mdl1b=Mdl1be;
            kmin=k;
            cbest=c;
            epbest=ep;
            save('kcccc')
            idxTrn=train;
            idxTest=test;
          end
          obj=RMSEbes
         %obj=RMSEbe
        %cv=[cv,c];vep=[vep,ep];vk=[vk,k];
        %VRMSE=[VRMSE,RMSE];
      
%------------------------------------------------------------------------
