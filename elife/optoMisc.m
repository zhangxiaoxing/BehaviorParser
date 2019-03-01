perfT=table(num2str(perMice.gene.'),...
perMice.perf(:,1),...
perMice.perf(:,2),...
perMice.perf(:,3),...
perMice.perf(:,4),...
perMice.perf(:,5),...
perMice.perf(:,6),...
perMice.perf(:,7),...
perMice.perf(:,8),...
perMice.perf(:,9),...
perMice.perf(:,10),...
'VariableNames',{'Gene',...
'LaserOff','L138','L434','L831','L165','L363','L561','L1A1','LB6','LBA'
});
opto=table(num2str((1:10).'),'VariableNames',{'OptoCondition'});
% opto=table(...
% {'off','on','on','on','on','on','on','on','on','on'}.',...
% [0 3 3 3 6 6 6 10 6 10].',...
%     {'delay';'delay';'delay';'delay';'delay';'delay';'delay';'delay';'baseline';'baseline'},...
%     [12 8 4.5 1 5 3 1 1 1 1].',...
%     'VariableNames',{'Laser','Len','Epoch','Latency'});
RAMDL=fitrm(perfT,'LaserOff,L138,L434,L831,L165,L363,L561,L1A1,LB6,LBA~Gene','WithinDesign',opto);
[ranovatbl,A,C,D]=ranova(RAMDL,'WithinModel','OptoCondition');





function plotOne(perMice,)
figure;

subplot(1,2,1);
sel=(perMice.gene==1) ;
hold on;
plot(perMice.perf(sel,[1 4 7 8]).');
plot(mean(perMice.perf(sel,[1 4 7 8])),'ko','MarkerFaceColor','k');

subplot(1,2,2);
sel=(perMice.gene==0) ;
hold on;
plot(perMice.perf(sel,[1 4 7 8]).');
plot(mean(perMice.perf(sel,[1 4 7 8])),'ko','MarkerFaceColor','k');




figure;

subplot(1,2,1);
sel=(perMice.gene==1) ;
hold on;
plot(perMice.FA(sel,[1 8]).');
plot(mean(perMice.FA(sel,[1 8])),'ko','MarkerFaceColor','k');

subplot(1,2,2);
sel=(perMice.gene==0) ;
hold on;
plot(perMice.FA(sel,[1 8]).');
plot(mean(perMice.FA(sel,[1 8])),'ko','MarkerFaceColor','k');

end

selOpto=(perMice.gene==1) ;
poptos=[];
for i=2:10
    poptos(1,i)=Tools.pairedPermTest(perMice.perf(selOpto,1),perMice.perf(selOpto,i));
    poptos(2,i)=signrank(perMice.perf(selOpto,1),perMice.perf(selOpto,i));
end


selCtrl=(perMice.gene==0) ;
pctrl=[];
for i=2:10
    pctrl(1,i)=Tools.pairedPermTest(perMice.perf(selCtrl,1),perMice.perf(selCtrl,i));
    pctrl(2,i)=signrank(perMice.perf(selCtrl,1),perMice.perf(selCtrl,i));
end


selOpto=(perMice.gene==1) ;
poptos=[];
for i=2:10
    poptos(1,i)=Tools.pairedPermTest(perMice.FA(selOpto,1),perMice.FA(selOpto,i));
    poptos(2,i)=signrank(perMice.FA(selOpto,1),perMice.FA(selOpto,i));
end


selCtrl=(perMice.gene==0) ;
pctrl=[];
for i=2:10
    pctrl(1,i)=Tools.pairedPermTest(perMice.FA(selCtrl,1),perMice.FA(selCtrl,i));
    pctrl(2,i)=signrank(perMice.FA(selCtrl,1),perMice.FA(selCtrl,i));
end



% figure;subplot(1,2,1);bar(mean(perMice.FA(perMice.gene==1,:)));ylim([0,0.5]);subplot(1,2,2);bar(mean(perMice.FA(perMice.gene==0,:)));ylim([0,0.5]);
% figure;subplot(1,2,1);bar(mean(perMice.miss(perMice.gene==1,:)));ylim([0,0.5]);subplot(1,2,2);bar(mean(perMice.miss(perMice.gene==0,:)));ylim([0,0.5]);

