function out=plotGNG
javaaddpath('I:\java\hel2arial\build\classes\');javaaddpath('I:\java\zmat\build\classes\');
z=zmat.ZmatGNG;
z.updateFilesList('D:\Behavior\');
close all
f=cell(z.listFiles({'PreOdor','-Nphr','-10mW','-4s','-0mW'}));
f2=cell(z.listFiles({'gonogo','-lr'}));
f=sort([f;f2]);

for i=2:size(f,1)
    if length(f{i-1})>50 && strcmpi(f{i}(1:50),f{i-1}(1:50))
        f{i}='';
    end
end
f2(1)=f(1);

for i=2:size(f,1)
    if length(f{i})>10
        f2=[f2;f(i)];
    end
end
f=f2;


toUse=ones(size(f,1),1);
for i=1:size(f,1)
    z.processFile(f{i});
    o1=z.getPerf(true,50);
    o2=z.getPerf(false,50);
    o=[o1;o2];
    if sum(o(:,5))<100 || sum(sum(o(:,[1 4])))<80
        toUse(i)=0;
    end
end

out=stats(f(toUse>0));

% fprintf('Ctrl n = %d, Opto n = %d \n',sum(strcmpi(out(:,6),'ctrl'))/2, sum(strcmpi(out(:,6),'chr2'))/2)
% 
% % out=stats(f);
% pir.chr2.gonogo=out;
% plotForAI(pir.chr2);
end