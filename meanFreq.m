z.setMinLick(4);
avgFreq=zeros(7,2);
idx=0;
for mice=[66 67 76 78 80 81 83]
    idx=idx+1;
    mStr=num2str(mice);
    disp(mStr);
    f=z.listFiles('I:\Behavior\2014\',{mStr,'InDelay','ChR2.ser','3s'});
    disp(f);
    if size(f,1)<1
        continue;
    end

    z.processLickFile(f);
    avgFreq(idx,1)=mean(double(z.getLickFreq(true(1))));
    avgFreq(idx,2)=mean(double(z.getLickFreq(false(1))));
    
end