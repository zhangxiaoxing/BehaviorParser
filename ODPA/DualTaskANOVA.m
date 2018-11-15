out=plot_DPA_dual(ODPAfiles.dualLateBlock,'dualLateDelayPerf','dualLateDelayMissFalse',80);
close all
crt=[out{1}(:,1:2),out{2}(:,1:3)];
t=table(crt(:,1),crt(:,2),crt(:,3),crt(:,4),crt(:,5),'VariableNames',{'OnGo','OffGo','OnNogo','OffNogo','Gene'});
wic=[{'On','Off','On','Off'};{'Go','Go','Nogo','Nogo'}]';
wi=table(wic(:,1),wic(:,2),'VariableNames',{'Laser','Distr'});
rm=fitrm(t,'OnGo-OffNogo~Gene','WithinDesign',wi);
ranovatbl=ranova(rm,'WithinModel','Laser*Distr')


crt=[out{1}(:,6:7),out{2}(:,[6 7 3])];
t=table(crt(:,1),crt(:,2),crt(:,3),crt(:,4),crt(:,5),'VariableNames',{'OnGo','OffGo','OnNogo','OffNogo','Gene'});
wic=[{'On','Off','On','Off'};{'Go','Go','Nogo','Nogo'}]';
wi=table(wic(:,1),wic(:,2),'VariableNames',{'Laser','Distr'});
rm=fitrm(t,'OnGo-OffNogo~Gene','WithinDesign',wi);
ranovatbl=ranova(rm,'WithinModel','Laser*Distr')




% wic=[{'On','Off','On','Off'};{'Go','Go','Nogo','Nogo'}]';
% wi=table(wic(:,1),wic(:,2),'VariableNames',{'Laser','Distr'});
% rm=fitrm(t,'OnGo-OffNogo~Gene','WithinDesign',wi);
% ranovatbl=ranova(rm)
% 
% crt=[out{1}(:,1:2),out{2}(:,1:3)];
% crt(crt(:,5)==0,:)=[];
% wic=[{'On','Off','On','Off'};{'Go','Go','Nogo','Nogo'}]';
% wi=table(wic(:,1),wic(:,2),'VariableNames',{'Laser','Distr'});
% rm=fitrm(t,'OnGo-OffNogo~1','WithinDesign',wi);
% ranovatbl=ranova(rm,'WithinModel','Laser*Distr')
% 
% ranovatbl=ranova(rm,'WithinModel','Laser+Distr')