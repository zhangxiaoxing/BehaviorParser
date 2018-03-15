load dnmsfiles.mat
[allTrials5,perf5]=stats_GLM(dnmsfiles.delay5s);
[allTrials8,perf8]=stats_GLM(dnmsfiles.delay8s);
[allTrials12,perf12]=stats_GLM(dnmsfiles.delay12s);
[allTrialsBase,perfBase]=stats_GLM(dnmsfiles.baseline);
[allTrialsSample,perfSample]=stats_GLM(dnmsfiles.firstOdor);
[allTrialsTest,perfTest]=stats_GLM(dnmsfiles.secondOdor);
[allTrialsBoth,perfBoth]=stats_GLM(dnmsfiles.bothOdor);


fillIn=@(x,y) [x(:,1:8),repmat(y,size(x,1),1)];
decay=@(x) 50-exp(-x/21.37)*50;

allTrials5=fillIn(allTrials5,[decay(5) 1 0 0 0 3]);
allTrials8=fillIn(allTrials8,[decay(8) 1 0 0 0 6]);
allTrials12=fillIn(allTrials12,[decay(12) 1 0 0 0 10]);
allTrialsBase=fillIn(allTrialsBase,[decay(5) 0 1 0 0 3]);

allTrialsSample=fillIn(allTrialsSample,[decay(5) 0 0 1 0 1]);
allTrialsTest=fillIn(allTrialsTest,[decay(5) 0 0 0 1 1]);
allTrialsBoth=fillIn(allTrialsBoth,[decay(5) 0 0 1 1 2]);

allTrials=[allTrials5;allTrials8;allTrials12;allTrialsBase;allTrialsSample;allTrialsTest;allTrialsBoth];

factors=cell(1,size(allTrials,2));
for i=1:length(factors)
    factors{i}=unique(allTrials(:,i))';
end

dataMat=[];

for f1=factors{1}
    for f2=factors{2}
        for f3=factors{3}
            for f4=factors{8}
                for f5=factors{9}
                    for f6=factors{10}
                        for f7=factors{11}
                            for f8=factors{12}
                                for f9=factors{13}
                                    for f10=factors{14}
                                        sel=all(allTrials(:,[1:3,8:14])==[f1 f2 f3 f4 f5 f6 f7 f8 f9 f10],2);
                                        %                         disp(sum(sel)/length(sel));
                                        if nnz(sel)>0
                                            perf=sum(allTrials(sel,4))*100/nnz(sel);
                                            ci=bootci(100, @(x) sum(x)*100/length(x),allTrials(sel,4));
                                            dataMat=[dataMat;perf,ci(1),ci(2),f1 f2 f3 f4 f5 f6 f7 f8 f9 f10];
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

    %     s t l g dl pd pb ps pt ll out

termsMat=[0 0 0 0 0  0  0  0  0  0  0;
          1 0 0 0 0  0  0  0  0  0  0;
%           1 0 0 0 1  0  0  0  0  0  0;
          0 1 0 0 0  0  0  0  0  0  0;
          1 1 0 0 0  0  0  0  0  0  0;
          0 0 1 0 0  0  0  0  0  0  0;
          0 0 0 1 0  0  0  0  0  0  0;
          0 0 0 0 1  0  0  0  0  0  0;
          0 0 0 0 0  1  0  0  0  0  0;
          0 0 0 0 0  0  1  0  0  0  0;
          0 0 0 0 0  0  0  1  0  0  0;
          0 0 0 0 0  0  0  0  1  0  0;
          
%           0 0 0 1 0  1  0  0  0  0  0;
%           0 0 0 1 0  0  1  0  0  0  0;
%           0 0 0 1 0  0  0  1  0  0  0;
%           0 0 0 1 0  0  0  0  1  0  0;
          0 0 1 1 1  1  0  0  0  0  0;
          0 0 1 1 0  0  1  0  0  0  0;
          0 0 1 1 0  0  0  1  0  0  0;
          0 0 1 1 0  0  0  0  1  0  0];

y=double(dataMat(:,1));
X=double(dataMat(:,4:12));
% X=double(allTrials(:,1:3));


mdl=fitglm(X,y,termsMat(:,1:end-1),'Categorical',[1:4,6:9],'Distribution','normal',...
     'VarNames',{'Sample','Test','Laser','Genotype','Memory_decay','Perturb_Delay','Perturb_Baseline','Perturb_Sample','Perturb_Test','Correct_rate'});

disp(mdl);
% disp(mdl.Rsquared);
% plotSlice(mdl);
% 
close all;
figure('Color','w','Position',[100,100,180,235]);
hold on;
[~,sortIdx]=sort(dataMat(:,1),'descend');
fill([1:length(dataMat),length(dataMat):-1:1],[dataMat(sortIdx,2);flip(dataMat(sortIdx,3))],[1,0.8,0.8],'EdgeColor','none');
phe=plot(dataMat(sortIdx,1),'-r.','LineWidth',1);
phm=plot(mdl.Fitted.Response(sortIdx),'ko','LineWidth',1,'MarkerSize',3);
xlim([1,length(dataMat)]);
ylim([70,100]);
text(min(xlim),max(ylim),sprintf('r^2 = %0.3f',mdl.Rsquared.Ordinary),'FontSize',10);
legend([phe,phm],{'Mice','GLM'},'FontSize',10);
set(gca,'Xtick',[],'YTick',70:10:100,'FontSize',10);
ylabel('Correct Rate','FontSize',10);
xlabel('Task parameter space','FontSize',10);
save('glmModel.mat','mdl');
savefig('GLMFit.fig');
print('GLM.eps','-depsc','-r0','-cmyk')
disp(mdl.Coefficients(mdl.Coefficients.pValue<0.05,:));
disp(find(mdl.Coefficients.pValue<0.05));




interceptC=mdl.Coefficients.Estimate(1);
sampC=mdl.Coefficients.Estimate(2);
delayC=mdl.Coefficients.Estimate(7);
LaserXdelayC=mdl.Coefficients.Estimate(12);
figure('Color','w','Position',[100,100,140,235]);
hold on;
xx=0:12;
hs=fill([xx,fliplr(xx)],[repmat(-sampC,1,13),repmat(0,1,13)],[0.67,0.67,0.67],'EdgeColor','none');
hdl=fill([xx,fliplr(xx)],[arrayfun(@(x) delayC*decay(x)-sampC,xx),repmat(-sampC,1,13)],[0.33,0.33,0.33],'EdgeColor','none');
hldl=fill([xx,fliplr(xx)],[arrayfun(@(x) delayC*decay(x)+LaserXdelayC*decay(x)-sampC,xx),arrayfun(@(x) delayC*decay(x)-sampC,fliplr(xx))],'k','EdgeColor','none');
xlim([0,12]);
ylim([-15,10]);
ylabel('\Delta correct rate (%)');
xlabel('Delay duration(s)');
legend([hs,hdl,hldl],{'Sample 1','Delay Duration','Pertubation x delay duration'});
save('GLMPredictor.fig');
print('GLMPredictor.eps','-deps','-r0');
% set(gcf,'Position',[1800,500,140,235])


