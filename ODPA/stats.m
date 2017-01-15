function results=stats(files,fullSessione)

p=javaclasspath('-dynamic');
if ~ismember('I:\java\zmat\build\classes\',p)
    javaaddpath('I:\java\zmat\build\classes\');
end
z=zmat.Zmat;

ids=cell(0);
for i=1:length(files)
    outID=regexp(char(files(i)),'(?<=\\)\w?\d{1,4}(?=_)','match');
    if ~ismember(outID{1},ids)
        ids{length(ids)+1}=outID{1};
    end
end



results=cell(1,9);

% optoPos={'D10','D9','D8','D4','D11','D12','D3'};
% optoPos={'D10','D9','D8'};
optoPos={'D10','D9','D8','D4','D11','D12','D3','D220','D214','D216', 'D219', 'D221', 'D215'};
idx=0;
minLick=0;
% fullSession=24;

for mice=1:length(ids)

    f=getMiceFile(ids{mice});
    
    z.setMinLick(minLick);
    z.setFullSession(fullSession);
    z.processFile(f);
%     tOn=double(sum(z.getPerf(true,50)));  
%     tOff=double(sum(z.getPerf(false,50))); 

    tOn=double(sum(z.getPerf(true,0)));  
    tOff=double(sum(z.getPerf(false,0))); 
    
    if tOn(5)>0
        crs=(tOn(1)+tOn(4))*100/tOn(5);
        fas=tOn(3)*100/(tOn(3)+tOn(4));
        mss=tOn(2)*100/(tOn(1)+tOn(2));
        lickEff=tOn(6)*100/(tOn(6)+tOn(7));
    end
    
    if length(tOff)>4 && tOff(5)>0
        crs(:,2)=(tOff(1)+tOff(4))*100/tOff(5);
        fas(:,2)=tOff(3)*100/(tOff(3)+tOff(4));
        mss(:,2)=tOff(2)*100/(tOff(1)+tOff(2));
        lickEff(:,2)=tOff(6)*100/(tOff(6)+tOff(7));
    end
    
    
    
    fam=double(fas);
    msm=double(mss);
    
    fam(fam<0.1)=0.1;
    msm(msm<0.1)=0.1;
    
    fam(fam>99.9)=99.9;
    msm(msm>99.9)=99.9;
    
    dpc=norminv((100-msm)./100)-norminv(fam./100);
    
    if ismember(ids{mice},optoPos)
        strainStr='ChR2';
    else
        strainStr='ctrl';
    end
    
    odor='RQ';

    
    if tOn(5)>0
        idx=idx+1;
        results(idx,:)={ids{mice}, crs(:,1),fas(:,1),mss(:,1),'lightOn',strainStr,dpc(1),odor,lickEff(:,1)};
    end
    if length(tOff)>4 && tOff(5)>0
        idx=idx+1;
        results(idx,:)={ids{mice}, crs(:,2),fas(:,2),mss(:,2),'lightOff',strainStr,dpc(2),odor,lickEff(:,2)};
    end
end

    function out=getMiceFile(id)
        out=char(files(~(cellfun('isempty',regexp(files,['(?<=\\)',id,'(?=_)'])))));
    end

end

