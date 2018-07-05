function out=plotRespT(fs,perf)
out=struct;
out.fn=cell(0,0);
out.lick=cell(0,0);
z=zmat.Zmat;
ids=[];
for i=1:size(fs,1)
    fn=replace(fs(i),'behaviorNew','behavior2016\2015');
    fn=replace(fn,'behaviornew','behavior2016\2015');
    mid=regexpi(fn,'\\S(\d+)_','tokens','once');
    id=str2double(mid{1});
    if perf.perf(abs(perf.perf(:,1)-id)<0.1,2)==0
        disp(fn);
        z.processFile(fn);
        tLick=z.getTrialLick(100);
        out.fn(i)=fn;
        out.lick{i}=tLick;
    end
end
disp(ids);
end