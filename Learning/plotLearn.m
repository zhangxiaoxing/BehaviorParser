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
            fw=360;
            path(path,'D:\behavior\reports\z');
            perf=data.perf;
            false=data.false;
            miss=data.miss;
            dpc=data.dpc;
            lickEff=data.lickEff;
            
            n=size(perf,1);
            pos=sum(perf(:,2));
            
            plotLearning(perf,'Performance','p');
            plotLearning(false,'False Choice','f');
            plotLearning(miss,'Miss','m');
            plotLearning(dpc,'\it d''','d');
            plotLearning(lickEff,'Lick Efficiency','l');
            
            if any(strcmp('distPerf',fieldnames(data)))
                plotLearning(data.distPerf,'GNG Performance','dp');
            end
            
            
            
            function plotLearning(data,plotTitle,fileTag)
                
                hf=figure('Color','w','Position',[dx,100,fw,190]);
                hold on;
                hc=plot(mean(data(data(:,2)==0,3:end)),'o-','MarkerSize',8);
                hc.LineWidth=1.5;
                hc.Color=zGetColor('b1');
                h=errorbar(1:size(data,2)-2,mean(data(data(:,2)==0,3:end)),std(data(data(:,2)==0,3:end))/sqrt(n-pos),'.');
                h.LineWidth=1;
                h.Color=zGetColor('b1');
                hop=plot(mean(data(data(:,2)==1,3:end)),'bo-','MarkerSize',8);
                hop.LineWidth=1.5;
                hop.Color=zGetColor('b1');
                hop.MarkerFaceColor=zGetColor('b1');
                h=errorbar(1:size(data,2)-2,mean(data(data(:,2)==1,3:end)),std(data(data(:,2)==1,3:end))/sqrt(pos),'b.');
                h.Color=zGetColor('b1');
                h.LineWidth=1;
                xlim([0.5,5.5]);
                set(gca,'XTick',1:5,'FontSize',10,'XColor','k','YColor','k');
                xlabel('Day','Color','k','FontSize',12);
                
                ylabel(plotTitle,'FontSize',12,'Color','k');
                
                h=legend([hc hop],{sprintf('Ctrl n = %d',sum(~perf(:,2))),sprintf('VGAT-ChR2 n = %d',sum(perf(:,2)))});
                h.FontSize=10;
                
                obj.figs=[obj.figs,hf];
                obj.fileTags=[obj.fileTags,fileTag];
                dx=dx+fw+100;
                
            end
            obj.savePlots();
        end
        
        function savePlots(obj)
            dpath=javaclasspath('-dynamic');
            if ~ismember('I:\java\hel2arial\build\classes\',dpath)
                javaaddpath('I:\java\hel2arial\build\classes\');
            end
            
            h2a=hel2arial.Hel2arial;
            for i=1:length(obj.figs)
                set(obj.figs(i),'PaperPositionMode','auto');
                print(obj.figs(i),'-depsc',sprintf('DNMSLearn%s.eps',obj.fileTags(i)),'-cmyk');
%                 close(obj.figs(i)) ;
                h2a.h2a(sprintf('%s\\DNMSLearn%s.eps',pwd,obj.fileTags(i)));
            end
        end
    end
end