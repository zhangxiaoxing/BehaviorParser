function plotModel()
t=-1:0.1:6;
dp=zeros(4,length(t));
dp(:,t>0 & t<=1)=1;
dp(1,t>3 & t<=6)=genSeq(3,6);

dp(2,t>0&t<=3)=1;
dp(2,t>5&t<=6)=genSeq(5,6);

dp(3,t>1&t<=3)=1.2;
dp(3,t>3 & t<=6)=1.2-genSeq(3,6);

dp(4,t>1&t<=3)=1;
dp(4,t>3 & t<=5)=1.2;
dp(4,t>5 & t<=6)=1.2-genSeq(5,6);

close all;
plotCurve();
% plotSurf();

    function plotCurve()
        figure;
        hold on;
        grid on;
        for cat=1:4
            plot3(ones(1,length(t))*cat,t,dp(cat,:),'LineWidth',2);
            ylabel('Time');
            zlabel('Sample decoding power');
            set(gca,'XTick',1:4,'XTickLabel',{'Early suppression','Late suppressioin','Early elevation','Late elevation'});
            xlim([0,5]);
            ylim([-1,6]);
            
            text(1,1,0.1,'Laser');
            text(2,3,0.1,'Laser');
            text(3,1,1.3,'Laser');
            text(4,3,1.3,'Laser');
        end
    end

    function plotSurf()
        figure;
        hold on;
        grid on;
        for cat=1:4
            
            surf(t,[cat-0.25,cat+0.25],[dp(cat,:);dp(cat,:)],ones(2,length(t))*(cat-1)/3,'FaceAlpha',0.5,'LineStyle','none');
            xlabel('Time');
            zlabel('Sample decoding power');
            set(gca,'YTick',1:4,'YTickLabel',{'Early suppression','Late suppressioin','Early elevation','Late elevation'},'YDir','reverse');
            xlim([-1,6]);
            ylim([0,5]);
            
            text(2,1,0.1,'Laser','HorizontalAlignment','center');
            text(4,2,0.1,'Laser','HorizontalAlignment','center');
            text(2,3,1.3,'Laser','HorizontalAlignment','center');
            text(4,4,1.3,'Laser','HorizontalAlignment','center');
        end
    end



    function out=genSeq(from, to)
        d=0.1;
        tau=2;
        step=(to-from)/0.1-1;
        out=(-exp(-[1:d:(1+step*d)]/tau)+exp(-1/tau))*1.3;
    end

end