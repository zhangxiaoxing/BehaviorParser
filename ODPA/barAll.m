% load('dnmsfiles.mat');

[~,perf5]=stats_GLM(dnmsfiles.delay5s);
[~,perf8]=stats_GLM(dnmsfiles.delay8s);
[~,perf12]=stats_GLM(dnmsfiles.delay12s);
[~,perfGNG]=stats_GLM(dnmsfiles.gonogo,[],true);
[~,perfBase]=stats_GLM(dnmsfiles.baseline);
[~,perfNoDelay]=stats_GLM(dnmsfiles.noDelayBaselineResp);
% load('odpafiles.mat');
[~,perfDPABlock]=stats_GLM(ODPAfiles.DPA_delay_laser);

plot_DPA_dual(ODPAfiles.dualLateBlock,'dualLateDelayPerf','dualLateDelayMissFalse');close all;


tags={'DNMS 5s','DNMS 8s','DNMS 12s','Baseline ctrl','GNG','NoDelay','DPA','Dual-Go','Dual-Nogo'};
perfs={perf5,perf8,perf12,perfBase,perfGNG,perfNoDelay,perfDPABlock,perfDPA_distr1,perfDPA_distr2};

figure('Color','w','Position',[100,100,315,300]);
hold on;
for pIdx=1:length(perfs)
    perf=perfs{pIdx};
    delta=diff(perf(perf(:,3)==1,[2 1]),1,2);
    bar(pIdx,mean(delta),0.8,'FaceColor','k','EdgeColor',[0.8,0.8,0.8]);
    randx=pIdx+rand(size(delta))*0.3-0.15;
    plot(randx,delta,'ko','MarkerFaceColor','w','MarkerEdgeColor','k','MarkerSize',3);
end
ylabel('Optogenetic effect (correct rate)');
set(gca,'XTick',1:length(perfs),'XtickLabel',tags,'XTickLabelRotation',30,'FontSize',10);
xlim([0.5,length(perfs)+0.5]);