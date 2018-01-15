function [pCtrl,pOpto,nonnorm]=plotOneSet(data,measure,tag)
path(path,'D:\behavior\reports\z');


ctrlOff=cell2mat(data(strcmpi('lightOff',data(:,5)) & strcmpi('ctrl',data(:,6)),measure));
ctrlOn=cell2mat(data(strcmpi('lightOn',data(:,5)) & strcmpi('ctrl',data(:,6)),measure));
optoOff=cell2mat(data(strcmpi('lightOff',data(:,5)) & strcmpi('ChR2',data(:,6)),measure));
optoOn=cell2mat(data(strcmpi('lightOn',data(:,5)) & strcmpi('ChR2',data(:,6)),measure));

ho=jbtest(optoOff-optoOn);
hc=jbtest(ctrlOff-ctrlOn);

nonnorm=sum([ho,hc]);

figure('Color','w','Position',[100 100 175 200]);
% figure('Color','w','Position',[100 100 175 175]);
subplot('Position',[0.3,0.27,0.7,0.55]);
% subplot('Position',[0.3,0.27,0.7,0.63]);
place=[1 3 6 8]+1;
plotParallel();
% subplot('Position',[0.28,0.62,0.625,0.375]);
% plotIndividual();
% subplot('Position',[0.28,0.22,0.625,0.345]);
% plotPopulation();



    function plotParallel()
        
        
        hold on;
        
        plot(repmat(place(1:2),size(ctrlOff,1),1)',[ctrlOff ctrlOn]','k-','Color',zGetColor('b1'));
        plot(repmat(place(3:4),size(optoOff,1),1)',[optoOff optoOn]','k-','Color',zGetColor('b1'));
        
        plot(place(1)+genX(ctrlOff),sort(ctrlOff),'ko','MarkerSize',4,'MarkerFaceColor','none');
        plot(place(2)+genX(ctrlOn),sort(ctrlOn),'ko','MarkerSize',4,'MarkerFaceColor','none','MarkerEdgeColor',zGetColor('b1'));
        plot(place(3)+genX(optoOff),sort(optoOff),'ko','MarkerSize',4,'MarkerFaceColor','k');
        plot(place(4)+genX(optoOn),sort(optoOn),'ko','MarkerSize',4,'MarkerFaceColor',zGetColor('b1'),'MarkerEdgeColor',zGetColor('b1'));
        
        plotMean(ctrlOff,1);
        plotMean(ctrlOn,2);
        plotMean(optoOff,3);
        plotMean(optoOn,4);
        
%         if min([ctrlOff;optoOff;optoOn;ctrlOn])>50
%             ylim([50,100]);
%         elseif max([ctrlOff;optoOff;optoOn;ctrlOn])<50 
%             ylim([0,50]);
%         end
        ylim([0,100]);

        
        topY=ylim;
        
%         [~,pCtrl]=ttest(ctrlOff,ctrlOn);
%         [~,pOpto]=ttest(optoOff,optoOn);

         pCtrl=signrank(ctrlOff,ctrlOn);
         pOpto=signrank(optoOff,optoOn);


        fprintf('%s ctrl p=%04f, opto p=%04f\n',tag,pCtrl,pOpto);
        
        sigCtrl=p2Str(pCtrl);
        sigOpto=p2Str(pOpto);
        
        sigDY=(topY(2)-topY(1))*0.01;
        
%         if (pOpto<0.05)
            text(nanmean(place(3:4)),topY(2)+(7+(pOpto>0.05)*4)*sigDY,sigOpto,'FontSize',10,'HorizontalAlignment','center','FontName','Helvetica');
            if pOpto<0.05 && pOpto>=0.001
                text(nanmean(place(3:4)),topY(2)+20*sigDY,sprintf('%0.3f',pOpto),'FontSize',10,'HorizontalAlignment','center','FontName','Helvetica');
            end
            
            line([place(3) place(4)],[topY(2)+5*sigDY,topY(2)+5*sigDY],'LineWidth',1,'Clipping','Off','Color','k');
            line([place(3) place(3)],[topY(2)+3*sigDY,topY(2)+5*sigDY],'LineWidth',1,'Clipping','Off','Color','k');
            line([place(4) place(4)],[topY(2)+3*sigDY,topY(2)+5*sigDY],'LineWidth',1,'Clipping','Off','Color','k');
