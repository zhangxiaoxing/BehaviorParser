load dnmsfiles.mat
[allTrials5,perf5]=stats_GLM(dnmsfiles.delay5s);
[allTrials8,perf8]=stats_GLM(dnmsfiles.delay8s);
[allTrials12,perf12]=stats_GLM(dnmsfiles.delay12s);
[allTrialsBase,perfBase]=stats_GLM(dnmsfiles.baseline);


fillIn=@(x,y) [x(:,1:8),repmat(y,size(x,1),1)];
decay=@(x) 50-exp(-x/21.37)*50;
% decay=@(x) x;
allTrials5=fillIn(allTrials5,[decay(5) 1]);
allTrials8=fillIn(allTrials8,[decay(8) 1]);
allTrials12=fillIn(allTrials12,[decay(12) 1]);
allTrialsBase=fillIn(allTrialsBase,[decay(5) 0]);


allTrials=[allTrials5;allTrials8;allTrials12;allTrialsBase];

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
                        sel=all(allTrials(:,[1:3,8:10])==[f1 f2 f3 f4 f5 f6],2);
                        %                         disp(sum(sel)/length(sel));
                        if nnz(sel)>0
                            perf=sum(allTrials(sel,4))*100/nnz(sel);
                            ci=bootci(500, @(x) sum(x)*100/length(x),allTrials(sel,4));
                            dataMat=[dataMat;perf,ci(1),ci(2),f1 f2 f3 f4 f5 f6];
                        end
                    end
                end
            end
        end
    end
end

    %     s t l g dl pd out

termsMat=[0 0 0 0 0  0  0;
          1 0 0 0 0  0  0;
          0 1 0 0 0  0  0;
          1 1 0 0 0  0  0;
          0 0 1 0 0  0  0;
          0 0 0 1 0  0  0;
          0 0 0 0 1  0  0;
          0 0 0 0 0  1  0;
          0 0 1 0 0  1  0;
          0 0 1 1 0  0  0;
          0 0 0 1 0  1  0;
%           0 0 1 1 0  1  0;
          0 0 1 1 1  1  0];


y=double(dataMat(:,1));
X=double(dataMat(:,4:9));
% X=double(allTrials(:,1:3));


mdl=fitglm(X,y,termsMat,'Categorical',[1:4,6],'Distribution','normal',...
     'VarNames',{'Sample','Test','Laser','Genotype','Exponential_decay','Perturb_type','Performance'});

disp(mdl);
disp(mdl.Rsquared);
% plotSlice(mdl);
% 
figure('Color','w','Position',[100,100,150,235]);
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
text(min(xlim),max(ylim),sprintf('r^2 = %0.3f',mdl.Rsquared.Ordinary),'FontSize',12);
legend([phe,phm],{'Experiment data','Model prediction'},'FontSize',12);
