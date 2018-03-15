
close all;
set(groot,'DefaultLineLineWidth',1);
figure('Color','w','Position',[100,100,450,180]);
hold on;
plotOne([2,1],perf5(perf5(:,3)==0,1:2),'k');
plotOne([4,3]+1,perf5(perf5(:,3)==1,1:2),'b');
plotOne([6,5]+2,perf8(perf8(:,3)==1,1:2),'b');
plotOne([8,7]+3,perf12(perf12(:,3)==1,1:2),'b');
plotOne([10,9]+4,perfBase(perfBase(:,3)==1,1:2),'b');

xlim([0,15]);
ylim([55,100]);

plot([12,12],ylim(),':k','LineWidth',1);

set(gca,'YTick',60:20:100,'XTick',[1 2 4 5 7 8 10 11 13 14],'XTickLabel',[]);
savefig('OptoSupress.fig');

[~,p5n]=ttest(perf5(perf5(:,3)==0,1),perf5(perf5(:,3)==0,2));
[~,p5]=ttest(perf5(perf5(:,3)==1,1),perf5(perf5(:,3)==1,2));
[~,p8]=ttest(perf8(perf8(:,3)==1,1),perf8(perf8(:,3)==1,2));
[~,p12]=ttest(perf12(perf12(:,3)==1,1),perf12(perf12(:,3)==1,2));





function plotOne(x,y,pColor)
dd=0.5;
randd=@(x) rand(size(x,1),1)*0.5-0.25;
plot((x+randd(y))',y',sprintf('-%s.',pColor));

ci=bootci(100,@(x) mean(x), y(:,2));
plot([x(2)-dd,x(2)-dd],ci,sprintf('-%s',pColor),'LineWidth',1);
disp(ci)
ci=bootci(100,@(x) mean(x), y(:,1));
plot([x(1)+dd,x(1)+dd],ci,sprintf('-%s',pColor),'LineWidth',1);

plot(x(2)-dd,mean(y(:,2)),sprintf('%so',pColor),'MarkerFaceColor','w','MarkerSize',4,'LineWidth',1);
plot(x(1)+dd,mean(y(:,1)),sprintf('%so',pColor),'MarkerFaceColor',pColor,'MarkerSize',4,'LineWidth',1);

end




 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function loadFilesAnova
load dnmsfiles.mat
[~,perf5]=stats_GLM(dnmsfiles.delay5s);
[~,perf8]=stats_GLM(dnmsfiles.delay8s);
[~,perf12]=stats_GLM(dnmsfiles.delay12s);
[~,perfBase]=stats_GLM(dnmsfiles.baseline);

n51=[perf5(:,1),perf5(:,3),ones(length(perf5),1),ones(length(perf5),1)*5];
n50=[perf5(:,2),perf5(:,3),ones(length(perf5),1)*0,ones(length(perf5),1)*5];
n81=[perf8(:,1),perf8(:,3),ones(length(perf8),1),ones(length(perf8),1)*8];
n80=[perf8(:,2),perf8(:,3),ones(length(perf8),1)*0,ones(length(perf8),1)*8];
n121=[perf12(:,1),perf12(:,3),ones(length(perf12),1),ones(length(perf12),1)*12];
n120=[perf12(:,2),perf12(:,3),ones(length(perf12),1)*0,ones(length(perf12),1)*12];
toN=[n51;n50;n81;n80;n121;n120];
anovan(toN(:,1),{toN(:,2),toN(:,3),toN(:,4)},'model','interaction','continuous',3, 'varnames',{'Gene','Laser','DelayLen'})
end

