function [lenX,meandata]=plotVarDelayLen
% load('VarLen.mat');
dataset={'out5','out8','out12','out16','out20','out30','out40'};
measure={'perf','false','miss','dpc','lickEff'};
mDesc={'Correct rate','False choice','Miss','D prime','Lick efficiency'};
lenX=[5,8,12,16,20,30,40];

%%%%%%%%%%%COLOR MAP%%%%%%%%%%%%%%

miceId=[];
for len=1:length(dataset)
    dataStr=evalin('base',dataset{len});
    miceId=[miceId;dataStr.perf(:,1)];
    
    %         disp(sum(data(:,2)==0));
    
end
miceId=unique(miceId);
cmap=colormap('jet');
% cl=length(cmap);
subCmap=cmap(ceil(rand(19,1)*64),:); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
allData=cell(1,7);
for mIdx=1%:length(measure)
    m=measure{mIdx};
    meandata=nan(1,length(dataset));
    semdata=nan(1,length(dataset));
    for len=1:length(dataset)
        dataStr=evalin('base',dataset{len});
        data=dataStr.(m);
        allData{len}=data(data(:,2)==0,[3 1]);
        meandata(len)=mean(data(data(:,2)==0,3));
        stdTemp=std(data(data(:,2)==0,3));
        semdata(len)=stdTemp/sqrt(sum(data(:,2)==0));
%         disp(sum(data(:,2)==0));
        
    end
    ft = fittype('50+b*exp(a*x)');
    fitData=cell2mat(arrayfun(@(x) [repmat(lenX(x),length(allData{x}),1),allData{x}(:,1)],1:length(lenX),'UniformOutput',false)');
    
    [fitM,gof]=fit(fitData(:,1),(fitData(:,2)),ft,'StartPoint',[-0.5,50],'Upper',[0,50]);
    
    
    figure('Color','w','Position',[mIdx*400+100,100,350,240]);
    hold on;
    
%     errorbar(lenX,meandata,semdata,'k.');
%     fill([lenX,fliplr(lenX)],[meandata-semdata,fliplr(meandata+semdata)],[0.8,0.8,0.8],'EdgeColor','none');
    
    for i=1:7
%         plot(lenX(i)+rand(size(allData{i}(:,1)))-0.5,allData{i}(:,1),'o','MarkerSize',3,'MarkerFaceColor',[1,0,0],'MarkerEdgeColor','none');
        arrayfun(@(x) plot(lenX(i)+rand()*1.5-0.75,allData{i}(x,1),'o','MarkerSize',4,'MarkerFaceColor',subCmap(miceId==allData{i}(x,2),:),'MarkerEdgeColor','none'),1:length(allData{i}));
        fprintf('%d s, n = %d\n',lenX(i),length(allData{i}));
    end
%     plot(lenX,meandata,'-k','LineWidth',1,'LineWidth',1.5);
    plot(lenX,exp(fitM.a*lenX)*50+50,'--k','LineWidth',2);
    text(10,100,sprintf('\\tau = %0.2f (s)',-1/fitM.a),'FontSize',12,'Interpreter','tex'); 
    text(20,90,sprintf('r^2 = %0.3f',gof.rsquare),'FontSize',12); 
    set(gca,'YTick',[50 75 100],'FontSize',12);
    xlim([0,41]);
%     errorbar(lenX,meandata,semdata,'.k','LineWidth',1.5);
    ylabel(mDesc{mIdx},'FontSize',12,'FontName','Helvetica');
    xlabel('Delay duration (s)','FontSize',12,'FontName','Helvetica');
    
end

end