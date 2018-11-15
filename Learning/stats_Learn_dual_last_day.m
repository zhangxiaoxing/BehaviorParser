function perf=stats_Learn_dual_last_day(files)
dpath=javaclasspath('-dynamic');
if ~ismember('I:\java\zmat\build\classes\',dpath)
    javaaddpath('I:\java\zmat\build\classes\');
end
path(path,'D:\behavior\reports\z');

optoPos={'D220','D214','D216', 'D219', 'D221', 'D215'};
ids=unique(regexp(files(:,1),'(?<=\\)\w?\d{1,4}_','match','once'));
perf=nan(length(ids),5);

z=zmat.ZmatDual;
z.setMinLick(0);
z.setFullSession(24);

for mouse=1:length(ids)
    id=ids{mouse};
    fids=files(contains(files,id));
    dates=cellfun(@(x) str2double(strjoin(x,'')), regexp(fids,'(201\d)_(\d\d)_(\d\d)','tokens','once'));
    [~,idx]=max(dates);
    f=strtrim(fids{idx});
    perf(mouse,1)=str2double(regexp(id,'\d+','match'));
    perf(mouse,2)=ismember(replace(id,'_',''),optoPos);
    z.processFile(f);
    factors=z.getFactorSeq(false);
    corrects=ismember(factors(:,4),[3 6]);
%     w_distr=(factors(:,5)~=12);
    perf(mouse,3)=nnz(corrects & factors(:,5)==12)*100/nnz(factors(:,5)==12);
    perf(mouse,4)=nnz(corrects & factors(:,5)==2)*100/nnz(factors(:,5)==2);
    perf(mouse,5)=nnz(corrects & factors(:,5)==1)*100/nnz(factors(:,5)==1);
end

% [~,p]=ttest(perf(:,3),perf(:,4));


perfT=table(perf(:,1),perf(:,3),perf(:,4),perf(:,5),'VariableNames',{'MiceID','None','Nogo','Go'});
distr=table({'None';'Nogo';'Go'},'VariableNames',{'Distractor'});
perfRM=fitrm(perfT,'None-Go~MiceID','WithinDesign',distr);
ranovatbl=ranova(perfRM);
p=ranovatbl.pValue(1);

figure('Color','w','Position',[100,100,250,180]);
hold on;
plotOne(1:3,perf(:,3:5),'k');

text(mean(xlim()),max(ylim()),sprintf('%0.3f',p));
savefig('DPA_Distr_OnOff.fig');
print('DPA_Distr_OnOff.eps','-depsc','-r0');

end



function plotOne(x,y,pColor)
dd=0.5;
randd=@(x) rand(size(x,1),1)*0.5-0.25;
% cm=colormap('jet');
% getColor=@(i) cm(floor(((y(i,1)-min(y(:,1)))/(max(y(:,1))-min(y(:,1))))*(length(cm)-1))+1,:);
getColor=@(x) [0.8,0.8,0.8];
arrayfun(@(i) plot(x+(rand*0.5-0.25),y(i,:),'Color',getColor(i)),1:size(y,1));
% arrayfun(@(i) plot(x+(rand*0.5-0.25),y(i,:),'Color',getColor(i)),1:size(y,1));

% plot((x+randd(y))',y',sprintf('-%s.',pColor));

ci=bootci(1000,@(x) mean(x), y(:,1));
plot(x([1,1]),ci,sprintf('-%s',pColor),'LineWidth',1);
% disp(ci)
ci=bootci(1000,@(x) mean(x), y(:,2));
plot(x([2,2]),ci,sprintf('-%s',pColor),'LineWidth',1);

ci=bootci(1000,@(x) mean(x), y(:,3));
plot(x([3,3]),ci,sprintf('-%s',pColor),'LineWidth',1);

plot(x,mean(y),sprintf('-%so',pColor),'LineWidth',1,'MarkerFaceColor','k','MarkerSize',4);

xlim([0.5,3.5]);
set(gca,'XTick',1:3,'XTickLabel',{'None','Nogo','Go'});
ylabel('Correct rate (%)');
% plot(x(2)-dd,mean(y(:,2)),sprintf('%so',pColor),'MarkerFaceColor','w','MarkerSize',4,'LineWidth',2);
% plot(x(1)+dd,mean(y(:,1)),sprintf('%so',pColor),'MarkerFaceColor',pColor,'MarkerSize',4,'LineWidth',2);

end