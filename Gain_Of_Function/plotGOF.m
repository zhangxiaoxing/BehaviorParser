classdef plotGOF < handle
    properties
        fileName
        n
        pos
        figX=100
        
    end
    
    methods
        function out=plotGOF
            path(path,'d:\Behavior\reports\Z');
        end
        function plotOld(obj,data)
            % dataF=load('newGain.mat','gain');
            % data=dataF.gain;
            
            perf=data.perf;
            false=data.false;
            miss=data.miss;
            dpc=data.dpc;
            lickEff=data.lickEff;
            
            obj.n=size(perf,1);
            obj.pos=sum(perf(:,2));
            
            % plotLearning(perf,'Performance');
            % plotLearning(false,'False Choice');
            % plotLearning(miss,'Miss');
            % plotLearning(dpc,'\it d''');
            % plotLearning(lickEff,'Lick Efficiency');
            %
            obj.plotBar(perf, 8,'Performance','5sp');
            obj.plotBar(perf, 9,'Performance','8sp');
            obj.plotBar(perf, 10,'Performance','12sp');
            %
            obj.plotBar(false, 8,'False Choice','5sf');
            obj.plotBar(false, 9,'False Choice','8sf');
            obj.plotBar(false, 10,'False Choice','12sf');
            %
            obj.plotBar(miss, 8,'Miss','5sm');
            obj.plotBar(miss, 9,'Miss','8sm');
            obj.plotBar(miss, 10,'Miss','12sm');
            
            obj.plotBar(dpc, 8,'\it d''','5sd');
            obj.plotBar(dpc, 9,'\it d''','8sd');
            obj.plotBar(dpc, 10,'\it d''','12sd');
            
            obj.plotBar(lickEff, 8,'Lick Efficiency','5sl');
            obj.plotBar(lickEff, 9,'Lick Efficiency','8sl');
            obj.plotBar(lickEff, 10,'Lick Efficiency','12sl');
            
        end
        
        function plotOne(obj,data,ylabel,fileName)
            obj.n=size(data,1);
            obj.pos=sum(data(:,2));
            obj.plotBar(data,3,ylabel,fileName);
        end
        
        function plotLearning(data,plotTitle)
            
            figure('Color','w','Position',[100,100,300,240]);
            hold on;
            hc=plot(mean(data(data(:,2)==0,3:7)),'ko-');
            hc.LineWidth=1.5;
            h=errorbar(1:5,mean(data(data(:,2)==0,3:7)),std(data(data(:,2)==0,3:7))/sqrt(obj.n-obj.pos),'k.');
            h.LineWidth=1.5;
            hop=plot(mean(data(data(:,2)==1,3:7)),'bo-');
            hop.LineWidth=1.5;
            hop.Color=zGetColor('b1');
            hop.MarkerFaceColor=zGetColor('b1');
            h=errorbar(1:5,mean(data(data(:,2)==1,3:7)),std(data(data(:,2)==1,3:7))/sqrt(obj.pos),'b.');
            h.Color=zGetColor('b1');
            h.LineWidth=1;
            xlim([0.5,5.5]);
            ylim([50 90]);
            set(gca,'XTick',1:5,'FontSize',10,'XColor','k','YColor','k');
            xlabel('Day','Color','k','FontSize',12);
            
            ylabel(plotTitle,'FontSize',12,'Color','k');
            
            h=legend([hc hop],{'Ctrl n = 14','CaMKII-ChR2 n = 9'});
            h.FontSize=10;
            
            set(gcf,'PaperPositionMode','auto');
            print('-depsc','GoFLearning.eps','-cmyk');
            %         close gcf;
            h2a.h2a([pwd,'\','GoFLearning.eps']);
        end
        
        function plotBar(obj,data,column,plotTitle,fileName)
            figure('Color','w','Position',[100 100 50 200]);
            subplot('Position',[0.4 0.2 0.55 0.66]);
            hold on
            ctrl=data(data(:,2)==0 & ~isnan(data(:,column)),column);
            opto=data(data(:,2)==1 & ~isnan(data(:,column)),column);
            bctl=bar(1,mean(ctrl),'LineWidth',1);
            bopto=bar(2,mean(opto),'LineWidth',1);
            
            errorbar([1 2 12],[mean(ctrl),mean(opto), 0],[std(ctrl)/sqrt(obj.n-obj.pos),std(opto)/sqrt(obj.pos),0],'k.','LineWidth',1);
            %         e.LineWidth=1.5;
            
            set(bctl,'FaceColor','w','LineWidth',1);
            set(bopto,'FaceColor',zGetColor('b1'),'LineWidth',1);
            ylabel(plotTitle,'FontSize',12,'Color','k');
            if min([opto;ctrl])>50
                ylim([50 100]);
            end
            xlim([0,3]);
            %         set(gca,'XTick', [1 2], 'XTickLabel', {'Control','CaMKII-ChR2'},'XTickLabelRotation',40,'FontSize', 10,'XColor','k','YColor','k');
            set(gca,'XTick', [1 2], 'XTickLabel', {},'XTickLabelRotation',40,'FontSize', 10,'XColor','k','YColor','k');
            
            topY=ylim;
            if strcmpi('Performance',plotTitle)
                topY=([50,topY(2)]);
                ylim(topY);
            end
            sigDY=(topY(2)-topY(1))*0.01;
            dY=topY(1)-5*sigDY;
            
            text(0.9,dY,'Ctrl','Color','k','FontSize',10,'VerticalAlignment','top','HorizontalAlignment','center','FontName','Helvetica');
            %         text(1.6,dY,'CaMKII','Color','k','FontSize',10,'VerticalAlignment','top','HorizontalAlignment','left','FontName','Helvetica');
            text(1.6,dY,'CaMKII','Color','k','FontSize',10,'VerticalAlignment','top','HorizontalAlignment','left','FontName','Helvetica');
            text(1.6,dY-11*sigDY,'ChR2','Color','k','FontSize',10,'VerticalAlignment','top','HorizontalAlignment','left','FontName','Helvetica');
            
            
            dy=diff(ylim)*0.01;
            
            yspan=ylim;
            
            [~,p]=ttest2(ctrl,opto);
%             p=ranksum(ctrl,opto);
            fprintf('ctrl n=%d, opto n=%d, ',length(ctrl),length(opto));
            %         if p<0.05
            str=p2Str(p);
            % str=num2str(p);
            t=text(1.5,yspan(2)+(7+(p>0.05)*4)*dy,str,'HorizontalAlignment','center','FontSize',10);
            t.FontSize=10;
            plotPairTag(1,2,yspan(2),dy);
            %         end
            ylim(yspan);
            
            
            function str=p2Str(p)
                fprintf('p=%.4f\n',p);
                if p<0.001
                    str='***';
                elseif p<0.01
                    str='**';
                elseif p<0.05
                    str='*';
                else
                    str='n.s.';
                end
            end
            
            
            
            
            function plotPairTag(x1,x2,y,dy)
                line([x1 x2],[y+5*dy,y+5*dy],'LineWidth',1,'Clipping','Off','Color','k');
                line([x1 x1],[y+3*dy,y+5*dy],'LineWidth',1,'Clipping','Off','Color','k');
                line([x2 x2],[y+3*dy,y+5*dy],'LineWidth',1,'Clipping','Off','Color','k');
            end
            obj.fileName=fileName;
            obj.writeFile();
            
            pause();
        end
        
        function plotOneGroup(obj,data,prefix)
            measures={'perf','false','miss','dpc','lickEff'};
            labels={'Performance','False Choice','Miss','d''','Lick Efficiency'};
            suffix={'sp','sf','sm','sd','sl'};

            obj.n=size(data.(measures{1}),1);
            obj.pos=sum(data.(measures{1})(:,2));
            for i=1:length(measures)
                obj.plotBar(data.(measures{i}),3,labels{i},[prefix,suffix{i}]);
            end
        end
        
        function writeFile(obj)
            
            dpath=javaclasspath('-dynamic');
            if ~ismember('I:\java\hel2arial\build\classes\',dpath)
                javaaddpath('I:\java\hel2arial\build\classes\');
            end
%             path(path,'D:\behavior\reports\z');
            h2a=hel2arial.Hel2arial;
            set(gcf,'PaperPositionMode','auto');
            %         print('-depsc',[fileName,'.eps'],'-cmyk');
            %%%%%%%%%%%%%%%%%%%%%%%
            %%% silence  %%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%
            print('-depsc',['hemiSilence',obj.fileName,'.eps'],'-cmyk');
            %         close gcf;
            h2a.h2a([pwd,'\','hemiSilence',obj.fileName,'.eps']);
        end
    end
end