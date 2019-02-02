%%%%%%%%%%%%WATER%%%%%%%%%%%%%%%%
figure('Color','w','Position',[100,100,400,300]);
hold on;
waterTS=find(diff(mat(:,3))>3);
startVec=waterTS-1000;
endVec=waterTS+1999;

sel=startVec>0 & endVec<length(mat);
startVec=startVec(sel);
endVec=endVec(sel);

waterTriggered=cell2mat(arrayfun(@(x) mat(startVec(x):endVec(x),1),1:length(startVec),'UniformOutput',false));
baselinedAll=(waterTriggered-mean(waterTriggered(1:500,:)))./mean(waterTriggered(1:500,:)).*100;
idces=1:floor(length(startVec)/3):length(startVec)-1;
colorsFill=[1,0.8,0.8;0.8,1,0.8;0.8,0.8,1];
colorsLine={'r','g','b'};
for idx=1:3
    baselined=baselinedAll(:,idces(idx):idces(idx)+floor(length(startVec)/3)-1);
    stded=std(baselined,[],2);
    sem=stded./sqrt(size(baselined,2));
    mm=mean(baselined,2);
    fill([1:length(sem),fliplr(1:length(sem))],[mm+sem;flip(mm-sem)],colorsFill(idx,:),'EdgeColor','none');
    ph(idx)=plot(mm,'-','Color',colorsLine{idx});
end
plot([1000,1000],ylim(),':k');
set(gca,'XTick',0:500:3000,'XTickLabel',-10:5:20);
legend(ph,{'Early','Mid','Late'},'FontSize',10);
ylabel('dF / F (%)');
xlabel('Time (s)');

%%%%%%%%%%%LICK%%%%%%%%%%%%%%%%%%%%%


figure('Color','w','Position',[100,100,400,300]);
hold on;
lickTS=find(diff(mat(:,2))>0.5);
startVec=lickTS-1000;
endVec=lickTS+1999;

sel=startVec>0 & endVec<length(mat);
startVec=startVec(sel);
endVec=endVec(sel);

waterTriggered=cell2mat(arrayfun(@(x) mat(startVec(x):endVec(x),1),1:length(startVec),'UniformOutput',false));
baselinedAll=(waterTriggered-mean(waterTriggered(1:500,:)))./mean(waterTriggered(1:500,:)).*100;
idces=1:floor(length(startVec)/3):length(startVec)-1;
colorsFill=[1,0.8,0.8;0.8,1,0.8;0.8,0.8,1];
colorsLine={'r','g','b'};
for idx=1:3
    baselined=baselinedAll(:,idces(idx):idces(idx)+floor(length(startVec)/3)-1);
    stded=std(baselined,[],2);
    sem=smooth(stded./sqrt(size(baselined,2)),10);
    mm=smooth(mean(baselined,2),10);
    fill([1:length(sem),fliplr(1:length(sem))],[mm+sem;flip(mm-sem)],colorsFill(idx,:),'EdgeColor','none');
    ph(idx)=plot(mm,'-','Color',colorsLine{idx});
end
plot([1000,1000],ylim(),':k');
set(gca,'XTick',0:500:3000,'XTickLabel',-10:5:20);
legend(ph,{'Early','Mid','Late'},'FontSize',10);
ylabel('dF / F (%)');
xlabel('Time (s)');


%%%%%%%%%%%RAND
randPermm=randperm(size(mat,1));
randTS=randPermm(1:300);
startVec=randTS-1000;
endVec=randTS+1999;

sel=startVec>0 & endVec<length(mat);
startVec=startVec(sel);
endVec=endVec(sel);


waterTriggered=cell2mat(arrayfun(@(x) mat(startVec(x):endVec(x),1),1:length(startVec),'UniformOutput',false));
baselined=waterTriggered-mean(waterTriggered(1:500,:));
stded=std(baselined,[],2);
sem=stded./sqrt(size(baselined,2));
mm=mean(baselined,2);
figure('Color','w','Position',[100,100,400,300]);
hold on;
fill([1:length(sem),fliplr(1:length(sem))],[mm+sem;flip(mm-sem)],[0.8,0.8,1],'EdgeColor','none');
plot(mm,'-b');



