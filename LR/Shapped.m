thres=16;
if ~exist('z','var')
    p=javaclasspath('-dynamic');
    if ~ismember('I:\java\zmat\build\classes\',p)
        javaaddpath('I:\java\zmat\build\classes\');
    end
    z=zmat.Zmat;
end
z.updateFilesList('I:\behavior\2015\aug');
f=z.listFiles({'09_06','NMWOD'});

for i=1:length(f)
    z.processFile(char(f(i)));
    tp=z.getPerf(2,0);
    if sum(tp(:,1)>thres)>2
        disp(char(f(i)));
        disp(sum(tp(:,1)>thres));
    end
end
