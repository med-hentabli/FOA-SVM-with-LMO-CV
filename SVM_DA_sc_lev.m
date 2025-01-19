global RMSEbes datmi es X Y Xn Yn
%load('resultats DA_SVM.mat')
%VRMSE=[];cv=[];vk=[];
RMSEbes=1000;
datmi=xlsread('D:\recharche\laidi\ouldji\work01\data set.xlsx');es=1;
X=(datmi(:,1:5));Xn=(X.*1).^es;
Y=(datmi (:,6));Yn=(Y);
fobj =@SVMr_DA1_lev
dim =2;
Max_iteration = 20
SearchAgents_no =30
lb=[1,0.1]; %...,lbn] where lbn is the lower bound of variable n
ub=[2000,3]; %,...,ubn] where ubn is the upper bound of variable n
handles=[];
value=[];
%[Best_score,Best_pos,cg_curve]=DA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,handles,value)
%[Best_score,Best_pos]=FOX(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
[Best_score,Best_pos,cg_curve]=DA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,handles,value)
ploting_ruseltats
%h = daviolinplot(datmi(:,1:12));