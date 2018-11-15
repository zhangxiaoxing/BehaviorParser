function miceAverage=plotLickDualAll(fs)
delayLen=13;
binW=200;
lickBin=-(delayLen+2)*1000:binW:3500;
% addpath d:\Behavior\reports\Z;
ids=cell(0);
for i=1:length(fs)
    outID=regexp(char(fs(i)),'(?<=\\)D\d{1,3}(?=_)','match');
    if ~ismember(outID{1},ids)
        ids{length(ids)+1}=outID{1};
    end
end
% DBG
% optoPos={'D10','D9','D8','D4','D11','D12','D3','D220','D214','D216', 'D219', 'D221', 'D215'};
%
% ids=ids(ismember(ids,optoPos));


javaaddpath('I:\java\zmat\build\classes\')
z=zmat.ZmatDual;


miceAverage=struct();
% miceAverage.hitLaser=nan(length(ids),length(lickBin)-1);
% miceAverage.hitNone=nan(length(ids),length(lickBin)-1);
% miceAverage.crLaser=nan(length(ids),length(lickBin)-1);
% miceAverage.crNone=nan(length(ids),length(lickBin)-1);

miceAverage.hitLaser=nan(0,length(lickBin)-1);
miceAverage.hitNone=nan(0,length(lickBin)-1);
miceAverage.crLaser=nan(0,length(lickBin)-1);
miceAverage.crNone=nan(0,length(lickBin)-1);

miceAverage.FALaser=nan(0,length(lickBin)-1);
miceAverage.FANone=nan(0,length(lickBin)-1);


for midx=1:length(ids)
    miceF=getMiceFile(ids{midx});
    %     hitLaser=nan(size(miceF,1),length(lickBin)-1);
    %     hitNone=nan(size(miceF,1),length(lickBin)-1);
    %     crLaser=nan(size(miceF,1),length(lickBin)-1);
    %     crNone=nan(size(miceF,1),length(lickBin)-1);
    
    hitGo=nan(0,length(lickBin)-1);
    hitNogo=nan(0,length(lickBin)-1);
    crGo=nan(0,length(lickBin)-1);
    crNogo=nan(0,length(lickBin)-1);
    %     FALaser=nan(0,length(lickBin)-1);
    %     FANone=nan(0,length(lickBin)-1);
    
    
    
    
    
    for fidx=1:size(miceF,1)
        
        z.setFullSession(24);
        z.processFile(strtrim(miceF(fidx,:)));
        facSeq=z.getFactorSeq();
        if numel(facSeq)<50
            z.setFullSession(48);
            z.processFile(strtrim(miceF(fidx,:)));
            facSeq=z.getFactorSeq();
            z.setFullSession(24);
        end
        if numel(facSeq)<10
            continue;
        end
        
        
        
        
        %         z.processFile(miceF(fidx,:));
        lickOne=z.getTrialLick(100);
        if ~isempty(lickOne)
            
            hitGo(fidx,:)=histcounts(lickOne(lickOne(:,3)==0 & lickOne(:,5)==1 & lickOne(:,4)==0,2),lickBin)./length(unique(lickOne(lickOne(:,3)==0 & lickOne(:,5)==1 & lickOne(:,4)==0,1))).*(1000/binW);
            hitNogo(fidx,:)=histcounts(lickOne(lickOne(:,3)==0 & lickOne(:,5)==2 & lickOne(:,4)==0,2),lickBin)./length(unique(lickOne(lickOne(:,3)==0 & lickOne(:,5)==2 & lickOne(:,4)==0,1))).*(1000/binW);
            crGo(fidx,:)=histcounts(lickOne(lickOne(:,3)==3 & lickOne(:,5)==1 & lickOne(:,4)==0,2),lickBin)./length(unique(lickOne(lickOne(:,3)==3 & lickOne(:,5)==1 & lickOne(:,4)==0,1))).*(1000/binW);
            crNogo(fidx,:)=histcounts(lickOne(lickOne(:,3)==3 & lickOne(:,5)==2 & lickOne(:,4)==0,2),lickBin)./length(unique(lickOne(lickOne(:,3)==3 & lickOne(:,5)==2 & lickOne(:,4)==0,1))).*(1000/binW);
            %             FALaser(fidx,:)=histcounts(lickOne(lickOne(:,3)==2 & lickOne(:,4)==1,2),lickBin)./double(onTrials).*(1000/binW);
            %             FANone(fidx,:)=histcounts(lickOne(lickOne(:,3)==2 & lickOne(:,4)==0,2),lickBin)./double(offTrials).*(1000/binW);
            
        end
    end
    if all(isnan(hitGo))
        continue;
    end
    miceAverage.hitLaser(size(miceAverage.hitLaser,1)+1,:)=nanmean(hitGo,1);
    miceAverage.hitNone(size(miceAverage.hitNone,1)+1,:)=nanmean(hitNogo,1);
    miceAverage.crLaser(size(miceAverage.crLaser,1)+1,:)=nanmean(crGo,1);
    miceAverage.crNone(size(miceAverage.crNone,1)+1,:)=nanmean(crNogo,1);
    %     miceAverage.FALaser(size(miceAverage.crLaser,1)+1,:)=nanmean(FALaser,1);
    %     miceAverage.FANone(size(miceAverage.crNone,1)+1,:)=nanmean(FANone,1);
end

fh=figure('Color','w','Position',[100,100,220,240]);
subplot(2,1,1);
hold on;
plotOne(miceAverage.hitLaser,miceAverage.hitNone,'hit');
subplot(2,1,2);
hold on;
plotOne(miceAverage.crLaser,miceAverage.crNone,'CR');
% plotOne(miceAverage.FALaser,miceAverage.FANone,'FA');
% plotOne(miceAverage.crLaser,miceAverage.crNone,'cr');


print('-depsc',sprintf('Lick_Dual.eps'),'-painters');

    function out=getMiceFile(id)
        out=char(fs(~(cellfun('isempty',regexp(fs,['(?<=\\)',id,'(?=_)'])))));
    end


    function plotOne(laserOn,laserOff,fname)
        
        
        ciOn=bootci(1000,@(x) mean(x),laserOn);
        fill([1:length(ciOn),length(ciOn):-1:1],[ciOn(1,:),flip(ciOn(2,:))],[1,0.8,0.8],'EdgeColor','none');
        
        ciOff=bootci(1000,@(x) mean(x),laserOff);
        fill([1:length(ciOff),length(ciOff):-1:1],[ciOff(1,:),flip(ciOff(2,:))],[0.5,0.5,0.5],'EdgeColor','none');
        
        plot(mean(laserOff),'-k','LineWidth',1);
        plot(mean(laserOn),'-r','LineWidth',1);
        
        set(gca,'XTick',[(1000/binW):(1000/binW*5):length(lickBin)]+0.5 ,'XTickLabel',0:5:length(lickBin)/(1000/binW),'FontSize',10);
        delta=delayLen-5;
        arrayfun(@(x) plot([x x],[0 10],':k'),[0,1 3 4.5 14 15 16 16.5]*(1000/binW)+(1000/binW)+0.5);
        xlabel('Time (s)','FontSize',10);
        ylabel('Lick (Hz)','FontSize',10);
        
        text(5,5,sprintf('n = %d',size(laserOn,1)),'FontSize',10);
        winW=1000/binW;
        
        xlim([0,length(lickBin)]);
        ylim([0,8]);
        savefig(fh,sprintf('%ds_%s_lick.fig',delayLen,fname));
        set(fh,'PaperPositionMode','auto');
        print(fh,sprintf('%ds_%s_lick.eps',delayLen,fname),'-depsc','-cmyk');
        %         DBG
        %         for pidx=1:winW:(length(lickBin)-winW-1)
        %             p=permTest(laserOn(:,(pidx:pidx+winW-1)),laserOff(:,(pidx:pidx+winW-1)));
        %             if p<0.05
        %                 text(pidx+(winW/2+0.5),3.25,sprintf('%.3f',p),'HorizontalAlignment','center','FontSize',10);
        % %                 text(pidx+(winW/2+0.5),3.75,sprintf('%.3f',p),'HorizontalAlignment','center','FontSize',10);
        %                 fprintf('Significant %d\n',pidx);
        %              else
        %                  text(pidx+(winW/2+0.5),3.25,'N.S.','HorizontalAlignment','center','FontSize',10);
        %             end
        %         end
        
    end


end

function out=permTest(A,B)
currDelta=abs(mean(A(:))-mean(B(:)));
permed=nan(1,1000);
for i=1:1000
    [AA,BB]=permSample(A,B);
    permed(i)=abs(mean(AA)-mean(BB));
end
out=mean(permed>=currDelta);
end

function [newA,newB]=permSample(A,B)
pool=[A(:);B(:)];
pool=pool(randperm(length(pool)));
newA=pool(1:numel(A));
newB=pool((numel(A)+1):end);
end