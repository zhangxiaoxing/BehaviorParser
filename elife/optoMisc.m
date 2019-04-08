classdef OptoMisc < handle
    methods (Static)
        function ranovatbl=ranova8(perMice,measure)
            perfT=table(num2str(perMice.gene.'),...
                perMice.(measure)(:,1),...
                perMice.(measure)(:,2),...
                perMice.(measure)(:,3),...
                perMice.(measure)(:,4),...
                perMice.(measure)(:,5),...
                perMice.(measure)(:,6),...
                perMice.(measure)(:,7),...
                perMice.(measure)(:,8),...
                'VariableNames',{'Genotype',...
                'LaserOff','L138','L434','L831','L165','L363','L561','L1A1'
                });
            opto=table(num2str((1:8).'),'VariableNames',{'OptoCondition'});
            
            RAMDL=fitrm(perfT,'LaserOff,L138,L434,L831,L165,L363,L561,L1A1~Genotype','WithinDesign',opto);
            [ranovatbl,A,C,D]=ranova(RAMDL,'WithinModel','OptoCondition');
        end
        
        function ranovatbl=ranova3(perMice,measure)
            perfT=table(num2str(perMice.gene.'),...
                perMice.(measure)(:,1),...
                perMice.(measure)(:,9),...
                perMice.(measure)(:,10),...
                'VariableNames',{'Genotype',...
                'LaserOff','BL6','BLA'
                });
            opto=table(num2str((1:3).'),'VariableNames',{'OptoCondition'});
            
            RAMDL=fitrm(perfT,'LaserOff,BL6,BLA~Gene','WithinDesign',opto);
            [ranovatbl,A,C,D]=ranova(RAMDL,'WithinModel','OptoCondition');
        end
        
        function ranovatbl=ranova10(perMice,measure)
            perfT=table(num2str(perMice.gene.'),...
                perMice.(measure)(:,1),...
                perMice.(measure)(:,2),...
                perMice.(measure)(:,3),...
                perMice.(measure)(:,4),...
                perMice.(measure)(:,5),...
                perMice.(measure)(:,6),...
                perMice.(measure)(:,7),...
                perMice.(measure)(:,8),...
                perMice.(measure)(:,9),...
                perMice.(measure)(:,10),...
                'VariableNames',{'Genotype',...
                'LaserOff','L138','L434','L831','L165','L363','L561','L1Cx','LxCx','LxC1'
                });
            opto=table(num2str((1:10).'),'VariableNames',{'OptoCondition'});
            
            RAMDL=fitrm(perfT,'LaserOff,L138,L434,L831,L165,L363,L561,L1Cx,LxCx,LxC1~Gene','WithinDesign',opto);
            [ranovatbl,A,C,D]=ranova(RAMDL,'WithinModel','OptoCondition');
        end
        
        function ranovatbl=ranovaBL(perMice,measure)
            perfT=table(num2str(perMice.gene.'),...
                perMice.(measure)(:,1),...
                perMice.(measure)(:,2),...
                perMice.(measure)(:,3),...
                perMice.(measure)(:,4),...
                perMice.(measure)(:,5),...
                perMice.(measure)(:,6),...
                perMice.(measure)(:,7),...
                perMice.(measure)(:,8),...
                perMice.(measure)(:,9),...
                perMice.(measure)(:,10),...
                'VariableNames',{'Genotype',...
                'LaserOff','L138','L434','L831','L165','L363','L561','L1A1','LB6','LBA'
                });
            opto=table(num2str((1:10).'),'VariableNames',{'OptoCondition'});
            
            RAMDL=fitrm(perfT,'LaserOff,L138,L434,L831,L165,L363,L561,L1A1,LB6,LBA~Gene','WithinDesign',opto);
            [ranovatbl,A,C,D]=ranova(RAMDL,'WithinModel','OptoCondition');
        end
        
        function ranovatbl=ranovaVD(perMice,measure)
            perfT=table(num2str(perMice.gene.'),...
                perMice.(measure)(:,1),...
                perMice.(measure)(:,2),...
                perMice.(measure)(:,3),...
                perMice.(measure)(:,4),...
                perMice.(measure)(:,5),...
                perMice.(measure)(:,6),...
                perMice.(measure)(:,7),...
                perMice.(measure)(:,8),...
                'VariableNames',{'Genotype',...
                'D5sOff','D5sOn','D8sOff','D8sOn','D12sOff','D12sOn','D20sOff','D20sOn'});
                opto=table([5,5,8,8,12,12,20,20].',{'Off','On','Off','On','Off','On','Off','On'}.','VariableNames',{'Delay','Laser'});
            
                RAMDL=fitrm(perfT,'D5sOff,D5sOn,D8sOff,D8sOn,D12sOff,D12sOn,D20sOff,D20sOn~Gene','WithinDesign',opto);
            [ranovatbl,A,C,D]=ranova(RAMDL,'WithinModel','Delay*Laser');
        end
        
        function [fh,axL,axR]=plotOne(perMice,measure)
            fh=figure('Color','w','Position',[100,100,450,250]);
            subplot(1,2,1);hold on;
            sel=(perMice.gene==1) ;
            axL=OptoMisc.plotHalf(perMice,measure,sel);
            
            subplot(1,2,2);hold on;
            sel=(perMice.gene==0) ;
            axR=OptoMisc.plotHalf(perMice,measure,sel);
        end
        
        function ax=plotHalf(perMice,measure,sel)
            mm=mean(perMice.(measure)(sel,:));
            
            if length(mm)==8
                bar(1:2:8,mm(1:2:8),0.4,'EdgeColor','k','FaceColor','w');
                bar(2:2:8,mm(2:2:8),0.4,'EdgeColor','k','FaceColor',[0,51,204]./255);
                ysel=1:8;
            elseif length(mm)==10
                bar(1,mm(1),0.8,'EdgeColor','k','FaceColor','w');
                bar(2:4,mm(2:4),0.8,'EdgeColor','k','FaceColor',[0,51,204]./255);
                bar(5:7,mm(5:7),0.8,'EdgeColor','k','FaceColor',[86,180,233]./255);
                bar(8,mm(8),0.8,'EdgeColor','k','FaceColor',[0,158,115]./255);
%                 bar(9:10,mm(9:10),0.4,'EdgeColor','k','FaceColor','b');
                ysel=1:8;
            elseif length(mm)==11
                bar(1,mm(1),0.8,'EdgeColor','k','FaceColor','w');
                bar(2:4,mm(2:4),0.8,'EdgeColor','k','FaceColor',[0,51,204]./255);
                bar(5:7,mm(5:7),0.8,'EdgeColor','k','FaceColor',[86,180,233]./255);
                bar(8:10,mm(8:10),0.8,'EdgeColor','k','FaceColor',[0,158,115]./255);
%                 bar(11,mm(11),0.4,'EdgeColor','k','FaceColor','b');
                ysel=1:10;
            else
                bar(mm,'EdgeColor','k','FaceColor','none');
                ysel=1:size(mm,2);
            end
            ci=bootci(1000,@(x) mean(x),perMice.(measure)(sel,ysel));
            errorbar(ysel,mm(:,ysel),ci(1,:)-mm(:,ysel),ci(2,:)-mm(:,ysel),'k.');
            ax=gca;
            if size(perMice.(measure),2)==10
            set(gca,'XTick',1:8,...%10,...
                'XTickLabel',{'Off','3s Early','3s Mid','3s Late','6s Early','6s Mid','6s Late','10s'},...%,'6s BL','10s BL'},...
                'XTickLabelRotation',60,'FontSize',10);
            elseif size(perMice.(measure),2)==11
                set(gca,'XTick',1:10,...%11,...
                'XTickLabel',{'Off','3s Early','3s Mid','3s Late','6s Early','6s Mid','6s Late','12s Early','12s Mid','12s Late'},...,'10s BL'},...
                'XTickLabelRotation',60,'FontSize',10);
            elseif size(perMice.(measure),2)==8
                set(gca,'XTick',1:8,...
                'XTickLabel',{'5s off','5s on','8s off','8s on','12s off','12s on','20s off','20s on'},...
                'XTickLabelRotation',60,'FontSize',10);
            end
        end
        
        function plotPair(x,y,pColor)
            dd=0.5;
            randd=@(x) rand(size(x,1),1)*0.5-0.25;
            plot((x+randd(y))',y',sprintf('-%s.',pColor));
            
            ci=bootci(1000,@(x) nanmean(x), y(:,1));
            plot([x(1)-dd,x(1)-dd],ci,sprintf('-%s',pColor),'LineWidth',1);
            ci=bootci(1000,@(x) nanmean(x), y(:,2));
            plot([x(3)+dd,x(3)+dd],ci,sprintf('-%s',pColor),'LineWidth',1);
            ci=bootci(1000,@(x) nanmean(x), y(:,3));
            plot([x(3)+dd*2,x(3)+dd*2],ci,sprintf('-%s',pColor),'LineWidth',1);
            
            plot(x(1)-dd,nanmean(y(:,1)),sprintf('%so',pColor),'MarkerFaceColor','w','MarkerSize',4,'LineWidth',1);
            plot(x(3)+dd,nanmean(y(:,2)),sprintf('%so',pColor),'MarkerFaceColor',pColor,'MarkerSize',4,'LineWidth',1);
            plot(x(3)+dd*2,nanmean(y(:,3)),sprintf('%so',pColor),'MarkerFaceColor',pColor,'MarkerSize',4,'LineWidth',1);
            
        end
        
        function p=permTestMice(perMice,measure)
            selOpto=(perMice.gene==1) ;
            selCtrl=(perMice.gene==0) ;
            p=[];
            for i=2:size(perMice.(measure),2)
                p(1,i)=OptoMisc.pairedPermTest(perMice.(measure)(selOpto,1),perMice.(measure)(selOpto,i));
                p(2,i)=OptoMisc.pairedPermTest(perMice.(measure)(selCtrl,1),perMice.(measure)(selCtrl,i));
            end
        end
        
        function p=permTestMiceVD(perMice,measure)
            selOpto=(perMice.gene==1) ;
            selCtrl=(perMice.gene==0) ;
            p=[];
            for i=2:2:size(perMice.(measure),2)
                p(1,i)=OptoMisc.pairedPermTest(perMice.(measure)(selOpto,i-1),perMice.(measure)(selOpto,i));
                p(2,i)=OptoMisc.pairedPermTest(perMice.(measure)(selCtrl,i-1),perMice.(measure)(selCtrl,i));
            end
        end

        function ranovatbl=ranovaOpto(perMice,measure,col)
            sel=perMice.gene==1;
            if ~exist('col','var')
                col=7;
            end
            if col==7
            factorName={...
                'L138','L434','L831','L165','L363','L561','L1A1'};
            perfT=table(...
                perMice.(measure)(sel,2),...
                perMice.(measure)(sel,3),...
                perMice.(measure)(sel,4),...
                perMice.(measure)(sel,5),...
                perMice.(measure)(sel,6),...
                perMice.(measure)(sel,7),...
                perMice.(measure)(sel,8),...
                'VariableNames',factorName);
            opto=table(([3;3;3;6;6;6;10]),([8;4.5;1;5;3;1;1]),'VariableNames',{'Duration','Interval'});
            design='L138,L434,L831,L165,L363,L561,L1A1~1';
            elseif col==9
                factorName={...
                'L138','L434','L831','L165','L363','L561','L1C7','L4C4','L7C1'};
                perfT=table(...
                perMice.(measure)(sel,2),...
                perMice.(measure)(sel,3),...
                perMice.(measure)(sel,4),...
                perMice.(measure)(sel,5),...
                perMice.(measure)(sel,6),...
                perMice.(measure)(sel,7),...
                perMice.(measure)(sel,8),...
                perMice.(measure)(sel,9),...
                perMice.(measure)(sel,10),...
                'VariableNames',factorName);
            opto=table(([3;3;3;6;6;6;12;12;12]),([8;4.5;1;5;3;1;7;4;1]),'VariableNames',{'Duration','Interval'});
            design='L138,L434,L831,L165,L363,L561,L1C7,L4C4,L7C1~1';
            end
    
            RAMDL=fitrm(perfT,design,'WithinDesign',opto);
            [ranovatbl,A,C,D]=ranova(RAMDL,'WithinModel','Duration*Interval');
%             writetable(ranovatbl,'len_lat.xlsx','WriteRowNames',true)
        end
        
        function out=clearBadPerf(facSeq,thresh)
            contSess=4;
            in=false(size(facSeq,1),1);
            for i=1:(size(facSeq,1)-contSess)
                rsped=squeeze(reshape(facSeq(i:i+contSess,:,:),1,[],size(facSeq,3)));
                if (mean(ismember(rsped(rsped(:,7)==0,4),[3 6]))*100)>=thresh
                    in(i:i+contSess)=true;
                end
            end
            out=squeeze(reshape(facSeq(in,:,:),1,[],size(facSeq,3)));
        end
                
        function out=clearBadPerf20(facSeq,thresh)
            contSess=0;
            in=false(size(facSeq,1),1);
            for i=1:(size(facSeq,1)-contSess)
                rsped=squeeze(reshape(facSeq(i:i+contSess,:,:),1,[],size(facSeq,3)));
                if (mean(ismember(rsped(rsped(:,7)==0,4),[3 6]))*100)>=thresh
                    in(i:i+contSess)=true;
                end
            end
            out=squeeze(reshape(facSeq(in,:,:),1,[],size(facSeq,3)));
        end
        
        function [out,larger]=permTest(A,B)
            rawDiff=mean(A(:))-mean(B(:));
            currDelta=abs(rawDiff);
            permed=nan(1,1000);
            for i=1:1000
                [AA,BB]=Tools.permSample(A,B);
                permed(i)=abs(mean(AA)-mean(BB));
            end
            out=mean(permed>=currDelta);
            if rawDiff>0
                larger=1;
            else
                larger=2;
            end
        end
        
        function [newA,newB]=permSample(A,B)
            pool=[A(:);B(:)];
            pool=pool(randperm(length(pool)));
            newA=pool(1:numel(A));
            newB=pool((numel(A)+1):end);
        end
        
        function p=pairedPermTest(A,B,repeat)
            if ~exist('repeat','var')
                repeat=10000;
            end
            currDelta=abs(mean(A(:)-B(:)));
            permed=nan(1,repeat);
            for i=1:repeat
                permed(i)=abs(((rand(1,numel(A))>0.5).*2-1)*(A(:)-B(:)))./numel(A);
            end
            p=mean(permed>=currDelta);
        end
        
        function p=effSize(perMice,measure)
            selOpto=(perMice.gene==1) ;
            selCtrl=(perMice.gene==0) ;
            p=[];
            for i=2:size(perMice.(measure),2)
                p(1,i)=OptoMisc.cohensD(perMice.(measure)(selOpto,i),perMice.(measure)(selOpto,1));
                p(2,i)=OptoMisc.cohensD(perMice.(measure)(selCtrl,i),perMice.(measure)(selCtrl,1));
            end
        end
        
        function p=effSizeVD(perMice,measure)
            selOpto=(perMice.gene==1) ;
            selCtrl=(perMice.gene==0) ;
            p=[];
            for i=2:2:size(perMice.(measure),2)
                p(1,i)=OptoMisc.cohensD(perMice.(measure)(selOpto,i),perMice.(measure)(selOpto,i-1));
                p(2,i)=OptoMisc.cohensD(perMice.(measure)(selCtrl,i),perMice.(measure)(selCtrl,i-1));
            end
        end
        
        function out=cohensD(cond1,cond2)
            nOpto=numel(cond1)-1;
            stdv=sqrt((nOpto*var(cond1)+nOpto*var(cond2))/(2*nOpto));
            out=(mean(cond1)-mean(cond2))/stdv;
        end

        function elifeFormatPrefix(s1,col,tag,efc,efo)
            fprintf('<br/><table><tr><th colspan=%d>%s</th></tr>\n',col,s1);
            fprintf('<tr><td colspan=%d>Effect size (Cohen''s d)</td></tr>\n',col);
            fprintf('<tr><td/>');
            cellfun(@(x) fprintf('<td>%s</td>',x),tag);
            fprintf('</tr>\n<tr><td>ChR2</td>');
            arrayfun(@(x) fprintf('<td>%.2f</td>',x),efo);
            fprintf('</tr>\n<tr><td>Ctrl</td>');
            arrayfun(@(x) fprintf('<td>%.2f</td>',x),efc);
            fprintf('</tr>\n');
        end
        
        function elifeFormatMid(col)
            fprintf('<tr><td>Mixed-between-within-ANOVA</td><td colspan=%d><pre>',col-1);
        end
        
        function elifeFormatPostfix(col,tag,ppc,ppo)
            fprintf('</pre></td></tr>\n<tr><td colspan=%d>Post-hoc paired-permutation test of 10000 repeats, Bonferroni adjusted p-value',col);
            fprintf('<tr><td/>');
            cellfun(@(x) fprintf('<td>%s</td>',x),tag);
            fprintf('</tr>\n<tr><td>ChR2</td>');
            arrayfun(@(x) fprintf('<td>%.3f</td>',x),ppo);
            fprintf('</tr>\n<tr><td>Ctrl</td>');
            arrayfun(@(x) fprintf('<td>%.3f</td>',x),ppc);
            fprintf('</tr></table>\n');
        end        
        
        function Laser_Dura_Interv_Format(s1,tbl)
            fprintf('<br/><table><tr><th colspan=2>%s</th></tr>\n',s1);
            fprintf('<tr><td>Repeated-measure ANOVA</td><td colspan=1><pre>');
            disp(tbl);
            fprintf('</pre></td></tr></table>\n');
        end
        
    end
end