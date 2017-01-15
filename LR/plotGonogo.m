function plotGonogo( )
%PLOTGONOGO Summary of this function goes here
%   Detailed explanation goes here

rawdata=load('gonogo.mat');
hit=rawdata.gonogo.hit;
miss=rawdata.gonogo.miss;
perf=rawdata.gonogo.perf;

plotOne(hit,'Hit Rate');
plotOne(miss,'Miss Rate');
plotOne(perf,'Performance');

    function plotOne(data,label)
        figure('Position',[100 100 400 300],'Color','w');
        hold on;
        exp=data(data(:,2)==1,3:end);
        ctl=data(data(:,2)==0,3:end);
        hb=bar([mean(ctl);mean(exp)]',0.9);
        set(hb(1),'FaceColor','k');
        set(hb(2),'FaceColor',zGetColor('b1'));
        semExp=std(exp)/sqrt(size(exp,1));
        semCtl=std(ctl)/sqrt(size(ctl,1));
        [~,p]=ttest2(exp,ctl);
        
        for i=find(p<0.05)
            text(i,100,p2Str(p(i)),'FontSize',14,'HorizontalAlignment','center');
        end
        deltaX=0.125;
        he=errorbar([1:3,1:3]+[repmat(-deltaX,1,3),repmat(deltaX,1,3)],[mean(ctl),mean(exp)],[semCtl,semExp],'k.');
        set(he,'LineWidth',1);
        if min(min([mean(exp),mean(ctl)]))>50
            ylim([50,100]);
        else
            ys=ylim;
            ylim([0,ys(2)]);
        end
        legend('Ctrl','ChR2');
        set(gca,'XTick',1:5,'XTickLabel',{'Baseline','Odor','Response Delay'},'XTickLabelRotation',30);
        ylabel(label,'FontSize',14);
    end

end

