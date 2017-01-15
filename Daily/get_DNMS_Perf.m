function out=get_DNMS_Perf(tags,ftitle)
javaaddpath('I:\java\zmat\build\classes\');z=zmat.Zmat;
z.setFullSession(24);
z.updateFilesList('D:\behaviorNew\2016');
fs=z.listFiles(tags);
out=nan(length(fs),15);
for i=1:length(fs)
    z.processFile(cell(fs(i)));
    l=double(z.getPerf(2,300));  %%10x7 mat, need (1+4)/5
    p=(l(:,1)+l(:,4))*100./l(:,5);
    if length(p)<15
        p(length(p)+1:15)=nan;
    end
    out(i,:)=p;  
end
figure('Color','w','Position',[100,100,400,300]);
hold on;
sem=nan(1,size(out,2));
ss=nanstd(out);
for i=1:size(out,2)
    sem(i)=ss(i)/sqrt(sum(~isnan(out(:,i))));
end
plot(nanmean(out),'-ko');
errorbar(nanmean(out),sem,'k.');
set(gca,'XTick',0:3:12,'XTickLabel',strsplit(num2str(0:72:288),' '));
xlim([0,12]);
ylim([45,100]);
xlabel('Trials');
ylabel('Performance correct rate (%)');
title([ftitle,', n = ',num2str(size(out,1))]);
end



