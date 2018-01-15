function plotVarDelayLen
dataset={'out5','out8','out12','out16','out20','out30','out40'};
measure={'perf','false','miss','dpc','lickEff'};
mDesc={'Performance','False Choice','Miss','D prime','Lick Efficiency'};
lenX=[5,8,12,16,20,30,40];

close all;
allData=cell(1,7)
for mIdx=1%:length(measure)
    m=measure{mIdx};
    meandata=nan(1,length(dataset));
    semdata=nan(1,length(dataset));
    for len=1:length(dataset)
        dataStr=evalin('base',dataset{len});
        data=dataStr.(m);
        allData{len}=data(data(:,2)==0,3);
        meandata(len)=mean(data(data(:,2)==0,3));
        stdTemp=std(data(data(:,2)==0,3));
        semdata(len)=stdTemp/sqrt(sum(data(:,2)==0));
        disp(sum(data(:,2)==0));
        
    end
    
    figure('Color','w','Position',[mIdx*400+100,100,340,240]);
    hold on;
    
%     errorbar(lenX,meandata,semdata,'k.');
%     fill([lenX,fliplr(lenX)],[meandata-semdata,fliplr(meandata+semdata)],[0.8,0.8,0.8],'EdgeColor','none');
    
    for i=1:7
        plot(lenX(i),allData{i},'o','MarkerSize',4,'MarkerFaceColor',[0.6,0.6,0.6],'MarkerEdgeColor','none');
    end
    plot(lenX,meandata,'-k','LineWidth',1,'LineWidth',1.5);
    errorbar(lenX,meandata,semdata,'.k','LineWidth',1.5);
    ylabel(mDesc{mIdx},'FontSize',10,'FontName','Helvetica');
    xlabel('Delay duration (s)','FontSize',10,'FontName','Helvetica');
    
end

end