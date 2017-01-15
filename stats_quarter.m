dpath=javaclasspath('-dynamic');
if ~ismember('I:\java\zmat\build\classes\',dpath)
    javaaddpath('I:\java\zmat\build\classes\');
end
path(path,'I:\behavior\reports\z');
z=zmat.Zmat;


results=cell(11,7);
chr2Pos=[1 7 9 14 15];

idx=0;

for mice=1:15
    mStr=['V',num2str(mice),'_'];
    disp(mStr);
    f=z.listFiles('I:\Behavior\2015\Feb',{mStr,'Qtr'});
    disp(f);
    if size(f,1) ~= 1
        disp([mStr ' ' num2str(size(f,1)) ' instance']);
        if size(f,1)<1
            continue;
        end
    end
%     z.setMinLick(4);
    z.processFile(f);
    crs=double(z.cr());
    fas=double(z.fa());
    mss=double(z.miss());
    
    crs(crs==-1)=NaN;
    fas(fas==-1)=NaN;
    mss(mss==-1)=NaN;
    
    
    fam=nanmean(double(fas));
    msm=nanmean(double(mss));
    
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
  
    tags={'NoLaser','1Q','2Q','3Q','4Q'};
%     tags={'NoLaser','4s','2s','1s','0.5s'};

    for i=1:5
        idx=idx+1;
        results(idx,:)={mice, nanmean(crs(:,i)),nanmean(fas(:,i)),nanmean(mss(:,i)),tags{i},strainStr,dpc(1)};
    end
end

    