%         end
        
%         if (pCtrl<0.05)
            text(nanmean(place(1:2)),topY(2)+(7+(pCtrl>0.05)*4)*sigDY,sigCtrl,'FontSize',10,'HorizontalAlignment','center','FontName','Helvetica');
            if pCtrl<0.05 && pCtrl>=0.001
                text(nanmean(place(1:2)),topY(2)+20*sigDY,sprintf('%0.3f',pCtrl),'FontSize',10,'HorizontalAlignment','center','FontName','Helvetica');
            end
            line([place(1) place(2)],[topY(2)+5*sigDY,topY(2)+5*sigDY],'LineWidth',1,'Clipping','Off','Color','k');
            line([place(1) place(1)],[topY(2)+3*sigDY,topY(2)+5*sigDY],'LineWidth',1,'Clipping','Off','Color','k');
            line([place(2) place(2)],[topY(2)+3*sigDY,topY(2)+5*sigDY],'LineWidth',1,'Clipping','Off','Color','k');
%         end
        
        ylim(topY);
        
        xlim([0,11]);
        
        %         set(gca,'XTick',place,'XTickLabel',{'Ctrl Off  ','Ctrl On ','ChR2 Off ','ChR2 On'},'XTickLabelRotation',40,'FontSize',11,'XColor','k','YColor','k');
        set(gca,'XTick',place,'XTickLabel',{'Off','On','Off','On'},'YColor','k','XColor','k','FontSize',10);
%         text(place(1),topY(1)-7*sigDY,'Off','Color','k','Rotation',0,'FontSize',10,'HorizontalAlignment','right','FontName','Helvetica');
%         text(place(2)+0.5,topY(1)-5*sigDY,'On','Color','k','Rotation',0,'FontSize',10,'HorizontalAlignment','right','FontName','Helvetica');
%         text(place(3),topY(1)-7*sigDY,'Off','Color','k','Rotation',0,'FontSize',10,'HorizontalAlignment','right','FontName','Helvetica');
%         text(place(4)+0.7,topY(1)-5*sigDY,'On','Color','k','Rotation',0,'FontSize',10,'HorizontalAlignment','right','FontName','Helvetica');
        %         ylim([topY(1),topY(2)+(topY(2)-topY(1))*0.2]);
        
        %         set(gca,'XTick',[],'XColor','w');
        %         set(gca,'XAxisLocation','top');
        text(3,topY(1)-21*sigDY,'Ctrl','Color','k','FontSize',10,'VerticalAlignment','top','HorizontalAlignment','center','FontName','Helvetica');
        text(8,topY(1)-21*sigDY,'VGAT','Color','k','FontSize',10,'VerticalAlignment','top','HorizontalAlignment','center','FontName','Helvetica');
        text(8,topY(1)-30*sigDY,'ChR2','Color','k','FontSize',10,'VerticalAlignment','top','HorizontalAlignment','center','FontName','Helvetica');
        ddY=topY(1)-16*sigDY;
        line([1,6;5,10],[ddY,ddY;ddY,ddY],'Color','k','Clipping','off','LineWidth',1);
        
        h=ylabel(tag,'Color','k','FontName','Helvetica');
        h.FontSize=12;
        
        
    end

    function plotMean(data,position)
        edgeColors={'k',zGetColor('b1'),'k',zGetColor('b1')};
        faceColors={'w','w','k',zGetColor('b1')};
        mLength=1.5;
        dd=0.5;
        semLength=0.25;
        dh=1;
        stdd=nanstd(data);
        n=length(data);
        sem=stdd/sqrt(n);
        mm=nanmean(data);
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


    function xs=genX(ys)
        delta=[-0.15,0.15,-0.25,0.25,-0.35,0.35,-0.45,0.45];
        ys=sort(ys);
        xs=zeros(size(ys));
        d=0;
        for i=2:length(ys)
            if ys(i)-ys(i-1)<0.1
                if d+1<length(delta)
                    d=d+1;
                end
                xs(i)=delta(d);
            else
                d=0;
            end
        end
        
        
    end

end