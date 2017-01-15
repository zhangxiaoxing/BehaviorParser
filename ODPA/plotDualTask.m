function plotDualTask(data,forppt)
dpath=javaclasspath('-dynamic');
if ~ismember('I:\java\hel2arial\build\classes\',dpath)
    javaaddpath('I:\java\hel2arial\build\classes\');
end
path(path,'D:\behavior\reports\z');

% h2a=hel2arial.Hel2arial;

measureTags={'p','f','m','d','l'};
% measureTags={'p','f'};

labels={'Performance','False Choice','Miss','\it d''','Lick Efficiency'};

measure=[2:4,7,9];


if forppt
    figure('Color','w','Position',[100,100,1200,350]);
    for m=1:length(measure)
        subplot('Position',[0.2*m-0.15,0.52,0.15,0.43]);
        saveOne(data,measure(m),labels{m},['DualTask_',measureTags{m}]);
    end    
else
    for m=1:length(measure)
        saveOne(data,measure(m),labels{m},['DualTask_',measureTags{m}]);
    end
end


    function saveOne(data,measure,tag,fileName)
        plotOneDual(data, measure,tag,forppt)
        set(gcf,'PaperPositionMode','auto');
        print('-depsc',[fileName,'.eps'],'-cmyk');
%         close gcf;
%         h2a.h2a([pwd,'\',fileName,'.eps']);
    end
end