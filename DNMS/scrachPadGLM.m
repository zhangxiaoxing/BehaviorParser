%1:4, Sample, Test, Laser, Response, 
%5:8, class, match, optoPos, optoPos x Laser
%9:12,Delay_Len, LaserChoice(0=delay,1=baseline)

load dnmsfiles.mat
[allTrials5,perf5]=stats_GLM(dnmsfiles.delay5s);
[allTrials8,perf8]=stats_GLM(dnmsfiles.delay8s);
[allTrials12,perf12]=stats_GLM(dnmsfiles.delay12s);
[allTrialsBase,perfBase]=stats_GLM(dnmsfiles.baseline);
[allTrialsSample,perfSample]=stats_GLM(dnmsfiles.firstOdor);
[allTrialsTest,perfTest]=stats_GLM(dnmsfiles.secondOdor);
[allTrialsBoth,perfBoth]=stats_GLM(dnmsfiles.bothOdor);


allTrials5(:,9)=5;
allTrials8(:,9)=8;
allTrials12(:,9)=12;
allTrialsBase(:,9)=5;



allTrials5(:,10)=1;
allTrials8(:,10)=1;
allTrials12(:,10)=1;
allTrialsBase(:,10)=0;


allTrials=[allTrials5;allTrials8;allTrials12;allTrialsBase];
%%%%%%%%%%1 2 3 6 7 9 a /
termsMat=[1 0 0 0 0 0 0 0;...
          0 1 0 0 0 0 0 0;...
          0 0 1 0 0 0 0 0;...
          0 0 0 1 0 0 0 0;...
          0 0 0 0 1 0 0 0;...
          0 0 0 0 0 0 0 0;...
          0 0 0 0 0 1 0 0;...
          0 0 0 0 0 0 1 0;...
          %0 0 1 0 1 0 0 0;...
          %0 0 1 0 0 0 1 0;...
          %0 0 0 0 1 0 1 0;...
          0 0 1 0 1 0 1 0];


y=double(allTrials(:,4));
X=double(allTrials(:,[1:3,6,7,9,10]));

mdl=fitglm(X,y,termsMat,'Categorical',[1:5,7],'Distribution','binomial',...
     'VarNames',{'Sample','Test','Laser','Match','Genotype','Delay_Length','LaserType','Correct'});
disp(mdl);
plotSlice(mdl);



allTrials5=stats_GLM(dnmsfiles.delay5s,true);
allTrials8=stats_GLM(dnmsfiles.delay8s,true);
allTrials12=stats_GLM(dnmsfiles.delay12s,true);

allTrials5(:,9)=5;
allTrials8(:,9)=8;
allTrials12(:,9)=12;

allTrials=[allTrials5;allTrials8;allTrials12];

y=double(allTrials(:,4));
X=double(allTrials(:,[1:3,6:9]));

mdl=fitglm(X,y,'linear','Categorical',1:6,'Distribution','binomial',...
    'VarNames',{'Sample','Test','Laser','Match','Genotype','Laser_x_Gen','Delay_Length','Lick'});
disp(mdl);
plotSlice(mdl);












%%%%%%%%%%%New Perf Criteria%%%%%%%%%%%%
perfn=perf5;

figure();
hold on;
plot([2,1],perfn(perfn(:,3)==1,1:2),'bo-');
plot([4,3],perfn(perfn(:,3)==0,1:2),'ko-');
plot([6,5],perfn(perfn(:,3)==1,4:5),'bo-');
plot([8,7],perfn(perfn(:,3)==0,4:5),'ko-');
plot([10,9],perfn(perfn(:,3)==1,6:7),'bo-');
plot([12,11],perfn(perfn(:,3)==0,6:7),'ko-');
xlim([0,13]);
rpp=ranksum(perfn(perfn(:,3)==1,1),perfn(perfn(:,3)==1,2));
[~,pp]=ttest(perfn(perfn(:,3)==1,1),perfn(perfn(:,3)==1,2));
rpm=ranksum(perfn(perfn(:,3)==1,4),perfn(perfn(:,3)==1,5));
[~,pm]=ttest(perfn(perfn(:,3)==1,4),perfn(perfn(:,3)==1,5));
rpf=ranksum(perfn(perfn(:,3)==1,6),perfn(perfn(:,3)==1,7));
[~,pf]=ttest(perfn(perfn(:,3)==1,6),perfn(perfn(:,3)==1,7));

