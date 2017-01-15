function out=getLearnPerf(files)
p=javaclasspath('-dynamic');
if ~ismember('I:\java\zmat\build\classes\',p)
    javaaddpath('I:\java\zmat\build\classes\');
end
z=zmat.Zmat;
z.updateFilesList('D:\Behavior\2015\Aug\');
% files=cell(z.listFiles({'TASK_Teach_NoLaser','-P2'}));

ids=unique(regexp(files,'(?<=\\)\w\d+(?=_)','match','once'));
dates=unique(regexp(files,'(?<=_)\d{4}_\d{2}_\d{2}(?=_)','match','once'));
dates=sort(dates);

perf=nan(length(ids),12);
hitRate=perf;
bias=perf;

for i=1:length(ids)
trainedDate=3;
    for d=1:length(dates)

        f=files(~cellfun('isempty',strfind(files,[ids{i},'_',dates{d}])));
        if length(f)>1
            disp(f);
            pause;
        end
        if ~isempty(f)
            z.processFile(f);
            tp=double(sum(z.getPerf(2,0)));
            if numel(tp)<5
                fprintf('File error in %s\n',char(f));
                continue;
            end
            
            tm=z.ser2mat(f);
            if numel(tm)<5
                continue;
            end
%             tHit=sum(tm(:,3)==7 & tm(:,4)~=127);
%             tFalse=sum(tm(:,3)==7 & tm(:,4)~=127);
            
            tl=sum((tm(:,3)==4 | tm(:,3)==7) & tm(:,4)==2);
            tr=sum((tm(:,3)==4 | tm(:,3)==7) & tm(:,4)==3);
            tb=(tl-tr)/(tl+tr)*100;
            
            if abs(tb) > 80
                fprintf('Biased %.2f, %s\n',tb, char(f));
                continue;
            end
            
            bias(i,trainedDate)= tb;
            perf(i,trainedDate)=tp(1)*100/tp(5);
            hitRate(i,trainedDate)=tp(1)*100/(tp(1)+tp(3));
            
            trainedDate=trainedDate+1;
        end
    end
end

out=struct();
out.perf=perf;
out.hitRate=hitRate;
out.bias=bias;
out.ids=ids;

figure('Color','w');
hold on;
plot(bias','LineStyle',':');
plot(nanmean(abs(bias)),'k-');
set(gca,'XTick',1:length(dates));
xlabel('Day');
ylabel('Bias');


figure('Color','w');
hold on;
plot(perf','LineStyle',':');
plot(nanmean(perf),'k-');
set(gca,'XTick',1:length(dates));
xlabel('Day');
ylabel('Performace');


figure('Color','w');
hold on;
plot(hitRate','LineStyle',':');
plot(nanmean(hitRate),'k-');
set(gca,'XTick',1:length(dates));
xlabel('Day');
ylabel('Hit Rate');
end