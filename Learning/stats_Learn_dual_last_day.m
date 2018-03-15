function perf=stats_Learn_dual_last_day(files)
dpath=javaclasspath('-dynamic');
if ~ismember('I:\java\zmat\build\classes\',dpath)
    javaaddpath('I:\java\zmat\build\classes\');
end
path(path,'D:\behavior\reports\z');

optoPos={'D220','D214','D216', 'D219', 'D221', 'D215'};
ids=unique(regexp(files(:,1),'(?<=\\)\w?\d{1,4}_','match','once'));
perf=nan(length(ids),4);

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
    w_distr=(factors(:,5)~=12);
    perf(mouse,3)=nnz(corrects & ~w_distr)*100/nnz(~w_distr);
    perf(mouse,4)=nnz(corrects & w_distr)*100/nnz(w_distr);
end

[~,p]=ttest(perf(:,3),perf(:,4));

figure('Color','w','Position',[100,100,120,180]);
hold on;
plotOne([2,1],perf(:,[4 3]),'k');
xlim([0,3]);
ylim([50,100]);
text(mean(xlim()),max(ylim()),sprintf('%0.3f',p));
set(gca,'YTick',50:25:100,'XTick',[1 2],'XTickLabel',[]);
savefig('DPA_Distr_OnOff.fig');
print('DPA_Distr_OnOff.eps','-deps','-r0');

end



function plotOne(x,y,pColor)
dd=0.5;
randd=@(x) rand(size(x,1),1)*0.5-0.25;
plot((x+randd(y))',y',sprintf('-%s.',pColor));

ci=bootci(100,@(x) mean(x), y(:,2));
plot([x(2)-dd,x(2)-dd],ci,sprintf('-%s',pColor),'LineWidth',1);
disp(ci)
ci=bootci(100,@(x) mean(x), y(:,1));
plot([x(1)+dd,x(1)+dd],ci,sprintf('-%s',pColor),'LineWidth',1);

plot(x(2)-dd,mean(y(:,2)),sprintf('%so',pColor),'MarkerFaceColor','w','MarkerSize',4,'LineWidth',1);
plot(x(1)+dd,mean(y(:,1)),sprintf('%so',pColor),'MarkerFaceColor',pColor,'MarkerSize',4,'LineWidth',1);

end