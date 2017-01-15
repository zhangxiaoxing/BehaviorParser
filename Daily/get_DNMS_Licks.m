function out=get_DNMS_Licks(tags,distractor,ftitle)
binWidth=200;
bins=-15000:200:6000;
javaaddpath('I:\java\zmat\build\classes\');z=zmat.Zmat;
z.setFullSession(24);
z.updateFilesList('D:\behaviorNew\2016');
fs=z.listFiles(tags);
out=nan(length(fs),length(bins)-1);
for i=1:length(fs)
    z.processFile(cell(fs(i)));
    l=z.getTrialLick(200);
%     bar(histcounts(l(:,2),bins));
    out(i,:)=histcounts(l(:,2),bins)/100/binWidth*1000;
end
figure('Color','w','Position',[100,100,400,300]);
hold on;
scale=1000/binWidth;
fill([1,2,2,1]*scale,[0,0,10,10],[1,0.8,0.8]);
fill([15,16,16,15]*scale,[0,0,10,10],[0.8,1,0.8]);
fill([17,17.5,17.5,17]*scale,[0,0,10,10],[0.8,0.8,1]);
if distractor
    fill([3,4,4,3]*scale,[0,0,10,10],[1,1,0.8]);
end
ss=std(out);
sem=ss/sqrt(length(fs));
bar(mean(out),'FaceColor',[0.5,0.5,0.5],'EdgeColor','none');
errorbar(mean(out),sem,'k.');
set(gca,'XTick',0:10:100,'XTickLabel',strsplit(num2str(0:2:20),' '));
xlim([0,21]*scale);
ylim([0,10]);
xlabel('Time (s)');
ylabel('Lick frequency (Hz)');
title([ftitle,', n = ',num2str(size(out,1))]);

end



