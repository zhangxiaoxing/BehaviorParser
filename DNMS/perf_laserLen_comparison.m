load dnmsfiles;EachQuarter=stats_quarter(dnmsfiles.quarter);
% mean(cell2mat(EachQuarter(strcmp(EachQuarter(:,6),'ChR2') & strcmp(EachQuarter(:,5),'4Q'),2)))
[~,perf5]=stats_GLM(dnmsfiles.delay5s);
% mean(perf5(perf5(:,3)==1,[1 2]))
[~,perf8]=stats_GLM(dnmsfiles.delay8s);
% % mean(perf8(perf8(:,3)==1,[1 2]))
[~,perf12]=stats_GLM(dnmsfiles.delay12s);


figure('Color','w','Position',[100,100,300,220]);
hold on;
[~,p]=anovan([d1;d2;d3],{[ones(length(d1),1);ones(length(d2),1).*2;ones(length(d3),1).*3]});
dither=@(x) rand(length(x),1)*0.6-0.3;
d1=perf5(perf5(:,3)==0,2);
plot(1+dither(d1),d1,'ko','MarkerFaceColor','none','MarkerSize',3);
d2=perf8(perf8(:,3)==0,2);
plot(2+dither(d2),d2,'ko','MarkerFaceColor','none','MarkerSize',3);
% getData=@(x) cell2mat(EachQuarter(strcmp(EachQuarter(:,6),'ChR2') & strcmp(EachQuarter(:,5),x),2));
% d3=getData('4Q');
d3=perf12(perf12(:,3)==0,2);
plot(3+dither(d3),d3,'ko','MarkerFaceColor','none','MarkerSize',3);
plot(1:3,[mean(d1),mean(d2),mean(d3)],'k+','MarkerSize',12,'LineWidth',2);
set(gca,'XTick',1:3,'XtickLabel',[]);
ylabel('Performance impairment (%)');



% figure('Color','w','Position',[100,100,300,220]);
% hold on;
% [~,p]=anovan([d1;d2;d3],{[ones(length(d1),1);ones(length(d2),1).*2;ones(length(d3),1).*3]});
% dither=@(x) rand(length(x),1)*0.6-0.3;
% d1=-diff(perf5(perf5(:,3)==1,[1 2]),1,2);
% plot(1+dither(d1),d1,'ko','MarkerFaceColor','none','MarkerSize',3);
% d2=-diff(perf8(perf8(:,3)==1,[1 2]),1,2);
% plot(2+dither(d2),d2,'ko','MarkerFaceColor','none','MarkerSize',3);
% getData=@(x) cell2mat(EachQuarter(strcmp(EachQuarter(:,6),'ChR2') & strcmp(EachQuarter(:,5),x),2));
% d3=-diff([getData('4Q'),getData('NoLaser')],1,2);
% plot(3+dither(d3),d3,'ko','MarkerFaceColor','none','MarkerSize',3);
% plot(1:3,[mean(d1),mean(d2),mean(d3)],'k+','MarkerSize',12,'LineWidth',2);
% set(gca,'XTick',1:3,'XtickLabel',[]);
% ylabel('Performance impairment (%)');
% 
% figure('Color','w','Position',[100,100,300,220]);
% hold on;
% 
% dither=@(x) rand(length(x),1)*0.6-0.3;
% d1=-diff(perf5(perf5(:,3)==1,[1 2]),1,2);
% plot(1+dither(d1),d1,'ko','MarkerFaceColor','none','MarkerSize',3);
% % d2=-diff(perf8(perf8(:,3)==1,[1 2]),1,2);
% % plot(2+dither(d2),d2,'ko','MarkerFaceColor','none','MarkerSize',3);
% getData=@(x) cell2mat(EachQuarter(strcmp(EachQuarter(:,6),'ChR2') & strcmp(EachQuarter(:,5),x),2));
% d3=-diff([getData('4Q'),getData('NoLaser')],1,2);
% plot(2+dither(d3),d3,'ko','MarkerFaceColor','none','MarkerSize',3);
% plot(1:2,[mean(d1),mean(d3)],'k+','MarkerSize',12,'LineWidth',2);
% % [~,p]=anovan([d1;d3],{[ones(length(d1),1);ones(length(d2),1).*2;ones(length(d3),1).*3]});
% p=ranksum(d1,d3);
% set(gca,'XTick',1:3,'XtickLabel',[]);
% ylabel('Performance impairment (%)');