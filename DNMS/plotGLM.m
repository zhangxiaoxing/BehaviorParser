load dnmsfiles.mat
[allTrials5,perf5]=stats_GLM(dnmsfiles.delay5s);
[allTrials8,perf8]=stats_GLM(dnmsfiles.delay8s);
[allTrials12,perf12]=stats_GLM(dnmsfiles.delay12s);
[allTrialsBase,perfBase]=stats_GLM(dnmsfiles.baseline);
[allTrialsSample,perfSample]=stats_GLM(dnmsfiles.firstOdor);
[allTrialsTest,perfTest]=stats_GLM(dnmsfiles.secondOdor);
[allTrialsBoth,perfBoth]=stats_GLM(dnmsfiles.bothOdor);


fillIn=@(x,y) [x(:,1:8),repmat(y,size(x,1),1)];
allTrials5=fillIn(allTrials5,[5 1 0 0 0]);
allTrials8=fillIn(allTrials8,[8 1 0 0 0]);
allTrials12=fillIn(allTrials12,[12 1 0 0 0]);
allTrialsBase=fillIn(allTrialsBase,[5 0 1 0 0]);

allTrialsSample=fillIn(allTrialsSample,[5 0 0 1 0]);
allTrialsTest=fillIn(allTrialsTest,[5 0 0 0 1]);
allTrialsBoth=fillIn(allTrialsBoth,[5 0 0 1 1]);

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
                                    sel=all(allTrials(:,[1:3,8:13])==[f1 f2 f3 f4 f5 f6 f7 f8 f9],2);
            %                         disp(sum(sel)/length(sel));
                                    if nnz(sel)>0
                                        perf=sum(allTrials(sel,4))*100/nnz(sel);
                                        ci=bootci(100, @(x) sum(x)*100/length(x),allTrials(sel,4));
                                        dataMat=[dataMat;perf,ci(1),ci(2),f1 f2 f3 f4 f5 f6 f7 f8 f9];
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

    %     s t l g dl pd pb ps pt out

termsMat=[0 0 0 0 0  0  0  0  0  0;
          1 0 0 0 0  0  0  0  0  0;
          0 1 0 0 0  0  0  0  0  0;
          0 0 1 0 0  0  0  0  0  0;
          0 0 0 1 0  0  0  0  0  0;
          0 0 0 0 1  0  0  0  0  0;
          0 0 0 0 0  1  0  0  0  0;
          0 0 0 0 0  0  1  0  0  0;
          0 0 0 0 0  0  0  1  0  0;
          0 0 0 0 0  0  0  0  1  0;
%           1 1 0 0 0  0  0  0  0  0;
%           0 0 1 1 0  0  0  0  0  0;
%           0 0 1 0 0  1  0  0  0  0;
%           0 0 1 0 0  0  1  0  0  0;
%           0 0 1 0 0  0  0  1  0  0;
%           0 0 1 0 0  0  0  0  1  0;
          0 0 0 1 0  1  0  0  0  0;
          0 0 0 1 0  0  1  0  0  0;
          0 0 0 1 0  0  0  1  0  0;
          0 0 0 1 0  0  0  0  1  0;
          0 0 1 1 0  1  0  0  0  0;
          0 0 1 1 0  0  1  0  0  0;
          0 0 1 1 0  0  0  1  0  0;
          0 0 1 1 0  0  0  0  1  0];

y=double(dataMat(:,1));
X=double(dataMat(:,4:12));
% X=double(allTrials(:,1:3));


mdl=fitglm(X,y,termsMat,'Categorical',[1:4,6:9],'Distribution','normal',...
     'VarNames',{'Sample','Test','Laser','Genotype','Delay_Length','Perturb_Delay','Perturb_Baseline','Perturb_Sample','Perturb_Test','Performance'});

disp(mdl);
disp(mdl.Rsquared);
% plotSlice(mdl);
% 
figure('Color','w','Position',[100,100,200,235]);
hold on;
[~,sortIdx]=sort(dataMat(:,1));
fill([1:length(dataMat),length(dataMat):-1:1],[dataMat(sortIdx,2);flip(dataMat(sortIdx,3))],[1,0.8,0.8],'EdgeColor','none');
phe=plot(sort(dataMat(:,1)),'-r.','LineWidth',1);
phm=plot(sort(mdl.Fitted.Response),'-k.','LineWidth',1);
xlim([1,length(dataMat)]);
ylim([70,100]);
set(gca,'Xtick',[],'YTick',70:10:100,'FontSize',12);
ylabel('Correct Rate','FontSize',12);
xlabel('Parameter Combinations','FontSize',12);

