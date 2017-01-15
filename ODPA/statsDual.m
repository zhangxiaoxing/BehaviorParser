function results=statsDual(files,dpaOnOff)
eachTypeTrialNum=0;
fullSession=48;
p=javaclasspath('-dynamic');
if ~ismember('I:\java\zmat\build\classes\',p)
    javaaddpath('I:\java\zmat\build\classes\');
end

if exist('dpaOnOff','var') && dpaOnOff
    z=zmat.ZmatDualDPAOnOff;
else
    z=zmat.ZmatDual;
end
ids=cell(0);
for i=1:length(files)
    outID=regexp(char(files(i)),'(?<=\\)\w?\d{1,4}(?=_)','match');
    if ~ismember(outID{1},ids)
        ids{length(ids)+1}=outID{1};
    end
end



results=cell(0,0);

optoPos={'D10','D9','D8','D4','D11','D12','D3','D220','D214','D216', 'D219', 'D221', 'D215'};
% optoPos={'D10','D9','D8'};
idx=0;
minLick=0;


z.setMinLick(minLick);
z.setFullSession(fullSession);

for mice=1:length(ids)
    
    f=getMiceFile(ids{mice});
    z.processFile(f);
    for laser=[true,false]
        for distr=[true,false]
            line=getOne(laser,distr); %laser, distractor
            if length(line)>9
                idx=idx+1;
                results(idx,:)=line;
            end
        end
    end
    
end

    function out=getMiceFile(id)
        out=char(files(~(cellfun('isempty',regexp(files,['(?<=\\)',id,'(?=_)'])))));
    end

    function out=getOne(laser,distr)
        tPerf=double(sum(z.getPerf(laser,distr,eachTypeTrialNum)));
        %         tOff=double(sum(z.getPerf(false,distracted, 0)));
        
        if length(tPerf)>5 && tPerf(5)>0
            crs=(tPerf(1)+tPerf(4))*100/tPerf(5);
            fas=tPerf(3)*100/(tPerf(3)+tPerf(4));
            mss=tPerf(2)*100/(tPerf(1)+tPerf(2));
            lickEff=tPerf(6)*100/(tPerf(6)+tPerf(7));
            
            
            
            fam=double(fas);
            msm=double(mss);
            
            fam(fam<0.1)=0.1;
            msm(msm<0.1)=0.1;
            
            fam(fam>99.9)=99.9;
            msm(msm>99.9)=99.9;
            
            dpc=norminv((100-msm)./100)-norminv(fam./100);
            
            
            
            crd=(tPerf(8)+tPerf(11))*100/sum(tPerf(8:11));
            fad=tPerf(10)*100/(tPerf(10)+tPerf(11));
            msd=tPerf(9)*100/(tPerf(8)+tPerf(9));
            
            if ismember(ids{mice},optoPos)
                strainStr='ChR2';
            else
                strainStr='ctrl';
            end
            
            odor='RQ';
            
            laserDesc='lightOff';
            if laser
                laserDesc='lightOn';
            end
            
            distrDesc='none';
            if distr
                if exist('dpaOnOff','var') && dpaOnOff
                    distrDesc='dpa';
                else
                    distrDesc='distr';
                end
            end
%             out={ids{mice}, crs(:,1),fas(:,1),mss(:,1),laserDesc,strainStr,dpc(1),odor,lickEff(:,1),distrDesc,};
            out={ids{mice}, crs,fas,mss,laserDesc,strainStr,dpc(1),odor,lickEff(:,1),distrDesc,crd,fad,msd};
        else
%             disp(f);
            out=cell(1,13);
        end
        
        
    end

end

