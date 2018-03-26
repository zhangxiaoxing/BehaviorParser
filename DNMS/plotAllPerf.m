
% close all;
% set(groot,'DefaultLineLineWidth',1);
% figure('Color','w','Position',[100,100,450,180]);
% hold on;
% plotOne([2,1],perf5(perf5(:,3)==0,1:2),'k');
% plotOne([4,3]+1,perf5(perf5(:,3)==1,1:2),'b');
% plotOne([6,5]+2,perf8(perf8(:,3)==1,1:2),'b');
% plotOne([8,7]+3,perf12(perf12(:,3)==1,1:2),'b');
% plotOne([10,9]+4,perfBase(perfBase(:,3)==1,1:2),'b');
% 
% set(gca,'XTick',[2 3 5 6 8 9 11 12]-1,'XTickLabel',{'off','on','off','on','off','on','off','on'});
% 
% xlim([0,12]);
% ylim([55,100]);
% 


%%%%%%%%%%%%%%%%%%%
% Ctrl Op Supress %
%%%%%%%%%%%%%%%%%%%
% 
% figure('Color','w','Position',[100,100,370,180]);
% hold on;
% plotOne([2,1]+1,perfBase(perfBase(:,3)==1,1:2),'b');
% plotOne([4,3]+2,perfGNG(perfGNG(:,3)==1,1:2),'b');
% plotOne([6,5]+3,perfNodelay(perfNodelay(:,3)==1,1:2),'b');
% ylabel('Correct rate (%)');
% 
% xlim([1,10]);
% ylim([55,100]);
% set(gca,'XTick',[2 3 5 6 8 9],'XTickLabel',{'off','on','off','on','off','on'});
% print('CtrlOpSupress.eps','-depsc','-r0','-painters');
% return;


% figure('Color','w','Position',[100,100,180,180]);
% hold on;
% plotOne([2,1]+1,perfDPABlock(perfDPABlock(:,3)==0,1:2),'k');
% plotOne([4,3]+2,perfDPABlock(perfDPABlock(:,3)==1,1:2),'b');
% 
% xlim([1,7]);
% % ylim([55,100]);
% set(gca,'XTick',[2 3 5 6 8 9],'XTickLabel',{'off','on','off','on','off','on'});
% print('CtrlOpSupress.eps','-depsc','-r0','-painters');
% 
% 
% figure('Color','w','Position',[100,100,450,180]);
% hold on;
% yyaxis left;
% plotOne([2,1]+1,perfDPABlock(perfDPABlock(:,3)==1,4:5),'b');
% plotOne([4,3]+2,perfDPABlock(perfDPABlock(:,3)==1,6:7),'b');
% yyaxis right;
% plotOne([6,5]+3,norminv((1-(perfDPABlock(perfDPABlock(:,3)==1,4:5)./100))*0.98+0.01)-norminv(perfDPABlock(perfDPABlock(:,3)==1,6:7)./100*0.98+0.01),'b');
% 
% xlim([1,11]);
% % ylim([55,100]);
% set(gca,'XTick',[2 3 5 6 8 9],'XTickLabel',{'off','on','off','on','off','on'});
% print('CtrlOpSupress.eps','-depsc','-r0','-painters');
% return;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 12s false miss %
%%%%%%%%%%%%%%%%%%

close all;
set(groot,'DefaultLineLineWidth',1);
figure('Color','w','Position',[100,100,300,180]);
hold on;
yyaxis left;
% plotOne([2,1],perf5(perf5(:,3)==0,1:2),'k');
% plotOne([4,3]+1,perf5(perf5(:,3)==1,1:2),'b');
% plotOne([6,5]+2,perf8(perf8(:,3)==1,1:2),'b');
plotOne([2,1],perf12(perf12(:,3)==1,4:5),'b');
plotOne([4,3]+1,perf12(perf12(:,3)==1,6:7),'b');
yyaxis right;
plotOne([6,5]+2,norminv((1-(perf12(perf12(:,3)==1,4:5)./100))*0.98+0.01)-norminv(perf12(perf12(:,3)==1,6:7)./100*0.98+0.01),'b');

