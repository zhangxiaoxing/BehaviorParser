function out=stats_Gain_of_Func_Catch(files)
out=struct();
optoPos={'A32','A33','A34', 'A37', 'A40', 'A42', 'A46', 'A47', 'A48','S1','S5','S6','S12','S16','S24','S32','S31','S33','S34'};
% tasks={'noodor','incongruent'};
tasks={'silenceIncongruent','silenceNoOdor'};

dpath=javaclasspath('-dynamic');
if ~ismember('I:\java\zmat\build\classes\',dpath)
    javaaddpath('I:\java\zmat\build\classes\');
end
z=zmat.Zmat;
z.setMinLick(0);




for t=1:length(tasks)
    fls=files.(tasks{t});
    ids=regexp(fls,'(?<=\\)\w?\d{1,4}(?=_)','match','once');
    n=length(ids);
    perf=nan(n,4);
    perf(:,1)=str2num(char(regexp(ids,'\d*','match','once')));
    perf(:,2)=ismember(ids,optoPos);
    false=perf;
    miss=perf;
    
    for i=1:length(ids)
        f=fls(~cellfun('isempty',regexp(fls,['\\',ids{i},'_'])));
            if size(f,1)~=1
                disp(f);
                pause;
                continue;
            end

        z.processCatchFile(f);
        for catchTrial=0:1
            currQtr=double(sum(z.getCatchPerf(catchTrial,160-catchTrial*120)));

            cr=(currQtr(1)+currQtr(4))*100/currQtr(5);
            fa=currQtr(3)*100/(currQtr(3)+currQtr(4));
            ms=currQtr(2)*100/(currQtr(1)+currQtr(2));

            perf(i,catchTrial+3)=cr;
            false(i,catchTrial+3)=fa;
            miss(i,catchTrial+3)=ms;
        end
    end
        out.(tasks{t})=struct();
        out.(tasks{t}).perf=perf;
        out.(tasks{t}).false=false;
        out.(tasks{t}).miss=miss;
end


end

