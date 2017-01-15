results=cell(24,7);
chr2Pos=[101 102 106 107 33 38 41];

idx=0;
for mice=[32 33 37 38 40 41 101:109]

    
    mStr=num2str(mice);
    f=o.listFiles('I:\Behavior\',{mStr,'ChR2','PreOdor'});
    disp(f);
    if size(f,1) ~= 1
        disp([mStr ' ' num2str(size(f,1)) ' instance']);
        if size(f,1)<1
            continue;
        end
    end
    o.setMinLick(4);
    o.processFile(f);
    crs=o.cr();
    fas=o.fa();
    mss=o.miss();
    
    fam=mean(double(fas));
    msm=mean(double(mss));
    
    fam(fam<0.1)=0.1;
    msm(msm<0.1)=0.1;
    
    fam(fam>99.9)=99.9;
    msm(msm>99.9)=99.9;
    
    dpc=norminv((100-msm)./100)-norminv(fam./100);
    
    if any(chr2Pos==mice)
        strainStr='ChR2';
    else
        strainStr='ctrl';
    end
  
    idx=idx+1;
    results(idx,:)={mice, mean(crs(:,1)),mean(fas(:,1)),mean(mss(:,1)),'lightOn',strainStr,dpc(1)};
    idx=idx+1;
    results(idx,:)={mice, mean(crs(:,2)),mean(fas(:,2)),mean(mss(:,2)),'lightOff',strainStr,dpc(2)};
end

    