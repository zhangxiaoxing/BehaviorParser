function plotQtrForAI()

tags={'Performance','False Choice','Miss' };
groups={'Ctrl','ChR2'};
groupTags={'Ctrl','VGAT-ChR2'};
conditions={'NoLaser','1Q','2Q','3Q','4Q'};
conditionTags={'  No\newlineLaser','Q1','Q2','Q3','Q4'};

dataFile=load('EachQtr.mat','EachQuarter');
data=dataFile.EachQuarter;
fileName={'QtrSip','QtrSif','QtrSim'};

for measure=[2]% 3 4]
    figure('Color','w', 'Position',[100,100,400 250]);
    subplot('Position',[0.12,0.35 0.75 0.55]);
    hold on;
    plotFigureNBar(data,measure,groups,conditions,tags(measure-1));
    
    set(gcf,'PaperPositionMode','auto');
    print('-depsc',[fileName{measure-1},'.eps']);

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
        

        anovamat=[];
        for gIdx=1:size(resultCell,1)
            for lIdx=1:size(resultCell,2)
                for mIdx=1:length(resultCell{gIdx,lIdx})
                    if gIdx==2
                        mDelta=length(resultCell{1,1});
                    else
                        mDelta=0;
                    end
                    anovamat=[anovamat;resultCell{gIdx,lIdx}(mIdx),gIdx,lIdx,mIdx+mDelta];
                end
            end
        end
        [SSQs, DFs, MSQs, Fs, Ps]=mixed_between_within_anova(anovamat);
        [SSQs, DFs, MSQs, Fs, Ps]=mixed_between_within_anova(anovamat(anovamat(:,3)<4,:));%first 3 quarter

        sems=zeros(1,nGrp*nCondition);
        means=zeros(1,nGrp*nCondition);
        colors={'k','b'};
        for group=1:nGrp
            for condition=1:nCondition
                count=(group-1)*nCondition+condition;
                means(count)=mean(resultCell{group,condition});
                oneresult=resultCell{group,condition};
                plot(count,means(count),'+','MarkerFaceColor','none','MarkerEdgeColor',colors{group},'MarkerSize',12,'LineWidth',2);
                plot(count+rand(1,length(oneresult)).*0.6-0.3,oneresult,'o','MarkerFaceColor','none','MarkerEdgeColor',colors{group},'MarkerSize',4);

            end
        end
        
        he=errorbar(1:size(sems,2),means,sems,'k.');
        set(he,'LineWidth',1);
        
        categories=cell(nGrp*nCondition,1);
        
        for group=1:nGrp
            for condition=1:nCondition
%                 categories{(group-1)*nCondition+condition}=[groupTags{group},' ',conditions{condition}];
                 categories{(group-1)*nCondition+condition}=[conditionTags{condition}];
            end
        end

        ylim([55,100]);
        set(gca,'XTick',1:nGrp*nCondition,'XTickLabel',categories,'XColor','k','YColor','k','FontSize',10,'YTick',60:20:100);
        ylabel(tag,'FontSize',10);
        

        xlim([0,11]);

        hold off
        
        
        
    end


end