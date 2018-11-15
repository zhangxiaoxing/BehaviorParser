classdef plotBehave < handle
  
    properties
        pir;
        NPHR='NPHR';
        ChR2='ChR2';
        type='ChR2';
        
    end
    
    properties (Access=private)
        blue=[0.3412    0.7647    0.9294];  
    end
    methods
        
        function obj=plotBehave(pir)
            obj.pir=pir;
        end
        
    end
    
    methods (Access=private)
        function out=getSubPosition(obj,currIdx)
            out=[mod(currIdx,2)*0.5+0.125,floor(currIdx/2)*0.5+0.125,0.35,0.3];
        end
        
        function plotFigure(obj,data,measure)
            placeX=1:4;
            ctrlOff=cell2mat(data(strcmpi('lightOff',data(:,5)) & strcmpi('ctrl',data(:,6)),measure));
            ctrlOn=cell2mat(data(strcmpi('lightOn',data(:,5)) & strcmpi('ctrl',data(:,6)),measure));
            optoOff=cell2mat(data(strcmpi('lightOff',data(:,5)) & strcmpi(obj.type,data(:,6)),measure));
            optoOn=cell2mat(data(strcmpi('lightOn',data(:,5)) & strcmpi(obj.type,data(:,6)),measure));
            
            signs=strrep(strrep(strrep(data(:,8),'BJ','-o'),'MK','-^'),'RQ','-+');
            ctrlSign=signs(strcmpi('lightOff',data(:,5)) & strcmpi('ctrl',data(:,6)));
            optoSign=signs(strcmpi('lightOff',data(:,5)) & strcmpi(obj.type,data(:,6)));
            
            [~,pCtrl]=ttest(ctrlOff,ctrlOn);
            [~,pOpto]=ttest(optoOff,optoOn);
            
            
            semCtrlOff=std(ctrlOff)/sqrt(size(ctrlOff,1));
            semCtrlOn=std(ctrlOn)/sqrt(size(ctrlOn,1));
            semOptoOff=std(optoOff)/sqrt(size(optoOff,1));
            semOptoOn=std(optoOn)/sqrt(size(optoOn,1));
                        
            sigCtrl=obj.p2Str(pCtrl);
            sigOpto=obj.p2Str(pOpto);
            
            hold on;
            
            %             barplot(1)=bar(1,mean(ctrlOff),barw);
            %             barplot(2)=bar(2,mean(ctrlOn),barw);
            %             barplot(3)=bar(3,mean(optoOff),barw);
            %             barplot(4)=bar(4,mean(optoOn),barw);
            
            plot(placeX,[mean(ctrlOff),mean(ctrlOn),mean(optoOff),mean(optoOn)],'ko');
                        
            for iter=1:size(ctrlOff)
                hp=plot([1.33,1.67],[ctrlOff(iter) ctrlOn(iter)],ctrlSign{iter});
                set(hp,'Color','k','MarkerEdgeColor','k');
            end
            %             set(hc,'Color',[0.8,0.8,0.8],'MarkerEdgeColor',[0.8,0.8,0.8],'LineWidth',1.5);
            
            for iter=1:size(optoOff)
                
                hp=plot([3.33,3.67],[optoOff(iter) optoOn(iter)],optoSign{iter});
                set(hp,'Color',[0.1,0.3,1],'MarkerEdgeColor',[0.1,0.3,1]);
            end
                        
            he=errorbar([1:4,8],[mean(ctrlOff) mean(ctrlOn) mean(optoOff) mean(optoOn) 1],[semCtrlOff semCtrlOn semOptoOff semOptoOn 1],'k.');
            
            set(he,'LineWidth',1.5);
                                                            
            text(3.4,max(max([optoOff optoOn])),sigOpto,'FontSize',16);
            text(1.4,max(max([ctrlOff ctrlOn])),sigCtrl,'FontSize',16);
            
            %             text(3.4,max(max([mean(optoOff)+semOptoOff mean(optoOn)+semOptoOn])),sigOpto,'FontSize',16);
            %             text(1.4,max(max([mean(ctrlOff)+semCtrlOff mean(ctrlOn)+semCtrlOn])),sigCtrl,'FontSize',16);
                                    
            if measure==2
                currLim=ylim;
                ylim([50 currLim(2)]);
            else
                currLim=ylim;
                ylim([0 currLim(2)]);
            end
            
            %             set(barplot(1),'EdgeColor','k','FaceColor','w','LineWidth',1.5);
            %             set(barplot(2),'EdgeColor','k','FaceColor','k','LineWidth',1.5);
            %             set(barplot(3),'EdgeColor',[0.1,0.3,1],'FaceColor','w','LineWidth',1.5);
            %             set(barplot(4),'EdgeColor',[0.1,0.3,1],'FaceColor',[0.1,0.3,1],'LineWidth',1.5);
            
            categories={'Ctrl-LaserOff','Ctrl-LaserOn',[obj.type,'-LaserOff'],[obj.type, '-LaserOn']};
            
            set(gca,'XTick',1:4,'XTickLabel',categories,'XTickLabelRotation',30);
                                    
            %             xticklabel_rotate(1:4,25,categories);
            
            if measure~=7
                ylabel('Percentage');
            end
            
            if measure==3
                ymax=ylim;
                text(-0.85,ymax(2)*1.15,['Ctrl N=' num2str(size(ctrlOff,1))]);
                text(-0.85,ymax(2)*1.25,['ChR2 N=' num2str(size(optoOff,1))]);
            end
             xlim([0.5 4.5]);
                        
            hold off
        end
        
        
        function plotEveryTrialFigure(obj,data,measure)

            ctrlOn=cell2mat(data(strcmpi('lightOn',data(:,5)) & strcmpi('ctrl',data(:,6)),measure));
            optoOn=cell2mat(data(strcmpi('lightOn',data(:,5)) & strcmpi(obj.type,data(:,6)),measure));

            [~,pOpto]=ttest2(ctrlOn,optoOn);

            semCtrlOn=std(ctrlOn)/sqrt(size(ctrlOn,1));
            semOptoOn=std(optoOn)/sqrt(size(optoOn,1));

            sigOpto=obj.p2Str(pOpto);
            
            hold on;
            
            barw=0.5;

                        barplot(1)=bar(1,mean(ctrlOn),barw);
                        barplot(2)=bar(2,mean(optoOn),barw);
            