fprintf('TransGene, %.2f, %.2f | %.2f, %.2f | %.2f, %.2f | \n',rpp,pp,rpm,pm,rpf,pf);
rpp=ranksum(perfn(perfn(:,3)==0,1),perfn(perfn(:,3)==0,2));
[~,pp]=ttest(perfn(perfn(:,3)==0,1),perfn(perfn(:,3)==0,2));
rpm=ranksum(perfn(perfn(:,3)==0,4),perfn(perfn(:,3)==0,5));
[~,pm]=ttest(perfn(perfn(:,3)==0,4),perfn(perfn(:,3)==0,5));
rpf=ranksum(perfn(perfn(:,3)==0,6),perfn(perfn(:,3)==0,7));
[~,pf]=ttest(perfn(perfn(:,3)==0,6),perfn(perfn(:,3)==0,7));
fprintf('Ctrl, %.2f, %.2f | %.2f, %.2f | %.2f, %.2f | \t',rpp,pp,rpm,pm,rpf,pf);

perfn=perf8;

figure();
hold on;
plot([2,1],perfn(perfn(:,3)==1,1:2),'bo-');
plot([4,3],perfn(perfn(:,3)==0,1:2),'ko-');
plot([6,5],perfn(perfn(:,3)==1,4:5),'bo-');
plot([8,7],perfn(perfn(:,3)==0,4:5),'ko-');
plot([10,9],perfn(perfn(:,3)==1,6:7),'bo-');
plot([12,11],perfn(perfn(:,3)==0,6:7),'ko-');
xlim([0,13]);
rpp=ranksum(perfn(perfn(:,3)==1,1),perfn(perfn(:,3)==1,2));
[~,pp]=ttest(perfn(perfn(:,3)==1,1),perfn(perfn(:,3)==1,2));
rpm=ranksum(perfn(perfn(:,3)==1,4),perfn(perfn(:,3)==1,5));
[~,pm]=ttest(perfn(perfn(:,3)==1,4),perfn(perfn(:,3)==1,5));
rpf=ranksum(perfn(perfn(:,3)==1,6),perfn(perfn(:,3)==1,7));
[~,pf]=ttest(perfn(perfn(:,3)==1,6),perfn(perfn(:,3)==1,7));

fprintf('TransGene, %.2f, %.2f | %.2f, %.2f | %.2f, %.2f | \n',rpp,pp,rpm,pm,rpf,pf);
rpp=ranksum(perfn(perfn(:,3)==0,1),perfn(perfn(:,3)==0,2));
[~,pp]=ttest(perfn(perfn(:,3)==0,1),perfn(perfn(:,3)==0,2));
rpm=ranksum(perfn(perfn(:,3)==0,4),perfn(perfn(:,3)==0,5));
[~,pm]=ttest(perfn(perfn(:,3)==0,4),perfn(perfn(:,3)==0,5));
rpf=ranksum(perfn(perfn(:,3)==0,6),perfn(perfn(:,3)==0,7));
[~,pf]=ttest(perfn(perfn(:,3)==0,6),perfn(perfn(:,3)==0,7));
fprintf('Ctrl, %.2f, %.2f | %.2f, %.2f | %.2f, %.2f | \t',rpp,pp,rpm,pm,rpf,pf);

perfn=perf12;

