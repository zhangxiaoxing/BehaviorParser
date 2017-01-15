classdef stats_learning_Nphr < handle
    
    methods
        function [perf,false]=sumStats(obj,z)
            z.setMinLick(4);
            perf=nan(11,11);
            false=nan(11,11);
            NpHRPos=[];
            
            midx=1;
            for mice=[1:4 7 9 11:15]
                perf(midx,1:2)=[mice,any(NpHRPos==mice)];
                false(midx,1:2)=[mice,any(NpHRPos==mice)];
                didx=3;
                for date=13:23
%                     disp(date);
                    mStr=['V' num2str(mice) '_'];
                    f=z.listFiles('I:\Behavior\2015\',{mStr,['01_' num2str(date)],'ChR2_2mW_Blue_3s_5sDelay.'});
                    if size(f,1)<1
                        f=z.listFiles('I:\Behavior\2015\',{mStr,['01_' num2str(date)],'_DNMS_NoLaser.'});
                        if size(f,1)<1
                            f=z.listFiles('I:\Behavior\2015\',{mStr,['01_' num2str(date)],'_DNMS_ChR2_2mW_Blue_3s_5sDelay.'});
                            if size(f,1)<1
                            continue;
                            end
                        end
                    end
                   
                    z.processFile(f);
                    crs=z.cr();
                    fas=z.fa();
                    
                    crm=mean(double(crs));
                    fam=mean(double(fas));
                    
                    
                    %         if any(NpHRPos==mice)
                    %             strainStr='NpHR';
                    %         else
                    %             strainStr='ctrl';
                    %         end
                    
                    perf(midx,didx)=crm(1);
                    false(midx,didx)=fam(1);
                    didx=didx+1;
                end
                midx=midx+1;
            end
        end
        
       
        function [perf,false]=oneStat(obj,mice,days)
            z.setMinLick(4);
            perf=nan(1,11);
            false=nan(1,11);
            NpHRPos=[];
            
                perf(1:2)=[mice,any(NpHRPos==mice)];
                false(1:2)=[mice,any(NpHRPos==mice)];
                didx=3;
                for date=days
                    mStr=['V' num2str(mice) '_'];
                    f=z.listFiles('I:\Behavior\2015\',{mStr,['01_' num2str(date)]});
                    if size(f,1)<1
                            continue;
                    end
                    z.processFile(f);
                    crs=z.cr();
                    fas=z.fa();
                    
                    crm=mean(double(crs));
                    fam=mean(double(fas));
                    
                    
                    %         if any(NpHRPos==mice)
                    %             strainStr='NpHR';
                    %         else
                    %             strainStr='ctrl';
                    %         end
                    
                    perf(didx)=crm(1);
                    false(didx)=fam(1);
                    didx=didx+1;
                end
        end
        
        
        function plot(obj,data,yy)
            figure('Color','w','Position',[100 100 400 300]);
            expr=data(data(:,2)==1,3:end);
            ctrl=data(data(:,2)==0,3:end);
%             disp(size(expr));
            meanE=mean(expr);
            semE=std(expr)/sqrt(size(expr,1));
            meanC=mean(ctrl);
            semC=std(ctrl)/sqrt(size(ctrl,1));
            hold on;
            nphr=plot(1:5,meanE(1:5),'r-');
            ctrl=plot(1:5,meanC(1:5),'k-');
            plot(6:8,meanE(6:8),'r:');
            plot(6:8,meanC(6:8),'k:');
            errorbar(1:9,meanE,semE,'r.');
            errorbar(1:9,meanC,semC,'k.');
            legend([nphr ctrl],{'ChR2','Ctrl'});
            xlabel('Day')
            ylabel(yy);
            
        end
        
        
        function plotAll(obj,data,yy)
            figure('Color','w','Position',[100 100 400 300]);
%             expr=data(data(:,2)==1,3:end);
            ctrl=data(data(:,2)==0,3:end);
            
%             disp(size(expr));
%             meanE=mean(expr);
%             semE=std(expr)/sqrt(size(expr,1));
%             meanC=mean(ctrl);
%             semC=std(ctrl)/sqrt(size(ctrl,1));
            hold on;
%             nphr=plot(1:5,expr(1:5),'r-');
            hctrl=plot(1:5,ctrl(:,1:5),'-');
%             plot(6:8,expr(6:8),'r:');
            plot(6:8,ctrl(:,6:8),':');
%             errorbar(1:9,meanE,semE,'r.');
%             errorbar(1:9,meanC,semC,'k.');
            plot(9,ctrl(:,9),'d');
%             legend([nphr ctrl],{'NpHR','Ctrl'});
            xlabel('Day')
            ylabel(yy);
            
        end
    end
end