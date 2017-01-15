function corrTwo (datax,labelx,datay,labely)

dBothO=getOneValue(datax);
dODPA=getOneValue(datay);
figure('Color','w','Position',[100 100 400 300]);
plot(dBothO,dODPA,'ko');
xlabel(labelx);
ylabel(labely);
title('Performance change (%)');


function d=getOneValue(data)
    
    sorted=sortrows(data,1);
    if size(data,2)>9
        distred=strcmpi(sorted(:,10),'distr');
    else
        distred=ones(size(data,1),1);
    end
    offIdx=strcmpi(sorted(:,5),'lightOff');
    offPerf=cell2mat(sorted(offIdx & distred,2));
    onPerf=cell2mat(sorted(distred & (~offIdx),2));
    d=(onPerf-offPerf).*100./offPerf;
end

end