figure();
hold on;
plot([2,1],perfn(perfn(:,3)==1,1:2),'bo-');
plot([4,3],perfn(perfn(:,3)==0,1:2),'ko-');
plot([6,5],perfn(perfn(:,3)==1,4:5),'bo-');
plot([8,7],perfn(perfn(:,3)==0,4:5),'ko-');
plot([10,9],perfn(perfn(:,3)==1,6:7),'bo-');
plot([12,11],perfn(perfn(:,3)==0,6:7),'ko-');
xlim([0,13]);
rpp=ranksum(perfn(perfn(:,3)==1,1),perfn(perfn(:,3)==1,2));
[~,pp]=ttest(perfn(perfn(:,3)==1,1),perfn(perfn(:,3)==1,2));
rpm=ranksum(perfn(perfn(:,3)==1,4),perfn(perfn(:,3)==1,5));
[~,pm]=ttest(perfn(perfn(:,3)==1,4),perfn(perfn(:,3)==1,5));
rpf=ranksum(perfn(perfn(:,3)==1,6),perfn(perfn(:,3)==1,7));
[~,pf]=ttest(perfn(perfn(:,3)==1,6),perfn(perfn(:,3)==1,7));

fprintf('TransGene, %.2f, %.2f | %.2f, %.2f | %.2f, %.2f | \n',rpp,pp,rpm,pm,rpf,pf);
rpp=ranksum(perfn(perfn(:,3)==0,1),perfn(perfn(:,3)==0,2));
[~,pp]=ttest(perfn(perfn(:,3)==0,1),perfn(perfn(:,3)==0,2));
rpm=ranksum(perfn(perfn(:,3)==0,4),perfn(perfn(:,3)==0,5));
[~,pm]=ttest(perfn(perfn(:,3)==0,4),perfn(perfn(:,3)==0,5));
rpf=ranksum(perfn(perfn(:,3)==0,6),perfn(perfn(:,3)==0,7));
[~,pf]=ttest(perfn(perfn(:,3)==0,6),perfn(perfn(:,3)==0,7));
fprintf('Ctrl, %.2f, %.2f | %.2f, %.2f | %.2f, %.2f | \t',rpp,pp,rpm,pm,rpf,pf);

perfn=perfBase;

figure();
hold on;
plot([2,1],perfn(perfn(:,3)==1,1:2),'bo-');
plot([4,3],perfn(perfn(:,3)==0,1:2),'ko-');
plot([6,5],perfn(perfn(:,3)==1,4:5),'bo-');
plot([8,7],perfn(perfn(:,3)==0,4:5),'ko-');
plot([10,9],perfn(perfn(:,3)==1,6:7),'bo-');
plot([12,11],perfn(perfn(:,3)==0,6:7),'ko-');
xlim([0,13]);
rpp=ranksum(perfn(perfn(:,3)==1,1),perfn(perfn(:,3)==1,2));
[~,pp]=ttest(perfn(perfn(:,3)==1,1),perfn(perfn(:,3)==1,2));
rpm=ranksum(perfn(perfn(:,3)==1,4),perfn(perfn(:,3)==1,5));
[~,pm]=ttest(perfn(perfn(:,3)==1,4),perfn(perfn(:,3)==1,5));
rpf=ranksum(perfn(perfn(:,3)==1,6),perfn(perfn(:,3)==1,7));
[~,pf]=ttest(perfn(perfn(:,3)==1,6),perfn(perfn(:,3)==1,7));

fprintf('TransGene, %.2f, %.2f | %.2f, %.2f | %.2f, %.2f | \n',rpp,pp,rpm,pm,rpf,pf);
rpp=ranksum(perfn(perfn(:,3)==0,1),perfn(perfn(:,3)==0,2));
[~,pp]=ttest(perfn(perfn(:,3)==0,1),perfn(perfn(:,3)==0,2));
rpm=ranksum(perfn(perfn(:,3)==0,4),perfn(perfn(:,3)==0,5));
[~,pm]=ttest(perfn(perfn(:,3)==0,4),perfn(perfn(:,3)==0,5));
rpf=ranksum(perfn(perfn(:,3)==0,6),perfn(perfn(:,3)==0,7));
[~,pf]=ttest(perfn(perfn(:,3)==0,6),perfn(perfn(:,3)==0,7));
fprintf('Ctrl, %.2f, %.2f | %.2f, %.2f | %.2f, %.2f | \t',rpp,pp,rpm,pm,rpf,pf);


