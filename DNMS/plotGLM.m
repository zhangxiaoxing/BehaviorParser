getData();
mdl=model();




% disp(mdl.Rsquared);
% plotSlice(mdl);
% 

close all;
figure('Color','w','Position',[100,100,180,235]);
hold on;
% [~,sortIdx]=sort(dataMat(:,1),'descend');%sort mice perf
% fill([1:length(dataMat),length(dataMat):-1:1],[dataMat(sortIdx,2);flip(dataMat(sortIdx,3))],[1,0.8,0.8],'EdgeColor','none');%fill mice perf shadow
% phe=plot(dataMat(sortIdx,1),'-r.','LineWidth',1);%plot mice line
% phm=plot(mdl.Fitted.Response(sortIdx),'ko','LineWidth',1,'MarkerSize',3);% plot fitted

[~,sortIdx]=sort(mdl.Fitted.Response,'descend');%sort mice perf
% fill([1:length(dataMat),length(dataMat):-1:1],[dataMat(sortIdx,2);flip(dataMat(sortIdx,3))],[1,0.8,0.8],'EdgeColor','none');%fill mice perf shadow
arrayfun(@(x) plot([x,x],[dataMat(sortIdx(x),2),dataMat(sortIdx(x),3)],'-k','LineWidth',1), 1:length(dataMat));
phe=plot(dataMat(sortIdx,1),'ko','LineWidth',1,'MarkerSize',3,'MarkerFaceColor','w');%plot mice line
phm=plot(mdl.Fitted.Response(sortIdx),'r.','LineWidth',2,'MarkerSize',5);% plot fitted

xlim([1,length(dataMat)]);
ylim([60,100]);
text(min(xlim),max(ylim),sprintf('r^2 = %0.3f',mdl.Rsquared.Ordinary),'FontSize',10);
legend([phe,phm],{'Mice','GLM'},'FontSize',10);
set(gca,'Xtick',[],'YTick',60:20:100,'FontSize',10);
ylabel('Correct Rate','FontSize',10);
xlabel('Task parameter space','FontSize',10);
save('glmModel.mat','mdl');
savefig('GLMFit.fig');
print('GLM.eps','-depsc','-r0')
disp(mdl.Coefficients(mdl.Coefficients.pValue<0.05,:));
disp(find(mdl.Coefficients.pValue<0.05));
fprintf('r^2 = %0.3f',mdl.Rsquared.Ordinary);


interceptC=mdl.Coefficients.Estimate(1);
matchC=mdl.Coefficients.Estimate(2);
delayC=mdl.Coefficients.Estimate(3);
LaserXdelayC=mdl.Coefficients.Estimate(4);
figure('Color','w','Position',[100,100,140,160]);
hold on;
xx=0:12;
hs=fill([xx,fliplr(xx)],[repmat(matchC,1,13),repmat(0,1,13)],[0.67,0.67,0.67],'EdgeColor','none');
hdl=fill([xx,fliplr(xx)],[arrayfun(@(x) delayC*decay(x)+matchC,xx),repmat(matchC,1,13)],[0.33,0.33,0.33],'EdgeColor','none');
hldl=fill([xx,fliplr(xx)],[arrayfun(@(x) delayC*decay(x)+LaserXdelayC*decay(x)+matchC,xx),arrayfun(@(x) delayC*decay(x)+matchC,fliplr(xx))],'k','EdgeColor','none');
xlim([0,12]);
ylim([-20,0]);

ylabel('\Delta correct rate (%)');
xlabel('Delay duration(s)');
set(gca,'YTick',-20:10:0);
% legend([hs,hdl,hldl],{'Match','Delay Duration','Pertubation x delay duration'});
savefig('GLMPredictor.fig');
print('GLMPredictor.eps','-deps','-r0');
% set(gcf,'Position',[1800,500,140,235])



function getData()
pause; 
load dnmsfiles.mat
[allTrials5,perf5]=stats_GLM(dnmsfiles.delay5s);
[allTrials8,perf8]=stats_GLM(dnmsfiles.delay8s);
[allTrials12,perf12]=stats_GLM(dnmsfiles.delay12s);
[allTrialsBase,perfBase]=stats_GLM(dnmsfiles.baseline);
% % [allTrialsSample,perfSample]=stats_GLM(dnmsfiles.firstOdor);
% % [allTrialsTest,perfTest]=stats_GLM(dnmsfiles.secondOdor);
% % [allTrialsBoth,perfBoth]=stats_GLM(dnmsfiles.bothOdor);
[allTrialsNoDelay,perfNoDelay]=stats_GLM(dnmsfiles.noDelayBaselineResp);
[allTrialsNoLaser,perfNoLaser]=stats_GLM(dnmsfiles.noLaser,true);
% 
% % [allTrialsGNG,perfGNG]=stats_GLM(dnmsfiles.gonogo);
% % [allTrialsNDelay,perfNDelay]=stats_GLM(chr2.dnms.baselineNDelay);
% [allTrialsBaseNDelay,perfBaseNDelay]=stats_GLM(dnmsfiles.baselineNDelay);


% [allTrialsDual,perfDual]=stats_GLM(dnmsfiles.delay12s);
end




function mdl=model()
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

factors=cell(1,size(allTrials,2));
for i=1:length(factors)
    factors{i}=unique(allTrials(:,i))';
end

dataMat=[];

for f1=factors{1}%col4 sample
    for f2=factors{2}%col5 test
        for f3=factors{3}%col6 laser
            for f4=factors{8}%col7 geno
                for f5=factors{9}%col8 decay
                    for f6=factors{10}%col9 purtb delay
                        for f7=factors{11} %col 10 perturb base
%                             for f8=factors{12} %N/A
%                              for f8=factors{6} %Prev_Correct
%                                 for f9=factors{13} %N/A
%                                  for f9=factors{7} %N/A
                                    for f10=factors{14} % match
%                                         sel=all(allTrials(:,[1:3,8:14])==[f1 f2 f3 f4 f5 f6 f7 f8 f9 f10],2);
                                         sel=all(allTrials(:,[1:3,8:11,14])==[f1 f2 f3 f4 f5 f6 f7,f10],2);
                                        %                         disp(sum(sel)/length(sel));
                                        if nnz(sel)>0
                                            perf=sum(allTrials(sel,4))*100/nnz(sel);
                                            ci=bootci(100, @(x) sum(x)*100/length(x),allTrials(sel,4));
%                                             dataMat=[dataMat;perf,ci(1),ci(2),f1 f2 f3 f4 f5 f6 f7 f8 f9 f10];
                                            dataMat=[dataMat;perf,ci(1),ci(2),f1 f2 f3 f4 f5 f6 f7 0 0 f10];
                                        end
                                    end
%                                 end
%                             end
                        end
                    end
                end
            end
        end
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


mdl=fitglm(X,y,termsMat,'Categorical',[1:4,6:10],'Distribution','normal',...
     'VarNames',{'Sample','Test','Laser','Genotype','Memory_decay','Perturb_Delay','Perturb_Baseline','Prev_Correct','Prev_Lick','Match','Correct_rate'});

disp(mdl);
disp(mdl.ModelCriterion);
end

function modifyForTable()
set(gcf,'Position',[170,100,180,225]);
set(gca,'XTick',20:20:100,'XTickLabel',20:20:100)
xlim([0,97]);
set(gca,'XGrid','on');
xlabel('Task parameter','FontSize',10,'FontName','Helvetica');
end