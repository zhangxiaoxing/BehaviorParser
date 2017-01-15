function out = gonogo()
javaaddpath('I:\java\zmat\build\classes\');
z=zmat.Zmat;
z.updateFilesList('I:\Behavior');

mice=[93:95,98 99,102,104:107,20:30];
LRChR2Mice=[93 95 99 102 106 22 23 25 28 30];
tasks={'Base','Odor','Response'}

out=struct();


z.setMinLick(0);
mouseCount=1;
hitRate=NaN(length(mice),length(tasks)+2);
hitRate(:,1)=mice';
hitRate(:,2)=ismember(mice,LRChR2Mice)';

miss=hitRate;
perf=hitRate;

for mouse=mice
    dayCount=3;
    for task=1:length(tasks)
        try
            if mouse<90
                mouseStr=['V',num2str(mouse)];
            else
                mouseStr=[num2str(mouse)];
            end
            fl=z.listFiles({mouseStr,tasks{task},'LR','Go'});
            if size(fl,1)>0
                if size(fl,1)~=1
                    disp(fl);
                    pause;
                end
                z.processGoNogoFile(fl);
                t=sum(z.getPerf(1,100));
                hitRate(mouseCount,dayCount)=t(1)*100/(t(1)+t(3));
                miss(mouseCount,dayCount)=t(2)*100/t(5);
                perf(mouseCount,dayCount)=t(1)*100/t(5);
            else
                disp(['error at mouse #',num2str(mouse),'Day ',tasks{task}]);
            end
            dayCount=dayCount+1;
        catch e
            disp([num2str(mouse),', ',tasks{task},', ',e.identifier]);
        end
    end
    mouseCount=mouseCount+1;
end

out.hit=hitRate;
out.miss=miss;
out.perf=perf;


end

