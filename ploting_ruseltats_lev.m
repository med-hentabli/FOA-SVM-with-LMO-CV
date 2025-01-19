global X Y Xn a  Mdlb  Mdl1b idxTrn idxTest
%cvp=Mdl1b.Partition
%idxTrn = training(cvp); % Training set indices
%idxTest = test(cvp);    % Test set indices
%------------------------------Ruseltat------------------------------------
ycaln = predict(Mdlb,Xn);
%ycal=10.^(ycaln)./a;
ycal=ycaln./a;
RMSEb(3,1)=(((sum((ycal-Y).^2))/length(Y)))^(1/2);
%RMSElog=(((sum((ycaln-Yn).^2))/length(Yn)))^(1/2)
R2(3,1)=1-(sum((Y-ycal).^2)/sum((ycal-mean(Y)).^2));
figure(3)
[m(3,1),b(3,1),r(3,1)]=postreg(ycal,Y);
set(gcf, 'menubar', 'figure' );
%xlim([0,1]);
%ylim([0,1]); 
%--------------------------------train%------------------------------------
%%
ycalp = ycal(idxTrn,:);
Yp=Y(idxTrn,:);
RMSEb(1,1)=(((sum((ycalp-Yp).^2))/length(Yp)))^(1/2);
R2(1,1)=1-(sum((Yp-ycalp).^2)/sum((ycalp-mean(Yp)).^2));
figure(1)
[m(1,1),b(1,1),r(1,1)]=postreg(ycalp,Yp);
set(gcf, 'menubar', 'figure' );
%xlim([0,50]);
%ylim([0,50]);
%---------------------------------Test-------------------------------------
%%
ytcal = ycal(idxTest,:);
Yt=Y(idxTest,:);
RMSEb(2,1)=(((sum((ytcal-Yt).^2))/length(Yt)))^(1/2);
R2(2,1)=1-(sum((Yt-ytcal).^2)/sum((ytcal-mean(Yt)).^2));
figure(2)
[m(2,1),b(2,1),r(2,1)]=postreg(ytcal,Yt);
title(['PRODUCTIVITY(ml/hr.m2)_{Exp}^{Test} vs. PRODUCTIVITY(ml/hr.m2)_{Cal}^{Test}, R=' num2str(r(2)),' ; R^2= ' num2str(R2(2))]);
xlabel('PRODUCTIVITY(ml/hr.m2)(mPa/s)_{Exp}^{Test}','FontSize',12,'FontWeight' ,'bold');
ylabel({['Linear Fit: PRODUCTIVITY(ml/hr.m2)_{Cal}^{Test}=(',num2str(m(3),2),')PRODUCTIVITY(ml/hr.m2)_{Exp}^{Test} +(', num2str(b(3),2), ')'];'PRODUCTIVITY(ml/hr.m2)_{Cal}^{Test}'},'FontSize',12,'FontWeight','bold');
legend({' Test data','Best Linear Fit','PRODUCTIVITY(ml/hr.m2)_{Exp}^{Test} = PRODUCTIVITY(ml/hr.m2)_{Cal}^{Test}'},'FontSize',10,'FontWeight' ,'bold','Location','northwest');

set(gcf, 'menubar', 'figure' );
%xlim([0,1]);
%ylim([0,1]);
%-------------------------conclusion---------------------------------------
%%
figure(5)
plot((Yp),(ycalp),'ok','LineWidth',1)
set(gcf, 'menubar', 'figure' );
hold on 
line(minmax(Y'),minmax(Y'),'Color','red','LineStyle','-','LineWidth',1.5)
line(minmax(Y'),minmax(Y'),'Color','k','LineStyle','--','LineWidth',0.5)
%plot((Yn),(Yn),'-r','LineWidth',2)
%plot((Yn),(ycal),'--k','LineWidth',0.5)
%Yt=[Yt;250;280;320;221];ytcal=[ytcal;250;280;322;226]
plot((Yt),(ytcal),'sb','LineWidth',1)                   
xlabel('PRODUCTIVITY(ml/hr.m2)_{Exp}','FontSize',12,'FontWeight' ,'bold');
ylabel({['Linear Fit: PRODUCTIVITY_{Cal}=(',num2str(m(3),2),')PRODUCTIVITY_{Exp} +(', num2str(b(3),2), ')'];'PRODUCTIVITY_{Cal}'},'FontSize',12,'FontWeight','bold');
title(['PRODUCTIVITY_{Exp} vs. PRODUCTIVITY_{Cal}, R=' num2str(r(3)),' ; R^2= ' num2str(R2(3))]);
legend({' Train data','Best Linear Fit','PRODUCTIVITY_{Exp} = PRODUCTIVITY_{Cal}',' Test data',' Validation data'},'FontSize',10,'FontWeight' ,'bold','Location','northwest');
legend('boxoff')
xlim(minmax(Y'));
ylim(minmax(Y'));
%xlim([0,50]);
%ylim([0,50]);
hold off
%%
rsdd(1,1)=((sum((ycalp-Yp).^2))/(length(Yp)-1))^(1/2)/mean(Yp)*100;
MAE(1,1)=sum(abs(ycalp-Yp))/length(Yp);
MRPE(1,1)=max((abs((ycalp-Yp)./Yp)))*100;
MAPE(1,1)=(sum((abs((ycalp-Yp)./Yp)))/length(Yp))*100;
AARD(1,1)=100*(sum(abs((ycalp-Yp)./Yp)))/length(Yp);

rsdd(2,1)=((sum((Yt-ytcal).^2))/(length(Yt)-1))^(1/2)/mean(Yt)*100;
MAE(2,1)=sum(abs(Yt-ytcal))/length(Yt);
MRPE(2,1)=max((abs((Yt-ytcal)./Yt)))*100;
MAPE(2,1)=(sum((abs((Yt-ytcal)./Yt)))/length(Yt))*100;
AARD(2,1)=100*(sum(abs((Yt-ytcal)./Yt)))/length(Yt);

rsdd(3,1)=((sum((Y-ycal).^2))/(length(Y)-1))^(1/2)/mean(Y)*100;
MAE(3,1)=sum(abs(Y-ycal))/length(Y);
MRPE(3,1)=max((abs((Y-ycal)./Y)))*100;
MAPE(3,1)=(sum((abs((Y-ycal)./Y)))/length(Y))*100;
AARD(3,1)=100*(sum(abs((ycal-Y)./Y)))/length(Y);

SSigma=Mdlb.ModelParameters.KernelScale
 C=Mdlb.ModelParameters.BoxConstraint
 Quantity_of_support_vectors=size(Mdlb.SupportVectors,1)
epselon=kfoldLoss(Mdl1b)
%LOSS1=loss(Mdlb,Xn,Yn)

Data = {'Train';'Test';'All'};slop=m;
uu=table(Data,RMSEb,R2,r,b,slop,AARD,MAPE,MRPE,MAE,rsdd)