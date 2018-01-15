function plotQtrForAI()
dpath=javaclasspath('-dynamic');
if isempty(strfind(dpath,'arial'))
     javaaddpath('I:\java\hel2arial\build\classes\');
end
h2a=hel2arial.Hel2arial;
path(path,'D:\Behavior\reports\Z');
tags={'Performance','False Choice','Miss' };
groups={'Ctrl','ChR2'};
groupTags={'Ctrl','VGAT-ChR2'};
conditions={'NoLaser','1Q','2Q','3Q','4Q'};
conditionTags={'Off','Q1','Q2','Q3','Q4'};

dataFile=load('pir.mat','pir');
data=dataFile.pir.chr2.dnms.eachQuarter;
fileName={'QtrSip','QtrSif','QtrSim'};

for measure=[2 3 4]
    figure('Color','w', 'Position',[100,100,400 200]);
    subplot('Position',[0.12,0.35 0.75 0.55]);
%     subplot('Position',[0.1, 0.55,0.85,0.4]);
    plotFigureNBar(data,measure,groups,conditions,tags(measure-1));
    
    set(gcf,'PaperPositionMode','auto');
    print('-depsc',[fileName{measure-1},'.eps'],'-cmyk');
    close gcf;
    h2a.h2a([pwd,'\',fileName{measure-1},'.eps']);
end


    function plotFigureNBar(data,measure,groups,conditions,tag)
        nGrp=size(groups,2);
        nCondition=size(conditions,2);
        resultCell=cell(nGrp,nCondition);
        for group=1:nGrp
            for condition=1:nCondition
                resultCell{group,condition}=cell2mat(data(strcmpi(conditions{condition},data(:,5)) & strcmpi(groups{group},data(:,6)),measure));
            end
        end
        
        pValues=ones(nGrp,1);
%         p3Values=ones(nGrp,1);
%         groupDesc={'Wild type = ','VGAT-ChR2 = '};
        for group=1:nGrp
            anovaMat=cell2mat(resultCell(group,:));
            if min(size(anovaMat))>1
                [p,tbl,stats]=anova1(anovaMat,{'NoLaser','Q1','Q2','Q3','Q4'},'off');
                pValues(group)=p;
%                 anovaMat3Q=anovaMat(:,1:4);
%                 [p3,~,~]=anova1(anovaMat3Q,{'NoLaser','Q1','Q2','Q3'},'off');
%                 p3Values(group)=p3;
%                 fprintf('<tr><td class="stats"><p>F = %.4f</p><p>p = %.4f</p></td><td>%s%d</td></tr>\n',table{2,5},p,groupDesc{group},stats.n(1));
            end
        end
        
        
        hold on;
        
%         barw=0.5;
        
%         barplot=zeros(nGrp,nCondition);
ph=nan(nGrp,nCondition);
phm=nan(nGrp,nCondition);
        sems=zeros(1,nGrp*nCondition);
        means=zeros(1,nGrp*nCondition);
        for group=1:nGrp
            for condition=1:nCondition
                count=(group-1)*nCondition+condition;
                means(count)=mean(resultCell{group,condition});
%                 barplot(group,condition)=bar(count,means(count),barw);
                randRange=1./(abs(resultCell{group,condition}-means(count)));
                randRange(randRange>1)=1;
%                 randRange=max(randRange)-randRange;
%                 ph(group,condition)=plot(count+(rand(size(randRange))-1).*randRange.*0.4,resultCell{group,condition},'o','MarkerSize',3);
                ph(group,condition)=plot(-0.2+count*ones(size(resultCell{group,condition})),resultCell{group,condition},'o','MarkerSize',2);
                phm(group,condition)=plot(count+0.2,means(count),'o','MarkerSize',4);
                
                sd=std(resultCell{group,condition});
                sems(count)=sd/sqrt(size(resultCell{group,condition},1));
                pher(group,condition)=errorbar(count+0.2,means(count),sems(count),'.');
            end
        end
        
%         he=errorbar([1,6],means([1,6]),sems([1,6]),'k.');
%         set(he,'LineWidth',1);
%         
%          he=errorbar([2:5,7:10]+0.25,means([2:5,7:10]),sems([2:5,7:10]),'.');
%          set(he,'LineWidth',1,'Color',zGetColor('b1'));
        
%         he=errorbar(half+1:half*2,means(half+1:end),sems(half+1:end),'k.');
%         set(he,'LineWidth',1);
        
        categories=cell(nGrp*nCondition,1);
        
        for group=1:nGrp
            for condition=1:nCondition
%                 categories{(group-1)*nCondition+condition}=[groupTags{group},' ',conditions{condition}];
                 categories{(group-1)*nCondition+condition}=[conditionTags{condition}];
            end
        end
%         groupColors={'k',zGetColor('b1')};
%         faceGroups=repmat({'k';zGetColor('b1')},1,5);
        optoColors={'k',zGetColor('b1'),zGetColor('b1'),zGetColor('b1'),zGetColor('b1')};
        cellTypeColors={'w','w','w','w','w';'k',zGetColor('b1'),zGetColor('b1'),zGetColor('b1'),zGetColor('b1')};
        for group=1:nGrp
            for condition=1:nCondition
%                 set(barplot(group,condition),'EdgeColor',optoColors{condition},'FaceColor',cellTypeColors{group,condition},'LineWidth',1.5);
                  set(ph(group,condition),'MarkerEdgeColor',optoColors{condition},'MarkerFaceColor',cellTypeColors{group,condition});
                  set(phm(group,condition),'MarkerEdgeColor',optoColors{condition},'MarkerFaceColor',cellTypeColors{group,condition},'LineWidth',1);
                  set(pher(group,condition),'Color',optoColors{condition},'LineWidth',1);
            end
        end

        currLim=ylim;
        currLim(1)=currLim(1)-mod(currLim(1),10);
        currLim(2)=currLim(2)-mod(currLim(2),10)+(mod(currLim(2),10)~=0)*10;
        if min(means-sems)>50
            currLim(1)=50;
        end
        ylim(currLim);
        set(gca,'XTick',1:nGrp*nCondition,'XTickLabel',categories,'XColor','k','YColor','k','FontSize',10,'YTick',currLim(1):10:currLim(2));
        ylabel(tag,'FontSize',12);
        
        for group=1:nGrp
%             pStr=p2Str(pValues(group));
            if pValues(group)<0.05
                pStr=sprintf('p = %.4f',pValues(group));
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