%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%    Odor Cue
%%%%%%%%%%%%%%%%%%%%%%%%%%



figure('Color','w','Position',[100,100,400,300]);
hold on;
odorTS=find(diff(mat(:,3))>0.5);
cueTS=odorTS([true;diff(odorTS)>400]);
mBase=mean(base(:,1));
f=mat(:,1)-mBase;
% f=mat(:,1);
startVec=cueTS-100;
endVec=cueTS+899;

sel=startVec>0 & endVec<length(mat);
startVec=startVec(sel);
endVec=endVec(sel);

waterTriggered=cell2mat(arrayfun(@(x) f(startVec(x):endVec(x),1),1:length(startVec),'UniformOutput',false));
baselinedAll=(waterTriggered-mean(waterTriggered(91:100,:)))./mean(waterTriggered(91:100,:)).*100;
idces=1:floor(length(startVec)/3):length(startVec)-1;
colorsFill=[1,0.8,0.8;0.8,1,0.8;0.8,0.8,1;0.8,0.8,0.8];
colorsLine={'r','g','b','k'};
for idx=4%:3
    baselined=baselinedAll;
    stded=smooth(std(baselined,[],2),10);
    sem=stded./sqrt(size(baselined,2));
    mm=smooth(mean(baselined,2),10);
    fill([1:length(sem),fliplr(1:length(sem))],[mm+sem;flip(mm-sem)],colorsFill(idx,:),'EdgeColor','none');
    ph(idx)=plot(mm,'-','Color',colorsLine{idx});
end
arrayfun(@(x) plot([x,x],ylim(),':k'),[100 200 400 500]);
set(gca,'XTick',100:500:700,'XTickLabel',0:5:7,'FontSize',12);
% legend(ph,{'Early','Mid','Late'},'FontSize',10);
ylabel('dF / F (%)');
xlabel('Time (s)');


return








%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Seperate Trials
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

perTrialBase=51:100;


% mat=ser2mat(fs(1,:));
figure('Color','w','Position',[100,100,400,300]);
hold on;
mBase=mean(base(:,1));
f=mat(:,1)-mBase;
%%%%%%%%%%HIT
odorTS=find(diff(mat(:,3))>0.5);
cueTS=odorTS([true;diff(odorTS)>400]);
dfcuets=diff(cueTS);
dffac=diff(factors(:,5));
cueTS1=cueTS*10;
cueTS2=cueTS1+(double(factors(7,5))-cueTS1(7));

cueTS=odorTS([true;diff(odorTS)>400]);
hitTS=factors(factors(:,3)==3,5);
minDisplaceHit=arrayfun(@(x) min(abs(cueTS2(x)-hitTS)),1:length(cueTS2));
cueTS=cueTS(minDisplaceHit<1000);

startVec=cueTS-100;
endVec=cueTS+899;

sel=startVec>0 & endVec<length(mat);
startVec=startVec(sel);
endVec=endVec(sel);

waterTriggered=cell2mat(arrayfun(@(x) f(startVec(x):endVec(x),1),1:length(startVec),'UniformOutput',false));
baselinedAll=(waterTriggered-mean(waterTriggered(perTrialBase,:)))./mean(waterTriggered(perTrialBase,:)).*100;
colorsFill=[1,0.8,0.8;0.8,1,0.8;0.8,0.8,1;0.8,0.8,0.8];
colorsLine={'r','g','b','k'};
for idx=1%:3
    baselined=baselinedAll;
    stded=smooth(std(baselined,[],2),10);
    sem=stded./sqrt(size(baselined,2));
    mm=smooth(mean(baselined,2),10);
    fill([1:length(sem),fliplr(1:length(sem))],[mm+sem;flip(mm-sem)],colorsFill(idx,:),'EdgeColor','none');
    ph(idx)=plot(mm,'-','Color',colorsLine{idx});
end

%%%%%%%%%%%%%%%%%%%Miss
cueTS=odorTS([true;diff(odorTS)>400]);
missTS=factors(factors(:,3)==4,5);
minDisplaceMiss=arrayfun(@(x) min(abs(cueTS2(x)-missTS)),1:length(cueTS2));
cueTS=cueTS(minDisplaceMiss<1000);
startVec=cueTS-100;
endVec=cueTS+899;

