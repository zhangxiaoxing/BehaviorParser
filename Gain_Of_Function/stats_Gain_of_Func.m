function out=stats_Gain_of_Func(files)
out=struct();
dpath=javaclasspath('-dynamic');
if ~ismember('I:\java\zmat\build\classes\',dpath)
    javaaddpath('I:\java\zmat\build\classes\');
end
addpath('D:\Behavior\reports\extern_lib\');
z=zmat.Zmat;
optoPos={'A32','A33','A34', 'A37', 'A40', 'A42', 'A46', 'A47', 'A48','S1','S5','S6','S12','S16','S24','S32','S31','S33','S34'};
ids=regexp(files(:,1),'(?<=\\)\w?\d{1,4}(?=_)','match','once');
n=length(ids);
perf=nan(n,10);
perf(:,1)=str2num(char(regexp(ids,'\d*','match','once')));
perf(:,2)=ismember(ids,optoPos);

FA=perf;
miss=perf;
dpc=perf;
lickEff=perf;

z.setMinLick(0);

for mouse=1:size(files,1)
    for date=3:size(files,2)+2
        
        z.processFile(files{mouse,date-2});
        
        tOn=double(sum(z.getPerf(true,200,false)));
        
        if numel(tOn)<7
            disp(files{mouse,date-2});
            pause;
        else
            fas=tOn(3)*100/(tOn(3)+tOn(4));
            mss=tOn(2)*100/(tOn(1)+tOn(2));
            
            perf(mouse,date)=(tOn(1)+tOn(4))*100/tOn(5);
            FA(mouse,date)=fas;
            miss(mouse,date)=mss;
            dpc(mouse,date)=calcDpc(fas,mss);
            lickEff(mouse,date)=tOn(6)*100/(tOn(6)+tOn(7));
        end
    end
end

out.perf=perf;
out.FA=FA;
out.miss=miss;
out.dpc=dpc;
out.lickEff=lickEff;


    function out=calcDpc(fas,mss)
        fam=fas;
        msm=mss;
        
        fam(fam<0.1)=0.1;
        msm(msm<0.1)=0.1;
        
        fam(fam>99.9)=99.9;
        msm(msm>99.9)=99.9;
        
        out=norminv((100-msm)./100)-norminv(fam./100);
    end

end