function plotQuarter(data ,desc)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
blue=[0.3412    0.7647    0.9294];

opto=data(data(:,2)==1,3:7);
ctrl=data(data(:,2)==0,3:7);

disp([anova1(ctrl,[],'off'), anova1(opto,[],'off')]);

figure('Color','w','Position',[100,100,480,240]);
hold on;
h=bar(1:5,mean(ctrl));
h.FaceColor='k';
h.BarWidth=0.5;
h=bar(7:11,mean(opto));
h.FaceColor=blue;
h.BarWidth=0.5;
h=errorbar(1:5,mean(ctrl),std(ctrl)/sqrt(size(ctrl,1)),'k.');
h.LineWidth=1;
h=errorbar(7:11,mean(opto),std(opto)/sqrt(size(opto,1)),'k.');
h.LineWidth=1;
if min([mean(opto) mean(ctrl)])>50
    ylim([50,100]);
end
set(gca,'XTick',[1:5,7:11],'XTickLabel',{'Ctrl No Laser','Ctrl 1Q Laser','Ctrl 2Q Laser','Ctrl 3Q Laser','Ctrl 4Q Laser','ChR2 No Laser','ChR2 1Q Laser','ChR2 2Q Laser','ChR2 3Q Laser','ChR2 4Q Laser'},'XTickLabelRotation',30);
ylabel(desc);


end

