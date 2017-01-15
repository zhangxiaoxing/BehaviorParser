function plotCatchNew()
dpath=javaclasspath('-dynamic');
if ~ismember('I:\java\hel2arial\build\classes\',dpath)
    javaaddpath('I:\java\hel2arial\build\classes\');
end
h2a=hel2arial.Hel2arial;
path(path,'I:\behavior\reports\z');

data=load('newCatchTrials.mat');
catchTrials=data.catchTrials;

%%%%%%%%%%%%%%%%%%%%%%%
%%%  Activate  %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%

% catches={'noodor','incongruent'};

%%%%%%%%%%%%%%%%%%%%%%%
%%% hemi Silence  %%%%%
%%%%%%%%%%%%%%%%%%%%%%%

catches={'silenceNoOdor','silenceIncongruent'};

% path(path,'I:\Behavior\reports\DNMS\');

for i=1:length(catches)
    
    perf=catchTrials.(catches{i}).perf;
    false=catchTrials.(catches{i}).false;
    miss=catchTrials.(catches{i}).miss;
    
    plotOneSet(perf,'Performance',[catches{i},'p']);
    plotOneSet(false,'False Choice',[catches{i},'f']);
    plotOneSet(miss,'Miss',[catches{i},'m']);
    
end


function plotOneSet(data,tag,fileName)

ctrl=data(data(:,2)==0,3);
ctrlCatch=data(data(:,2)==0,4);
opto=data(data(:,2)==1,3);
optoCatch=data(data(:,2)==1,4);

figure('Color','w','Position',[100 100 160 250]);
subplot('Position',[0.3,0.28,0.7,0.63]);
place=[1 3 6 8]+1;
plotPair();
% subplot('Position',[0.28,0.62,0.625,0.375]);
% plotIndividual();
% subplot('Position',[0.28,0.22,0.625,0.345]);
% plotPopulation();



    function plotPair()
        
        
        hold on;
        
        plot(repmat(place(1:2),size(ctrl,1),1)',[ctrl ctrlCatch]','k-','Color',zGetColor('b1'));
        plot(repmat(place(3:4),size(opto,1),1)',[opto optoCatch]','k-','Color',zGetColor('b1'));
        
        plot(place(1),ctrl,'ko','MarkerSize',4,'MarkerFaceColor','w');
        plot(place(2),ctrlCatch,'ko','MarkerSize',4,'MarkerFaceColor','w','MarkerEdgeColor',zGetColor('b1'));
        plot(place(3),opto,'ko','MarkerSize',4,'MarkerFaceColor','k');
        plot(place(4),optoCatch,'ko','MarkerSize',4,'MarkerFaceColor',zGetColor('b1'),'MarkerEdgeColor',zGetColor('b1'));
        
        plotMean(ctrl,1);
        plotMean(ctrlCatch,2);
        plotMean(opto,3);
        plotMean(optoCatch,4);
        
        topY=ylim;
        
        [~,pCtrl]=ttest(ctrl,ctrlCatch);
        [~,pOpto]=ttest(opto,optoCatch);
        
        sigCtrl=p2Str(pCtrl);
        sigOpto=p2Str(pOpto);
        sigDY=(topY(2)-topY(1))*0.01;
        
        text(mean(place(3:4)),topY(2)+(7+4*(pOpto>0.05))*sigDY,sigOpto,'FontSize',10,'HorizontalAlignment','center');
        text(mean(place(1:2)),topY(2)+(7+4*(pCtrl>0.05))*sigDY,sigCtrl,'FontSize',10,'HorizontalAlignment','center');
%         if pCtrl<0.05
            plotPairTag(place(1),place(2),topY(2),sigDY);
%         end
%         if pOpto<0.05
            plotPairTag(place(3),place(4),topY(2),sigDY);
%         end

        
        ylim(topY);
        
        xlim([0,11]);
        
        set(gca,'XTick',place,'XTickLabel',{},'XColor','k','YColor','k');
%         text(place(1),topY(1)-7*sigDY,'Ctrl Regular','Color','k','Rotation',40,'FontSize',10,'HorizontalAlignment','right');
%         text(place(2)+0.5,topY(1)-5*sigDY,'Ctrl Catch','Color','k','Rotation',40,'FontSize',10,'HorizontalAlignment','right');
%         text(place(3),topY(1)-6*sigDY,'CaMKII-ChR2 Regular','Color','k','Rotation',40,'FontSize',10,'HorizontalAlignment','right');
%         text(place(4)+0.7,topY(1)-5*sigDY,'CaMKII-ChR2 Catch','Color','k','Rotation',40,'FontSize',10,'HorizontalAlignment','right');

        text(place(1),topY(1)-7.5*sigDY,'Regular','Color','k','Rotation',40,'FontSize',10,'HorizontalAlignment','right');
        text(place(2)+0.5,topY(1)-5.5*sigDY,'Catch','Color','k','Rotation',40,'FontSize',10,'HorizontalAlignment','right');
        text(place(3),topY(1)-7.5*sigDY,'Regular','Color','k','Rotation',40,'FontSize',10,'HorizontalAlignment','right');
        text(place(4)+0.7,topY(1)-5.5*sigDY,'Catch','Color','k','Rotation',40,'FontSize',10,'HorizontalAlignment','right');

        dY=topY(1)-37*sigDY;
        text(0.5,dY,'Ctrl','Color','k','FontSize',10,'VerticalAlignment','top','HorizontalAlignment','center','FontName','Helvetica');
%%%%%%%%%%
% CaMKII %
%%%%%%%%%%
        %         text(7,dY,'CaMKII-ChR2','Color','k','FontSize',10,'VerticalAlignment','top','HorizontalAlignment','center','FontName','Helvetica');
%%%%%%%%%%
%  VGAT  %
%%%%%%%%%%
                text(7,dY,'VGAT-ChR2','Color','k','FontSize',10,'VerticalAlignment','top','HorizontalAlignment','center','FontName','Helvetica');
        
        %         text(5.5,dY-9*sigDY,'ChR2','Color','k','FontSize',10,'VerticalAlignment','top','HorizontalAlignment','center','FontName','Helvetica');
        ddY=dY+5*sigDY;
        line([-1.5,3.5;2.5,7.5],[ddY,ddY;ddY,ddY],'Color','k','Clipping','off','LineWidth',1);
        
        h=ylabel(tag,'Color','k');
        h.FontSize=12;
        h.Position(1)=-2.7;
        
    end

    function plotPairTag(x1,x2,y,sigDY)
        line([x1 x2],[y+5*sigDY,y+5*sigDY],'LineWidth',1,'Clipping','Off','Color','k');
        line([x1 x1],[y+3*sigDY,y+5*sigDY],'LineWidth',1,'Clipping','Off','Color','k');
        line([x2 x2],[y+3*sigDY,y+5*sigDY],'LineWidth',1,'Clipping','Off','Color','k');
    end
    
    function plotMean(data,position)
        edgeColors={'k',zGetColor('b1'),'k',zGetColor('b1')};
        faceColors={'w','w','k',zGetColor('b1')};
        mLength=1.5;
        dd=0.5;
        semLength=0.25;
        dh=1;
        stdd=std(data);
        n=length(data);
        sem=stdd/sqrt(n);
        mm=mean(data);
        if position==1 || position==3
            x1=place(position)-mLength;
            xv=place(position)-dh;
            x2=place(position)-dd;
        else
            x1=place(position)+mLength;
            xv=place(position)+dh;
            x2=place(position)+dd;
            
        end
        
        %         plot([x1,x2],[mm,mm],'k-','LineWidth',1.5,'Color',colors{position});
        %         plot([xv,xv],[mm-sem,mm+sem],'k-','LineWidth',1.5,'Color',colors{position});
        plot([xv-semLength,xv+semLength],[mm+sem,mm+sem],'k-','LineWidth',1.5,'Color',edgeColors{position});
        plot([xv-semLength,xv+semLength],[mm-sem,mm-sem],'k-','LineWidth',1.5,'Color',edgeColors{position});
        plot([xv,xv],[mm-sem,mm+sem],'-','Color',edgeColors{position});
        plot(xv,mm,'o','MarkerSize',6,'MarkerEdgeColor',edgeColors{position},'MarkerFaceColor',faceColors{position});
        
        
    end
    
        set(gcf,'PaperPositionMode','auto');
        print('-depsc',[fileName,'.eps'],'-cmyk');
%         close gcf;
        h2a.h2a([pwd,'\',fileName,'.eps']);

end

end