fh=figure('Color','w');
for i=1:size(fs)
    subplot(6,4,i);
    plotOne(fs{i});
end

set(fh,'PaperPosition',[0,0,21,29.7]./2,'PaperSize', [21,29.7]./2,'PaperUnits','centimeters');
print(fh,'-dpng',[datestr(now,'yyyymmdd'),'.png'],'-r300');