function results=stats(z)

results=cell(1,8);
optoPos=[33 38 41 101 102 106 107 66 67 76 78 80 81 83 1 7 9 14 15];
bj=[32 33 700 701 702 703 704 707 101 102 103 105 106 107 108 109];
mk=[37 38 40 41 64 65 66 67];
rq=[76 77 78 79 80 81 82 83 1:15];
idx=0;
minLick=0;
% task='4345';
% %
for mice=[32 33 37 38 40 41 101 102 103 105 106 107 108 109 64 65 66 67 76 77 78 79 80 81 82 83 700 701 702 703 704 707 1:15]

    mStr=[num2str(mice),'_'];
    if mice<16
        mStr=['V',mStr];
    end
    f1=z.listFiles({mStr,'BothOdor','-NoDelay','ChR2','-NDelay','-LR','-GONOGO'});
    f2=[];
    %     disp(f);
    if size(f1,1)+size(f2,1)< 1
        continue;
    end
    %         disp([mStr ' ' num2str(size(f,1)) ' instance']);
    if size(f2,1)>0
        f=f2;
    else
        f=f1;
    end
    
    z.setMinLick(minLick);
    z.processFile(f);
    tOn=double(sum(z.getPerf(true,50)));
    tOff=double(sum(z.getPerf(false,50)));
    
    if tOn(5)>0
        crs=(tOn(1)+tOn(4))*100/tOn(5);
        fas=tOn(3)*100/(tOn(3)+tOn(4));
        mss=tOn(2)*100/(tOn(1)+tOn(2));
    end
    
    if tOff(4)>0
        crs(:,2)=(tOff(1)+tOff(4))*100/tOff(5);
        fas(:,2)=tOff(3)*100/(tOff(3)+tOff(4));
        mss(:,2)=tOff(2)*100/(tOff(1)+tOff(2));
    end
    
    
    
    fam=double(fas);
    msm=double(mss);
    
    fam(fam<0.1)=0.1;
    msm(msm<0.1)=0.1;
    
    fam(fam>99.9)=99.9;
    msm(msm>99.9)=99.9;
    
    dpc=norminv((100-msm)./100)-norminv(fam./100);
    
    if ismember(mice,optoPos)
        strainStr='ChR2';
    else
        strainStr='ctrl';
    end
    
    if ismember(mice,bj)
        odor='BJ';
    elseif ismember(mice,mk)
        odor='MK';
    elseif ismember(mice,rq)
        odor='RQ';
    else
        odor='NA'
    end
    
    if tOn(4)>0
        idx=idx+1;
        results(idx,:)={mice, crs(:,1),fas(:,1),mss(:,1),'lightOn',strainStr,dpc(1),odor};
    end
    if tOff(4)>0
        idx=idx+1;
        results(idx,:)={mice, crs(:,2),fas(:,2),mss(:,2),'lightOff',strainStr,dpc(2),odor};
    end
end

end

