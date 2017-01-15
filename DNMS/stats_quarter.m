function out=stats_quarter(files)
dpath=javaclasspath('-dynamic');
if ~ismember('I:\java\zmat\build\classes\',dpath)
    javaaddpath('I:\java\zmat\build\classes\');
end
path(path,'I:\behavior\reports\z');
z=zmat.Zmat;


out=cell(11,6);
chr2Pos={'V1_', 'V7_', 'V9_', 'V14_' 'V15_', '66_','67_','76_','78_','80_','81_','83_','700_','701_','703_','704_'};

idx=0;
ids=unique(regexp(files,'(?<=\\)\w?\d{1,4}_','match','once'));

for i=1:length(ids)
    f=files(~cellfun('isempty',regexp(files,['\\',ids{i}])));
    
    %     z.setMinLick(4);
    perf=nan(1,5);
    false=perf;
    miss=perf;
    z.processQtrFile(f);
    for qtr=1:5
        currQtr=double(sum(z.getPerf(qtr-1,60)));
        
        cr=(currQtr(1)+currQtr(4))*100/currQtr(5);
        fa=currQtr(3)*100/(currQtr(3)+currQtr(4));
        ms=currQtr(2)*100/(currQtr(1)+currQtr(2));
        
        perf(qtr)=cr;
        false(qtr)=fa;
        miss(qtr)=ms;
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
        out(idx,:)={ids{i}, perf(j),false(j),miss(j),tags{j},strainStr};
    end
end

end