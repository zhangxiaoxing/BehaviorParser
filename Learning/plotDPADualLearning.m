function plotDPADualLearning(dpaData,dualDataDPA,dualDataGNG)

dpaDay=size(dpaData,2)-2;
% dualDay=size(dualDataDPA,2)-2;
n=size(dpaData,1);
close all;
hf=figure('Color','w','Position',[100,100,180,240]);
subplot('Position',[0.20,0.17,0.75,0.6]);
hold on;


hs=plotDPA(dpaData);
hd=plotDualDPA(dualDataDPA);
hg=plotDualGNG(dualDataGNG);

% legend([hs hd hg],{'Single task DPA','Dual-task DPA','Dual-task Go/No-go'},'FontSize',10);

xlabel('Trials','Color','k','FontSize',10);
ylabel('Correct rate','FontSize',10);
xlim([0,2350]);
ylim([50,100]);
set(gca,'YTick',50:25:100);

pause;
savePlots();






    function hd=plotDPA(data)
        plot((1:dpaDay)*288-144,data(:,3:end),'-','Color',[0.8,0.8,0.8],'LineWidth',1);
        hd=plot((1:dpaDay)*288-144,mean(data(:,3:end)),'-ko','MarkerSize',3,'LineWidth',2,'MarkerFaceColor','k');
        ci=bootci(100,@(x) mean(x),data(:,3:end))-mean(data(:,3:end));
        errorbar((1:dpaDay)*288-144,mean(data(:,3:end)),ci(1,:),ci(2,:),'k','LineWidth',1);
    end


    function hd=plotDualDPA(data)
        rectangle('Position',[4*288+1,50,4*288,50],'FaceColor',[0.9,0.9,0.9],'EdgeColor','none');
        plot((1:dpaDay)*288-144+dpaDay*288,data(:,3:end),'-','Color',[1,0.8,0.8],'LineWidth',1);
        hd=plot((1:dpaDay)*288-144+dpaDay*288,mean(data(:,3:end)),'-ro','LineWidth',2,'MarkerFaceColor','r','MarkerSize',3);
        ci=bootci(100,@(x) mean(x),data(:,3:end))-mean(data(:,3:end));
        errorbar((1:dpaDay)*288-144+dpaDay*288,mean(data(:,3:end)),ci(1,:),ci(2,:),'r','LineWidth',1);
    end

    function hg=plotDualGNG(data)
        plot((1:dpaDay)*288-144+dpaDay*288,data(:,3:end),'-','Color',[0.8,0.8,1],'LineWidth',1);
        hg=plot((1:dpaDay)*288-144+dpaDay*288,mean(data(:,3:end)),'-bo','LineWidth',2,'MarkerFaceColor','b','MarkerSize',3);
        ci=bootci(100,@(x) mean(x),data(:,3:end))-mean(data(:,3:end));
        errorbar((1:dpaDay)*288-144+dpaDay*288,mean(data(:,3:end)),ci(1,:),ci(2,:),'b','LineWidth',1);
    end


    function savePlots
        set(hf,'PaperPositionMode','auto');
        print(hf,'-depsc','dpa_dual_learning.eps');
    end
end
