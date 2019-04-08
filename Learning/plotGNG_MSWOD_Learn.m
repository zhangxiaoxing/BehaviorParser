javaaddpath('I:\java\zmat\build\classes\');
z=zmat.ZmatGNG;
GNGFaqSeq=cell(0,1);
for i=1:length(GNGNoLaser)
    z.processFile(GNGNoLaser{i});
    GNGFaqSeq{end+1}=z.getFactorSeq(false,false);
end
z=zmat.Zmat;
MSWODFaqSeq=cell(0,1);
for i=1:length(NoDelayNoLaser)
    z.processFile(NoDelayNoLaser{i});
    MSWODFaqSeq{end+1}=z.getFactorSeq(false,false);
end




figure('Color','w','Position',[100,100,310,220]);
hold on;
perfG=nan(length(GNGFaqSeq),1000);
for i=1:length(GNGFaqSeq)
    correct=ismember(GNGFaqSeq{i}(:,4),[3 6]);
    perfG(i,1:(length(GNGFaqSeq{i})-19))=arrayfun(@(x) sum(correct(x:x+19)),1:(length(GNGFaqSeq{i})-19)).*5;
end
% plot(perfG','-','Color',[1,0.8,0.8],'LineWidth',1);



perfW=nan(length(MSWODFaqSeq),1000);
for i=1:length(MSWODFaqSeq)
    correct=ismember(MSWODFaqSeq{i}(:,4),[3 6]);
    perfW(i,1:(length(MSWODFaqSeq{i})-19))=arrayfun(@(x) sum(correct(x:x+19)),1:1:(length(MSWODFaqSeq{i})-19)).*5;
end
% plot(perfW','-','Color',[0.8,0.8,1],'LineWidth',1);

ciG=bootci(100,@(x) nanmean(x),perfG(:,1:150));
fill([1:150,150:-1:1],[ciG(1,:),fliplr(ciG(2,:))],[1,0.8,0.8],'EdgeColor','none');

ciW=bootci(100,@(x) nanmean(x),perfW(:,1:300));
fill([1:300,300:-1:1],[ciW(1,:),fliplr(ciW(2,:))],[0.8,0.8,1],'EdgeColor','none');

plot(nanmean(perfG(:,1:150)),'r-','LineWidth',1);
plot(nanmean(perfW(:,1:300)),'b-','LineWidth',1);
xlim([-10,290]);
ylim([40,100]);
set(gca,'XTick',[0:50:300]-10,'XTickLabel',[0:50:300]);
xlabel('Trial#');
ylabel('Performance (%)')








