function plotForAI(data)
dpath=javaclasspath('-dynamic');
if ~ismember('I:\java\hel2arial\build\classes\',dpath)
    javaaddpath('I:\java\hel2arial\build\classes\');
end
path(path,'I:\behavior\reports\z');

h2a=hel2arial.Hel2arial;
% data=load('pir.mat');
chr2=data.chr2;
% tasks={'delay5s','delay8s','delay12s','firstOdor','secondOdor','bothOdor','baseline','responseDelay'};
tasks={'delay8s','delay12s','secondOdor','responseDelay'};
% tasks={'delay12s'};
% measureTags={'p','f','m','d','l'};
measureTags={'p','f'};

labels={'Performance','False Choice','Miss','\it d''','Lick Efficiency'};

% measure=[2:4,7,9];
measure=2:3;

for t=1:length(tasks)
    for m=1:length(measure)
        saveOne(chr2.dnms.(tasks{t}),measure(m),labels{m},[tasks{t},measureTags{m}]);
    end
end

    function saveOne(data,measure,tag,fileName)
        plotOneSet(data, measure,tag)
        set(gcf,'PaperPositionMode','auto');
        print('-depsc',[fileName,'.eps'],'-cmyk');
        close gcf;
        h2a.h2a([pwd,'\',fileName,'.eps']);
    end
end