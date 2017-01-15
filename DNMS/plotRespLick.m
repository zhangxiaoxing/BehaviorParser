classdef plotRespLick < handle
    
    properties
        
        edges
        data
        n
    end
    
    
    methods
        function obj=plotRespLick()
            file=load('dnmsfiles.mat');
            fStruc=file.dnmsfiles;
            javaaddpath('I:\java\zmat\build\classes\');
            z=zmat.Zmat;
            close all;
            
            obj.edges=[-2000:250:3250]/1000+0.125;
            d=struct();
            [d.dHit]=getOneSeries(fStruc.delay5s,0);
            [d.dFalse]=getOneSeries(fStruc.delay5s,2);
            [d.rHit]=getOneSeries(fStruc.responseDelay,0);
            [d.rFalse]=getOneSeries(fStruc.responseDelay,2);
            [d.oHit]=getOneSeries(fStruc.secondOdor,0);
            [d.oFalse]=getOneSeries(fStruc.secondOdor,2);
            obj.data=d;
            
            
            
            function perMice=getOneSeries(files,type)
                optoPos={'33', '38', '41', '101', '102', '106', '107', '66', '67', '76', '78', '80', '81', '83','V14','V15','V7','V9','V1','V49','V50','V58','V59','V62'};
                miceID=unique(regexp(files,'(?<=\\)\w?\d{1,4}(?=_)','match','once'));
                perMice=nan(length(miceID),22);
                lineIdx=1;
                for i=1:length(miceID)
                    if ismember(miceID{i},optoPos)
                        miceFiles=files(~cellfun('isempty',strfind(files,[miceID{i},'_'])));
                        oneMice=getOne(miceFiles,type);
                        if numel(oneMice)>1
                            perMice(lineIdx,:)=mean(oneMice,1);
                            lineIdx=lineIdx+1;
                            %                 else
                            %                     disp(miceFiles);
                        end
                        
                        %         [n,e]=histcounts(out(:,2),-2000:250:1500);
                        %         r=n./out(end,1)*4;
                    end
                end
                if lineIdx<length(miceID)
                    perMice(lineIdx:end,:)=[];
                end
                %                 r=mean(perMice,1);
                %             d=std(perMice,1);
                %             sem=d./sqrt(size(perMice,1));
            end
            
            function out=getOne(miceFiles,type)
                out=nan(102400,22);
                line=1;
                for i=1:length(miceFiles)
                    z.processFile(miceFiles{i});
                    tl0=z.getTrialLick(100);
                    if type==2
                        tl1=tl0(tl0(:,3)==2 & tl0(:,2)>-1000 & tl0(:,2)<4500 & tl0(:,4)==1,[1 2]);
                    else
                        tl1=tl0(tl0(:,3)==0 & tl0(:,2)>-1000 & tl0(:,2)<4500 & tl0(:,4)==0,[1 2]);
                    end
                    
                    if size(tl1,1)>0
                        
                        ids=unique(tl1(:,1));
                        for j=1:length(ids)
                            tl2=tl1(tl1(:,1)==ids(j),2);
                            out(line,:)= histcounts(tl2,-2000:250:3500)*4;
                            line=line+1;
                        end
                    end
                    
                end
                out(line:end,:)=[];
                %         fprintf('total licks, %d\n',accuCount);
                % plot(out(:,2),out(:,1),'.');
                % figure();
                % plot(repmat(double(out(:,2)')./1000-1,2,1),[double(out(:,1))'-1;double(out(:,1))'+1],'k-','LineWidth',0.25);
                % xlim([-2,1.5]);
            end
        end
        
        function plotMaxBar(obj,endBin)
            
            figure('Color','w');
            subplot('Position',[0.1,0.2,0.8,0.7]);
            hold on;
            
            if ~exist('endBin','var')
                endBin=22;
                ylabel('Peak lick frequency (Hz)');
            else
                ylabel('Peak lick frequency before reward (Hz)');
            end
            d=obj.data;
            [dHL,dHMax,dHSE]=getMax(d.dHit(:,1:endBin));
            [dFL,dFMax,dFSE]=getMax(d.dFalse(:,1:endBin));
            [rHL,rHMax,rHSE]=getMax(d.rHit(:,1:endBin));
            [rFL,rFMax,rFSE]=getMax(d.rFalse(:,1:endBin));
            [oHL,oHMax,oHSE]=getMax(d.oHit(:,1:endBin));
            [oFL,oFMax,oFSE]=getMax(d.oFalse(:,1:endBin));

            
            bar(1:3,[dHMax,oHMax,rHMax],'FaceColor','k');
            bar(5:7,[dFMax,oFMax,rFMax],'FaceColor','w');
            
            errorbar([1:3,5:7],[dHMax,oHMax,rHMax,dFMax,oFMax,rFMax],[dHSE,oHSE,rHSE,dFSE,oFSE,rFSE],'k.','LineWidth',2);
            
            function [list,avg,SEM]=getMax(data)
                list=max(data,[],2);
                avg=mean(list);
                SEM=std(max(data,[],2))./sqrt(size(data,1));
            end
            
            yspan=ylim;
            if yspan(2)<5
                ylim([0,5]);
            else 
                ylim([0,10]);
            end
            yspan=ylim;
            dY=(yspan(2)-0)/100;
            
            pHit=anova1([dHL;rHL;oHL],[ones(length(dHL),1);ones(length(rHL),1)*2;ones(length(oHL),1)*3],'off');
            pFalse=anova1([dFL;rFL;oFL],[ones(length(dFL),1);ones(length(rFL),1)*2;ones(length(oFL),1)*3],'off');
            
            hitTagY=max([dHMax,oHMax,rHMax]+[dHSE,oHSE,rHSE]+2.5*dY);
            falseTagY=max([dFMax,oFMax,rFMax]+[dFSE,oFSE,rFSE]+2.5*dY);
            
            line([1,3],[hitTagY,hitTagY],'LineWidth',1,'Color','k','Clipping','off');
            line([5,7],[falseTagY,falseTagY],'LineWidth',1,'Color','k','Clipping','off');
            text(2,hitTagY+dY,[sprintf('p = %.3f',pHit)],'HorizontalAlignment','center','VerticalAlignment','bottom');
            text(6,falseTagY+dY,[sprintf('p = %.3f',pFalse)],'HorizontalAlignment','center','VerticalAlignment','bottom');
            
            set(gca,'XTick',[1 2 3 5 6 7],'XTickLabel',{'Delay','Odor 2','Response','Delay','Odor 2','Response'},'XTickLabelRotation',15);
            text(2.5,-11*dY,'delay','Rotation',15);
            text(6.5,-11*dY,'delay','Rotation',15);
            line([1,3],[-15*dY,-15*dY],'LineWidth',2,'Color','k','Clipping','off');
            line([5,7],[-15*dY,-15*dY],'LineWidth',2,'Color','k','Clipping','off');
            text(2,-20*dY,'Hit (Laser Off)','HorizontalAlignment','center');
            text(6,-20*dY,'False (Laser On)','HorizontalAlignment','center');

        end
        
        function plotAreaBar(obj,area)
            d=obj.data;
            [dHL,dHMax,dHSE]=getArea(d.dHit);
            [dFL,dFMax,dFSE]=getArea(d.dFalse);
            [rHL,rHMax,rHSE]=getArea(d.rHit);
            [rFL,rFMax,rFSE]=getArea(d.rFalse);
            [oHL,oHMax,oHSE]=getArea(d.oHit);
            [oFL,oFMax,oFSE]=getArea(d.oFalse);
            figure('Color','w','Position',[100 100 450 300]);
            subplot('Position',[0.1,0.2,0.8,0.7]);
            hold on;
            
            bar(1:3,[dHMax,oHMax,rHMax],'FaceColor','k');
            bar(5:7,[dFMax,oFMax,rFMax],'FaceColor','w');
            
            errorbar([1:3,5:7],[dHMax,oHMax,rHMax,dFMax,oFMax,rFMax],[dHSE,oHSE,rHSE,dFSE,oFSE,rFSE],'k.','LineWidth',2);
            
            function [list,avg,SEM]=getArea(data)
                
                list=sum(data(:,area),2)*0.25;
                avg=mean(list);
                SEM=std(max(data,[],2))./sqrt(size(data,1));
            end
            
            yspan=ylim;
            
            if yspan(2)<2
                ylim([0,2]);
            else 
                ylim([0,3]);
            end
            yspan=ylim;
            dY=(yspan(2)-0)/100;
            
            pHit=anova1([dHL;rHL;oHL],[ones(length(dHL),1);ones(length(rHL),1)*2;ones(length(oHL),1)*3],'off');
            pFalse=anova1([dFL;rFL;oFL],[ones(length(dFL),1);ones(length(rFL),1)*2;ones(length(oFL),1)*3],'off');
            
            hitTagY=max([dHMax,oHMax,rHMax]+[dHSE,oHSE,rHSE]+2.5*dY);
            falseTagY=max([dFMax,oFMax,rFMax]+[dFSE,oFSE,rFSE]+2.5*dY);
            
            line([1,3],[hitTagY,hitTagY],'LineWidth',1,'Color','k','Clipping','off');
            line([5,7],[falseTagY,falseTagY],'LineWidth',1,'Color','k','Clipping','off');
            text(2,hitTagY+dY,[sprintf('n.s.')],'HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',10,'FontName','Helvetica');
            text(6,falseTagY+dY,[sprintf('p = %.3f',pFalse)],'HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',10,'FontName','Helvetica');
            
            set(gca,'XTick',[0.9 2 3.3 4.9 6 7.3],'XTickLabel',{'Sensory','Odor 2','Response','Sensory','Odor 2','Response'},'FontSize',10,'FontName','Helvetica');
            text(3.05,-13*dY,'delay','FontSize',10,'FontName','Helvetica','HorizontalAlignment','center');
            text(7.05,-13*dY,'delay','FontSize',10,'FontName','Helvetica','HorizontalAlignment','center');
            text(0.75,-13*dY,'delay','FontSize',10,'FontName','Helvetica','HorizontalAlignment','center');
            text(4.75,-13*dY,'delay','FontSize',10,'FontName','Helvetica','HorizontalAlignment','center');
            
            line([1,3],[-19*dY,-19*dY],'LineWidth',2,'Color','k','Clipping','off');
            line([5,7],[-19*dY,-19*dY],'LineWidth',2,'Color','k','Clipping','off');
            text(2,-24*dY,'Hit trials (laser off)','HorizontalAlignment','center','FontSize',10,'FontName','Helvetica');
            text(6,-24*dY,'False trials (laser on)','HorizontalAlignment','center','FontSize',10,'FontName','Helvetica');
            ylabel('Average licking frequency in response delay (Hz)  ','FontSize',12,'FontName','Helvetica');
            
            
            
        end
        
        
        function plotCurve(obj)
            
            figure('Color','w','Position',[100,100,640,300]);
            hold on;
            
            fill([-1,0,0,-1],[0,0,15,15],[0.8,1,0.8],'EdgeColor','none','FaceAlpha',0.5); %Odor 2
            fill([1,1.5,1.5,1],[0,0,15,15],[0.8,0.8,1],'EdgeColor','none','FaceAlpha',0.5); %Reward
            d=obj.data;
            function [avg,SEM]=getMean(data)
                avg=mean(data);
                SEM=std(data)./sqrt(size(data,1));
            end
            
            
            p=nan(2,11);
            tdata={d.dHit,d.rHit,d.oHit,d.dFalse,d.rFalse,d.oFalse};
            for i=2:2:22
                dd=cell(6,1);
                for j=1:6
                    td=tdata{j}(:,i-1:i);
                    dd{j}=[td(:),ones(numel(td),1)*j];
                end
                ah=[dd{1};dd{2};dd{3}];
                af=[dd{4};dd{5};dd{6}];
                p(1,i/2)=anovan(ah(:,1),ah(:,2),'display','off');
                p(2,i/2)=anovan(af(:,1),af(:,2),'display','off');
            end
            
            
            [dHit,dHSE]=getMean(d.dHit);
            [dFalse,dFSE]=getMean(d.dFalse);
            [rHit,rHSE]=getMean(d.rHit);
            [rFalse,rFSE]=getMean(d.rFalse);
            [oHit,oHSE]=getMean(d.oHit);
            [oFalse,oFSE]=getMean(d.oFalse);
            
            
            fill([obj.edges,fliplr(obj.edges)],[dHit-dHSE,fliplr(dHit+dHSE)],[0.9,0.9,0.9],'EdgeColor','none','FaceAlpha',0.5);
            fill([obj.edges,fliplr(obj.edges)],[dFalse-dFSE,fliplr(dFalse+dFSE)],[0.8,0.8,0.8],'EdgeColor','none','FaceAlpha',0.5);
            fill([obj.edges,fliplr(obj.edges)],[rHit-rHSE,fliplr(rHit+rHSE)],[1,0.9,0.9],'EdgeColor','none','FaceAlpha',0.5);
            fill([obj.edges,fliplr(obj.edges)],[rFalse-rFSE,fliplr(rFalse+rFSE)],[1,0.8,0.8],'EdgeColor','none','FaceAlpha',0.5);
            fill([obj.edges,fliplr(obj.edges)],[oHit-oHSE,fliplr(oHit+oHSE)],[0.9,0.9,1],'EdgeColor','none','FaceAlpha',0.5);
            fill([obj.edges,fliplr(obj.edges)],[oFalse-oFSE,fliplr(oFalse+oFSE)],[0.8,0.8,1],'EdgeColor','none','FaceAlpha',0.5);
            
            
            h1=plot(obj.edges,dHit,':k','LineWidth',1);
            h2=plot(obj.edges,dFalse,'-k','LineWidth',1);
            
            h3=plot(obj.edges,rHit,':r','LineWidth',1);
            h4=plot(obj.edges,rFalse,'-r','LineWidth',1);
            
            h5=plot(obj.edges,oHit,':b','LineWidth',1);
            h6=plot(obj.edges,oFalse,'-b','LineWidth',1);
            
            set(gca,'FontSize',10);
            xlabel('Time since response delay (s)','FontSize',10);
            ylabel('Lick Frequency (Hz)');
            
            legend([h2,h6,h4,h1,h5,h3],{'False - Laser on (Sensory-delay)','False - Laser on (Odor 2)','False - Laser on (Response-delay)','Hit - Laser off (Sensory-delay)','Hit - Laser off (Odor 2)','Hit - Laser off (Response-delay)'},'Location','northeastoutside');
            text(-0.5,6.5,'Odor 2','FontSize',10,'HorizontalAlignment','center');
            text(1.25,6.5,'Reward','FontSize',10,'HorizontalAlignment','center');
            for i=1:9
                text(i*0.5-0.25-2,9,p2str(p(2,i)),'FontSize',10,'HorizontalAlignment','center');
            end
            
            ylim([0,10]);
            xlim([-2,2.5]);
            
            
            function str=p2str(p)
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
            
        end
        
        function str=p2str(p)
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
        
        function writeFile(obj,fileName)
            
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
end