n51=[perf5(:,1),perf5(:,3),ones(length(perf5),1),ones(length(perf5),1)*5,ones(length(perf5),1)];
n50=[perf5(:,2),perf5(:,3),zeros(length(perf5),1),ones(length(perf5),1)*5,ones(length(perf5),1)];


n81=[perf8(:,1),perf8(:,3),ones(length(perf8),1),ones(length(perf8),1)*8,ones(length(perf8),1)];
n80=[perf8(:,2),perf8(:,3),zeros(length(perf8),1),ones(length(perf8),1)*8,ones(length(perf8),1)];


n121=[perf12(:,1),perf12(:,3),ones(length(perf12),1),ones(length(perf12),1)*12,ones(length(perf12),1)];
n120=[perf12(:,2),perf12(:,3),zeros(length(perf12),1),ones(length(perf12),1)*12,ones(length(perf12),1)];

nbase1=[perfBase(:,1),perfBase(:,3),ones(length(perfBase),1),ones(length(perfBase),1)*5,ones(length(perfBase),1)*2];
nbase0=[perfBase(:,2),perfBase(:,3),zeros(length(perfBase),1),ones(length(perfBase),1)*5,ones(length(perfBase),1)*2];

toN=[n51;n50;n81;n80;n121;n120;nbase1;nbase0];

modelMat=[1 0 0 0; 
    0 1 0 0;
    0 0 1 0;
    0 0 0 1;
    1 1 0 1];
    
anovan(toN(:,1),{toN(:,2),toN(:,3),toN(:,4),toN(:,5)},'model',modelMat,'continuous',3, 'varnames',{'Gene','Laser','DelayLen','PurtType'});






load dnmsfiles.mat
[allTrials5,perf5]=stats_GLM(dnmsfiles.delay5s);
[allTrials8,perf8]=stats_GLM(dnmsfiles.delay8s);
[allTrials12,perf12]=stats_GLM(dnmsfiles.delay12s);
[allTrialsBase,perfBase]=stats_GLM(dnmsfiles.baseline);
[allTrialsSample,perfSample]=stats_GLM(dnmsfiles.firstOdor);
[allTrialsTest,perfTest]=stats_GLM(dnmsfiles.secondOdor);
[allTrialsBoth,perfBoth]=stats_GLM(dnmsfiles.bothOdor);


% 9=delay Length 10=delay laser 11=baseline laser 12=sample laser 13=test
% laser

fillIn=@(x,y) [x(:,1:8),repmat(y,size(x,1),1)];
allTrials5=fillIn(allTrials5,[5 1 0 0 0]);
allTrials8=fillIn(allTrials8,[8 1 0 0 0]);
allTrials12=fillIn(allTrials12,[12 1 0 0 0]);
allTrialsBase=fillIn(allTrialsBase,[5 0 1 0 0]);

allTrialsSample=fillIn(allTrialsSample,[5 0 0 1 0]);
allTrialsTest=fillIn(allTrialsTest,[5 0 0 0 1]);
allTrialsBoth=fillIn(allTrialsBoth,[5 0 0 1 1]);


allTrials=[allTrials5;allTrials8;allTrials12;allTrialsBase;allTrialsSample;allTrialsTest;allTrialsBoth];

      %   s t l pc pl g dl pd pb ps pt out
