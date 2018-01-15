function results=stats(files,earlyTrials)

p=javaclasspath('-dynamic');
if ~ismember('I:\java\zmat\build\classes\',p)
    javaaddpath('I:\java\zmat\build\classes\');
end
z=zmat.ZmatGNG;

ids=cell(0);
for i=1:length(files)
    outID=regexp(char(files(i)),'(?<=\\)\w?\d{1,4}(?=_)','match');
    if ~ismember(outID{1},ids)
        ids{length(ids)+1}=outID{1};
    end
end



results=cell(1,9);

optoPos={'33', '38', '41', '101', '102', '106', '107', '66', '67', '76', '78', '80', '81', '83','V14','V15','V7','V9','V1','V49','V50','V58','V59','V62','S1','S5','S6','S12','S16','S24','S32','S31','S33','S34'};
bj={'32', '33', '700', '701', '702', '703', '704', '707', '101', '102', '103', '105', '106', '107', '108', '109'};
mk={'37', '38', '40', '41', '64', '65', '66', '67'};
rq={'76', '77', '78', '79', '80', '81', '82', '83','V14','V15','V7','V9','V1','V2','V3','V4','V11','V12','V13','V46','V48','V49','V50','V51','V55','V58','V59','V61','V62','V63'};
idx=0;
minLick=0;

for mice=1:length(ids)

    f=getMiceFile(ids{mice});
    
    z.setMinLick(minLick);
    if exist('earlyTrials','var') && earlyTrials
        z.processFile(f(1,:));
        tOn=double(sum(z.getPerf(true,10),1));  
        tOff=double(sum(z.getPerf(false,10),1)); 
    else
        z.processFile(f);
        tOn=double(sum(z.getPerf(true,50)));  
        tOff=double(sum(z.getPerf(false,50))); 
        if length(tOn)<5
            disp(f);
            pause;
        end
    end
    
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
    
    if ismember(ids{mice},bj)
        odor='BJ';
    elseif ismember(ids{mice},mk)
        odor='MK';
    elseif ismember(ids{mice},rq)
        odor='RQ';
    else
        odor='RQ';
    end
    
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

