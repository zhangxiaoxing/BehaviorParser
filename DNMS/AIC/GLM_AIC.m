% load('dnmsfiles.mat')
% [allTrialsBase,perfBase]=stats_GLM(dnmsfiles.baseline);
% [allTrials5,perf5]=stats_GLM(dnmsfiles.delay5s);
% [allTrials8,perf8]=stats_GLM(dnmsfiles.delay8s);
% [allTrials12,perf12]=stats_GLM(dnmsfiles.delay12s);
% [allTrialsNoDelay,perfNoDelay]=stats_GLM(dnmsfiles.noDelayBaselineResp);
% [allTrialsNoLaser,perfNoLaser]=stats_GLM(dnmsfiles.noLaser,true);
load('data4AIC.mat');
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
%%% resample here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rpt=500;
AICs=nan(rpt,7);
rsq=nan(rpt,7);
mdlAIC=cell(rpt,7);

parfor rptIdx=1:rpt
    disp(rptIdx);
    resampTrials=datasample(allTrials,length(allTrials));
    
    factors=cell(1,size(resampTrials,2));
    for i=1:length(factors)
        factors{i}=unique(resampTrials(:,i))';
    end
    
    
    dataMat=[];
    for f1=factors{1}%col4 sample
        for f2=factors{2}%col5 test
            for f3=factors{3}%col6 laser
                for f4=factors{8}%col7 geno
                    for f5=factors{9}%col8 decay
                        for f6=factors{10}%col9 purtb delay
                            for f7=factors{11} %col 10 perturb base
                                for f10=factors{14} % match
                                    %                                         sel=all(resampTrials(:,[1:3,8:14])==[f1 f2 f3 f4 f5 f6 f7 f8 f9 f10],2);
                                    sel=all(resampTrials(:,[1:3,8:11,14])==[f1 f2 f3 f4 f5 f6 f7,f10],2);
                                    %                         disp(sum(sel)/length(sel));
                                    if nnz(sel)>0
                                        perf=sum(resampTrials(sel,4))*100/nnz(sel);
                                        ci=bootci(100, @(x) sum(x)*100/length(x),resampTrials(sel,4));
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
        1 0 0 0 0  0  0  0  0  0  0;
        0 1 0 0 0  0  0  0  0  0  0;
        %
        0 0 1 0 0  0  0  0  0  0  0;
        0 0 0 1 0  0  0  0  0  0  0;
        0 0 0 0 0  0  0  0  0  1  0;
        0 0 0 0 1  0  0  0  0  0  0;
        0 0 0 0 0  0  1  0  0  0  0;
        0 0 0 0 0  1  0  0  0  0  0;
        %           0 0 0 0 0  0  0  1  0  0  0;
        %           0 0 0 0 0  0  0  0  1  0  0;
        
        %           0 0 1 1 0  0  0  0  0  0  0;
        %           0 0 1 0 0  1  0  0  0  0  0;
        %           0 0 1 0 0  0  1  0  0  0  0;
        %
        %           0 0 0 1 0  1  0  0  0  0  0;
        %           0 0 0 1 0  0  1  0  0  0  0;
        %
        %           0 0 1 1 0  1  0  0  0  0  0;
        
        
        
        0 0 1 1 1  1  0  0  0  0  0;
        0 0 1 1 0  0  1  0  0  0  0;
        
        ];
    
    termsMatCompact=[0 0 0 0 0  0  0  0  0  0  0;
        
    0 0 0 0 0  0  0  0  0  1  0;
    0 0 0 0 1  0  0  0  0  0  0;
    0 0 1 1 1  1  0  0  0  0  0;
    ];
%     s t l g dl pd pb ps pt mt out
%                     prevprev
%                     corrlick

termsMatPBCtrl=[0 0 0 0 0  0  0  0  0  0  0;
    
0 0 0 0 0  0  0  0  0  1  0;
0 0 0 0 1  0  0  0  0  0  0;
0 0 1 1 0  0  1  0  0  0  0;
];




%     s t l g dl pd pb ps pt mt out



% X=double(resampTrials(:,1:3));

termsConst=[0 0 0 0 0  0  0  0  0  0  0];

termsSTM=[0 0 0 0 0  0  0  0  0  0  0;
    1 0 0 0 0  0  0  0  0  0  0;
    0 1 0 0 0  0  0  0  0  0  0;
    0 0 0 0 0  0  0  0  0  1  0];



%     s t l g dl pd pb ps pt mt out

termsSTMD=[0 0 0 0 0  0  0  0  0  0  0;
    1 0 0 0 0  0  0  0  0  0  0;
    0 1 0 0 0  0  0  0  0  0  0;
    0 0 0 0 1  0  0  0  0  0  0;
    0 0 0 0 0  0  0  0  0  1  0];


termsNoInter=[0 0 0 0 0  0  0  0  0  0  0;
    1 0 0 0 0  0  0  0  0  0  0;
    0 1 0 0 0  0  0  0  0  0  0;
    0 0 0 0 1  0  0  0  0  0  0;
    0 0 0 0 0  1  0  0  0  0  0;
    0 0 0 0 0  0  1  0  0  0  0;
    0 0 0 0 0  0  0  0  0  1  0];

