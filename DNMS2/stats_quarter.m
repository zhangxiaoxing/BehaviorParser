function out=stats_quarter(files)
dpath=javaclasspath('-dynamic');
if ~ismember('I:\java\zmat\build\classes\',dpath)
    javaaddpath('I:\java\zmat\build\classes\');
end
path(path,'I:\behavior\reports\z');
z=zmat.ZmatQtr;


out=cell(11,6);
chr2Pos={'V1_', 'V7_', 'V9_', 'V14_' 'V15_', '66_','67_','76_','78_','80_','81_','83_','700_','701_','703_','704_'};

idx=0;
ids=unique(regexp(files,'(?<=\\)\w?\d{1,4}_','match','once'));

for i=1:length(ids)
    fs=files(~cellfun('isempty',regexp(files,['\\',ids{i}])));
    facAll=[];
    for fIdx=1:length(fs)
        f=fs{fIdx};
        z.setMinLick(0);
        perf=nan(1,5);
        falseAlarm=perf;
        miss=perf;
        z.processFile(f);
        facs=z.getFactorSeq(false);
        facAll=[facAll;clearBadPerf(facs)];
    end
    for qtr=0:4
        
        cr=sum(ismember(facAll(:,4),[3 6]) & facAll(:,5)==qtr).*100./sum(facAll(:,5)==qtr);
        %             fa=currQtr(3)*100/(currQtr(3)+currQtr(4));
        %             ms=currQtr(2)*100/(currQtr(1)+currQtr(2));
        
        perf(qtr+1)=cr;
        %             falseAlarm(qtr)=fa;
        %             miss(qtr)=ms;
    end
    
    %     fam=nanmean(double(fas));
    %     msm=nanmean(double(mss));
    %
    %     fam(fam<0.1)=0.1;
    %     msm(msm<0.1)=0.1;
    %
    %     fam(fam>99.9)=99.9;
    %     msm(msm>99.9)=99.9;
    %
    %     dpc=norminv((100-msm)./100)-norminv(fam./100);
    %
    if ismember(ids{i},chr2Pos)
        strainStr='ChR2';
    else
        strainStr='ctrl';
    end
    
    tags={'NoLaser','1Q','2Q','3Q','4Q'};
    %     tags={'NoLaser','4s','2s','1s','0.5s'};
    
    for j=1:5
        idx=idx+1;
        %             out(idx,:)={ids{i}, perf(j),falseAlarm(j),miss(j),tags{j},strainStr};
        out(idx,:)={ids{i}, perf(j),perf(j),perf(j),tags{j},strainStr};
    end
end
end



function out=clearBadPerf(facSeq)
if length(facSeq)>=200
    facSeq(:,15)=0;
    i=200;
    while i<length(facSeq)
        goodOff=sum((facSeq(i-199:i,4)==3 | facSeq(i-199:i,4)==6)& facSeq(i-199:i,3)==0);
        if goodOff>=sum(facSeq(i-199:i,3)==0)*80/100
            facSeq(i-199:i-1,15)=1;
        end
        i=i+1;
    end
    out=facSeq(facSeq(:,15)==1,:);
else
    out=[];
end
end