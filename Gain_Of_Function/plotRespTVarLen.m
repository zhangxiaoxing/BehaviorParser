%plotAllRespT
close all;
figure('Color','w');
hold on;

arrayfun(@(x) plot([x,x],[1,10],':k'),[0,1000,2000,2500]);

data5=plotOneRespT(lick5.lick);
sem5=std(data5)/sqrt(size(data5,1));
fill([mean(data5)-sem5,fliplr(mean(data5)+sem5)],[1:10,10:-1:1],[1,0,0],'FaceAlpha',0.15,'EdgeColor','none');


data8=plotOneRespT(lick8.lick);
sem8=std(data8)/sqrt(size(data8,1));
fill([mean(data8)-sem8,fliplr(mean(data8)+sem8)],[1:10,10:-1:1],[1,0.5,0],'FaceAlpha',0.15,'EdgeColor','none');


data12=plotOneRespT(lick12.lick);
sem12=std(data12)/sqrt(size(data12,1));
fill([mean(data12)-sem12,fliplr(mean(data12)+sem12)],[1:10,10:-1:1],[1,1,0],'FaceAlpha',0.15,'EdgeColor','none');


data16=plotOneRespT(lick16.lick);
sem16=std(data16)/sqrt(size(data16,1));
fill([mean(data16)-sem16,fliplr(mean(data16)+sem16)],[1:10,10:-1:1],[0,1,0],'FaceAlpha',0.15,'EdgeColor','none');


data20=plotOneRespT(lick20.lick);
sem20=std(data20)/sqrt(size(data20,1));
fill([mean(data20)-sem20,fliplr(mean(data20)+sem20)],[1:10,10:-1:1],[0,0,1],'FaceAlpha',0.15,'EdgeColor','none');


data30=plotOneRespT(lick30.lick);
sem30=std(data30)/sqrt(size(data30,1));
fill([mean(data30)-sem30,fliplr(mean(data30)+sem30)],[1:10,10:-1:1],[0,1,1],'FaceAlpha',0.15,'EdgeColor','none');


data40=plotOneRespT(lick40.lick);
sem40=std(data40)/sqrt(size(data40,1));
fill([mean(data40)-sem40,fliplr(mean(data40)+sem40)],[1:10,10:-1:1],[1,0,1],'FaceAlpha',0.15,'EdgeColor','none');

ph(1)=plot(mean(data5),1:10,'-r','LineWidth',2);
ph(2)=plot(mean(data8),1:10,'-','Color',[1,0.5,0],'LineWidth',2);
ph(3)=plot(mean(data12),1:10,'-','Color',[1,1,0],'LineWidth',2);
ph(4)=plot(mean(data16),1:10,'-','Color',[0,1,0],'LineWidth',2);
ph(5)=plot(mean(data20),1:10,'-','Color',[0,0,1],'LineWidth',2);
ph(6)=plot(mean(data30),1:10,'-','Color',[0,1,1],'LineWidth',2);
ph(7)=plot(mean(data40),1:10,'-','Color',[1,0,1],'LineWidth',2);

legend(ph,{'5s','8s','12s','16s','20s','30s','40s'});

xlabel('Response time (mS)');
ylabel('# of lick');

% set(gca,'Color',[0.8,0.8,0.8]);

xlim([0,4000]);

forAnovan=[reArr(data5,5);reArr(data8,8);reArr(data12,12);reArr(data16,16);reArr(data20,20);reArr(data30,30);reArr(data40,40)];

p=anovan(forAnovan(:,1),{forAnovan(:,2),forAnovan(:,3)});




function out=reArr(data,delay)
out(:,1)=mean(data);
out(:,2)=1:10;
out(:,3)=delay;
end

