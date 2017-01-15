function barDist (data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
close all;
dist=cell2mat(data(strcmpi('distr',data(:,10)),2));
nodist=cell2mat(data(strcmpi('none',data(:,10)),2));
[~,p]=ttest(dist,nodist);
figure('Color','w','Position',[100,100,150,240]);
subplot('Position',[0.3,0.2,0.7,0.7]);
hold on;
bar(1,mean(nodist),'FaceColor','k','EdgeColor','k','BarWidth',0.7,'LineWidth',1);
bar(2, mean(dist),'FaceColor','w','EdgeColor','k','BarWidth',0.7,'LineWidth',1);
bar(8,0);
errorbar([1 2 8],[mean(nodist),mean(dist),0],[std(nodist)/sqrt(length(nodist)),std(nodist)/sqrt(length(dist)),0],'k.','LineWidth',1);
ylim([50,100]);
xlim([0.2,2.8]);
set(gca,'XTick',[1 2],'XtickLabel',{'DPA','Dual'},'FontSize',10,'LineWidth',0.5);
text(1,42,'task','HorizontalAlignment','center','FontSize',10);
text(2,42,'task','HorizontalAlignment','center','FontSize',10);
text(1.5,100,'***','HorizontalAlignment','center','FontSize',10);
ylabel('Performance','FontSize',10);

saveOne('distOnOff');




    function saveOne(fileName)
        dpath=javaclasspath('-dynamic');
        if ~ismember('I:\java\hel2arial\build\classes\',dpath)
            javaaddpath('I:\java\hel2arial\build\classes\');
        end
        h2a=hel2arial.Hel2arial;
        set(gcf,'PaperPositionMode','auto');
        print('-depsc',[fileName,'.eps'],'-cmyk');
        %         close gcf;
        h2a.h2a([pwd,'\',fileName,'.eps']);
    end

end

