clear java
javaaddpath('I:\java\hel2arial\build\classes\');
javaaddpath('I:\java\zmat\build\classes\')
z=zmat.Zmat;
load('files.mat', 'out')

for i=7
z.processFile(out{i,1});
fprintf('%d\n',i);
stats=z.getTrialLick(50);
plotExample(stats,i);
% pause;
close all
end


lickTs=nan(max(stats(:,1)),75);
for i=1:max(stats(:,1))
    lickTs(i,:)=histcounts(double(stats(stats(:,3)>=2 & stats(:,1)==i,2)),-8000:200:7000).*5;
end

figure('Position',[100,100,170,40],'Color','w');
hold on;
std_=std(lickTs);
sem=std_./sqrt(size(lickTs,1));

fill([1:size(lickTs,2),size(lickTs,2):-1:1]./5-2.2,[mean(lickTs)-sem,fliplr(mean(lickTs)+sem)],[0.8,0.8,0.8],'EdgeColor','none');
plot([-8:0.2:6.8]+6,mean(lickTs),'k-','LineWidth',1);
xlim([-2,13]);
ylim([0,10]);
set(gca,'XTick',[],'YTick',[0,10],'FontName','Helvetica','FontSize',12);