function miceAverage=plotLickAll(fs,delayLen)
binW=200;
lickBin=-(delayLen+2)*1000:binW:3500;
addpath d:\Behavior\reports\Z;
ids=unique(regexp(fs,'(?<=\\)\w?\d{1,4}(?=_)','match','once'));
%DBG
optoPos={'33', '38', '41', '101', '102', '106', '107', '66', '67', '76', '78', '80', '81', '83','V14','V15','V7','V9','V1','V49','V50','V58','V59','V62','S1','S5','S6','S12','S16','S24','S32','S31','S33','S34'};

ids=ids(ismember(lower(ids),lower(optoPos)));%only use ChR2 mice

javaaddpath('I:\java\zmat\build\classes\')
z=zmat.Zmat;
% z.setFullSession(20);
% z.setMinLick(5);
% z.setDebugLevel(100);

miceAverage=struct();
miceAverage.hitLaser=nan(length(ids),length(lickBin)-1);
miceAverage.hitNone=nan(length(ids),length(lickBin)-1);
miceAverage.crLaser=nan(length(ids),length(lickBin)-1);
miceAverage.crNone=nan(length(ids),length(lickBin)-1);

for midx=1:length(ids)
    miceF=getMiceFile(ids{midx});
    hitLaser=zeros(size(miceF,1),length(lickBin)-1);
    hitNone=zeros(size(miceF,1),length(lickBin)-1);
    crLaser=zeros(size(miceF,1),length(lickBin)-1);
    crNone=zeros(size(miceF,1),length(lickBin)-1);
    
    for fidx=1:size(miceF,1)
        z.processFile(miceF(fidx,:));
        lickOne=z.getTrialLick(100);
        if ~isempty(lickOne)
%DBG        
%             hitLaser(fidx,:)=histcounts(lickOne(lickOne(:,3)==0 & lickOne(:,4)==1,2),lickBin)./length(unique(lickOne(lickOne(:,3)==0 & lickOne(:,4)==1,1))).*(1000/binW);
%             hitNone(fidx,:)=histcounts(lickOne(lickOne(:,3)==0 & lickOne(:,4)==0,2),lickBin)./length(unique(lickOne(lickOne(:,3)==0 & lickOne(:,4)==0,1))).*(1000/binW);
%             crLaser(fidx,:)=histcounts(lickOne(lickOne(:,3)==3 & lickOne(:,4)==1,2),lickBin)./length(unique(lickOne(lickOne(:,3)==3 & lickOne(:,4)==1,1))).*(1000/binW);
%             crNone(fidx,:)=histcounts(lickOne(lickOne(:,3)==3 & lickOne(:,4)==0,2),lickBin)./length(unique(lickOne(lickOne(:,3)==3 & lickOne(:,4)==0,1))).*(1000/binW);
             hitLaser(fidx,:)=histcounts(lickOne(lickOne(:,3)==0 & lickOne(:,4)==1,2),lickBin)./length(unique(lickOne(lickOne(:,3)==0 & lickOne(:,4)==1,1))).*(1000/binW);
             hitNone(fidx,:)=histcounts(lickOne(lickOne(:,3)==0 & lickOne(:,4)==0,2),lickBin)./length(unique(lickOne(lickOne(:,3)==0 & lickOne(:,4)==0,1))).*(1000/binW);
             crLaser(fidx,:)=histcounts(lickOne(lickOne(:,3)==3 & lickOne(:,4)==1,2),lickBin)./length(unique(lickOne(lickOne(:,3)==3 & lickOne(:,4)==1,1))).*(1000/binW);
             crNone(fidx,:)=histcounts(lickOne(lickOne(:,3)==3 & lickOne(:,4)==0,2),lickBin)./length(unique(lickOne(lickOne(:,3)==3 & lickOne(:,4)==0,1))).*(1000/binW);
        else
            disp('Empty Lick');
            pause();
        end
    end
    
    miceAverage.hitLaser(midx,:)=mean(hitLaser,1);
    miceAverage.hitNone(midx,:)=mean(hitNone,1);
    miceAverage.crLaser(midx,:)=mean(crLaser,1);
    miceAverage.crNone(midx,:)=mean(crNone,1);
end


plotOne(miceAverage.hitLaser,miceAverage.hitNone,'hit');
print('-depsc',sprintf('Lick_LaserOnOff_D%d.eps',delayLen),'-painters');
% plotOne(miceAverage.crLaser,miceAverage.crNone,'cr');




    function out=getMiceFile(id)
        out=char(fs(~(cellfun('isempty',regexp(fs,['(?<=\\)',id,'(?=_)'])))));
    end


    function plotOne(laserOn,laserOff,fname)
        fh=figure('Color','w','Position',[1700,500,(delayLen+6)*45,235]);
        hold on;

        ciOn=bootci(1000,@(x) mean(x),laserOn);
        %DBG
        fill([1:length(ciOn),length(ciOn):-1:1],[ciOn(1,:),flip(ciOn(2,:))],[0.8,0.8,1],'EdgeColor','none');

        ciOff=bootci(1000,@(x) mean(x),laserOff);
        fill([1:length(ciOff),length(ciOff):-1:1],[ciOff(1,:),flip(ciOff(2,:))],[0.5,0.5,0.5],'EdgeColor','none');
        
        plot(mean(laserOff),'-k','LineWidth',1);
        %DBG
        plot(mean(laserOn),'-b','LineWidth',1);

        set(gca,'XTick',[(1000/binW):(1000/binW*2):length(lickBin)]+0.5,'XTickLabel',0:2:length(lickBin)/(1000/binW),'FontSize',10);
        arrayfun(@(x) plot([x x],[0 10],':k'),[0,1 delayLen+1 delayLen+2 delayLen+3 delayLen+3.5]*(1000/binW)+(1000/binW)+0.5);

        xlabel('Time since sample onset (s)','FontSize',10);
        ylabel('Lick (Hz)','FontSize',10);
        
        text(delayLen.*(1000/binW),5,sprintf('n = %d',size(laserOn,1)),'FontSize',10);
        winW=1000/binW;
        

        savefig(fh,sprintf('%ds_%s_lick.fig',delayLen,fname));
        set(fh,'PaperPositionMode','auto');
%         print(fh,sprintf('%ds_%s_lick.eps',delayLen,fname),'-depsc','-cmyk');
%DBG        
        for pidx=1:winW:(length(lickBin)-winW-1)
            [p,larger]=permTest(laserOn(:,(pidx:pidx+winW-1)),laserOff(:,(pidx:pidx+winW-1)));
            colors={'b','k'};
            if p<0.05
                text(pidx+(winW/2+0.5),3.25,p2Str(p),'HorizontalAlignment','center','FontSize',10,'Color',colors{larger});
                text(pidx+(winW/2+0.5),3.75,sprintf('%.3f',p),'HorizontalAlignment','center','FontSize',10,'Color',colors{larger});
                fprintf('Significant %d\n',pidx);
             else
                 text(pidx+(winW/2+0.5),3.25,'N.S.','HorizontalAlignment','center','FontSize',10);
            end
        end
%         xlim([delayLen.*(1000/binW),(delayLen+5).*(1000/binW)]+0.5);
        
        ylim([0,9]);
        
    end



    

end

function [out,larger]=permTest(A,B)
    rawDiff=mean(A(:))-mean(B(:));
    currDelta=abs(rawDiff);
    permed=nan(1,1000);
    for i=1:1000
        [AA,BB]=permSample(A,B);
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