termsMat=[0 0 0 0  0  0 0  0  0  0  0  0;
          1 0 0 0  0  0 0  0  0  0  0  0;
          0 1 0 0  0  0 0  0  0  0  0  0;
          0 0 1 0  0  0 0  0  0  0  0  0;
          0 0 0 1  0  0 0  0  0  0  0  0;
          0 0 0 0  1  0 0  0  0  0  0  0;
          0 0 0 0  0  1 0  0  0  0  0  0;
          0 0 0 0  0  0 1  0  0  0  0  0;
          0 0 0 0  0  0 0  1  0  0  0  0;
          0 0 0 0  0  0 0  0  1  0  0  0;
          0 0 0 0  0  0 0  0  0  1  0  0;
          0 0 0 0  0  0 0  0  0  0  1  0;
          1 1 0 0  0  0 0  0  0  0  0  0;
          0 0 1 0  0  1 0  1  0  0  0  0;
%           0 0 1 0 1 1  1  0  0  0  0;
          0 0 1 0  0  1 0  0  1  0  0  0;
          0 0 1 0  0  1 0  0  0  1  0  0;
          0 0 1 0  0  1 0  0  0  0  1  0];


y=double(allTrials(:,4));
X=double(allTrials(:,[1:3,6:13]));
% X=double(allTrials(:,1:3));


mdl=fitglm(X,y,termsMat,'Categorical',[1:6,8:10],'Distribution','binomial',...
     'VarNames',{'Sample','Test','Laser','PreviousCorrect','PreviousLick','Genotype','Delay_Length','Perturb_Delay','Perturb_Baseline','Perturb_Sample','Perturb_Test','Correct'});

disp(mdl);
plotSlice(mdl);



      %   s t l pc pl g dl pd pb ps pt out
termsMat=[0 0 0 0  0  0 0  0  0  0  0  0;
          1 0 0 0  0  0 0  0  0  0  0  0;
          0 1 0 0  0  0 0  0  0  0  0  0;
          0 0 1 0  0  0 0  0  0  0  0  0;
          0 0 0 1  0  0 0  0  0  0  0  0;
          0 0 0 0  1  0 0  0  0  0  0  0;
          0 0 0 0  0  1 0  0  0  0  0  0;
          0 0 0 0  0  0 1  0  0  0  0  0;
%           0 0 0 0 0 0  1  0  0  0  0;
%           0 0 0 0 0 0  0  1  0  0  0;
%           0 0 0 0 0 0  0  0  1  0  0;
%           0 0 0 0 0 0  0  0  0  1  0;
          1 1 0 0  0  0 0  0  0  0  0  0;
          0 0 1 0  0  1 0  1  0  0  0  0;
%           0 0 1 0 1 1  1  0  0  0  0;
          0 0 1 0  0  1 0  0  1  0  0  0;
          0 0 1 0  0  1 0  0  0  1  0  0;
          0 0 1 0  0  1 0  0  0  0  1  0];


y=double(allTrials(:,5));
X=double(allTrials(:,[1:3,6:13]));
% X=double(allTrials(:,1:3));


mdl=fitglm(X,y,termsMat,'Categorical',[1:6,8:10],'Distribution','binomial',...
     'VarNames',{'Sample','Test','Laser','PreviousCorrect','PreviousLick','Genotype','Delay_Length','Perturb_Delay','Perturb_Baseline','Perturb_Sample','Perturb_Test','Correct'});

disp(mdl);
plotSlice(mdl);

%                             dl pd pb ps pt out
fillIn=@(x,y) [x(:,1:8),repmat(y,size(x,1),1)];
allTrials5=fillIn(allTrials5,[5 1]);
allTrials8=fillIn(allTrials8,[8 1]);
allTrials12=fillIn(allTrials12,[12 1]);
allTrialsBase=fillIn(allTrialsBase,[5 2]);

allTrialsSample=fillIn(allTrialsSample,[5 3]);
allTrialsTest=fillIn(allTrialsTest,[5 4]);
allTrialsBoth=fillIn(allTrialsBoth,[5 5]);
allTrials=[allTrials5;allTrials8;allTrials12;allTrialsBase;allTrialsSample;allTrialsTest;allTrialsBoth];