sel=startVec>0 & endVec<length(mat);
startVec=startVec(sel);
endVec=endVec(sel);

waterTriggered=cell2mat(arrayfun(@(x) f(startVec(x):endVec(x),1),1:length(startVec),'UniformOutput',false));
baselinedAll=(waterTriggered-mean(waterTriggered(perTrialBase,:)))./mean(waterTriggered(perTrialBase,:)).*100;
colorsFill=[1,0.8,0.8;0.8,1,0.8;0.8,0.8,1;0.8,0.8,0.8];
colorsLine={'r','g','b','k'};
for idx=2%:3
    baselined=baselinedAll;
    stded=smooth(std(baselined,[],2),10);
    sem=stded./sqrt(size(baselined,2));
    mm=smooth(mean(baselined,2),10);
    fill([1:length(sem),fliplr(1:length(sem))],[mm+sem;flip(mm-sem)],colorsFill(idx,:),'EdgeColor','none');
    ph(idx)=plot(mm,'-','Color',colorsLine{idx});
end

%%%%%%%%%%%%%%%%False
cueTS=odorTS([true;diff(odorTS)>400]);
falseTS=factors(factors(:,3)==5,5);
minDisplaceFalse=arrayfun(@(x) min(abs(cueTS2(x)-falseTS)),1:length(cueTS2));
cueTS=cueTS(minDisplaceFalse<1000);
startVec=cueTS-100;
endVec=cueTS+899;

sel=startVec>0 & endVec<length(mat);
startVec=startVec(sel);
endVec=endVec(sel);

waterTriggered=cell2mat(arrayfun(@(x) f(startVec(x):endVec(x),1),1:length(startVec),'UniformOutput',false));
baselinedAll=(waterTriggered-mean(waterTriggered(perTrialBase,:)))./mean(waterTriggered(perTrialBase,:)).*100;
colorsFill=[1,0.8,0.8;0.8,1,0.8;0.8,0.8,1;0.8,0.8,0.8];
colorsLine={'r','g','b','k'};
for idx=3%:3
    baselined=baselinedAll;
    stded=smooth(std(baselined,[],2),10);
    sem=stded./sqrt(size(baselined,2));
    mm=smooth(mean(baselined,2),10);
    fill([1:length(sem),fliplr(1:length(sem))],[mm+sem;flip(mm-sem)],colorsFill(idx,:),'EdgeColor','none');
    ph(idx)=plot(mm,'-','Color',colorsLine{idx});
end
%%%%%%%%%%%%%%Abort
cueTS=odorTS([true;diff(odorTS)>400]);
falseTS=factors(factors(:,3)==13,5);
minDisplaceFalse=arrayfun(@(x) min(abs(cueTS2(x)-falseTS)),1:length(cueTS2));
cueTS=cueTS(minDisplaceFalse<1000);
startVec=cueTS-100;
endVec=cueTS+899;

sel=startVec>0 & endVec<length(mat);
startVec=startVec(sel);
endVec=endVec(sel);

waterTriggered=cell2mat(arrayfun(@(x) f(startVec(x):endVec(x),1),1:length(startVec),'UniformOutput',false));
baselinedAll=(waterTriggered-mean(waterTriggered(perTrialBase,:)))./mean(waterTriggered(perTrialBase,:)).*100;
colorsFill=[1,0.8,0.8;0.8,1,0.8;0.8,0.8,1;0.8,0.8,0.8];
colorsLine={'r','g','b','k'};
for idx=4%:3
    baselined=baselinedAll;
    stded=smooth(std(baselined,[],2),10);
    sem=stded./sqrt(size(baselined,2));
    mm=smooth(mean(baselined,2),10);
    fill([1:length(sem),fliplr(1:length(sem))],[mm+sem;flip(mm-sem)],colorsFill(idx,:),'EdgeColor','none');
    ph(idx)=plot(mm,'-','Color',colorsLine{idx});
end

arrayfun(@(x) plot([x,x],ylim(),':k'),[100 200 400 500]);
set(gca,'XTick',100:500:900,'XTickLabel',0:5:7,'FontSize',12);
legend(ph,{'Hit','Miss','False','Abort'},'FontSize',10);
ylabel('dF / F (%)');
xlabel('Time (s)');