% plotOne([10,9]+4,perfBase(perfBase(:,3)==1,1:2),'b');

xlim([0,9]);
% ylim([0,70]);

[~,p12m]=ttest(perf12(perf12(:,3)==1,4),perf12(perf12(:,3)==1,5));
[~,p12f]=ttest(perf12(perf12(:,3)==1,6),perf12(perf12(:,3)==1,7));

set(gca,'XTick',[1,2,4,5,7,8],'XTickLabel',{'off','on','off','on','off','on'});


% figure('Color','w','Position',[100,100,450,180]);
% hold on;
% plotOne([2,1]+1,perfBase(perfBase(:,3)==1,1:2),'b');
% plotOne([4,3]+2,perfGNG(perfGNG(:,3)==1,1:2),'b');
% 
% xlim([1,7]);
% ylim([55,100]);
return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 12S miss false early late %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% allTrials=allTrials5;
% mice=unique(allTrials(:,7));
% isIncorrect=@(x) x(:,4)==0;
% isMatch=@(x) (x(:,1)==x(:,2));
% stats=[];
% earlyThres=50;
% lateThres=200;
% for mouse=1:size(mice,1)
%     trials=allTrials(allTrials(:,7)==mice(mouse),:);
%     if trials(1,8)==0
%         continue;
%     end
%     falseOffEarly=nnz(isIncorrect(trials) & isMatch(trials) & trials(:,3)==0 & trials(:,6)<=earlyThres)*100/nnz(isMatch(trials) & trials(:,3)==0 & trials(:,6)<=earlyThres);
%     falseOffLate=nnz(isIncorrect(trials) & isMatch(trials) & trials(:,3)==0 & trials(:,6)>lateThres)*100/nnz(isMatch(trials) & trials(:,3)==0 & trials(:,6)>lateThres);
%     
%     falseOnEarly=nnz(isIncorrect(trials) & isMatch(trials) & trials(:,3)==1 & trials(:,6)<=earlyThres)*100/nnz(isMatch(trials) & trials(:,3)==1 & trials(:,6)<=earlyThres);
%     falseOnLate=nnz(isIncorrect(trials) & isMatch(trials) & trials(:,3)==1 & trials(:,6)>lateThres)*100/nnz(isMatch(trials) & trials(:,3)==1 & trials(:,6)>lateThres);
% 
% 
%     missOffEarly=nnz(isIncorrect(trials) & (~isMatch(trials)) & trials(:,3)==0 & trials(:,6)<=earlyThres)*100/nnz((~isMatch(trials)) & trials(:,3)==0 & trials(:,6)<=earlyThres);
%     missOffLate=nnz(isIncorrect(trials) & (~isMatch(trials)) & trials(:,3)==0 & trials(:,6)>lateThres)*100/nnz((~isMatch(trials)) & trials(:,3)==0 & trials(:,6)>lateThres);
%     
%     missOnEarly=nnz(isIncorrect(trials) & (~isMatch(trials)) & trials(:,3)==1 & trials(:,6)<=earlyThres)*100/nnz((~isMatch(trials)) & trials(:,3)==1 & trials(:,6)<=earlyThres);
%     missOnLate=nnz(isIncorrect(trials) & (~isMatch(trials)) & trials(:,3)==1 & trials(:,6)>lateThres)*100/nnz((~isMatch(trials)) & trials(:,3)==1 & trials(:,6)>lateThres);
%     stats=[stats;missOnEarly, missOffEarly, missOnLate, missOffLate, falseOnEarly, falseOffEarly, falseOnLate, falseOffLate];
% end
%     
% 
% close all;
% set(groot,'DefaultLineLineWidth',1);
% figure('Color','w','Position',[100,100,450,180]);
% hold on;
% 
% plotOne([2,1]+1,stats(:,1:2),'b');
% plotOne([4,3]+2,stats(:,3:4),'b');
% 
% plotOne([6,5]+3,stats(:,5:6),'b');
% plotOne([8,7]+4,stats(:,7:8),'b');
% 
% 
% % set(gca,'XTick',[1,2,4,5],'XTickLabel',{'off','on','off','on'});
% % xlim([1,7]);
% % ylim([55,100]);
% 
% 
% return;





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% plot([12,12],ylim(),':k','LineWidth',1);