terms2InterMat=[0 0 0 0 0  0  0  0  0  0  0;
    1 0 0 0 0  0  0  0  0  0  0;
    0 1 0 0 0  0  0  0  0  0  0;
    
    0 0 1 0 0  0  0  0  0  0  0;
    0 0 0 1 0  0  0  0  0  0  0;
    0 0 0 0 0  0  0  0  0  1  0;
    0 0 0 0 1  0  0  0  0  0  0;
    0 0 0 0 0  0  1  0  0  0  0;
    0 0 0 0 0  1  0  0  0  0  0;
    
    
    0 0 1 1 0  0  0  0  0  0  0;
    0 0 1 0 0  1  0  0  0  0  0;
    0 0 1 0 0  0  1  0  0  0  0;
    
    0 0 0 1 0  1  0  0  0  0  0;
    0 0 0 1 0  0  1  0  0  0  0;
    
    %           0 0 1 1 0  1  0  0  0  0  0;
    
    
    
    0 0 1 1 1  1  0  0  0  0  0;
    0 0 1 1 0  0  1  0  0  0  0;
    
    ];


termsNoInter=[0 0 0 0 0  0  0  0  0  0  0;
    1 0 0 0 0  0  0  0  0  0  0;
    0 1 0 0 0  0  0  0  0  0  0;
    0 0 0 0 1  0  0  0  0  0  0;
    0 0 0 0 0  1  0  0  0  0  0;
    0 0 0 0 0  0  1  0  0  0  0;
    0 0 0 0 0  0  0  0  0  1  0];

terms3InterMat=[0 0 0 0 0  0  0  0  0  0  0;
    1 0 0 0 0  0  0  0  0  0  0;
    0 1 0 0 0  0  0  0  0  0  0;
    
    0 0 1 0 0  0  0  0  0  0  0;
    0 0 0 1 0  0  0  0  0  0  0;
    0 0 0 0 0  0  0  0  0  1  0;
    0 0 0 0 1  0  0  0  0  0  0;
    0 0 0 0 0  0  1  0  0  0  0;
    0 0 0 0 0  1  0  0  0  0  0;
    
    
    0 0 1 1 0  0  0  0  0  0  0;
    0 0 1 0 0  1  0  0  0  0  0;
    0 0 1 0 0  0  1  0  0  0  0;
    
    0 0 0 1 0  1  0  0  0  0  0;
    0 0 0 1 0  0  1  0  0  0  0;
    
    0 0 1 1 0  1  0  0  0  0  0;
    0 0 0 1 1  1  0  0  0  0  0;
    0 0 1 0 1  1  0  0  0  0  0;
    0 0 1 1 1  0  0  0  0  0  0;
    
    
    0 0 1 1 1  1  0  0  0  0  0;
    0 0 1 1 0  0  1  0  0  0  0;
    
    ];


termsList={termsConst,termsSTM,termsSTMD,termsNoInter,termsMat,termsMatCompact,termsMatPBCtrl};

y=double(dataMat(:,1));
X=double(dataMat(:,4:13));

for termsIdx=1:7%length(termsList)
    mdlAIC{rptIdx,termsIdx}=fitglm(X,y,termsList{termsIdx},'Categorical',[1:4,6:10],'Distribution','normal',...
        'VarNames',{'Sample','Test','Laser','Genotype','Memory_decay','Perturb_Delay','Perturb_Baseline','Perturb_Sample','Perturb_Test','Match','Correct_rate'});
    
    % disp(mdl);
    AICs(rptIdx,termsIdx)=mdlAIC{rptIdx,termsIdx}.ModelCriterion.AIC;
    rsq(rptIdx,termsIdx)=mdlAIC{rptIdx,termsIdx}.Rsquared.Ordinary;
end

end
figure('Color','w','Position',[400,400,175,210]);
hold on;
yyaxis left;

ciAIC=bootci(100,@(x) mean(x), AICs);
errorbar(1:7,mean(AICs),ciAIC(1,:)-mean(AICs),ciAIC(2,:)-mean(AICs),'r.','LineWidth',1);
plot(mean(AICs),'-ro','LineWidth',1);
set(gca,'YColor','k');
ylabel('Akaike information criterion','FontSize',10);
yyaxis right;

cirsq=bootci(100,@(x) mean(x), rsq);
errorbar(1:7,mean(rsq),cirsq(1,:)-mean(rsq),cirsq(2,:)-mean(rsq),'k.','LineWidth',1);
plot(mean(rsq),'-ko','LineWidth',1);
set(gca,'YColor','k');
ylabel('R-squared','FontSize',10);
set(gca,'XTick',1:7);
xlabel('Model #','FontSize',10,'FontName','Helvetica','Color','k');
% xlim([0.5,length(termsList)+0.5]);
xlim([0.5,7.5]);

savefig('AIC.fig');
print('-depsc','-painters','AIC.eps');
save('AIC.mat','AICs','rsq');

% disp(mdl.Rsquared);
% plotSlice(mdl);
%

% save('glmModel.mat','mdl');
% savefig('GLMFit.fig');
% print('GLM.eps','-depsc','-r0')
% disp(mdl.Coefficients(mdl.Coefficients.pValue<0.05,:));
% disp(find(mdl.Coefficients.pValue<0.05));
% fprintf('r^2 = %0.3f',mdl.Rsquared.Ordinary);

return