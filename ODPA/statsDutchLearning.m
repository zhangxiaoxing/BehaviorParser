function results=statsDutchLearning(files)
eachTypeTrialNum=0;
fullSession=24;
minLick=0;
p=javaclasspath('-dynamic');
if ~ismember('I:\java\zmat\build\classes\',p)
    javaaddpath('I:\java\zmat\build\classes\');
end


z=zmat.ZmatDual;

ids=cell(0);
for i=1:length(files)
    outID=regexp(char(files(i)),'(?<=\\)\w?\d{1,2}(?=_)','match');
    if ~isempty(outID) && ~ismember(outID{1},ids)
        ids{length(ids)+1}=outID{1};
    end
end


z.setMinLick(minLick);
z.setFullSession(fullSession);


for mice=1:length(ids)
    f=getMiceFile(ids{mice});
    disp('=========');
    disp(f);
    z.processFile(f);
    laser=false;
    distr=true;
    line=getOne(laser,distr); %laser, distractor
    results(mice)=line;
    
    
end


    function out=getMiceFile(id)
        out=char(files(~(cellfun('isempty',regexp(files,['(?<=\\)',id,'(?=_)'])))));
    end



    function out=getOne(laser,distr)
        out=false;
        tPerf=double(z.getPerf(laser,distr,eachTypeTrialNum));
        %         tOff=double(sum(z.getPerf(false,distracted, 0)));
        
        if length(tPerf)>5 && tPerf(5)>0
            for j=1:size(tPerf,1)-1
                if sum(sum(tPerf(j:j+1,[1 4])))>sum(tPerf(j:j+1,5))*0.8
                    out=true;
                    break
                end
            end
        end
        
    end


end







