classdef multidayStats < handle
    
    properties
        mice=20:30
        dates={'03_20','03_21','03_22','03_23','03_24','03_25','03_26','03_27','03_28'}
        datesLearn={'03_30','03_31','04_01','04_02','04_03'}
        datesTeach={'04_04','04_06','04_07','04_08','04_09',}
        datesCtrl={'Baseline','3s_Delay_2mW_ChR2','FirstOdor','SecondOdor','ResponseDelay'}
        
        rootDir='I:\Behavior\2015\Apr\'
        minLick=14
        LRChR2Mice=[22 23 25 28 30];
        z;
    end
    
    methods
        function obj=multidayStats
            javaaddpath('I:\java\zmat\build\classes');
            obj.z=zmat.Zmat;
            obj.z.updateFilesList('I:\Behavior\2015');
            obj.z.setMinLick(obj.minLick);
        end
        
        function [perf,hitRate,miss]=processdays(obj,lightOn,trialLimits)
            obj.z.setMinLick(obj.minLick);
            mouseCount=1;
            hitRate=NaN(size(obj.mice,2),size(obj.dates,2)+2);
            hitRate(:,1)=obj.mice';
            hitRate(:,2)=ismember(obj.mice,obj.LRChR2Mice)';
            
            miss=hitRate;
            perf=hitRate;
            
            for mouse=obj.mice
                dayCount=3;
                for date=1:length(obj.dates)
                    try
                        fl=obj.z.listFiles({['V',num2str(mouse)],obj.dates{date},'LR','Go'});
                        if size(fl,1)>0
                            if size(fl,1)>1
                                disp(fl);
                                pause;
                            end
                            obj.z.processFile(fl);
                            t=sum(obj.z.getPerf(lightOn,trialLimits));
                            hitRate(mouseCount,dayCount)=t(1)*100/(t(1)+t(3));
                            miss(mouseCount,dayCount)=t(2)*100/t(5);
                            perf(mouseCount,dayCount)=t(1)*100/t(5);
                        else
                            disp(['error at mouse #',num2str(mouse),'Day ',obj.dates{date}]);
                        end
                        dayCount=dayCount+1;
                    catch e
                        disp([num2str(mouse),', ',obj.dates{date},', ',e.identifier]);
                    end
                end
                mouseCount=mouseCount+1;
            end
        end
        
        function plot(obj,LRStats)
            figure
            hold on
            plot(1:9,mean(LRStats.HitRate_LaserEveryTrial_Learning),'bo-');
            plot(1:9,LRStats.HitRate_LaserEveryTrial_Learning,':');
            plot(10:14,LRStats.HitRate_NoLaser_Learning,':');
            plot(10:14,mean(LRStats.HitRate_NoLaser_Learning),'ko-');
            plot(15:19,mean(LRStats.HitRate_NoLaser_Teach),'ro-');
            plot(15:19,LRStats.HitRate_NoLaser_Teach,':');
            
            figure
            hold on
            plot(1:9,mean(LRStats.False_LaserEveryTrial_Learning),'bo-');
            plot(1:9,LRStats.False_LaserEveryTrial_Learning,':');
            plot(10:14,LRStats.False_NoLaser_Learning,':');
            plot(10:14,mean(LRStats.False_NoLaser_Learning),'ko-');
            plot(15:19,mean(LRStats.False_NoLaser_Teach),'ro-');
            plot(15:19,LRStats.False_NoLaser_Teach,':');
        end
        
        function barCtrls(obj,data)
            figure('Position',[100 100 400 300],'Color','w');
            hold on;
            exp=data(data(:,2)==1,3:end);
            ctl=data(data(:,2)==0,3:end);
            hb=bar([mean(ctl);mean(exp)]',0.9);
            set(hb(1),'FaceColor','k');
            set(hb(2),'FaceColor',zGetColor('b1'));
            semExp=std(exp)/sqrt(size(exp,1));
            semCtl=std(ctl)/sqrt(size(ctl,1));
            [~,p]=ttest2(exp,ctl);
            
            for i=find(p<0.05)
                text(i,100,p2Str(p(i)),'FontSize',14,'HorizontalAlignment','center');
            end
            deltaX=0.125;
            he=errorbar([1:5,1:5]+[repmat(-deltaX,1,5),repmat(deltaX,1,5)],[mean(ctl),mean(exp)],[semCtl,semExp],'k.');
            set(he,'LineWidth',1);
            if min(min([mean(exp),mean(ctl)]))>50
                ylim([50,100]);
            else
                ys=ylim;
                ylim([0,ys(2)]);
            end
            legend('Ctrl','ChR2');
            set(gca,'XTick',1:5,'XTickLabel',{'Baseline','Delay','First Odor','Second Odor','Response Delay'},'XTickLabelRotation',30);
        end
        
        function plotLearning(obj,data)
            figure('Position',[100 100 600 400],'Color','w');
            hold on;
            exp=data(data(:,2)==1,3:end);
            ctl=data(data(:,2)==0,3:end);
            
            plot(1:9,mean(ctl(:,1:9)),'k-');
            plot(10:14,mean(ctl(:,10:14)),'k--');
            plot(1:9,mean(exp(:,1:9)),'c-');
            plot(10:14,mean(exp(:,10:14)),'c--');
            
            legend('Ctrl Laser','Ctrl','ChR2 Laser','ChR2');
            
            semExp=std(exp)/sqrt(size(exp,1));
            semCtl=std(ctl)/sqrt(size(ctl,1));
            
            he=errorbar([1:14,1:14],[mean(ctl),mean(exp)],[semCtl,semExp],'k.');
            set(he,'LineWidth',1);
            %             ylim([50,100]);
            
            set(gca,'XTick',1:14,'XTickLabel',[100:100:900,100:100:500]);
            xlabel('Trials');
        end
    end
end

