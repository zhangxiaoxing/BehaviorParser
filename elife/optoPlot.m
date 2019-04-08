% close all
%%%%%%%%%%%%%BAR GRAPH%%%%%%%%%%%%%%%%%
javaaddpath('I:\java\zmat\build\classes\');
z=zmat.Zmat;
z.updateFilesList({'D:\Behavior2019\Feb\'});
fs=cell(z.listFiles({'opto','12s'}));
[~,perMice]=stats_opto(fs,79.99,12);
fs=cell(z.listFiles({'opto','20s'}));
[~,perMice]=stats_opto(fs,74.99,20);
fs=cell(z.listFiles({'VARDELAY'}));
[~,perMice]=stats_opto_vardelay(fs,74.9);

return

[fhp,axL,axR]=OptoMisc.plotOne(perMice,'perf');
axL.YLim=[58,100];
axL.YTick=60:20:100;
axR.YLim=[58,100];
axR.YTick=60:20:100;
axL.TickLength=[0.02,0.05]
axR.TickLength=[0.02,0.05]
% print(fhp,'-depsc','perfBar12.eps');
% print(fhp,'-depsc','perfBar20.eps');
% print(fhp,'-depsc','perfBarVD.eps');

[fhf,axL,axR]=OptoMisc.plotOne(perMice,'FA');
axL.YLim=[0,60];
axL.YTick=0:20:60;
axR.YLim=[0,60];
axR.YTick=0:20:60;
axL.TickLength=[0.02,0.05]
axR.TickLength=[0.02,0.05]
% print(fhf,'-depsc','FABar12.eps');
% print(fhf,'-depsc','FABar20.eps');
print(fhf,'-depsc','FABarVD.eps');

[fhm,axL,axR]=OptoMisc.plotOne(perMice,'miss');
axL.YLim=[0,60];
axL.YTick=0:20:60;
axR.YLim=[0,60];
axR.YTick=0:20:60;
axL.TickLength=[0.02,0.05]
axR.TickLength=[0.02,0.05]
% print(fhm,'-depsc','missBar12.eps');
% print(fhm,'-depsc','missBar20.eps');
print(fhm,'-depsc','missBarVD.eps');

figure('Color','w','Position',[100,100,250,180]);
hold on;
OptoMisc.plotPair([1,2,3],perMice.perf(perMice.gene~=1,[1,9,10]),'k');
OptoMisc.plotPair([5,6,7]+0.5,perMice.perf(perMice.gene==1,[1,9,10]),'b');
xlim([0,9]);
ylim([55,100]);
ylabel('Correct Rate (%)','FontSize',10);
set(gca,'XTick',[1 2 3 5.5 6.5 7.5],'XTickLabel',{'off','6s','10s'},'TickLength',[0.02 0.05]);
print('-depsc','-painters','-r0','perfBaselineVD.eps');

return
%%%%%%%%%%%ANOVA 12S%%%%%%%%%%%%%%%%
ranovas=struct();
ranovas.perf=OptoMisc.ranova8(perMice,'perf');
ranovas.FA=OptoMisc.ranova8(perMice,'FA');
ranovas.miss=OptoMisc.ranova8(perMice,'miss');



%%%%%%%%%%%ANOVA 20S%%%%%%%%%%%%%%%%
ranovas=struct();
ranovas.perf=OptoMisc.ranova10(perMice,'perf');
ranovas.FA=OptoMisc.ranova10(perMice,'FA');
ranovas.miss=OptoMisc.ranova10(perMice,'miss');


%%%%%%%%%%ANOVA VARDELAY%%%%%%%%%%%%%%
ranovaVD=struct();
ranovaVD.perf=OptoMisc.ranovaVD(perMice,'perf');
ranovaVD.FA=OptoMisc.ranovaVD(perMice,'FA');
ranovaVD.miss=OptoMisc.ranovaVD(perMice,'miss');


%%%%%%%%%%ANOVA Baseline ctrl%%%%%%%%%%%%%%
ranovabl=struct();
ranovabl.perf=OptoMisc.ranova3(perMice,'perf');
ranovabl.FA=OptoMisc.ranova3(perMice,'FA');
ranovabl.miss=OptoMisc.ranova3(perMice,'miss');

%%%%%%%%%%permutation%%%%%%%%%%%%
pairPermP=struct();
baselineN=1;
pairPermP.perf=OptoMisc.permTestMice(perMice,'perf');
bonfAdj=size(pairPermP.perf,2)-1-baselineN;
pairPermP.perfAdj=pairPermP.perf.*bonfAdj;
pairPermP.FA=OptoMisc.permTestMice(perMice,'FA');
pairPermP.FAAdj=pairPermP.FA.*bonfAdj;
pairPermP.miss=OptoMisc.permTestMice(perMice,'miss');
pairPermP.missAdj=pairPermP.miss.*bonfAdj;


%%%%%%%%%%permutationVD%%%%%%%%%%%%
pairPermP=struct();
pairPermP.perf=OptoMisc.permTestMiceVD(perMice,'perf');
pairPermP.FA=OptoMisc.permTestMiceVD(perMice,'FA');
pairPermP.miss=OptoMisc.permTestMiceVD(perMice,'miss');

%%%%%%%%%%opto Length Latency %%%%%%%%%%%%%%
col=7;
optoLenLate=struct();%Latency
optoLenLate.perf=OptoMisc.ranovaOpto(perMice,'perf',col);
optoLenLate.FA=OptoMisc.ranovaOpto(perMice,'FA',col);
optoLenLate.miss=OptoMisc.ranovaOpto(perMice,'miss',col);


%%%%%%%%%%%Effect Size %%%%%%%%%%%%%%%%%%%%%%%

effSize=struct();
effSize.perf=OptoMisc.effSize(perMice,'perf');
effSize.FA=OptoMisc.effSize(perMice,'FA');
effSize.miss=OptoMisc.effSize(perMice,'miss');


%%%%%%%%%%%Effect Size VD %%%%%%%%%%%%%%%%%%%%%%%

effSizeVD=struct();
effSizeVD.perf=OptoMisc.effSizeVD(perMice,'perf');
effSizeVD.FA=OptoMisc.effSizeVD(perMice,'FA');
effSizeVD.miss=OptoMisc.effSizeVD(perMice,'miss');

%%%%%%%%%%%%Table%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;load plot12.mat;
col=8;

tag={'3s Early','3s Mid','3s Late','6s Early','6s Mid','6s Late','10s'};
OptoMisc.elifeFormatPrefix('Fixed 12s delay, varied optogenetic perturbation, correct rate',col,tag,effSize.perf(2,2:8),effSize.perf(1,2:8));
OptoMisc.elifeFormatMid(col);
disp(ranovas.perf(:,1:5));
OptoMisc.elifeFormatPostfix(col,tag,pairPermP.perfAdj(2,2:8),pairPermP.perfAdj(1,2:8));

OptoMisc.elifeFormatPrefix('Fixed 12s delay, varied optogenetic perturbation, miss rate',col,tag,effSize.miss(2,2:8),effSize.miss(1,2:8));
OptoMisc.elifeFormatMid(col);
disp(ranovas.miss(:,1:5));
OptoMisc.elifeFormatPostfix(col,tag,pairPermP.missAdj(2,2:8),pairPermP.missAdj(1,2:8));

OptoMisc.elifeFormatPrefix('Fixed 12s delay, varied optogenetic perturbation, false alarm rate',col,tag,effSize.FA(2,2:8),effSize.FA(1,2:8));
OptoMisc.elifeFormatMid(col);
disp(ranovas.FA(:,1:5));
OptoMisc.elifeFormatPostfix(col,tag,pairPermP.FAAdj(2,2:8),pairPermP.FAAdj(1,2:8));

OptoMisc.Laser_Dura_Interv_Format('Effect of laser duration and laser-offset-test-onset interval, 12s delay, correct rate',optoLenLate.perf(:,1:5));
OptoMisc.Laser_Dura_Interv_Format('Effect of laser duration and laser-offset-test-onset interval, 12s delay, miss rate',optoLenLate.miss(:,1:5));
OptoMisc.Laser_Dura_Interv_Format('Effect of laser duration and laser-offset-test-onset interval, 12s delay, false alarm rate',optoLenLate.FA(:,1:5));


clear;load plot20.mat;
col=10;
tag={'3s Early','3s Mid','3s Late','6s Early','6s Mid','6s Late','12s Early','12s Mid','12s Late'};
OptoMisc.elifeFormatPrefix('Fixed 20s delay, varied optogenetic perturbation, correct rate',col,tag,effSize.perf(2,2:10),effSize.perf(1,2:10));
OptoMisc.elifeFormatMid(col);
disp(ranovas.perf(:,1:5));
OptoMisc.elifeFormatPostfix(col,tag,pairPermP.perfAdj(2,2:10),pairPermP.perfAdj(1,2:10));

OptoMisc.elifeFormatPrefix('Fixed 20s delay, varied optogenetic perturbation, miss rate',col,tag,effSize.miss(2,2:10),effSize.miss(1,2:10));
OptoMisc.elifeFormatMid(col);
disp(ranovas.miss(:,1:5));
OptoMisc.elifeFormatPostfix(col,tag,pairPermP.missAdj(2,2:10),pairPermP.missAdj(1,2:10));


OptoMisc.elifeFormatPrefix('Fixed 20s delay, varied optogenetic perturbation, false alarm rate',col,tag,effSize.FA(2,2:10),effSize.FA(1,2:10));
OptoMisc.elifeFormatMid(col);
disp(ranovas.FA(:,1:5));
OptoMisc.elifeFormatPostfix(col,tag,pairPermP.FAAdj(2,2:10),pairPermP.FAAdj(1,2:10));


OptoMisc.Laser_Dura_Interv_Format('Effect of laser duration and laser-offset-test-onset interval, 20s delay, correct rate',optoLenLate.perf(:,1:5));
OptoMisc.Laser_Dura_Interv_Format('Effect of laser duration and laser-offset-test-onset interval, 20s delay, miss rate',optoLenLate.miss(:,1:5));
OptoMisc.Laser_Dura_Interv_Format('Effect of laser duration and laser-offset-test-onset interval, 20s delay, false alarm rate',optoLenLate.FA(:,1:5));


clear;load plotVD.mat;
col=5;
tag={'5s Delay','8s Delay','12s Delay','20s Delay'};

OptoMisc.elifeFormatPrefix('Fixed 3s late delay laser, varied delay duration, correct rate',col,tag,effSizeVD.perf(2,2:2:8),effSizeVD.perf(1,2:2:8));
OptoMisc.elifeFormatMid(col);
disp(ranovaVD.perf(:,1:5));
OptoMisc.elifeFormatPostfix(col,tag,pairPermP.perf(2,2:2:8),pairPermP.perf(1,2:2:8));

OptoMisc.elifeFormatPrefix('Fixed 3s late delay laser, varied delay duration, miss rate',col,tag,effSizeVD.miss(2,2:2:8),effSizeVD.miss(1,2:2:8));
OptoMisc.elifeFormatMid(col);
disp(ranovaVD.miss(:,1:5));
OptoMisc.elifeFormatPostfix(col,tag,pairPermP.miss(2,2:2:8),pairPermP.miss(1,2:2:8));


OptoMisc.elifeFormatPrefix('Fixed 3s late delay laser, varied delay duration, false alarm rate',col,tag,effSizeVD.FA(2,2:2:8),effSizeVD.FA(1,2:2:8));
OptoMisc.elifeFormatMid(col);
disp(ranovaVD.FA(:,1:5));
OptoMisc.elifeFormatPostfix(col,tag,pairPermP.FA(2,2:2:8),pairPermP.FA(1,2:2:8));


