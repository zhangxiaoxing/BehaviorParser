function plotQtrForAI()
dpath=javaclasspath('-dynamic');
if ~ismember('I:\java\hel2arial\build\classes\',dpath)
    javaaddpath('I:\java\hel2arial\build\classes\');
end
h2a=hel2arial.Hel2arial;
path(path,'I:\Behavior\reports\Z');
tags={'Performance','False Choice','Miss' };
groups={'Ctrl','VGAT-ChR2'};
conditions={'NoLaser','1Q','2Q','3Q','4Q'};
conditionTags={'Off','Q1','Q2','Q3','Q4'};

dataFile=load('silencequarter.mat','data');
fileName={'QtrSip','QtrSif','QtrSim'};
types={'perf','false','miss'};

for t=1:length(types)
    figure('Color','w', 'Position',[100,100,400 250]);
    subplot('Position',[0.12,0.35 0.75 0.55]);
%     subplot('Position',[0.1, 0.55,0.85,0.4]);
    plotFigureNBar(dataFile.data.(types{t}),groups,conditions,tags(t));
    
    set(gcf,'PaperPositionMode','auto');
    print('-depsc',[fileName{t},'.eps'],'-cmyk');
%         close gcf;
    h2a.h2a([pwd,'\',fileName{t},'.eps']);
end




    function plotFigureNBar(data,groups,conditions,tag)
        nGrp=size(groups,2);
        nCondition=size(conditions,2);
        resultCell=cell(nGrp,nCondition);
        for group=1:nGrp
            for condition=1:nCondition
                resultCell{group,condition}=data(data(:,2)==group-1,condition+2);
            end
        end
        
        pValues=ones(nGrp,1);
        groupDesc={'AAV-CaMKII&alpha;-mCherry = ','AAV-CaMKII&alpha;-ChR2-mCherry = '};
        for group=1:nGrp
            anovaMat=cell2mat(resultCell(group,:));
            if min(size(anovaMat))>1
                [p,table,stats]=anova1(anovaMat,{'NoLaser','Q1','Q2','Q3','Q4'},'off');
                pValues(group)=p;
%                 fprintf('<tr><td class="stats"><p>F = %.4f</p><p>p = %.4f</p></td><td>%s%d</td></tr>\n',table{2,5},p,groupDesc{group},stats.n(1));
            end
        end
        
        hold on;
        
        barw=0.5;
        
        barplot=zeros(nGrp,nCondition);
        sems=zeros(1,nGrp*nCondition);
        means=zeros(1,nGrp*nCondition);
        for group=1:nGrp
            for condition=1:nCondition
                count=(group-1)*nCondition+condition;
                means(count)=mean(resultCell{group,condition});
                barplot(group,condition)=bar(count,means(count),barw);
                sd=std(resultCell{group,condition});
                sems(count)=sd/sqrt(size(resultCell{group,condition},1));
            end
        end
        
        he=errorbar(1:size(sems,2),means,sems,'k.');
        set(he,'LineWidth',1);
        
        categories=cell(nGrp*nCondition,1);
        
        for group=1:nGrp
            for condition=1:nCondition
                categories{(group-1)*nCondition+condition}=[groups{group},' ',conditions{condition}];
            end
        end
        groupColors={'k',zGetColor('b1')};
        faceGroups=repmat({'k';zGetColor('b1')},1,5);
        for group=1:nGrp
            for condition=1:nCondition
                set(barplot(group,condition),'EdgeColor',groupColors{group},'FaceColor',faceGroups{group,condition},'LineWidth',1.5);
            end
        end

        currLim=ylim;
        currLim(1)=currLim(1)-mod(currLim(1),10);
        currLim(2)=currLim(2)-mod(currLim(2),10)+(mod(currLim(2),10)~=0)*10;
        if min(means-sems)>70
            currLim(1)=70;
        end
        ylim(currLim);
        set(gca,'XTick',1:nGrp*nCondition,'XTickLabel',conditionTags,'XColor','k','YColor','k','FontSize',10,'YTick',currLim(1):10:currLim(2));
        ylabel(tag,'FontSize',12,'Color','k');
        
        for group=1:nGrp
%             pStr=p2Str(pValues(group));
            if pValues(group)<0.05
                pStr=sprintf('p = %.4f',p);
            else
                pStr='n.s.';
            end
            
            x1=(group-1)*nCondition+1;
            x2=x1+nCondition-1;
            xm=mean([x1,x2]);
            yspan=ylim;
            dY=diff(yspan)*0.01;
            top=yspan(2);
            text(xm,top+7*dY,pStr,'FontSize',10,'HorizontalAlignment','center');
%             if pValues(group)<0.05
                line([x1 x2],[top,top],'LineWidth',1,'Clipping','Off','Color','k');
%                 line([x1 x1],[y-5,y-3],'LineWidth',1,'Clipping','Off','Color','k');
%                 line([x2 x2],[y-5,y-3],'LineWidth',1,'Clipping','Off','Color','k');
%             end
        end
        xlim([0,11]);
        ylim(yspan);
        hold off
    end
end