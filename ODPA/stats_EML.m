function out=stats_EML(files)
dpath=javaclasspath('-dynamic');
if ~ismember('I:\java\zmat\build\classes\',dpath)
    javaaddpath('I:\java\zmat\build\classes\');
end
path(path,'I:\behavior\reports\z');
z=zmat.ZmatEML;
z.setMinLick(0);
z.setFullSession(24);

out=cell(11,6);
chr2Pos={'D10_','D9_','D8_','D4_','D11_','D12_','D13_'};

idx=0;
ids=unique(regexp(files,'(?<=\\)\w?\d{1,4}_','match','once'));

for i=1:length(ids)
    f=files(~cellfun('isempty',regexp(files,['\\',ids{i}])));
    
    %     z.setMinLick(4);
    perf=nan(1,4);
    false=perf;
    miss=perf;
    z.processFile(f);
    for qtr=1:4
        currQtr=double(sum(z.getPerf(qtr-1,0)));
        if length(currQtr)<5
            disp(f);
            continue;
        end
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
  
    tags={'NoLaser','Early','Mid','Late'};
%     tags={'NoLaser','4s','2s','1s','0.5s'};

    for j=1:4
        idx=idx+1;
        out(idx,:)={ids{i}, perf(j),false(j),miss(j),tags{j},strainStr};
    end
end

end