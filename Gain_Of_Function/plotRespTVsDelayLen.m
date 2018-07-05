%plotAllRespT
close all;
figure('Color','w');
hold on;

arrayfun(@(x) plot([5,40],[x,x],':k'),[0,1000,2000,2500]);

data5=plotOneRespT(lick5.lick);
sem5=std(data5)/sqrt(size(data5,1));



sem8=std(data8)/sqrt(size(data8,1));


data12=plotOneRespT(lick12.lick);
sem12=std(data12)/sqrt(size(data12,1));


data16=plotOneRespT(lick16.lick);
sem16=std(data16)/sqrt(size(data16,1));


data20=plotOneRespT(lick20.lick);
sem20=std(data20)/sqrt(size(data20,1));


data30=plotOneRespT(lick30.lick);
sem30=std(data30)/sqrt(size(data30,1));


data40=plotOneRespT(lick40.lick);
sem40=std(data40)/sqrt(size(data40,1));


dataset={data5,data8,data12,data16,data20,data30,data40};
xx=[5,8,12,16,20,30,40];

getSEM=@(x) [sem5(x),sem8(x),sem12(x),sem16(x),sem20(x),sem30(:,x),sem40(x)];
getMean=@(x) [mean(data5(:,x)),mean(data8(:,x)),mean(data12(:,x)),mean(data16(:,x)),mean(data20(:,x)),mean(data30(:,x)),mean(data40(:,x))];
fill([xx,fliplr(xx)],[getSEM(1)+getMean(1),fliplr(getMean(1)-getSEM(1))],'r','FaceAlpha',0.15,'EdgeColor','none');
fill([xx,fliplr(xx)],[getSEM(2)+getMean(2),fliplr(getMean(2)-getSEM(2))],[1,0.5,0],'FaceAlpha',0.15,'EdgeColor','none');
fill([xx,fliplr(xx)],[getSEM(3)+getMean(3),fliplr(getMean(3)-getSEM(3))],[1,1,0],'FaceAlpha',0.15,'EdgeColor','none');
fill([xx,fliplr(xx)],[getSEM(4)+getMean(4),fliplr(getMean(4)-getSEM(4))],[0,1,0],'FaceAlpha',0.15,'EdgeColor','none');
fill([xx,fliplr(xx)],[getSEM(5)+getMean(5),fliplr(getMean(5)-getSEM(5))],[0,0,1],'FaceAlpha',0.15,'EdgeColor','none');
fill([xx,fliplr(xx)],[getSEM(6)+getMean(6),fliplr(getMean(6)-getSEM(6))],[0,1,1],'FaceAlpha',0.15,'EdgeColor','none');
fill([xx,fliplr(xx)],[getSEM(7)+getMean(7),fliplr(getMean(7)-getSEM(7))],[1,0,1],'FaceAlpha',0.15,'EdgeColor','none');



ph(1)=plot(xx,getMean(1),'-','Color',[1,0.5,0],'LineWidth',2);
ph(2)=plot(xx,getMean(2),'-','Color',[1,0.5,0],'LineWidth',2);
ph(3)=plot(xx,getMean(3),'-','Color',[1,1,0],'LineWidth',2);
ph(4)=plot(xx,getMean(4),'-','Color',[0,1,0],'LineWidth',2);
ph(5)=plot(xx,getMean(5),'-','Color',[0,0,1],'LineWidth',2);
ph(6)=plot(xx,getMean(6),'-','Color',[0,1,1],'LineWidth',2);
ph(7)=plot(xx,getMean(7),'-','Color',[1,0,1],'LineWidth',2);
xlim([5,40]);

legend(ph,{'1st','2nd','3rd','4th','5th','6th','7th'},'Location','eastoutside');
xlabel('Delay duration (s)');
ylabel('Response time (ms)');



