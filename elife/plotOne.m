
function factors=plotOne(fn,skip)
if exist('skip','var') && skip && exist('stats.txt','file')
    return
end

if isempty(fn)
    return
end
if size(fn,1)>1
    fn=fn(end,:);
end
javaaddpath('I:\java\zmat\build\classes\');
z=zmat.Zmat;
z.setFullSession(0);

z.processFile(fn);
factors=z.getFactorSeq(false,false);
% l=z.getTrialLick(0);
% violated=false(size(l));
factors(factors(:,4)==3 & factors(:,5)<2,4)=4;
len=size(factors,1);
perf=zeros(len-39,1);
if size(factors,1)>40
    for i=40:size(factors)
        perf(i-39)=mean(ismember(factors(i-39:i,4),[3,6]));
    end
end
mid=regexp(fn,'(?<=\\)\d{3,4}(?=_2019)','match','once');
% figure();
hold on;
plot(perf);
plot(xlim(),[0.8,0.8],':k');
ylim([0,1]);
set(gca,'YTick',[])

if contains(fn,'Test','IgnoreCase',true) && contains(fn,'Shaping','IgnoreCase',true)
    suffix=' Error in task';
elseif contains(fn,'Test','IgnoreCase',true)
    suffix=regexp(fn,'TEST_{0,1}\d{0,2}[sS]{0,1}','match','once');
elseif contains(fn,'Opto','IgnoreCase',true)
    suffix=regexpi(fn,'OPTO_{0,1}\d{0,2}[sS]{0,1}','match','once');
elseif contains(fn,'Shaping','IgnoreCase',true)
    suffix=' Shaping';
else
    suffix=' Unknown task';
end
title(sprintf('%s %s',mid,suffix),'Interpreter','none');
end

function useless
fh=figure('Color','w','Visible','off');
hold on;
fill([-2000,-3000,-3000,-2000],[0.5,0.5,1000,1000],[1,0.8,0.8],'EdgeColor','none');
fill([0,1000,1000,0],[0.5,0.5,1000,1000],[0.8,0.8,1],'EdgeColor','none');
for i=1:size(l,1)
    if ~isempty(l{i})
        lr=l{i}(l{i}(:,2)==82,1);
        ll=l{i}(l{i}(:,2)==76,1);
        if ~isempty(lr)
            plot([1;1]*double(lr).',[i-0.8,i+0.8],'-r');
        end
        
        if ~isempty(ll)
            plot([1;1]*double(ll).',[i-0.8,i+0.8],'-b');
        end
        if(sum(l{i}(:,1)>-2000 & l{i}(:,1)<0)>0)
            violated(i)=true;
        end
    end
    
    switch factors(i,3)
        case 3
            if violated(i)
                plot(3500,i,'ko','MarkerSize',2,'MarkerFaceColor','none');
            else
                plot(3500,i,'ko','MarkerSize',2,'MarkerFaceColor','k');
            end
        case 4
            plot(3700,i,'bo','MarkerSize',2,'MarkerFaceColor','b');
        case 5
            if violated(i)
                plot(3600,i,'ro','MarkerSize',2,'MarkerFaceColor','none');
            else
                plot(3600,i,'ro','MarkerSize',2,'MarkerFaceColor','r');
            end
    end
end



xlim([-4000,4000]);
ylim([0,size(l,1)+1]);
set(gca,'XTick',[-3000,2000],'XTickLabel',[0,5]);
xlabel('Time (s)');
ylabel('Trial #');

set(fh,'PaperPosition',[0,0,4,10]);
set(gcf, 'PaperSize', [4 10]);
print(fh,'-dpng','raster.png','-r300')
% print(fh, 'raster.eps', '-depsc','-painters', '-r300' );

fh=fopen('stats.txt','wt');
fprintf(fh,'%s\n',fn);
fprintf(fh,'Overall accuracy (hit/(hit+false)) %.2f%%.\n',sum(factors(:,3)==3)./sum(ismember(factors(:,3),[3 5])).*100);
fprintf(fh,'Overall performance (hit/trials) %.2f%%.\n',sum(factors(:,3)==3)./size(factors,1).*100);
fprintf(fh,'Overall response rate ((hit+false)/trials) %.2f%%.\n',sum(ismember(factors(:,3),[3 5]))./size(factors,1).*100);
fprintf(fh,'Non-violated accuracy %.2f%%.\n',sum(factors(~violated,3)==3)./sum(ismember(factors(~violated,3),[3 5])).*100);
fprintf(fh,'Total hit trials %d, (left %d; right %d).\n',sum(factors(:,3)==3),sum(factors(ismember(factors(:,1),[6 16 17]),3)==3),sum(factors(ismember(factors(:,1),[7,18,19]),3)==3));
fprintf(fh,'Non-violated hit trials %d, (left %d; right %d).\n',sum(factors(~violated,3)==3),sum(factors((~violated) & ismember(factors(:,1),[6 16 17]),3)==3),sum(factors((~violated) & ismember(factors(:,1),[7,18,19]),3)==3));
fclose(fh);
open('stats.txt');

end