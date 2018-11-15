

%getData();
%mdl=model();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%   coefficients
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

interceptCs=cellfun(@(x) x.Coefficients.Estimate(1),mdls);
matchCs=cellfun(@(x) x.Coefficients.Estimate(2),mdls);
delayCs=cellfun(@(x) x.Coefficients.Estimate(3),mdls);
LaserXdelayCs=cellfun(@(x) x.Coefficients.Estimate(4),mdls);

ciInterc=bootci(1000,@(x) mean(x),interceptCs);
ciMatch=bootci(1000,@(x) mean(x), matchCs);
ciDelayCs=bootci(1000,@(x) mean(x), delayCs);
ciLaserXDelay=bootci(1000,@(x) mean(x),LaserXdelayCs);

figure('Color','w','Position',[100,100,140,160]);
hold on;
xx=0:12;
hs=fill([xx,fliplr(xx)],[ones(1,13).*ciMatch(1),ones(1,13).*ciMatch(2)],[0.8,0.8,0.8],'EdgeColor','none');
hdl=fill([xx,fliplr(xx)],[arrayfun(@(x) ciDelayCs(1).*decay(x),xx),arrayfun(@(x) ciDelayCs(2)*decay(x),fliplr(xx))],[0.8,0.8,1],'EdgeColor','none');
hldl=fill([xx,fliplr(xx)],[arrayfun(@(x) ciLaserXDelay(1)*decay(x),xx),arrayfun(@(x) ciLaserXDelay(2)*decay(x),fliplr(xx))],[1,0.8,1],'EdgeColor','none');

mMatch=plot(xx,ones(1,13).*mean(matchCs),'k','LineWidth',1);
mDelay=plot(xx,arrayfun(@(x) mean(delayCs).*decay(x),xx),'b','LineWidth',1);
mLaserXDelay=plot(xx,arrayfun(@(x) mean(LaserXdelayCs)*decay(x),xx),'r','LineWidth',1);
xlim([0.5,12.5]);
set(gca,'XTick',[0 5 10],'XAxisLocation','origin');
set(gcf,'Position',[100,100,160,140]);

currD=abs(mean(delayCs)-mean(LaserXdelayCs));
rpt=1000;
permD=nan(1000,1);
for i=1:rpt
    pool=[delayCs,LaserXdelayCs];
    pool=pool(randperm(numel(delayCs)+numel(LaserXdelayCs)));
    permD(i)=abs(mean(pool(1:numel(delayCs)))-mean(pool(numel(delayCs)+1:end)));
end
p=sum(permD>=currD)./1000;

ylabel('\Delta correct rate (%)');
xlabel('Delay duration(s)');
set(gca,'YTick',-20:10:0);

savefig('GLMPredictor.fig');
print('GLMPredictor.eps','-deps','-r0');
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
%

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

% allTrialsBaseNDelay=fillIn(allTrialsBaseNDelay,[decay(5) 1 1 0 0 3]);
%
% allTrialsSample=fillIn(allTrialsSample,[decay(5) 0 0 1 0 1]);
% allTrialsTest=fillIn(allTrialsTest,[decay(5) 0 0 0 1 1]);
% allTrialsBoth=fillIn(allTrialsBoth,[decay(5) 0 0 1 1 2]);

% allTrials=[allTrials5;allTrials8;allTrials12;allTrialsBase;allTrialsSample;allTrialsTest;allTrialsBoth;allTrialsNoDelay];
allTrials=[allTrials5;allTrials8;allTrials12;allTrialsBase;allTrialsNoDelay;allTrialsNoLaser];

matchOdor=@(x,y) ismember(x,[2 5 7])==ismember(y,[2 5 7]);

allTrials(:,end)=matchOdor(allTrials(:,1),allTrials(:,2));


%%%%%%%%%%%%%%%%%%%%%%%
%%% resample 
%%%%%%%%%%%%%%%%%%%%%%%
rpt=500;
mdls=cell(rpt,1);

for rptIdx=1:rpt
    disp(rptIdx);
    resampTrials=datasample(allTrials,length(allTrials));
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
end
save('mdls.mat','mdls');
end





function modifyForTable()
set(gcf,'Position',[170,100,180,225]);
set(gca,'XTick',20:20:100,'XTickLabel',20:20:100)
xlim([0,97]);
set(gca,'XGrid','on');
xlabel('Task parameter','FontSize',10,'FontName','Helvetica');
end