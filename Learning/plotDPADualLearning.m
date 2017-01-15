function plotDPADualLearning(dpaData,dualDataDPA,dualDataGNG)

dpaDay=size(dpaData,2)-2;
% dualDay=size(dualDataDPA,2)-2;
n=size(dpaData,1);
close all;
hf=figure('Color','w','Position',[100,100,230,320]);
subplot('Position',[0.20,0.17,0.75,0.6]);
hold on;


hs=plotDPA(dpaData);
hd=plotDualDPA(dualDataDPA);
hg=plotDualGNG(dualDataGNG);

legend([hs hd hg],{'Single task DPA','Dual-task DPA','Dual-task Go/No-go'},'FontSize',10);

xlabel('Trials','Color','k','FontSize',10);
ylabel('Performance','FontSize',10);
xlim([0,2350])
pause;
savePlots();

    function hd=plotDPA(data)
        
        hd=plot((1:dpaDay)*288-144,mean(data(:,3:end)),'ko-','LineWidth',1);
        
        h=errorbar((1:dpaDay)*288-144,mean(data(:,3:end)),std(data(:,3:end))/sqrt(n),'k.','LineWidth',1);
        
        %         xlim([0.5,5.5]);
        %         set(gca,'XTick',1:5,'FontSize',10,'XColor','k','YColor','k');
        
    end


    function hd=plotDualDPA(data)
        rectangle('Position',[4*288+1,50,4*288,50],'FaceColor',[0.9,0.9,0.9],'EdgeColor','none');
        hd=plot((1:dpaDay)*288-144+dpaDay*288,mean(data(:,3:end)),'Marker','o','LineStyle','-','Color',[0.5,0,0],'LineWidth',1);
        
        errorbar((1:dpaDay)*288-144+dpaDay*288,mean(data(:,3:end)),std(data(:,3:end))/sqrt(n),'Color',[0.5,0,0],'LineStyle','none','LineWidth',1);
        
        %         xlim([0.5,5.5]);
        %         set(gca,'XTick',1:5,'FontSize',10,'XColor','k','YColor','k');
        
        %         text((1:dpaDay)*288+-288+dpaDay*288,ones(1,size(data,2)-2)*55,{'+0','2','3','4','5'});
    end

    function hg=plotDualGNG(data)
        hg=plot((1:dpaDay)*288-144+dpaDay*288,mean(data(:,3:end)),'Marker','o','LineStyle','--','Color',[0,0,0.5],'LineWidth',1);
        
        h=errorbar((1:dpaDay)*288-144+dpaDay*288,mean(data(:,3:end)),std(data(:,3:end))/sqrt(n),'Color',[0,0,0.5],'LineStyle','none','LineWidth',1);
        
        %         xlim([0.5,5.5]);
        %         set(gca,'XTick',1:5,'FontSize',10,'XColor','k','YColor','k');
        
    end


    function savePlots
        dpath=javaclasspath('-dynamic');
        if ~ismember('I:\java\hel2arial\build\classes\',dpath)
            javaaddpath('I:\java\hel2arial\build\classes\');
        end
        
        h2a=hel2arial.Hel2arial;
        
        set(hf,'PaperPositionMode','auto');
        print(hf,'-depsc','dpa_dual_learning.eps','-cmyk');
        %                 close(obj.figs(i)) ;
        h2a.h2a(sprintf('%s\\dpa_dual_learning.eps',pwd));
    end
end
