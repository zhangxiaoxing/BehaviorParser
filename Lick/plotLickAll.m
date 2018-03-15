function miceAverage=plotLickAll(fs,delay)
binW=200;
lickBin=-(delay+2)*1000:binW:3500;
addpath d:\Behavior\reports\Z;
ids=cell(0);
for i=1:length(fs)
    outID=regexp(char(fs(i)),'(?<=\\)\w?\d{1,4}(?=_)','match');
    if ~ismember(outID{1},ids)
        ids{length(ids)+1}=outID{1};
    end
end

% optoPos={'33', '38', '41', '101', '102', '106', '107', '66', '67', '76', '78', '80', '81', '83','V14','V15','V7','V9','V1','V49','V50','V58','V59','V62','S1','S5','S6','S12','S16','S24','S32','S31','S33','S34'};
% 
% ids=ids(ismember(ids,optoPos));


javaaddpath('I:\java\zmat\build\classes\')
z=zmat.Zmat;
z.setFullSession(20);
z.setMinLick(5);
z.setDebugLevel(100);

miceAverage=struct();
miceAverage.hitLaser=nan(length(ids),length(lickBin)-1);
miceAverage.hitNone=nan(length(ids),length(lickBin)-1);
miceAverage.crLaser=nan(length(ids),length(lickBin)-1);
miceAverage.crNone=nan(length(ids),length(lickBin)-1);

for midx=1:length(ids)
    miceF=getMiceFile(ids{midx});
    hitLaser=nan(size(miceF,1),length(lickBin)-1);
    hitNone=nan(size(miceF,1),length(lickBin)-1);
    crLaser=nan(size(miceF,1),length(lickBin)-1);
    crNone=nan(size(miceF,1),length(lickBin)-1);
    
    for fidx=1:size(miceF,1)
        z.processFile(miceF(fidx,:));
        lickOne=z.getTrialLick(100);
        if ~isempty(lickOne)
            onTrials=max(lickOne(lickOne(:,4)==1,1));
            offTrials=max(lickOne(lickOne(:,4)==0,1));
        
            hitLaser(fidx,:)=histcounts(lickOne(lickOne(:,3)==0 & lickOne(:,4)==1,2),lickBin)./double(onTrials).*(1000/binW);
            hitNone(fidx,:)=histcounts(lickOne(lickOne(:,3)==0 & lickOne(:,4)==0,2),lickBin)./double(offTrials).*(1000/binW);
            crLaser(fidx,:)=histcounts(lickOne(lickOne(:,3)==3 & lickOne(:,4)==1,2),lickBin)./double(onTrials).*(1000/binW);
            crNone(fidx,:)=histcounts(lickOne(lickOne(:,3)==3 & lickOne(:,4)==0,2),lickBin)./double(offTrials).*(1000/binW);
        end
    end
    
    miceAverage.hitLaser(midx,:)=nanmean(hitLaser,1);
    miceAverage.hitNone(midx,:)=nanmean(hitNone,1);
    miceAverage.crLaser(midx,:)=nanmean(crLaser,1);
    miceAverage.crNone(midx,:)=nanmean(crNone,1);
end


plotOne(miceAverage.hitLaser,miceAverage.hitNone,'hit');
plotOne(miceAverage.crLaser,miceAverage.crNone,'cr');




    function out=getMiceFile(id)
        out=char(fs(~(cellfun('isempty',regexp(fs,['(?<=\\)',id,'(?=_)'])))));
    end


    function plotOne(laserOn,laserOff,fname)
        fh=figure('Color','w','Position',[100,100,180,160]);
        hold on;
%         plot(laserOff','Color',[0.75,0.75,0.75],'LineStyle','-');
        ci=bootci(100,@(x) mean(x),laserOff);
        fill([1:length(ci),length(ci):-1:1],[ci(1,:),flip(ci(2,:))],[0.5,0.5,0.5],'EdgeColor','none');
        
%         plot(laserOn','Color',[0.85,0.85,1],'LineStyle','-');
        plot(mean(laserOff),'-k','LineWidth',1);
%         plot(mean(laserOn),'-b','LineWidth',1);
        set(gca,'XTick',(binW/200):(1000/binW*5):length(lickBin),'XTickLabel',0:5:length(lickBin)/(1000/binW),'FontSize',10);
        delta=delay-5;
%         plot(repmat([2.5,4.5,14.5,16.5,18.5,19.5]+[0,0,ones(1,4).*delta.*2],2,1),[zeros(1,6);ones(1,6).*10],':k');
        plot(repmat([2.5,4.5,14.5,16.5,18.5,19.5]+[0,0,ones(1,4).*delta.*2],2,1).*(500./binW),[zeros(1,6);ones(1,6).*10],':k');
        xlabel('Time (s)','FontSize',10);
        ylabel('Lick (Hz)','FontSize',10);
        text(5,5,sprintf('n = %d',size(laserOn,1)),'FontSize',10);
        xlim([0.5,length(lickBin)-0.5]);
        ylim([0,4]);
        savefig(fh,sprintf('%ds_%s_lick.fig',delay,fname));
        set(fh,'PaperPositionMode','auto');
        print(fh,sprintf('%ds_%s_lick.eps',delay,fname),'-depsc','-cmyk');
%         for pidx=1:length(lickBin)-1
%             p=ranksum(laserOn(:,pidx),laserOff(:,pidx));
%             if p<0.05
%                 text(pidx,7.25,p2Str(p),'HorizontalAlignment','center');
%                 text(pidx,7.75,sprintf('%.3f',p),'HorizontalAlignment','center');
%             end
%         end
        
    end

end