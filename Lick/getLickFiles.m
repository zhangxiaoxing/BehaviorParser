clear java
load fs.mat
javaaddpath('I:\java\zmat\build\classes\')
z=zmat.Zmat;
out=cell(0,0);
for i=1:size(fs,1)
    z.processFile(fs{i});
    perf=sum(z.getPerf(0,0));
    out=[out;{fs{i},sum(perf([1,4]))/perf(5),perf(3)/sum(perf([3,4])),perf(6)/sum(perf([6,7]))}];
end
    