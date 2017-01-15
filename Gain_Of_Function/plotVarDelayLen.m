function plotVarDelayLen
dataset={'out5','out8','out12','out16','out20','out30','out40'};
measure={'perf','false','miss','dpc','lickEff'};
mDesc={'Performance','False Choice','Miss','D prime','Lick Efficiency'};
lenX=[5,8,12,16,20,30,40];

close all;

for mIdx=1:length(measure)
    m=measure{mIdx};
    meandata=nan(1,length(dataset));
    semdata=nan(1,length(dataset));
    for len=1:length(dataset)
        dataStr=evalin('base',dataset{len});
        data=dataStr.(m);
        meandata(len)=mean(data(data(:,2)==0,3));
        stdTemp=std(data(data(:,2)==0,3));
        semdata(len)=stdTemp/sqrt(sum(data(:,2)==0));
        disp(sum(data(:,2)==0));
        
    end
    
    figure('Color','w','Position',[mIdx*400+100,100,300,200]);
    hold on;
    plot(lenX,meandata,'LineWidth',2,'Color','k');
    errorbar(lenX,meandata,semdata,'k.');
    
    ylabel(mDesc{mIdx});
    xlabel('Delay duration (s)');
    
end

end