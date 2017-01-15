function plotODPA_DpaOnOff(data)
dpath=javaclasspath('-dynamic');
if ~ismember('I:\java\hel2arial\build\classes\',dpath)
    javaaddpath('I:\java\hel2arial\build\classes\');
end
path(path,'I:\behavior\reports\z');

h2a=hel2arial.Hel2arial;

measureTags={'p','f','m','d','l'};
% measureTags={'p','f'};

labels={'Performance','False Choice','Miss','\it d''','Lick Efficiency'};

measure=[2:4,7,9];


for m=1:length(measure)
    saveOne(data,measure(m),labels{m},['ODAP_',measureTags{m}]);
end


    function saveOne(data,measure,tag,fileName)
        plotOneSetDPAOnOff(data, measure,tag)
        set(gcf,'PaperPositionMode','auto');
        print('-depsc',[fileName,'.eps'],'-cmyk');
%         close gcf;
        h2a.h2a([pwd,'\',fileName,'.eps']);
    end
end