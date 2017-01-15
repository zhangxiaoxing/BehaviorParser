function [out,outDistractor]=get_DPAD_Perf(tags,ftitle)
javaaddpath('I:\java\zmat\build\classes\');z=zmat.ZmatDual;
z.setFullSession(24);
z.updateFilesList('D:\behaviorNew\2016\June');
fs=z.listFiles(tags);
out=nan(length(fs),12);
outDistractor=nan(length(fs),12);
for i=1:length(fs)
    z.processFile(cell(fs(i)));
    l=double(z.getPerf(2,2,0));  %%10x7 mat, need (1+4)/5
    p=(l(:,1)+l(:,4))*100./l(:,5);
    pDistractor=(l(:,8)+l(:,11))*100./sum(l(:,8:11),2);
    if length(p)<12
        p(length(p)+1:12)=nan;
        pDistractor(length(pDistractor)+1:12)=nan;
    end
    out(i,:)=p;
    outDistractor(i,:)=pDistractor;
end
figure('Color','w','Position',[100,100,400,300]);
hold on;
sem=nan(1,size(out,2));
ss=nanstd(out);

semd=nan(1,size(outDistractor,2));
ssd=nanstd(outDistractor);

for i=1:size(out,2)
    sem(i)=ss(i)/sqrt(sum(~isnan(out(:,i))));
    semd(i)=ssd(i)/sqrt(sum(~isnan(outDistractor(:,i))));
end
plot(nanmean(out),'-ko');
plot(nanmean(outDistractor),'-bo');

errorbar(nanmean(out),sem,'k.');
errorbar(nanmean(outDistractor),sem,'b.');

set(gca,'XTick',0:3:12,'XTickLabel',strsplit(num2str(0:72:288),' '));
xlim([0,12]);
ylim([45,100]);
xlabel('Trials');
ylabel('Performance correct rate (%)');
title([ftitle,', n = ',num2str(size(out,1))]);
end