set(gca,'YTick',60:20:100,'XTick',[1 2 4 5 7 8 10 11 13 14],'XTickLabel',[]);
savefig('OptoSupress.fig');

[~,p5n]=ttest(perf5(perf5(:,3)==0,1),perf5(perf5(:,3)==0,2));
[~,p5]=ttest(perf5(perf5(:,3)==1,1),perf5(perf5(:,3)==1,2));
[~,p8]=ttest(perf8(perf8(:,3)==1,1),perf8(perf8(:,3)==1,2));
[~,p12]=ttest(perf12(perf12(:,3)==1,1),perf12(perf12(:,3)==1,2));


[~,pbase]=ttest(perfBase(perfBase(:,3)==1,1),perfBase(perfBase(:,3)==1,2));
[~,pGNG]=ttest(perfGNG(perfGNG(:,3)==1,1),perfGNG(perfGNG(:,3)==1,2));



function plotOne(x,y,pColor)
dd=0.5;
randd=@(x) rand(size(x,1),1)*0.5-0.25;
plot((x+randd(y))',y',sprintf('-%s.',pColor));

ci=bootci(100,@(x) nanmean(x), y(:,2));
plot([x(2)-dd,x(2)-dd],ci,sprintf('-%s',pColor),'LineWidth',1);
[~,p]=ttest(y(:,1),y(:,2));
disp(p);
% disp(ci)
ci=bootci(100,@(x) nanmean(x), y(:,1));
plot([x(1)+dd,x(1)+dd],ci,sprintf('-%s',pColor),'LineWidth',1);

plot(x(2)-dd,nanmean(y(:,2)),sprintf('%so',pColor),'MarkerFaceColor','w','MarkerSize',4,'LineWidth',1);
plot(x(1)+dd,nanmean(y(:,1)),sprintf('%so',pColor),'MarkerFaceColor',pColor,'MarkerSize',4,'LineWidth',1);

end




 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function loadFilesAnova
load dnmsfiles.mat
[~,perf5]=stats_GLM(dnmsfiles.delay5s);
[~,perf8]=stats_GLM(dnmsfiles.delay8s);
[~,perf12]=stats_GLM(dnmsfiles.delay12s);
[~,perfBase]=stats_GLM(dnmsfiles.baseline);


n51=[perf5(:,1),perf5(:,3),ones(length(perf5),1),ones(length(perf5),1)*5,perf5(:,8)];
n50=[perf5(:,2),perf5(:,3),ones(length(perf5),1)*0,ones(length(perf5),1)*5,perf5(:,8)];
n81=[perf8(:,1),perf8(:,3),ones(length(perf8),1),ones(length(perf8),1)*8,perf8(:,8)];
n80=[perf8(:,2),perf8(:,3),ones(length(perf8),1)*0,ones(length(perf8),1)*8,perf8(:,8)];
n121=[perf12(:,1),perf12(:,3),ones(length(perf12),1),ones(length(perf12),1)*12,perf12(:,8)];
n120=[perf12(:,2),perf12(:,3),ones(length(perf12),1)*0,ones(length(perf12),1)*12,perf12(:,8)];
toN=[n51;n50;n81;n80;n121;n120];
terms=[1 0 0 ;
       0 1 0 ;
       0 0 1 ;
       0 1 1 ;
       1 1 1 ];

anovan(toN(:,1),{toN(:,2),toN(:,3),toN(:,4)},'model',terms,'continuous',3, 'varnames',{'Gene','Laser','DelayLen'});
end

% sel=@(x,y) x(x(:,3)==y,1:2);
% fprintf('%.3f, %.3f',mean([sel(perf5,0);sel(perf8,0);sel(perf12,0)]),mean([sel(perf5,1);sel(perf8,1);sel(perf12,1)]))
% [~,p]=ttest2([sel(perf5,0);sel(perf8,0);sel(perf12,0)],[sel(perf5,1);sel(perf8,1);sel(perf12,1)])
% 
% 
% 
% 



