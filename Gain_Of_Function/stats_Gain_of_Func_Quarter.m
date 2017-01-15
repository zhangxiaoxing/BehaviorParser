function out=stats_Gain_of_Func_Quarter()
minLick=0;
javaaddpath('I:\java\zmat\build\classes\');
z=zmat.Zmat;
%%%% Hemi Activate
% z.updateFilesList('I:\behavior\2015\');
%%%% Hemi silence
z.updateFilesList('D:\BehaviorNew\Dec');
z.setMinLick(minLick);
% mice=[10:15 29:34 37 38 40:48];

mice=[1:6 11:14 16 21 24 25 31 32 33 34];
% optoPos=[32:34 37 40 42 46 47 48];
optoPos=[1 5 6 12 16 24 31 32 33 34];



n=size(mice,2);
perf=nan(n,7);
perf(:,1)=mice';
perf(:,2)=ismember(mice,optoPos)';

false=perf;
miss=perf;


midx=1;
for mouse=mice
    disp(mouse);
    
%     mStr=['A', num2str(mouse), '_'];
    mStr=['S', num2str(mouse), '_'];
    f=z.listFiles({mStr,'Quarter'});
    if size(f,1)~=1
        disp(f);
        pause;
    end
    
    z.processQtrFile(f);
    for qtr=0:4
        currQtr=double(sum(z.getPerf(qtr,40)));
        
        cr=(currQtr(1)+currQtr(4))*100/currQtr(5);
        fa=currQtr(3)*100/(currQtr(3)+currQtr(4));
        ms=currQtr(2)*100/(currQtr(1)+currQtr(2));
        
        perf(midx,qtr+3)=cr;
        false(midx,qtr+3)=fa;
        miss(midx,qtr+3)=ms;
            
    end
    midx=midx+1;
end
out=struct();
out.perf=perf;
out.miss=miss;
out.false=false;

end

