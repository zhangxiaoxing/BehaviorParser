function plotGoNogoInDual(data,forppt,fileNamePrefix)
dpath=javaclasspath('-dynamic');
if ~ismember('I:\java\hel2arial\build\classes\',dpath)
    javaaddpath('I:\java\hel2arial\build\classes\');
end
path(path,'D:\behavior\reports\z');

h2a=hel2arial.Hel2arial;

measureTags={'p','f','m'};
% measureTags={'p','f'};

labels={'Performance','False Choice','Miss'};

measure=[11:13];


if forppt
    figure('Color','w','Position',[100,100,720,250]);
    for m=1:length(measure)
        subplot('Position',[0.3333*m-0.25,0.25,0.25,0.65]);
        saveOne(data,measure(m),labels{m},[fileNamePrefix,measureTags{m}]);
    end
else
    for m=1:length(measure)
        saveOne(data,measure(m),labels{m},[fileNamePrefix,measureTags{m}]);
        p=get(gcf,'Position');
        p(1)=p(1)+m*200;
        set(gcf,'Position',p);
    end
end



    function saveOne(data,measure,tag,fileName)
        plotOneSet(data, measure,tag,forppt);
        set(gcf,'PaperPositionMode','auto');
        print('-depsc',[fileName,'.eps'],'-cmyk');
        %         close gcf;
        h2a.h2a([pwd,'\',fileName,'.eps']);
    end
end