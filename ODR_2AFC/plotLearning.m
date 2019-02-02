% % % z=zmat.ZmatODR;
% % % z.processFile(ls('*ch.ser'));
% % % day1=z.getFactorSeq(false);
% % % z.processFile(ls('*ch.ser'));
% % % day2=z.getFactorSeq(false);
% % % z.processFile(ls('*ch.ser'));
% % % day3=z.getFactorSeq(false);
% % % z.processFile(ls('*ch.ser'));
% % % day4=z.getFactorSeq(false);
% % % z.processFile(ls('*ch.ser'));
% % % day5a=z.getFactorSeq(false);
% % % z.processFile(ls('*P2.ser'));
% % % day5b=z.getFactorSeq(false);
% % % day5=[day5a;day5b];
% % % z.processFile(ls('*TEST.ser'));
% % % day6Test=z.getFactorSeq(false);
% % % clear day5a day5b
% % % 


figure('Color','w','Position',[100,100,800,450]);
hold on;
days={day1,day2,day3,day4,day5,day6Test};
xaccu=0;
winW=100;
binW=20;
for i=1:length(days)
    data=days{i};
    perf=arrayfun(@(x) sum(data(x:x+winW-1,3)==3).*100./winW,1:binW:length(data)-winW);
    hitRate=arrayfun(@(x) sum(data(x:x+winW-1,3)==3).*100./sum(ismember(data(x:x+winW-1,3),[3 5])),1:binW:length(data)-winW);
    abt=arrayfun(@(x) sum(data(x:x+winW-1,3)==13).*100./winW,1:binW:length(data)-winW);
    
    
    ph(3)=plot(xaccu+1:xaccu+length(perf),(abt),'-g.');
    ph(2)=plot(xaccu+1:xaccu+length(perf),(hitRate),'-r.');
    ph(1)=plot(xaccu+1:xaccu+length(perf),(perf),'-k.');
    xaccu=xaccu+length(perf)+winW/binW;
end
set(gca,'XTick',0:1000/binW:4000/binW,'XTickLabel',0:1000:4000,'FontSize',12);
xlabel('Trials');
ylabel('%');
legend(ph,{'Performance','Hit Rate','Aboort'},'FontSize',12);
ylim([0,100])