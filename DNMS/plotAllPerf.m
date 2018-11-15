addpath('D:\Behavior\reports\extern_lib');


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%% Fig.1 Perf 12 8 5 %%%%%%%%%%%%%%%%%%%
% 
% % % 
% close all;
% set(groot,'DefaultLineLineWidth',1);
% figure('Color','w','Position',[100,100,170,180]);
% hold on;
% plotOne([2,1],perf5(perf5(:,3)==0,1:2),'k');
% plotOne([4,3]+1,perf5(perf5(:,3)==1,1:2),'b');
% set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'},'FontSize',10,'YTick',60:20:100);
% xlim([0,6]);
% ylim([55,100]);
% ylabel('Correct Rate (%)','FontSize',10);
% print('-depsc','-painters','-r0','perf5s.eps');
% 
% set(groot,'DefaultLineLineWidth',1);
% figure('Color','w','Position',[100,100,170,180]);
% hold on;
% plotOne([2,1],perf8(perf8(:,3)==0,1:2),'k');
% plotOne([4,3]+1,perf8(perf8(:,3)==1,1:2),'b');
% set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'},'FontSize',10,'YTick',60:20:100);
% xlim([0,6]);
% ylim([55,100]);ylabel('Correct Rate (%)','FontSize',10);
% print('-depsc','-painters','-r0','perf8s.eps');
% 
% 
% set(groot,'DefaultLineLineWidth',1);
% figure('Color','w','Position',[100,100,170,180]);
% hold on;
% plotOne([2,1],perf12(perf12(:,3)==0,1:2),'k');
% plotOne([4,3]+1,perf12(perf12(:,3)==1,1:2),'b');
% set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'},'FontSize',10,'YTick',60:20:100);
% xlim([0,6]);
% ylim([55,100]);
% ylabel('Correct Rate (%)','FontSize',10);
% print('-depsc','-painters','-r0','perf12s.eps');
% 
% disp('ranksum 5, 8, 12');
% disp(ranksum(diff(perf5(perf5(:,3)==0,1:2),1,2),diff(perf5(perf5(:,3)==1,1:2),1,2)));
% disp(ranksum(diff(perf8(perf8(:,3)==0,1:2),1,2),diff(perf8(perf8(:,3)==1,1:2),1,2)));
% disp(ranksum(diff(perf12(perf12(:,3)==0,1:2),1,2),diff(perf12(perf12(:,3)==1,1:2),1,2)));
% 
% disp('adtest 5, 8, 12');
% [~,p]=adtest(diff(perf5(perf5(:,3)==1,1:2),1,2));
% fprintf('Anderson–Darling test\tn = %d\tp = %.4f\n',sum(perf5(:,3)==1),p);
% [~,p]=adtest(diff(perf8(perf8(:,3)==1,1:2),1,2));
% fprintf('Anderson–Darling test\tn = %d\tp = %.4f\n',sum(perf8(:,3)==1),p);
% [~,p]=adtest(diff(perf12(perf12(:,3)==1,1:2),1,2));
% fprintf('Anderson–Darling test\tn = %d\tp = %.4f\n',sum(perf12(:,3)==1),p);
% 
% disp('Mixed-between-within-ANOVA');
% [~,~,~,~,p]=mixed_between_within_anova(rearrange(perf5(perf5(:,3)==0,1),perf5(perf5(:,3)==0,2),perf5(perf5(:,3)==1,1),perf5(perf5(:,3)==1,2)));
% fprintf('Mixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% [~,~,~,~,p]=mixed_between_within_anova(rearrange(perf8(perf8(:,3)==0,1),perf8(perf8(:,3)==0,2),perf8(perf8(:,3)==1,1),perf8(perf8(:,3)==1,2)));
% fprintf('Mixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% [~,~,~,~,p]=mixed_between_within_anova(rearrange(perf12(perf12(:,3)==0,1),perf12(perf12(:,3)==0,2),perf12(perf12(:,3)==1,1),perf12(perf12(:,3)==1,2)));
% fprintf('Mixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% 
% 
% 
% return
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Fig.1 false miss lick dp 12s
% 
% figure('Color','w','Position',[100,100,170,180]);
% hold on;
% plotOne([2,1],perf12(perf12(:,3)==0,4:5),'k');
% plotOne([4,3]+1,perf12(perf12(:,3)==1,4:5),'b');
% set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'});
% xlim([0,6]);
% ylim([0,50]);
% ylabel('Miss (%)','FontSize',10);
% print('-depsc','-painters','-r0','miss12s.eps');
% 
% figure('Color','w','Position',[300,100,170,180]);
% hold on;
% plotOne([2,1],perf12(perf12(:,3)==0,6:7),'k');
% plotOne([4,3]+1,perf12(perf12(:,3)==1,6:7),'b');
% set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'});
% xlim([0,6]);
% ylim([0,100]);
% ylabel('False alarm (%)','FontSize',10);
% print('-depsc','-painters','-r0','false12s.eps');
% 
% figure('Color','w','Position',[500,100,170,180]);
% hold on;
% plotOne([2,1],perf12(perf12(:,3)==0,9:10),'k');
% plotOne([4,3]+1,perf12(perf12(:,3)==1,9:10),'b');
% set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'});
% xlim([0,6]);
% ylim([50,100]);
% ylabel('Lick efficiency (%)','FontSize',10);
% print('-depsc','-painters','-r0','lick12s.eps');
% 
% figure('Color','w','Position',[700,100,170,180]);
% hold on;
% plotOne([2,1],norminv((1-(perf12(perf12(:,3)==0,4:5)./100))*0.98+0.01)-norminv(perf12(perf12(:,3)==0,6:7)./100*0.98+0.01),'k');
% plotOne([4,3]+1,norminv((1-(perf12(perf12(:,3)==1,4:5)./100))*0.98+0.01)-norminv(perf12(perf12(:,3)==1,6:7)./100*0.98+0.01),'b');
% set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'});
% xlim([0,6]);
% ylim([0,5]);
% ylabel('Sensitivity index (d'')','FontSize',10);
% print('-depsc','-painters','-r0','dprime12s.eps');
% 
% 
% disp('ranksum miss')
% disp(ranksum(diff(perf12(perf12(:,3)==0,4:5),1,2),diff(perf12(perf12(:,3)==1,4:5),1,2)));
% disp('ranksum false')
% disp(ranksum(diff(perf12(perf12(:,3)==0,6:7),1,2),diff(perf12(perf12(:,3)==1,6:7),1,2)));
% disp('ranksum lickEff')
% disp(ranksum(diff(perf12(perf12(:,3)==0,9:10),1,2),diff(perf12(perf12(:,3)==1,9:10),1,2)));
% disp('ranksum d''')
% disp(ranksum(...
% diff(norminv((1-(perf12(perf12(:,3)==0,4:5)./100))*0.98+0.01)-norminv(perf12(perf12(:,3)==0,6:7)./100*0.98+0.01),1,2),...
% diff(norminv((1-(perf12(perf12(:,3)==1,4:5)./100))*0.98+0.01)-norminv(perf12(perf12(:,3)==1,6:7)./100*0.98+0.01),1,2)));
% 
% 
% 
% disp('adtest 12, miss, false, lickEff, d''');
% perf=perf12;[~,p]=swtest(diff(perf(perf(:,3)==1,4:5),1,2));
% fprintf('Anderson–Darling test\tn = %d\tp = %.4f\n',sum(perf(:,3)==1),p);
% [~,p]=adtest(diff(perf(perf(:,3)==1,6:7),1,2));
% fprintf('Anderson–Darling test\tn = %d\tp = %.4f\n',sum(perf(:,3)==1),p);
% [~,p]=adtest(diff(perf(perf(:,3)==1,9:10),1,2));
% fprintf('Anderson–Darling test\tn = %d\tp = %.4f\n',sum(perf(:,3)==1),p);
% [~,p]=adtest(...
% diff(norminv((1-(perf12(perf12(:,3)==1,4:5)./100))*0.98+0.01)-norminv(perf12(perf12(:,3)==1,6:7)./100*0.98+0.01),1,2));
% fprintf('Anderson–Darling test\tn = %d\tp = %.4f\n',sum(perf(:,3)==1),p);
% 
% 
% disp('Mixed-between-within-ANOVA');
% [~,~,~,~,p]=mixed_between_within_anova(rearrange(perf(perf(:,3)==0,4),perf(perf(:,3)==0,5),perf(perf(:,3)==1,4),perf(perf(:,3)==1,5)));
% fprintf('Mixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% [~,~,~,~,p]=mixed_between_within_anova(rearrange(perf(perf(:,3)==0,6),perf(perf(:,3)==0,7),perf(perf(:,3)==1,6),perf(perf(:,3)==1,7)));
% fprintf('Mixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% [~,~,~,~,p]=mixed_between_within_anova(rearrange(perf(perf(:,3)==0,9),perf(perf(:,3)==0,10),perf(perf(:,3)==1,9),perf(perf(:,3)==1,10)));
% fprintf('Mixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% [~,~,~,~,p]=mixed_between_within_anova(rearrange(...
%     (norminv((1-(perf12(perf12(:,3)==0,4)./100))*0.98+0.01)-norminv(perf12(perf12(:,3)==0,6)./100*0.98+0.01)),...
%     (norminv((1-(perf12(perf12(:,3)==0,5)./100))*0.98+0.01)-norminv(perf12(perf12(:,3)==0,7)./100*0.98+0.01)),...
%     (norminv((1-(perf12(perf12(:,3)==1,4)./100))*0.98+0.01)-norminv(perf12(perf12(:,3)==1,6)./100*0.98+0.01)),...
%     (norminv((1-(perf12(perf12(:,3)==1,5)./100))*0.98+0.01)-norminv(perf12(perf12(:,3)==1,7)./100*0.98+0.01))));
% fprintf('Mixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% 
% 
% return



% %%%%%%%%%%%%%%%%%%%
% % Fig.2 Ctrl Op Supress %
% %%%%%%%%%%%%%%%%%%%
% 
% [~,perfGNG]=stats_GLM(dnmsfiles.gonogo,[],true);
% 
% [~,perfBase]=stats_GLM(dnmsfiles.baseline);
% [~,perfNoDelay]=stats_GLM(dnmsfiles.noDelayBaselineResp);
% 
% figure('Color','w','Position',[100,100,170,180]);
% hold on;
% plotOne([2,1],perfBase(perfBase(:,3)==0,1:2),'k');
% plotOne([5,4],perfBase(perfBase(:,3)==1,1:2),'b');
% set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'});
% xlim([0,6]);
% ylim([55,100]);
% ylabel('Correct rate (%)','FontSize',10);
% print('-depsc','-painters','-r0','perfBaseline.eps');
% 
% 
% figure('Color','w','Position',[100,100,170,180]);
% hold on;
% plotOne([2,1],perfGNG(perfGNG(:,3)==0,1:2),'k');
% plotOne([5,4],perfGNG(perfGNG(:,3)==1,1:2),'b');
% set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'});
% xlim([0,6]);
% ylim([55,100]);
% ylabel('Correct rate (%)','FontSize',10);
% print('-depsc','-painters','-r0','perfGNG.eps');
% 
% 
% 
% figure('Color','w','Position',[100,100,170,180]);
% hold on;
% plotOne([2,1],perfNoDelay(perfNoDelay(:,3)==0,1:2),'k');
% plotOne([5,4],perfNoDelay(perfNoDelay(:,3)==1,1:2),'b');
% set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'});
% xlim([0,6]);
% ylim([55,100]);
% ylabel('Correct rate (%)','FontSize',10);
% print('-depsc','-painters','-r0','perfNoDelay.eps');
% 
% 
% disp('ranksum baseline GNG noDelay');
% ranksum(diff(perfBase(perfBase(:,3)==0,1:2),1,2),diff(perfBase(perfBase(:,3)==1,1:2),1,2))
% ranksum(diff(perfGNG(perfGNG(:,3)==0,1:2),1,2),diff(perfGNG(perfGNG(:,3)==1,1:2),1,2))
% ranksum(diff(perfNoDelay(perfNoDelay(:,3)==0,1:2),1,2),diff(perfNoDelay(perfNoDelay(:,3)==1,1:2),1,2))
% 
% 
% 
% 
% disp('adtest 12, miss, false, lickEff, d''');
% perf=perfBase;[~,p]=swtest(diff(perf(perf(:,3)==1,1:2),1,2));
% fprintf('Anderson–Darling test\tn = %d\tp = %.4f\n',sum(perf(:,3)==1),p);
% perf=perfGNG;[~,p]=adtest(diff(perf(perf(:,3)==1,1:2),1,2));
% fprintf('Anderson–Darling test\tn = %d\tp = %.4f\n',sum(perf(:,3)==1),p);
% perf=perfNoDelay;[~,p]=adtest(diff(perf(perf(:,3)==1,1:2),1,2));
% fprintf('Anderson–Darling test\tn = %d\tp = %.4f\n',sum(perf(:,3)==1),p);
% 
% 
% disp('Mixed-between-within-ANOVA');
% perf=perfBase;[~,~,~,~,p]=mixed_between_within_anova(rearrange(perf(perf(:,3)==0,1),perf(perf(:,3)==0,2),perf(perf(:,3)==1,1),perf(perf(:,3)==1,2)));
% fprintf('Mixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% perf=perfGNG;[~,~,~,~,p]=mixed_between_within_anova(rearrange(perf(perf(:,3)==0,1),perf(perf(:,3)==0,2),perf(perf(:,3)==1,1),perf(perf(:,3)==1,2)));
% fprintf('Mixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% perf=perfNoDelay;[~,~,~,~,p]=mixed_between_within_anova(rearrange(perf(perf(:,3)==0,1),perf(perf(:,3)==0,2),perf(perf(:,3)==1,1),perf(perf(:,3)==1,2)));
% fprintf('Mixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% 
% 
% 
% return;



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %  F4  DPA block
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~,perfDPABlock]=stats_GLM(ODPAfiles.DPA_delay_laser);

% close all;
% set(groot,'DefaultLineLineWidth',1);
% figure('Color','w','Position',[100,100,245,180]);
% hold on;
% plotOne([2,1],perfDPABlock(perfDPABlock(:,3)==0,1:2),'k');
% plotOne([4,3]+1,perfDPABlock(perfDPABlock(:,3)==1,1:2),'b');
% 
% set(gca,'XTick',[1,2,4,5],'XTickLabel',{'off','on','off','on'});
% ylim([55,100]);
% xlim([0,6]);
% ylabel('Correct rate (%)');
% ah=gca();
% ah.YAxis.Color='k';
% print('DPAperf.eps','-depsc','-r0');
% 
% disp('ranksum perf');
% disp(ranksum(perfDPABlock(perfDPABlock(:,3)==0,2)-perfDPABlock(perfDPABlock(:,3)==0,1),perfDPABlock(perfDPABlock(:,3)==1,2)-perfDPABlock(perfDPABlock(:,3)==1,1)));
% 
% perf=perfDPABlock;[~,p]=adtest(diff(perf(perf(:,3)==1,1:2),1,2));
% fprintf('Anderson–Darling test\tn = %d\tp = %.4f\n',sum(perf(:,3)==1),p);
% 
% perf=perfDPABlock;[~,~,~,~,p]=mixed_between_within_anova(rearrange(perf(perf(:,3)==0,1),perf(perf(:,3)==0,2),perf(perf(:,3)==1,1),perf(perf(:,3)==1,2)));
% fprintf('Mixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% 
% return
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %  S7  DPA block Miss false lickEff d'
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% disp('ranksum miss')
% disp(ranksum(diff(perfDPABlock(perfDPABlock(:,3)==0,4:5),1,2),diff(perfDPABlock(perfDPABlock(:,3)==1,4:5),1,2)));
% disp('ranksum false')
% disp(ranksum(diff(perfDPABlock(perfDPABlock(:,3)==0,6:7),1,2),diff(perfDPABlock(perfDPABlock(:,3)==1,6:7),1,2)));
% disp('ranksum lickEff')
% disp(ranksum(diff(perfDPABlock(perfDPABlock(:,3)==0,9:10),1,2),diff(perfDPABlock(perfDPABlock(:,3)==1,9:10),1,2)));
% disp('ranksum d''')
% disp(ranksum(...
% diff(norminv((1-(perfDPABlock(perfDPABlock(:,3)==0,4:5)./100))*0.98+0.01)-norminv(perfDPABlock(perfDPABlock(:,3)==0,6:7)./100*0.98+0.01),1,2),...
% diff(norminv((1-(perfDPABlock(perfDPABlock(:,3)==1,4:5)./100))*0.98+0.01)-norminv(perfDPABlock(perfDPABlock(:,3)==1,6:7)./100*0.98+0.01),1,2)));
% 
% disp('Miss, FA, LickEff, d''');
% 
% 
% figure('Color','w','Position',[100,100,160,180]);
% hold on;
% plotOne([2,1],perfDPABlock(perfDPABlock(:,3)==0,4:5),'k');
% plotOne([4,3]+1,perfDPABlock(perfDPABlock(:,3)==1,4:5),'b');
% set(gca,'XTick',[1,2,4,5],'XTickLabel',{'off','on','off','on'});
% xlim([0,6]);
% ylim([0,50]);
% ylabel('Miss');
% print('-depsc','-painters','-r0','missDPA.eps');
% 
% figure('Color','w','Position',[300,100,160,180]);
% hold on;
% plotOne([2,1],perfDPABlock(perfDPABlock(:,3)==0,6:7),'k');
% plotOne([5,4],perfDPABlock(perfDPABlock(:,3)==1,6:7),'b');
% set(gca,'XTick',[1,2,4,5],'XTickLabel',{'off','on','off','on'});
% xlim([0,6]);
% ylim([0,100]);
% ylabel('False alarm');
% print('-depsc','-painters','-r0','FA_DPA.eps');
% 
% 
% figure('Color','w','Position',[500,100,160,180]);
% hold on;
% plotOne([2,1],perfDPABlock(perfDPABlock(:,3)==0,9:10),'k');
% plotOne([5,4],perfDPABlock(perfDPABlock(:,3)==1,9:10),'b');
% set(gca,'XTick',[1,2,4,5],'XTickLabel',{'off','on','off','on'});
% xlim([0,6]);
% ylim([50,100]);
% ylabel('Lick efficiency');
% print('-depsc','-painters','-r0','LickEffDPA.eps');
% 
% 
% figure('Color','w','Position',[700,100,160,180]);
% hold on;
% plotOne([2,1],norminv((1-(perfDPABlock(perfDPABlock(:,3)==0,4:5)./100))*0.98+0.01)-norminv(perfDPABlock(perfDPABlock(:,3)==0,6:7)./100*0.98+0.01),'k');
% plotOne([5,4],norminv((1-(perfDPABlock(perfDPABlock(:,3)==1,4:5)./100))*0.98+0.01)-norminv(perfDPABlock(perfDPABlock(:,3)==1,6:7)./100*0.98+0.01),'b');
% set(gca,'XTick',[1,2,4,5],'XTickLabel',{'off','on','off','on'});
% xlim([0,6]);
% ylim([0,5]);
% ylabel('Sensitivity index (d'')');
% print('-depsc','-painters','-r0','DPrimeDPA.eps');
% 
% perf=perfDPABlock;
% [~,~,~,~,p]=mixed_between_within_anova(rearrange(perf(perf(:,3)==0,4),perf(perf(:,3)==0,5),perf(perf(:,3)==1,4),perf(perf(:,3)==1,5)));
% fprintf('Miss\tMixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% [~,~,~,~,p]=mixed_between_within_anova(rearrange(perf(perf(:,3)==0,6),perf(perf(:,3)==0,7),perf(perf(:,3)==1,6),perf(perf(:,3)==1,7)));
% fprintf('FA\tMixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% [~,~,~,~,p]=mixed_between_within_anova(rearrange(perf(perf(:,3)==0,9),perf(perf(:,3)==0,10),perf(perf(:,3)==1,9),perf(perf(:,3)==1,10)));
% fprintf('LE\tMixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% [~,~,~,~,p]=mixed_between_within_anova(rearrange(...
% norminv((1-(perf(perf(:,3)==0,4)./100))*0.98+0.01)-norminv(perf(perf(:,3)==0,6)./100*0.98+0.01),...
% norminv((1-(perf(perf(:,3)==0,5)./100))*0.98+0.01)-norminv(perf(perf(:,3)==0,7)./100*0.98+0.01),...
% norminv((1-(perf(perf(:,3)==1,4)./100))*0.98+0.01)-norminv(perf(perf(:,3)==1,6)./100*0.98+0.01),...
% norminv((1-(perf(perf(:,3)==1,5)./100))*0.98+0.01)-norminv(perf(perf(:,3)==1,7)./100*0.98+0.01)...
% ));
% fprintf('DP\tMixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% 
% return




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% false miss lick dp 8s
% 
% figure('Color','w','Position',[100,100,170,180]);
% hold on;
% plotOne([2,1],perf8(perf8(:,3)==0,4:5),'k');
% plotOne([4,3]+1,perf8(perf8(:,3)==1,4:5),'b');
% set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'});
% xlim([0,6]);
% ylim([0,50]);
% ylabel('Miss (%)','FontSize',10);
% print('-depsc','-painters','-r0','miss8s.eps');
% 
% figure('Color','w','Position',[300,100,170,180]);
% hold on;
% plotOne([2,1],perf8(perf8(:,3)==0,6:7),'k');
% plotOne([4,3]+1,perf8(perf8(:,3)==1,6:7),'b');
% set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'});
% xlim([0,6]);
% ylim([0,100]);
% ylabel('False alarm (%)','FontSize',10);
% print('-depsc','-painters','-r0','false8s.eps');
% 
% figure('Color','w','Position',[500,100,170,180]);
% hold on;
% plotOne([2,1],perf8(perf8(:,3)==0,9:10),'k');
% plotOne([4,3]+1,perf8(perf8(:,3)==1,9:10),'b');
% set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'});
% xlim([0,6]);
% ylim([50,100]);
% ylabel('Lick efficiency (%)','FontSize',10);
% print('-depsc','-painters','-r0','lick8s.eps');
% 
% figure('Color','w','Position',[700,100,170,180]);
% hold on;
% plotOne([2,1],norminv((1-(perf8(perf8(:,3)==0,4:5)./100))*0.98+0.01)-norminv(perf8(perf8(:,3)==0,6:7)./100*0.98+0.01),'k');
% plotOne([4,3]+1,norminv((1-(perf8(perf8(:,3)==1,4:5)./100))*0.98+0.01)-norminv(perf8(perf8(:,3)==1,6:7)./100*0.98+0.01),'b');
% set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'});
% xlim([0,6]);
% ylim([0,5]);
% ylabel('Sensitivity index (d'')','FontSize',10);
% print('-depsc','-painters','-r0','dprime8s.eps');
% 
% 
% disp('ranksum miss')
% disp(ranksum(diff(perf8(perf8(:,3)==0,4:5),1,2),diff(perf8(perf8(:,3)==1,4:5),1,2)));
% disp('ranksum false')
% disp(ranksum(diff(perf8(perf8(:,3)==0,6:7),1,2),diff(perf8(perf8(:,3)==1,6:7),1,2)));
% disp('ranksum lickEff')
% disp(ranksum(diff(perf8(perf8(:,3)==0,9:10),1,2),diff(perf8(perf8(:,3)==1,9:10),1,2)));
% disp('ranksum d''')
% disp(ranksum(...
% diff(norminv((1-(perf8(perf8(:,3)==0,4:5)./100))*0.98+0.01)-norminv(perf8(perf8(:,3)==0,6:7)./100*0.98+0.01),1,2),...
% diff(norminv((1-(perf8(perf8(:,3)==1,4:5)./100))*0.98+0.01)-norminv(perf8(perf8(:,3)==1,6:7)./100*0.98+0.01),1,2)));
% 
% 
% perf=perf8;
% [~,~,~,~,p]=mixed_between_within_anova(rearrange(perf(perf(:,3)==0,4),perf(perf(:,3)==0,5),perf(perf(:,3)==1,4),perf(perf(:,3)==1,5)));
% fprintf('Miss\tMixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% [~,~,~,~,p]=mixed_between_within_anova(rearrange(perf(perf(:,3)==0,6),perf(perf(:,3)==0,7),perf(perf(:,3)==1,6),perf(perf(:,3)==1,7)));
% fprintf('FA\tMixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% [~,~,~,~,p]=mixed_between_within_anova(rearrange(perf(perf(:,3)==0,9),perf(perf(:,3)==0,10),perf(perf(:,3)==1,9),perf(perf(:,3)==1,10)));
% fprintf('LE\tMixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% [~,~,~,~,p]=mixed_between_within_anova(rearrange(...
% norminv((1-(perf(perf(:,3)==0,4)./100))*0.98+0.01)-norminv(perf(perf(:,3)==0,6)./100*0.98+0.01),...
% norminv((1-(perf(perf(:,3)==0,5)./100))*0.98+0.01)-norminv(perf(perf(:,3)==0,7)./100*0.98+0.01),...
% norminv((1-(perf(perf(:,3)==1,4)./100))*0.98+0.01)-norminv(perf(perf(:,3)==1,6)./100*0.98+0.01),...
% norminv((1-(perf(perf(:,3)==1,5)./100))*0.98+0.01)-norminv(perf(perf(:,3)==1,7)./100*0.98+0.01)...
% ));
% fprintf('DP\tMixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% 
% return



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%% false miss lick dp 5s
% 
% figure('Color','w','Position',[100,100,170,180]);
% hold on;
% plotOne([2,1],perf5(perf5(:,3)==0,4:5),'k');
% plotOne([4,3]+1,perf5(perf5(:,3)==1,4:5),'b');
% set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'});
% xlim([0,6]);
% ylim([0,50]);
% ylabel('Miss (%)','FontSize',10);
% print('-depsc','-painters','-r0','miss5s.eps');
% 
% figure('Color','w','Position',[300,100,170,180]);
% hold on;
% plotOne([2,1],perf5(perf5(:,3)==0,6:7),'k');
% plotOne([4,3]+1,perf5(perf5(:,3)==1,6:7),'b');
% set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'});
% xlim([0,6]);
% ylim([0,100]);
% ylabel('False alarm (%)','FontSize',10);
% print('-depsc','-painters','-r0','false5s.eps');
% 
% figure('Color','w','Position',[500,100,170,180]);
% hold on;
% plotOne([2,1],perf5(perf5(:,3)==0,9:10),'k');
% plotOne([4,3]+1,perf5(perf5(:,3)==1,9:10),'b');
% set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'});
% xlim([0,6]);
% ylim([50,100]);
% ylabel('Lick efficiency (%)','FontSize',10);
% print('-depsc','-painters','-r0','lick5s.eps');
% 
% figure('Color','w','Position',[700,100,170,180]);
% hold on;
% plotOne([2,1],norminv((1-(perf5(perf5(:,3)==0,4:5)./100))*0.98+0.01)-norminv(perf5(perf5(:,3)==0,6:7)./100*0.98+0.01),'k');
% plotOne([4,3]+1,norminv((1-(perf5(perf5(:,3)==1,4:5)./100))*0.98+0.01)-norminv(perf5(perf5(:,3)==1,6:7)./100*0.98+0.01),'b');
% set(gca,'XTick',[1 2 4 5],'XTickLabel',{'off','on','off','on'});
% xlim([0,6]);
% ylim([0,5]);
% ylabel('Sensitivity index (d'')','FontSize',10);
% print('-depsc','-painters','-r0','dprime5s.eps');
% 
% 
% disp('ranksum miss')
% disp(ranksum(diff(perf5(perf5(:,3)==0,4:5),1,2),diff(perf5(perf5(:,3)==1,4:5),1,2)));
% disp('ranksum false')
% disp(ranksum(diff(perf5(perf5(:,3)==0,6:7),1,2),diff(perf5(perf5(:,3)==1,6:7),1,2)));
% disp('ranksum lickEff')
% disp(ranksum(diff(perf5(perf5(:,3)==0,9:10),1,2),diff(perf5(perf5(:,3)==1,9:10),1,2)));
% disp('ranksum d''')
% disp(ranksum(...
% diff(norminv((1-(perf5(perf5(:,3)==0,4:5)./100))*0.98+0.01)-norminv(perf5(perf5(:,3)==0,6:7)./100*0.98+0.01),1,2),...
% diff(norminv((1-(perf5(perf5(:,3)==1,4:5)./100))*0.98+0.01)-norminv(perf5(perf5(:,3)==1,6:7)./100*0.98+0.01),1,2)));
% 
% 
% perf=perf5;
% [~,~,~,~,p]=mixed_between_within_anova(rearrange(perf(perf(:,3)==0,4),perf(perf(:,3)==0,5),perf(perf(:,3)==1,4),perf(perf(:,3)==1,5)));
% fprintf('Miss\tMixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% [~,~,~,~,p]=mixed_between_within_anova(rearrange(perf(perf(:,3)==0,6),perf(perf(:,3)==0,7),perf(perf(:,3)==1,6),perf(perf(:,3)==1,7)));
% fprintf('FA\tMixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% [~,~,~,~,p]=mixed_between_within_anova(rearrange(perf(perf(:,3)==0,9),perf(perf(:,3)==0,10),perf(perf(:,3)==1,9),perf(perf(:,3)==1,10)));
% fprintf('LE\tMixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% [~,~,~,~,p]=mixed_between_within_anova(rearrange(...
% norminv((1-(perf(perf(:,3)==0,4)./100))*0.98+0.01)-norminv(perf(perf(:,3)==0,6)./100*0.98+0.01),...
% norminv((1-(perf(perf(:,3)==0,5)./100))*0.98+0.01)-norminv(perf(perf(:,3)==0,7)./100*0.98+0.01),...
% norminv((1-(perf(perf(:,3)==1,4)./100))*0.98+0.01)-norminv(perf(perf(:,3)==1,6)./100*0.98+0.01),...
% norminv((1-(perf(perf(:,3)==1,5)./100))*0.98+0.01)-norminv(perf(perf(:,3)==1,7)./100*0.98+0.01)...
% ));
% fprintf('DP\tMixed-between-within-ANOVA, within CRZ between interaction\tdf = 1\tp= %.4f\n',p{4});
% 
% 
% 
% 
% 
% return




% 
% set(groot,'DefaultLineLineWidth',1);
% figure('Color','w','Position',[100,100,160,180]);
% hold on;
% plotOne([2,1],perf8(perf8(:,3)==0,1:2),'k');
% xlim([0,3]);
% ylim([55,100]);
% set(gca,'XTick',[2 3 5 6 8 9 11 12]-1,'XTickLabel',{'off','on'});
% ylabel('Correct rate (%)');
% 
% figure('Color','w','Position',[100,100,160,180]);
% hold on;
% plotOne([2,1],perf12(perf12(:,3)==0,1:2),'k');
% xlim([0,3]);
% ylim([55,100]);
% set(gca,'XTick',[2 3 5 6 8 9 11 12]-1,'XTickLabel',{'off','on'});
% ylabel('Correct rate (%)');
% 
% disp('ranksum 5 8 12');
% ranksum(diff(perf5(perf5(:,3)==0,1:2),1,2),diff(perf5(perf5(:,3)==1,1:2),1,2))
% ranksum(diff(perf8(perf8(:,3)==0,1:2),1,2),diff(perf8(perf8(:,3)==1,1:2),1,2))
% ranksum(diff(perf12(perf12(:,3)==0,1:2),1,2),diff(perf12(perf12(:,3)==1,1:2),1,2))
% 
% decay=@(x) 50-exp(-x/21.37)*50;
% decay=@(x) x;

% n51=[perf5(:,1),perf5(:,3),ones(length(perf5),1),ones(length(perf5),1)*decay(5),perf5(:,8),ones(length(perf5),1)*1];
% n50=[perf5(:,2),perf5(:,3),ones(length(perf5),1)*0,ones(length(perf5),1)*decay(5),perf5(:,8),ones(length(perf5),1)*2];
% n81=[perf8(:,1),perf8(:,3),ones(length(perf8),1),ones(length(perf8),1)*decay(8),perf8(:,8),ones(length(perf8),1)*3];
% n80=[perf8(:,2),perf8(:,3),ones(length(perf8),1)*0,ones(length(perf8),1)*decay(8),perf8(:,8),ones(length(perf8),1)*4];
% n121=[perf12(:,1),perf12(:,3),ones(length(perf12),1),ones(length(perf12),1)*decay(12),perf12(:,8),ones(length(perf12),1)*5];
% n120=[perf12(:,2),perf12(:,3),ones(length(perf12),1)*0,ones(length(perf12),1)*decay(12),perf12(:,8),ones(length(perf12),1)*6];
% toN=[n51;n50;n81;n80;n121;n120];
% 
% anovan(toN(:,1),{toN(:,6)},'varnames',{'Group'});

% d5Ch=diff(perf5(perf5(:,3)==1,[1,2]),1,2);
% d8Ch=diff(perf8(perf8(:,3)==1,[1,2]),1,2);
% d12Ch=diff(perf12(perf12(:,3)==1,[1,2]),1,2);
% anovan([d5Ch;d8Ch;d12Ch],{[ones(size(d5Ch));ones(size(d8Ch))*2;ones(size(d12Ch))*12]});
% 


% return;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 12s false miss %
%%%%%%%%%%%%%%%%%%

% close all;
% set(groot,'DefaultLineLineWidth',1);
% figure('Color','w','Position',[100,100,150,180]);
% hold on;
% % yyaxis left;
% % plotOne([2,1],perf5(perf5(:,3)==0,1:2),'k');
% % plotOne([4,3]+1,perf5(perf5(:,3)==1,1:2),'b');
% % plotOne([6,5]+2,perf8(perf8(:,3)==1,1:2),'b');
% plotOne([2,1],perf12(perf12(:,3)==1,4:5),'b');
% plotOne([4,3]+1,perf12(perf12(:,3)==1,6:7),'b');
% set(gca,'XTick',[1,2,4,5],'XTickLabel',{'off','on','off','on'});
% set(gca,'YColor','k');
% xlim([0,6]);
% % yyaxis right;
% figure('Color','w','Position',[500,100,40,180]);
% hold on;
% plotOne([2,1]+1,norminv((1-(perf12(perf12(:,3)==1,4:5)./100))*0.98+0.01)-norminv(perf12(perf12(:,3)==1,6:7)./100*0.98+0.01),'b');
% set(gca,'XTick',[2,3],'XTickLabel',{'off','on'});
% set(gca,'YColor','k');
% % plotOne([10,9]+4,perfBase(perfBase(:,3)==1,1:2),'b');
% 
% xlim([1,4]);
% % ylim([0,70]);
% 
% [~,p12m]=ttest(perf12(perf12(:,3)==1,4),perf12(perf12(:,3)==1,5));
% [~,p12f]=ttest(perf12(perf12(:,3)==1,6),perf12(perf12(:,3)==1,7));
% 
% 
% 
% 
% figure('Color','w','Position',[1400,100,40,180]);
% hold on;
% plotOne([2,1]+1,perf12(perf12(:,3)==1,9:10),'b');
% xlim([1,4]);
% ylim([55,100]);
% set(gca,'XTick',[2,3],'XTickLabel',{'off','on'});
% return;






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

% set(gca,'YTick',60:20:100,'XTick',[1 2 4 5 7 8 10 11 13 14],'XTickLabel',[]);
% savefig('OptoSupress.fig');
% 
% [~,p5n]=ttest(perf5(perf5(:,3)==0,1),perf5(perf5(:,3)==0,2));
% [~,p5]=ttest(perf5(perf5(:,3)==1,1),perf5(perf5(:,3)==1,2));
% [~,p8]=ttest(perf8(perf8(:,3)==1,1),perf8(perf8(:,3)==1,2));
% [~,p12]=ttest(perf12(perf12(:,3)==1,1),perf12(perf12(:,3)==1,2));
% 
% 
% [~,pbase]=ttest(perfBase(perfBase(:,3)==1,1),perfBase(perfBase(:,3)==1,2));
% [~,pGNG]=ttest(perfGNG(perfGNG(:,3)==1,1),perfGNG(perfGNG(:,3)==1,2));



function plotOne(x,y,pColor)
dd=0.5;
randd=@(x) rand(size(x,1),1)*0.5-0.25;
plot((x+randd(y))',y',sprintf('-%s.',pColor));

ci=bootci(1000,@(x) nanmean(x), y(:,2));
plot([x(2)-dd,x(2)-dd],ci,sprintf('-%s',pColor),'LineWidth',1);
[~,p]=ttest(y(:,1),y(:,2));
disp(p);
% disp(ci)
ci=bootci(1000,@(x) nanmean(x), y(:,1));
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

decay=@(x) 50-exp(-x/21.37)*50;
% decay=@(x) x;

n51=[perf5(:,1),perf5(:,3),ones(length(perf5),1),ones(length(perf5),1)*decay(5),perf5(:,8)];
n50=[perf5(:,2),perf5(:,3),ones(length(perf5),1)*0,ones(length(perf5),1)*decay(5),perf5(:,8)];
n81=[perf8(:,1),perf8(:,3),ones(length(perf8),1),ones(length(perf8),1)*decay(8),perf8(:,8)];
n80=[perf8(:,2),perf8(:,3),ones(length(perf8),1)*0,ones(length(perf8),1)*decay(8),perf8(:,8)];
n121=[perf12(:,1),perf12(:,3),ones(length(perf12),1),ones(length(perf12),1)*decay(12),perf12(:,8)];
n120=[perf12(:,2),perf12(:,3),ones(length(perf12),1)*0,ones(length(perf12),1)*decay(12),perf12(:,8)];
toN=[n51;n50;n81;n80;n121;n120];
terms=[1 0 0 ;
       0 1 0 ;
       0 0 1 ;
       1 1 1 ];

anovan(toN(:,1),{toN(:,2),toN(:,3),toN(:,4)},'model',terms,'continuous',3, 'varnames',{'Gene','Laser','DelayLen'});

perf5t=perf5(:,[3 3 1 2]);
perf5t(:,2)=decay(5);
perf8t=perf8(:,[3 3 1 2]);
perf8t(:,2)=decay(8);
perf12t=perf12(:,[3 3 1 2]);
perf12t(:,2)=decay(12);

t=[perf5t;perf8t;perf12t];
perfT=table(t(:,1),t(:,2),t(:,3),t(:,4),'VariableNames',{'Gene','Delay','Laser_Off','Laser_On'});
laser=table({'Off';'On'},'VariableNames',{'Laser'});
RptMdl=fitrm(perfT,'Laser_Off,Laser_On~Gene*Delay','WithinDesign',laser);
[ranovatbl,A,C,D]=ranova(RptMdl,'WithinModel','Laser')


tdiff=[t(:,1:2),t(:,4)-t(:,3)];

anovan(tdiff(:,3),{tdiff(:,1),tdiff(:,2)},'model','interaction','continuous',2, 'varnames',{'Gene','DelayLen'});

anova1(tdiff(:,3))

end

% sel=@(x,y) x(x(:,3)==y,1:2);
% fprintf('%.3f, %.3f',mean([sel(perf5,0);sel(perf8,0);sel(perf12,0)]),mean([sel(perf5,1);sel(perf8,1);sel(perf12,1)]))
% [~,p]=ttest2([sel(perf5,0);sel(perf8,0);sel(perf12,0)],[sel(perf5,1);sel(perf8,1);sel(perf12,1)])
% 
% 
% 
% 

function p=permTest()
dperf=[perfDPABlock(:,2)-perfDPABlock(:,1),perfDPABlock(:,3)];
dCtrl=dperf(dperf(:,2)<0.5,1);
dChR2=dperf(dperf(:,2)>0.5,1);

pool=[dCtrl;dChR2];
currDiff=abs(mean(dChR2)-mean(dCtrl));


rpt=1000;
permDiff=nan(1,rpt);

for i=1:rpt
    pool=pool(randperm(length(pool)));
    permDiff(i)=abs(mean(pool(1:length(dCtrl))-mean(pool(length(dCtrl)+1:end))));
end
p=nnz(permDiff>currDiff)/rpt;

end

function out=rearrange(ctrlOff,ctrlOn,optoOff,optoOn)
out=[ctrlOff,repmat([1,1],length(ctrlOff),1),(1:length(ctrlOff))'];
out=[out;
    ctrlOn,repmat([1,2],length(ctrlOff),1),(1:length(ctrlOff))'];
out=[out;
    optoOff,repmat([2,1],length(optoOff),1),(1:length(optoOff))'+length(ctrlOff)];
out=[out;
    optoOn,repmat([2,2],length(optoOff),1),(1:length(optoOff))'+length(ctrlOff)];
end