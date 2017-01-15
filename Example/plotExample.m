function plotExample(licks,strTitle)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

nm=licks(licks(:,3)<2,:);
match=licks(licks(:,3)>1,:);

figure('Color','w','Position',[100 100 320 185]);
hold on;
subplot('Position',[0.08,0.17,0.4,0.8]);
plotOne(nm);

subplot('Position',[0.58,0.17,0.4,0.8]);
plotOne(match);


dpath=javaclasspath('-dynamic');
if ~ismember('I:\java\hel2arial\build\classes\',dpath)
    javaaddpath('I:\java\hel2arial\build\classes\');
end

h2a=hel2arial.Hel2arial;
% if exist('strTitle','var')
%     print([char(strTitle),'.png'],'-dpng');
%     %             print('-depsc',[fileName,'.eps']);
% end

    set(gcf,'PaperPositionMode','auto');
    print('-depsc','-painters','lick.eps')%,'-cmyk');
%         close gcf;
    h2a.h2a([pwd,'\lick.eps']);

    function plotOne(data)
        hold on;
        if data(1,3)<2
            rectangle('Position',[0,0,1,50],'FaceColor',[236 244 237]./255,'EdgeColor','none');
        else
            rectangle('Position',[0,0,1,50],'FaceColor',[251 245 234]./255,'EdgeColor','none');
        end
        rectangle('Position',[6,0,1,50],'FaceColor',[251 245 234]./255,'EdgeColor','none');
        rectangle('Position',[8,0,0.5,50],'FaceColor',[234 242 251]./255,'EdgeColor','none');
        h=plot(repmat(double(data(:,2)')./1000+6,2,1),[double(data(:,1))'-0.3;double(data(:,1))'+0.3],'k-','LineWidth',0.5);
        
        
        
        colors=[0,153,255;255,153,0;126,49,142;0,204,51]./255;
        results=unique(data(:,[1 3]),'rows');
        for i=1:size(results,1)
            h=plot([12,12.5],repmat(double(results(i,1)),1,2),'Color',colors(results(i,2)+1,:),'LineWidth',3);
        end
        
        h=gca;
        h.Box='off';
        xlim([-2,13]);
        ylim([0,20.5]);
        h.FontSize=10;
        h.FontName='Helvetica';
        
        xl=xlabel('Time ( sec )','FontSize',10,'FontName','Helvetica');
%         yl=ylabel('Trial No.','FontSize',12,'FontName','Helvetica');
        ax=gca;
        
    end
end

