results=cell(24,7);
chr2Pos=[51 57 62 82 65 66 67];

idx=0;

for mice=[51 53 54 57 59 60 62 63 65 66 67 69 70 81 82 87 88 90 91]
    mStr=num2str(mice);
    disp(mStr);
    f=z.listFiles('I:\Behavior\2015\CYL\NPHR\',{mStr,'4343'});
%     disp(f);
    if size(f,1) ~= 1
        disp([mStr ' ' num2str(size(f,1)) ' instance']);
        if size(f,1)<1
            continue;
        end
    end
    z.setMinLick(4);
    z.processFile(f);
    crs=z.cr();
    fas=z.fa();
    mss=z.miss();
    
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

    