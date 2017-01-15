function out=get_Dual_Licks(tags)
binWidth=200;
bins=-15000:200:6000;
javaaddpath('I:\java\zmat\build\classes\');z=zmat.ZmatDual;
z.setFullSession(24);
z.updateFilesList('D:\behaviorNew\2016');
fs=z.listFiles(tags);


out=nan(length(fs),length(bins)-1, 6); %1, DPA-Reward, GNG-Reward, 2 DPA-Reward, GNG-NG, 3 DPA-Reward, GNG-N/A, 4,5,6:DPA-No Reward
for i=1:length(fs)
    z.processFile(cell(fs(i)));
    l=z.getTrialLick(0);

    out(i,:,1)=histcounts(l((l(:,3)==0 | l(:,3)==1)& (l(:,5)==0 | l(:,5)==1),2),bins)/100/binWidth*1000;
    out(i,:,2)=histcounts(l((l(:,3)==0 | l(:,3)==1)& (l(:,5)==2 | l(:,5)==3),2),bins)/100/binWidth*1000;
    out(i,:,3)=histcounts(l((l(:,3)==0 | l(:,3)==1)& l(:,5)==9,2),bins)/100/binWidth*1000;
    out(i,:,4)=histcounts(l((l(:,3)==2 | l(:,3)==3)& (l(:,5)==0 | l(:,5)==1),2),bins)/100/binWidth*1000;
    out(i,:,5)=histcounts(l((l(:,3)==2 | l(:,3)==3)& (l(:,5)==2 | l(:,5)==3),2),bins)/100/binWidth*1000;
    out(i,:,6)=histcounts(l((l(:,3)==2 | l(:,3)==3)& l(:,5)==9,2),bins)/100/binWidth*1000;
end

for i=1:6
    outT=out(:,:,i);
    figure('Color','w','Position',[100,100,400,300]);
    hold on;
    scale=1000/binWidth;
    fill([1,2,2,1]*scale,[0,0,10,10],[1,0.8,0.8]);
    fill([15,16,16,15]*scale,[0,0,10,10],[0.8,1,0.8]);
    if i<4
        fill([17,17.5,17.5,17]*scale,[0,0,10,10],[0.8,0.8,1]);
    end
    if i~=3 && i~=6
        fill([6,6.5,6.5,6]*scale,[0,0,10,10],[1,1,0.8]);
    end
    if i==1 || i==4
        fill([7,7.5,7.5,7]*scale,[0,0,10,10],[0.8,0.8,1]);
    end
    ss=std(outT);
    sem=ss/sqrt(length(fs));
    bar(mean(outT),'FaceColor',[0.5,0.5,0.5],'EdgeColor','none');
    errorbar(mean(outT),sem,'k.');
    set(gca,'XTick',0:10:100,'XTickLabel',strsplit(num2str(0:2:20),' '));
    xlim([0,21]*scale);
    ylim([0,10]);
    xlabel('Time (s)');
    ylabel('Lick frequency (Hz)');
%     title([ftitle,', n = ',num2str(size(out,1))]);
end
end



