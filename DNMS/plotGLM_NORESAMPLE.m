% getData();
% mdl=model();


mdl=mdls{1};
close all;
figure('Color','w','Position',[100,100,180,235]);
hold on;

[~,sortIdx]=sort(mdl.Fitted.Response,'descend');%sort mice perf
arrayfun(@(x) plot([x,x],[dataMat(sortIdx(x),2),dataMat(sortIdx(x),3)],'-k','LineWidth',1), 1:length(dataMat));
phe=plot(dataMat(sortIdx,1),'ko','LineWidth',1,'MarkerSize',3,'MarkerFaceColor','w');%plot mice line
phm=plot(mdl.Fitted.Response(sortIdx),'r.','LineWidth',2,'MarkerSize',6);% plot fitted
text(min(xlim),max(ylim),sprintf('r^2 = %0.3f',mdl.Rsquared.Ordinary),'FontSize',10);
legend([phe,phm],{'Mice','GLM'},'FontSize',10);
set(gca,'Xtick',[],'YTick',60:20:100,'FontSize',10);
ylabel('Correct Rate','FontSize',10);
xlabel('Task parameter space','FontSize',10);
save('glmModel.mat','mdl');

disp(mdl.Coefficients(mdl.Coefficients.pValue<0.05,:));
disp(find(mdl.Coefficients.pValue<0.05));
fprintf('r^2 = %0.3f',mdl.Rsquared.Ordinary);
set(gca,'XTick',0:10:length(dataMat)+1);
% set(gca,'XGrid','on')
xlim([0,length(dataMat)+1]);
ylim([60,100]);
set(gca,'XTickLabel',[]);
savefig('GLMFit.fig');
print('GLM.eps','-depsc','-r0')
return


function getData()
pause;
load dnmsfiles.mat
[allTrials5,perf5]=stats_GLM(dnmsfiles.delay5s);
[allTrials8,perf8]=stats_GLM(dnmsfiles.delay8s);
[allTrials12,perf12]=stats_GLM(dnmsfiles.delay12s);
[allTrialsBase,perfBase]=stats_GLM(dnmsfiles.baseline);
[allTrialsNoDelay,perfNoDelay]=stats_GLM(dnmsfiles.noDelayBaselineResp);
[allTrialsNoLaser,perfNoLaser]=stats_GLM(dnmsfiles.noLaser,true);
end




function mdls=model()
fillIn=@(x,y) [x(:,1:8),repmat(y,size(x,1),1)];
decay=@(x) 50-exp(-x/21.37)*50;

allTrials5=fillIn(double(allTrials5),[decay(5) 1 0 0 0 3]);
allTrials8=fillIn(double(allTrials8),[decay(8) 1 0 0 0 6]);
allTrials12=fillIn(double(allTrials12),[decay(12) 1 0 0 0 10]);
allTrialsBase=fillIn(double(allTrialsBase),[decay(5) 0 1 0 0 3]);
allTrialsNoDelay=fillIn(double(allTrialsNoDelay),[decay(0.2) 0 1 0 0 2]);
allTrialsNoLaser=fillIn(double(allTrialsNoLaser),[decay(5) 0 0 0 0 3]);
allTrials=[allTrials5;allTrials8;allTrials12;allTrialsBase;allTrialsNoDelay;allTrialsNoLaser];

matchOdor=@(x,y) ismember(x,[2 5 7])==ismember(y,[2 5 7]);

allTrials(:,end)=matchOdor(allTrials(:,1),allTrials(:,2));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% no resample here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mdls=cell(1,1);

rptIdx=1;
resampTrials=allTrials;

factors=cell(1,size(resampTrials,2));
for i=1:length(factors)
    factors{i}=unique(resampTrials(:,i))';
end

dataMat=[];
% sample, test, laser, genotype, decay, purtb delay, perturb base, match
[f1,f2,f3,f4,f5,f6,f7,f10]=ndgrid(factors{1},factors{2},factors{3},factors{8},factors{9},factors{10},factors{11},factors{14});
for idx=1:numel(f1)
    sel=all(resampTrials(:,[1:3,8:11,14])==[f1(idx),f2(idx),f3(idx),f4(idx),f5(idx),f6(idx),f7(idx),f10(idx)],2);
    if nnz(sel)>0
        perf=sum(resampTrials(sel,4))*100/nnz(sel);
        ci=bootci(1000, @(x) sum(x)*100/length(x),resampTrials(sel,4));
        dataMat=[dataMat;perf,ci(1),ci(2),f1(idx) f2(idx) f3(idx) f4(idx) f5(idx) f6(idx) f7(idx) 0 0 f10(idx)];
    end
end


%     s t l g dl pd pb ps pt mt out
%                     prevprev
%                     corrlick
termsMat=[0 0 0 0 0  0  0  0  0  0  0;
    
0 0 0 0 0  0  0  0  0  1  0;
0 0 0 0 1  0  0  0  0  0  0;
0 0 1 1 1  1  0  0  0  0  0;

];


y=double(dataMat(:,1));
X=double(dataMat(:,4:13));
% X=double(allTrials(:,1:3));


mdls{rptIdx}=fitglm(X,y,termsMat,'Categorical',[1:4,6:10],'Distribution','normal',...
    'VarNames',{'Sample','Test','Laser','Genotype','Memory_decay','Perturb_Delay','Perturb_Baseline','Prev_Correct','Prev_Lick','Match','Correct_rate'});

% disp(mdl);
% disp(mdl.ModelCriterion);

save('mdl_Single_All.mat','mdls');
end



function modifyForTable()
set(gcf,'Position',[170,100,180,225]);
set(gca,'XTick',20:20:100,'XTickLabel',20:20:100)
xlim([0,97]);
set(gca,'XGrid','on');
xlabel('Task parameter','FontSize',10,'FontName','Helvetica');
end