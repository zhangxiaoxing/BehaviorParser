function plotODPA(data,prefix)
dpath=javaclasspath('-dynamic');
if ~ismember('I:\java\hel2arial\build\classes\',dpath)
    javaaddpath('I:\java\hel2arial\build\classes\');
end
path(path,'D:\behavior\reports\z');

nonnormAccu=0;
Accu=0;


% h2a=hel2arial.Hel2arial;

measureTags={'p','f','m','d','l'};
% measureTags={'p','f'};

labels={'Performance','False Choice','Miss','\it d''','Lick Efficiency'};

measure=[2:4,7,9];


for m=1:length(measure)
    saveOne(data,measure(m),labels{m},[prefix,'ODPA_',measureTags{m}]);
end
fprintf('%d total, %d non-normal\n', Accu,nonnormAccu);

    function saveOne(data,measure,tag,fileName)
        nonnorm=plotOneSet(data, measure,tag,false);
        nonnormAccu=nonnormAccu+nonnorm;
        Accu=Accu+2;
        set(gcf,'PaperPositionMode','auto');
        print('-depsc',[fileName,'.eps'],'-cmyk');
%         close gcf;
%         h2a.h2a([pwd,'\',fileName,'.eps']);
    end
end