%             plot(placeX,[mean(ctrlOn),mean(optoOn)],'ko');
            
            
%             for iter=1:size(ctrlOff)
%                 plot([1.33,1.67],[ctrlOff(iter) ctrlOn(iter)],'-ko');
%             end
            %             set(hc,'Color',[0.8,0.8,0.8],'MarkerEdgeColor',[0.8,0.8,0.8],'LineWidth',1.5);
            
%             for iter=1:size(optoOff)
%                 hp=plot([3.33,3.67],[optoOff(iter) optoOn(iter)],'-o');
%                 set(hp,'Color',[0.1,0.3,1],'MarkerEdgeColor',[0.1,0.3,1]);
%             end
                        
            he=errorbar([1:2 8],[mean(ctrlOn) mean(optoOn) 1],[semCtrlOn semOptoOn 1],'k.');
            
            set(he,'LineWidth',1.5);
            
            %             text(3.4,max(max([optoOff optoOn])),sigOpto,'FontSize',16);
            text(1.4,max(max([optoOn;ctrlOn])),sigOpto,'FontSize',16);
            
            %             text(3.4,max(max([mean(optoOff)+semOptoOff mean(optoOn)+semOptoOn])),sigOpto,'FontSize',16);
            %             text(1.4,max(max([mean(ctrlOff)+semCtrlOff mean(ctrlOn)+semCtrlOn])),sigCtrl,'FontSize',16);
                                    
            if measure==2
                currLim=ylim;
                ylim([50 currLim(2)]);
            else
                currLim=ylim;
                ylim([0 currLim(2)]);
            end
            
            xlim([0.5 2.5]);
            
                        set(barplot(1),'EdgeColor','k','FaceColor','k','LineWidth',1.5);
                        set(barplot(2),'EdgeColor','k','FaceColor','b','LineWidth',1.5);
            %             set(barplot(3),'EdgeColor',[0.1,0.3,1],'FaceColor','w','LineWidth',1.5);
            %             set(barplot(4),'EdgeColor',[0.1,0.3,1],'FaceColor',[0.1,0.3,1],'LineWidth',1.5);
            
            categories={'Ctrl-LaserOn',[obj.type, '-LaserOn']};
            
            set(gca,'XTick',1:2,'XTickLabel',categories,'XTickLabelRotation',30);
                                    
            %             xticklabel_rotate(1:4,25,categories);
            
            if measure~=7
                ylabel('Percentage');
            end
            
            if measure==3
                ymax=ylim;
                text(-0.1,ymax(2)*1.15,['Ctrl N=' num2str(size(ctrlOn,1))]);
                text(-0.1,ymax(2)*1.25,['ChR2 N=' num2str(size(optoOn,1))]);
            end
            hold off
        end
        
        function plotFigureNBar(obj,data,measure,groups,conditions)
            nGrp=size(groups,2);
            nCondition=size(conditions,2);
            resultCell=cell(nGrp,nCondition);
            for group=1:nGrp
                for condition=1:nCondition
                    resultCell{group,condition}=cell2mat(data(strcmpi(conditions{condition},data(:,5)) & strcmpi(groups{group},data(:,6)),measure));
                end
            end
            
            pValues=ones(nGrp,1);
            for group=1:nGrp
                anovaMat=cell2mat(resultCell(group,:));
                if min(size(anovaMat))>1
                    p=anova1(anovaMat,{'NoLaser','Q1','Q2','Q3','Q4'},'off');
                    pValues(group)=p;
                end
            end
            
            disp(pValues);
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
            
            
            %             for group=1:nGrp
            %                 for condition=1:nCondition
            %                     x=(group-1)*nCondition+condition;
            %                     plot(x,cell2mat(resultCell(group,condition)),'r.');
            %                 end
            %             end
            
            he=errorbar(1:size(sems,2),means,sems,'k.');
            set(he,'LineWidth',1.5);
            
            
            
            
            categories=cell(nGrp*nCondition,1);
            
            for group=1:nGrp
                for condition=1:nCondition
                    categories{(group-1)*nCondition+condition}=[groups{group},'-',conditions{condition}];
                end
            end
            groupColors={'k',obj.blue};
            faceGroups={'k','k','k','k','k';
                obj.blue,obj.blue,obj.blue,obj.blue,obj.blue,};
            for group=1:nGrp
                for condition=1:nCondition
                    set(barplot(group,condition),'EdgeColor',groupColors{group},'FaceColor',faceGroups{group,condition},'LineWidth',1.5);
                end
            end
            
            %             xticklabel_rotate(1:nGrp*nCondition,30,categories);
            set(gca,'XTick',1:nGrp*nCondition,'XTickLabel',categories,'XTickLabelRotation',30);
            
            
            currLim=ylim;
            
            if measure==2
                ylim([50 currLim(2)]);
            end
            
            ylabel('Percentage');
            
            for group=1:nGrp
                pStr=obj.p2Str(pValues(group));
                text((group-0.5)*nCondition+0.5,(currLim(2)-currLim(1))*0.975,pStr,'FontSize',16,'HorizontalAlignment','center');
            end
            
            hold off
            
        end
        
        function str=p2Str(obj,p)
            if p<0.001
                str='***';
            elseif p<0.01
                str='**';
            elseif p<0.05
                str='*';
            else
                str='';
            end
        end
        
        function plotLearningBase(obj,data,yy)
            figure('Color','w','Position',[100 100 400 300]);
            expr=data(data(:,2)==1,3:end);
            ctrl=data(data(:,2)==0,3:end);
            %             disp(size(expr));
            meanE=mean(expr);
            semE=std(expr)/sqrt(size(expr,1));
            meanC=mean(ctrl);
            semC=std(ctrl)/sqrt(size(ctrl,1));
            hold on;
            nphr=plot(1:5,meanE(1:5),'b-');
            ctrl=plot(1:5,meanC(1:5),'k-');
            plot(6:8,meanE(6:8),'b:');
            plot(6:8,meanC(6:8),'k:');
            errorbar(1:9,meanE,semE,'b.');
            errorbar(1:9,meanC,semC,'k.');
            legend([nphr ctrl],{'ChR2','Ctrl'});
            xlabel('Day')
            ylabel(yy);
        end
        
    end
    
    methods
        
        function plotGoNoGo(obj)
            
            desc=' (Go Nogo Control)';
            titles={'False Choice','Miss','Performance','d'''};
            figure('Color','w', 'Position',[150,0,800 600]);
            currIdx=0;
            for measure=[3 4 2 7]
                %                 subplot('Position',[(measure-2)*0.33+0.05,0.1,0.28,0.7]);
                subplot('Position',obj.getSubPosition(currIdx));
                data=obj.pir.gonogo;
                obj.plotFigure(data,measure);
                currIdx=currIdx+1;
                title([titles(currIdx) desc]);
            end
        end
        
        function plotDeltaFigure(obj,data,measure)
            ctrlOff=cell2mat(data(strcmpi('lightOff',data(:,5)) & strcmpi('ctrl',data(:,6)),measure));
            ctrlOn=cell2mat(data(strcmpi('lightOn',data(:,5)) & strcmpi('ctrl',data(:,6)),measure));
            optoOff=cell2mat(data(strcmpi('lightOff',data(:,5)) & strcmpi(obj.type,data(:,6)),measure));
            optoOn=cell2mat(data(strcmpi('lightOn',data(:,5)) & strcmpi(obj.type,data(:,6)),measure));
            
            deltaCtrl=ctrlOn-ctrlOff;
            deltaOpto=optoOn-optoOff;
            
            [~,pOpto]=ttest2(deltaCtrl,deltaOpto);
            
            
            sigOpto=obj.p2Str(pOpto);
            
            
            figure('Color','w','Position',[100 100 400 300]);
            hold on;
            
            barw=0.5;
            barplot(1)=bar(1,mean(deltaCtrl),barw);
            barplot(2)=bar(2,mean(deltaOpto),barw);
            
            plot(ones(size(deltaCtrl)),deltaCtrl,'ro');
            plot(2.*ones(size(deltaOpto)),deltaOpto,'ro');
            
            text(1.4,max([max(deltaCtrl) max(deltaOpto)]),sigOpto,'FontSize',16);
            
            categories={'Ctrl',obj.type};
            
            set(barplot,'EdgeColor','k','FaceColor',[0.75 0.75 0.75]);
            set(gca,'XTick',1:2,'XTickLabel',categories);
            if measure~=7
                ylabel('Percentage');
            end
            hold off
            
        end
        
        function plotDNMS(obj)
            delays={'delay5s','delay8s','delay12s'};
            delayDescs={' (5s Delay)',' (8s Delay)',' (12s Delay)'};
            titles={'False Choice','Miss','Performance','d'''};
            for delay=1:size(delays,2)
                
                figure('Color','w', 'Position',[150,0,800 600]);
                currIdx=0;
                for measure=[3 4 2 7]
                    %                     subplot('Position',[currIdx*0.25+0.05,0.1,0.20,0.7]);
                    subplot('Position',obj.getSubPosition(currIdx));
                    data=obj.pir.dnms.(delays{delay});
                    obj.plotFigure(data,measure);
                    currIdx=currIdx+1;
                    title([titles(currIdx) delayDescs(delay)]);
                end
            end
        end
        
        function plotOne(obj,data)
            titles={'False Choice','Miss','Performance','d'''};
            figure('Color','w', 'Position',[150,0,800 600]);
            currIdx=0;
            for measure=[3 4 2 7]
                subplot('Position',obj.getSubPosition(currIdx));
                obj.plotFigure(data,measure);
                currIdx=currIdx+1;
                title(titles(currIdx));
            end
        end
        
        function plotNPHR(obj)
            delays={'EveryOtherTrial_5s','EveryOtherTrial_8s'};
            delayDescs={' (5s Delay)',' (8s Delay)'};
            titles={'False Choice','Miss','Performance','d'''};
            for delay=1:size(delays,2)
                
                figure('Color','w', 'Position',[150,0,450 600]);
                currIdx=0;
                for measure=[3 4 2 7]
                    subplot('Position',obj.getSubPosition(currIdx));
                    data=obj.pir.(delays{delay});
                    obj.plotFigure(data,measure);
                    currIdx=currIdx+1;
                    title([titles(currIdx) delayDescs(delay)]);
                end
            end
        end
        
        function plotNPHREveryTrial(obj)
            delays={'EveryOtherTrial_5s','EveryOtherTrial_8s'};
            delayDescs={' (5s Delay)',' (8s Delay)'};
            titles={'False Choice','Miss','Performance','d'''};
            for delay=1:size(delays,2)
                
                figure('Color','w', 'Position',[150,0,400 600]);
                currIdx=0;
                for measure=[3 4 2 7]
                    subplot('Position',obj.getSubPosition(currIdx));
                    data=obj.pir.(delays{delay});
                    obj.plotEveryTrialFigure(data,measure);
                    currIdx=currIdx+1;
                    title([titles(currIdx) delayDescs(delay)]);
                end
            end
        end
        
        function plotCtrl(obj)
            controls={'baseline','bothOdor','responseDelay','firstOdor','secondOdor'};
            delayDescs={'(Baseline Control)', '(Both Odor Control)','(Response Delay Control)','(1st Odor Control)','(2nd Odor Control)'};
            titles={'False Choice','Miss','Performance','d'''};
            for control=1:size(controls,2)
                disp(control)
                figure('Color','w', 'Position',[150,0,800 600]);
                currIdx=0;
                for measure=[3 4 2 7]
                    subplot('Position',obj.getSubPosition(currIdx));
                    data=obj.pir.dnms.(controls{control});
                    obj.plotFigure(data,measure);
                    currIdx=currIdx+1;
                    title([titles(currIdx) delayDescs(control)]);
                    
                end
            end
            
            obj.plotGoNoGo();
        end
        
        function plotNoDelay(obj)
            
            controls={'shortLaserNoDelay','longLaserNoDelay','BaseResponseNoDelay'};
            delayDescs={'(No Delay 2.2s Laser Control)','(No Delay 4.2s Laser Control)','(Baseline & Response No Delay Control)'};
            titles={'False Choice','Miss','Performance','d'''};
            for control=1:size(controls,2)
                disp(control)
                figure('Color','w', 'Position',[150,0,800 600]);
                currIdx=0;
                for measure=[3 4 2 7]
                    subplot('Position',obj.getSubPosition(currIdx));
                    data=obj.pir.dnms.(controls{control});
                    obj.plotFigure(data,measure);
                    currIdx=currIdx+1;
                    title([titles(currIdx) delayDescs(control)]);
                    
                end
            end
        end
        
        function plotSumDNMS(obj)
            delays={'delay5s','delay8s','delay12s'};
            delayDescs={'5s Delay','8s Delay','12s Delay'};
            titles={'Performance' 'False Choice' 'Miss'};
            figure('Color','w','Position',[100 100 1200 300]);
            for measure=2:4
                means=zeros(3,4);
                sds=zeros(3,4);
                sems=zeros(3,4);
                tts=zeros(3,2);
                for delay=1:3
                    data=obj.pir.dnms.(delays{delay});
                    types={'ctrlOff','ctrlOn','optoOff','optoOn'};
                    group=struct();
                    group.ctrlOff=cell2mat(data(strcmpi('lightOff',data(:,5)) & strcmpi('ctrl',data(:,6)),measure));
                    group.ctrlOn=cell2mat(data(strcmpi('lightOn',data(:,5)) & strcmpi('ctrl',data(:,6)),measure));
                    group.optoOff=cell2mat(data(strcmpi('lightOff',data(:,5)) & strcmpi(obj.type,data(:,6)),measure));
                    group.optoOn=cell2mat(data(strcmpi('lightOn',data(:,5)) & strcmpi(obj.type,data(:,6)),measure));
                    
                    for datum=1:4
                        means(delay,datum)=mean(group.(types{datum}));
                        sds(delay,datum)=std(group.(types{datum}));
                        sems(delay,datum)=sds(delay,datum)/sqrt(size(group.(types{datum}),1));
                    end
                    
                    [~,pCtrl]=ttest(group.ctrlOff,group.ctrlOn);
                    [~,pOpto]=ttest(group.optoOff,group.optoOn);
                    tts(delay,:)=[pCtrl,pOpto];
                end
                %                 figure('Color','w','Position',[100 100 400 300]);
                
                subplot('Position',[(measure-2)*0.33+0.05,0.1,0.295,0.7]);
                hold on;
                h=bar(means);
                faceColors=[[1 1 1];[0.6 0 0];[1 1 1];[0 0 0.75]];
                edgeColors=[[0.6 0 0];[0.6 0 0];[0 0 0.75];[0 0 0.75]];
                for currBar=1:4
                    set(h(currBar),'FaceColor',faceColors(currBar,:),'EdgeColor',edgeColors(currBar,:),'LineWidth',1);
                end
                
                
                xpos=([-3,-1,1,3])./11;
                disp(tts);
                for currGrp=1:3
                    he=errorbar(currGrp+xpos,means(currGrp,:),sems(currGrp,:),'k.');
                    set(he,'LineWidth',1);
                    if tts(currGrp,1)<0.05
                        basePos=max(means(currGrp,[1 2])+sems(currGrp,[1 2]));
                        text(currGrp-2/11,basePos*1.15,obj.p2Str(tts(currGrp,1)),'FontSize',14,'HorizontalAlignment','center');
                        line([currGrp-3/11;currGrp-1/11],[basePos*1.1;basePos*1.1],'Color','k','LineWidth',2);
                    end
                    
                    if tts(currGrp,2)<0.05
                        basePos=max(means(currGrp,[3 4])+sems(currGrp,[3 4]));
                        text(currGrp+2/11,basePos+3.7,obj.p2Str(tts(currGrp,2)),'FontSize',14,'HorizontalAlignment','center');
                        line([currGrp+1/11;currGrp+3/11],[basePos+2.9;basePos+2.9],'Color','k','LineWidth',2);
                    end
                    disp(basePos);
                end
                if measure==2
                    ylim([50,max(max(means+sems))*1.25]);
                    set(gca,'YTick',50:10:100);
                    line([1-4/11 3+4/11],[50 50],'LineWidth',1,'Color','k');
                else
                    ylim([0,max(max(means+sems))*1.25]);
                end
                set(gca,'XTick',1:3,'XTickLabel',delayDescs);
                ylabel([titles{measure-1},' (%)']);
                title(titles{measure-1});
                legends={'Ctrl-Light Off','Ctrl-LightOn','ChR2-Light Off','ChR2-Light On'};
                
                hl=legend(legends,'Location','NorthWest');
                set(hl,'FontSize',7);
                
            end
        end
        
        function plotDeltaDNMS(obj)
            delays={'delay5s','delay8s','delay12s'};
            delayDescs={' (5s Delay)',' (8s Delay)',' (12s Delay)'};
            titles={'Delta Performance' 'Delta False Choice' 'Delta Miss'};
            for delay=1:3
                for measure=2:4
                    data=obj.pir.dnms.(delays{delay});
                    obj.plotDeltaFigure(data,measure);
                    title([titles(measure-1) delayDescs(delay)]);
                    
                end
            end
        end
        
        function plotQtr(obj)
            sets={'EachQuarter'};
            desc={'Each Quarter'};
            titles={'Performance','False Choice','Miss' };
            groups={'ctrl','ChR2'};
            conditions={'NoLaser','1Q','2Q','3Q','4Q'};
            for set=1:size(sets)
                figure('Color','w', 'Position',[100,100,800 600]);
                currIdx=0;
                for measure=[3 4 2]
                    subplot('Position',[mod(currIdx,2)*0.5+0.125,floor(currIdx/2)*0.5+0.125,0.4,0.3]);
                    
                    data=obj.pir.dnms.ramping.dnms.(sets{set});
                    obj.plotFigureNBar(data,measure,groups,conditions);
                    title([titles(measure-1) desc{set}]);
                    currIdx=currIdx+1;
                end
            end
        end
        
        function plotVarDelay(obj)
            sets={'VaryDelay'};
            desc={'Varying Delay'};
            titles={'Performance','False Choice','Miss' };
            groups={'ctrl','ChR2'};
            conditions={'NoLaser','4s','2s','1s','0.5s'};
            for set=1:size(sets)
                figure('Color','w', 'Position',[100,100,800 600]);
                currIdx=0;
                for measure=[3 4 2]
                    subplot('Position',[mod(currIdx,2)*0.5+0.125,floor(currIdx/2)*0.5+0.125,0.4,0.3]);
                    
                    data=obj.pir.dnms.ramping.dnms.(sets{set});
                    obj.plotFigureNBar(data,measure,groups,conditions);
                    title([titles(measure-1) desc{set}]);
                    currIdx=currIdx+1;
                end
            end
        end
        
        function plotLearning(obj)
            obj.plotLearningBase(obj.pir.dnms.EveryTrialLearningPerf,'Correct Rate%');
            obj.plotLearningBase(obj.pir.dnms.EveryTrialLearningFalse,'False Alarm%');
        end
        
        
    end
end

