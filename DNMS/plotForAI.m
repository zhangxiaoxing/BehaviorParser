function plotForAI(data)
dpath=javaclasspath('-dynamic');
if ~ismember('I:\java\hel2arial\build\classes\',dpath)
    javaaddpath('I:\java\hel2arial\build\classes\');
end
path(path,'D:\behavior\reports\z');

nonnormAccu=0;
Accu=0;

h2a=hel2arial.Hel2arial;
% data=load('newPir.mat');
% chr2=data.chr2;
chr2=data;
% tasks={'delay5s','delay8s','delay12s','firstOdor','secondOdor','bothOdor','baseline','responseDelay','gonogo'};
% tasks={'delay5s','delay8s','delay12s','delay16s','delay20s'};
% tasks={'firstOdor','secondOdor','responseDelay'};
% tasks={'delay12s','delay8s','delay5s','baseline','gonogo'};%
tasks={'delay5s'};

measureTags={'p','f','m','d','l'};
% measureTags={'p','f'};

labels={'Performance','False Choice','Miss','\it d''','Lick Efficiency'};
% labels={'Performance','False Choice','Miss'};

measure=[2:4,7,9];
% measure=[2:4];


for t=1:length(tasks)
    for m=1:length(measure)
        saveOne(chr2.dnms.(tasks{t}),measure(m),labels{m},['silence',tasks{t},measureTags{m}]);
%         saveOne(chr2.(tasks{t}),measure(m),labels{m},['silence',tasks{t},measureTags{m}]);
        set(gcf,'Position',[(m-1)*200+100,(t-1)*50+100,175,200]);
%         set(gcf,'Position',[(m-1)*200+100,(t-1)*250+100,175,200]);
    end
end

fprintf('%d total, %d non-normal\n', Accu,nonnormAccu);

    function saveOne(data,measure,tag,fileName)
        [pctrl,popto,nonnorm]=plotOneSet(data, measure,tag);
        nonnormAccu=nonnormAccu+nonnorm;
        Accu=Accu+2;
        stats=[pctrl,popto];
        save([fileName,'_Stats.txt'],'stats','-ascii');
        fprintf('%s, %.4f, %.4f\n',fileName,pctrl,popto);
        set(gcf,'PaperPositionMode','auto');
        print('-depsc',[fileName,'.eps'],'-cmyk');
%         close gcf;
        h2a.h2a([pwd,'\',fileName,'.eps']);
    end
end