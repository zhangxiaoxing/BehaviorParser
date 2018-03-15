classdef plotLearn < handle
    
    properties
        figs;
        fileTags;
    end
    
    methods
        function plot(obj,data)
            obj.figs=[];
            obj.fileTags=[];
            dx=100;
            fw=350;
            path(path,'D:\behavior\reports\z');
            perf=data.perf;
            false=data.false;
            miss=data.miss;
            dpc=data.dpc;
            lickEff=data.lickEff;
            
            n=size(perf,1);
            pos=sum(perf(:,2));
            
            plotLearning(perf,'Correct rate','p');
%             plotLearning(false,'False Choice','f');
%             plotLearning(miss,'Miss','m');
%             plotLearning(dpc,'\it d''','d');
%             plotLearning(lickEff,'Lick Efficiency','l');
            
            if any(strcmp('distPerf',fieldnames(data)))
                plotLearning(data.distPerf,'GNG Performance','dp');
            end
            
            
            
            function plotLearning(data,plotTitle,fileTag)
                
                hf=figure('Color','w','Position',[dx,100,fw,190]);
                hold on;
                plot(data(data(:,2)==0,3:end)','-','Color',[0.4,0.4,0.4]);
                plot(data(data(:,2)==1,3:end)','-','Color',[0.6,0.6,1]);
                hc=plot(mean(data(data(:,2)==0,3:end)),'-ko','LineWidth',2,'MarkerSize',4,'MarkerFaceColor','k');
                ci=bootci(100,@(x) mean(x),data(data(:,2)==0,3:end))-mean(data(data(:,2)==0,3:end));
                errorbar(1:size(data,2)-2,mean(data(data(:,2)==0,3:end)),ci(1,:),ci(2,:),'k.','LineWidth',1);
                
                hop=plot(mean(data(data(:,2)==1,3:end)),'bo-','MarkerSize',3,'LineWidth',2,'MarkerSize',4,'MarkerFaceColor','b');
               
                ci=bootci(100,@(x) mean(x),data(data(:,2)==1,3:end))-mean(data(data(:,2)==1,3:end));
                errorbar(1:size(data,2)-2,mean(data(data(:,2)==1,3:end)),ci(1,:),ci(2,:),'b.','LineWidth',1);

                xlim([0.5,5.5]);
                set(gca,'XTick',1:5,'XColor','k','YColor','k','YTick',[50,75,100]);
                xlabel('Day (100 trials / day)','Color','k');
                ylabel(plotTitle,'Color','k');
                
                h=legend([hc hop],{sprintf('Ctrl n = %d',sum(~perf(:,2))),sprintf('VGAT-ChR2 n = %d',sum(perf(:,2)))});
                h.FontSize=10;
                
                obj.figs=[obj.figs,hf];
                obj.fileTags=[obj.fileTags,fileTag];
                dx=dx+fw+100;
                
            end
            obj.savePlots();
        end
        
        function savePlots(obj)

            for i=1:length(obj.figs)
                set(obj.figs(i),'PaperPositionMode','auto');
                print(obj.figs(i),'-depsc',sprintf('DNMSLearn%s.eps',obj.fileTags(i)));
            end
        end
    end
end