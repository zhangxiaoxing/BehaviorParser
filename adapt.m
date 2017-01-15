classdef adapt < handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        dataSeries;
        %         minError;
        %         bonus=false;
        %         cf;
        %         pp;
        count=0;
        %         plateauSample=6;
        %         plateauThres=-0.1;
        %         bonusRange=1;
        p;
    end
    
    methods
        function add(obj,error)
            obj.dataSeries=[obj.dataSeries,abs(error)];
            obj.count=size(obj.dataSeries,2);
            %             if isempty(obj.minError)
            %                 obj.minError=error;
            %             elseif error<obj.minError
            %                 obj.minError=error;
            %             end
            
            %             if obj.count>=3
            %                 stdz=std(obj.dataSeries,0,2);
            %                 if error<obj.minError+stdz*obj.bonusRange;
            %                     obj.bonus=true;
            %                 else
            %                     obj.bonus=false;
            %                 end
            %             end
        end
        
        function clear(obj)
            obj.dataSeries=[];
            obj.count=1;
        end
        
        %         function [p,r]=polyFitz(obj)
        %
        %             if obj.plateauSample<=obj.count
        %                 first=obj.count-obj.plateauSample+1;
        %             else
        %                 first=1;
        %             end
        %             samples=first:obj.count;
        %             p=polyfit(samples,obj.dataSeries(samples),1);
        %             obj.pp=p;
        %             r=corrcoef(samples,obj.dataSeries(samples));
        %         end
        %
        %         function plat=plateaued(obj)
        %             plat=zeros(1,2);
        %             if obj.count>obj.plateauSample;
        %                 [p,~]=obj.polyFitz();
        %                 plat(1)=(p(1,1)>obj.plateauThres);
        %                 flim=obj.expFit();
        %                 plat(2)=mean(obj.dataSeries(obj.count-2:obj.count))<flim;
        %             end
        %         end
        
        function flat=plateaued(obj)
            
            if obj.count>=10
                seg1=obj.dataSeries(obj.count-9:obj.count-5);
                seg2=obj.dataSeries(obj.count-4:end);
                [h,p]=ttest2(seg1,seg2);
                %                 flat=~((mean(seg1)>mean(seg2)) && p<0.1);
                obj.p=p;
                if obj.count>=30
                    flat=true;
                else
                    flat=p>=0.5;
                end
            else
                flat=false;
            end
        end
        
        function plot(obj)
            if obj.count>=10
                figure;
                hold on;
                %                 plot(obj.cf,(1:obj.count)',obj.dataSeries');
                %                 samples=obj.count-obj.plateauSample+1:obj.count;
                %                 plot(samples,polyval(obj.pp,samples),'ko--');
                %                 line([0,obj.count],[obj.cf.a/exp(1),obj.cf.a/exp(1)],'LineStyle','-.','Color','r');
                plot(1:obj.count,obj.dataSeries,'ro');
                seg1a=obj.dataSeries(obj.count-9:obj.count-5);
                seg2a=obj.dataSeries(obj.count-4:end);
                errorbar([obj.count-7, obj.count-2],[mean(seg1a), mean(seg2a)],[(std(seg1a))/sqrt(5), (std(seg2a))/sqrt(5)],'k-');
                text(obj.count-3,max(obj.dataSeries)*0.75,['p=',num2str(obj.p)])
            else
                disp('Not Enough Data Point');
                
            end
        end
        
        %             function flim=expFit(obj)
        %                 if size(obj.dataSeries,2)>=6
        %                     obj.cf=fit((1:size(obj.dataSeries,2))',obj.dataSeries','exp1');
        %                     flim=obj.cf.a/exp(1);
        %                 else
        %                     flim=0;
        %                 end
        %             end
    end
end


