function sumSi(data)
barw=0.7;

chr2=data.chr2;
tasks={'baseline','delay5s','delay8s','delay12s','firstOdor','secondOdor','bothOdor'};
tags={'Baseline','Delay 5s','Delay 8s','Delay 12s','Sample','Test','Sample & Test'};
tCount=size(tasks,2);
dp=nan(tCount,1);
df=dp;
semp=dp;
semf=dp;
pp=dp;
pf=dp;
for t=1:tCount
    [dp(t),semp(t),pp(t)]=getOne(chr2.dnms.(tasks{t}),2);
    [df(t),semf(t),pf(t)]=getOne(chr2.dnms.(tasks{t}),3);
end

figure('Color','w','Position',[100 100 370 240]);
subplot('Position',[0.15,0.64,0.85,0.33]);
plotOne(dp,semp,pp,'\DeltaPerformance');
set(gca,'XTick',[],'XColor','w','box','off','FontSize',10);
subplot('Position',[0.15,0.27,0.85,0.33]);
plotOne(df,semf,pf,'\DeltaFalse Choice');
set(gca,'XTick',1:tCount,'XTickLabel',tags,'XTickLabelRotation',35,'box','off','FontSize',10);

dpath=javaclasspath('-dynamic');
if ~ismember('I:\java\hel2arial\build\classes\',dpath)
    javaaddpath('I:\java\hel2arial\build\classes\');
end

h2a=hel2arial.Hel2arial;
set(gcf,'PaperPositionMode','auto');
print('-depsc','sumSi.eps','-cmyk');
% close gcf;
h2a.h2a([pwd,'\','sumSi.eps']);



    function [dMean,sem,p]=getOne(data,measure)
%         ctrlOff=cell2mat(data(strcmpi('lightOff',data(:,5)) & strcmpi('ctrl',data(:,6)),measure));
%         ctrlOn=cell2mat(data(strcmpi('lightOn',data(:,5)) & strcmpi('ctrl',data(:,6)),measure));
        optoOff=cell2mat(data(strcmpi('lightOff',data(:,5)) & strcmpi('ChR2',data(:,6)),measure));
        optoOn=cell2mat(data(strcmpi('lightOn',data(:,5)) & strcmpi('ChR2',data(:,6)),measure));
%         d=(optoOn-optoOff)./optoOff*100;
        
        dMean=mean(optoOn-optoOff);
        sem=std(optoOn-optoOff)/sqrt(length(optoOn));
        [~,p]=ttest(optoOn,optoOff);
    end

    function plotOne(data,sem,p,label)
        hold on;
        h=bar(1:tCount,data,barw,'LineWidth',1);
        h.FaceColor='w';
        h.LineWidth=1;
        
        errorbar(1:length(data),data,sem,'k.','LineWidth',1);
        
        top=max(data+sem);
        
        for i=1:length(p)
            h=text(i,top-5,sprintf('%.3f',p(i)),'HorizontalAlignment','center','FontSize',8);
%             h.Rotation=35;
             if p(i)<0.05
                text(i,top,p2Str(p(i)),'HorizontalAlignment','center','FontSize',10);
                
             end
        end
        
        ax=gca;
        ylim([min(data-sem-1),max(data+sem+2)]);
        ax.YTick=ax.YTick(mod(ax.YTick,10)==0);
        xlim([0.5,tCount+0.5]);
        
        h=ylabel(label,'FontSize',12);
        h.Position=[-0.75,h.Position(2),h.Position(3)];
        
    end
end
