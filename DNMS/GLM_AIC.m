
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

 
y=double(dataMat(:,1));
X=double(dataMat(:,4:13));
% X=double(allTrials(:,1:3));

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
AICs=nan(1,length(termsList));
rsq=nan(1,length(termsList));
for termsIdx=1:length(termsList)
    mdlAIC{termsIdx}=fitglm(X,y,termsList{termsIdx},'Categorical',[1:4,6:10],'Distribution','normal',...
         'VarNames',{'Sample','Test','Laser','Genotype','Memory_decay','Perturb_Delay','Perturb_Baseline','Perturb_Sample','Perturb_Test','Match','Correct_rate'});

    % disp(mdl);
    AICs(termsIdx)=mdlAIC{termsIdx}.ModelCriterion.AIC;
    rsq(termsIdx)=mdlAIC{termsIdx}.Rsquared.Ordinary;
end
figure('Color','w','Position',[400,400,175,210]);
hold on;
yyaxis left;
plot(AICs,'-ro','LineWidth',1);
set(gca,'YColor','k');
ylabel('Akaike information criterion','FontSize',10);
yyaxis right;
plot(rsq,'-ko','LineWidth',1);
set(gca,'YColor','k');
ylabel('R-squared','FontSize',10);
set(gca,'XTick',1:7);
xlabel('Model #','FontSize',10,'FontName','Helvetica','Color','k');
xlim([0.5,length(termsList)+0.5]);

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