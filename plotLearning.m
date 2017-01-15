classdef plotLearning < handle
    properties
        zm;
        dPath='i:\Behavior\2014\';
    end
    
    methods
        %         function plot(obj,dataSet)
        %             types={'performance','falseAlarm','miss'};
        %             titles={'Performance','False Alarm', 'Miss'};
        %             figure('Position',[100,100, 1200,300]);
        %
        %             for type=1:size(types,2)
        %                 data=dataSet.(types{type});
        %                 days=cell2mat(data(:,2));
        %                 lastDay=max(days);
        %                 lightOn=zeros(lastDay,3);
        %                 lightOff=zeros(lastDay,3);
        %                 for day=1:lastDay
        %                     on=cell2mat(data(days==day,5));
        %                     lightOn(day,1)=mean(on);
        %                     lightOn(day,2)=std(on);
        %                     lightOn(day,3)=std(on)/sqrt(length(on));
        %
        %
        %
        %                     off=cell2mat(data(days==day,6));
        %                     lightOff(day,1)=mean(off);
        %                     lightOff(day,2)=std(off);
        %                     lightOff(day,3)=std(off)/sqrt(length(off));
        %                 end
        %                 subplot('Position',[(type-1)*0.33+0.05,0.15,0.28,0.7]);
        %                 hold on;
        %                 plot(1:lastDay,lightOn(:,1),'bo-');
        %                 plot(1:lastDay,lightOff(:,1),'ko--');
        %                 legend('Laser On','Laser Off');
        %                 title(titles{type});
        %                 xlabel('Day');
        %                 ylabel([titles{type},' %']);
        %             end
        %         end
        
        function obj=plotLearning
            javarmpath('I:\java\zmat\dist\zmat.jar');
            javaaddpath('I:\java\zmat\dist\zmat.jar');
            obj.zm=zmat.Zmat;
        end
        
        %         zm.listFiles(path,'37','Learning','InDelay','2mW')
        
        function plotByDay(obj,mouseNo,expType,delayLength,laserPower)
            fileList=cell(obj.zm.listFiles(obj.dPath,mouseNo,expType,delayLength,laserPower));
            disp(fileList);
            data=obj.zm.getPerfs();
            obj.plot(data,mouseNo,'Day');
            
        end
        function plotBySess(obj,mouseNo,expType,delayLength,laserPower)
            fileList=cell(obj.zm.listFiles(obj.dPath,mouseNo,expType,delayLength,laserPower));
            disp(fileList);
            data=obj.zm.getPerfsBySess();
            obj.plot(data,mouseNo,'Session');
            
        end
        
        function plot(obj,data,mouseNo,type)
            titles={'Performance','False Alarm', 'Miss'};
            figure('Color','w','Position',[100,100, 1200,300]);
            
            for measure=1:3
                subplot('Position',[(measure-1)*0.33+0.05,0.15,0.28,0.7]);
                hold on;
                plot(data(:,1),data(:,measure*2),'bo-');
                plot(data(:,1),data(:,measure*2+1),'ko-');
                
                legend('Laser On','Laser Off','Location','Best');
                
                title([titles{measure},'-#',mouseNo]);
                xlim([0,size(data,1)+1]);
                xlabel(type);
                ylabel([titles{measure},' %']);
            end
        end
        
    end
    
    
end