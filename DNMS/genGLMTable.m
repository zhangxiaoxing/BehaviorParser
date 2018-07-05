dataTbl=cell(0,0);
odorTag={'S1','S2'};
matchTag={'Non-match','match'};
delayLenTag=zeros(22,1);
delayLenTag([1,11,17,22])=[0.2,5,8,12];
geneTag={'Ctrl','ChR2'};
laserTag={'Laser-off','Laser-on'};
pdTag={'-','Perturb delay'};
pbTag={'-','Perturb baseline'};
for i=1:88
    dataTbl{i,1}=i;
    dataTbl{i,2}=odorTag{dataMat(sortIdx(i),4)-4};
    dataTbl{i,3}=odorTag{dataMat(sortIdx(i),5)-4};
    dataTbl{i,4}=matchTag{(dataMat(sortIdx(i),5)==dataMat(sortIdx(i),4))+1};
    dataTbl{i,5}=delayLenTag(round(dataMat(sortIdx(i),8)+1));
    dataTbl{i,6}=geneTag{dataMat(sortIdx(i),7)+1};
    dataTbl{i,7}=laserTag{dataMat(sortIdx(i),6)+1};
    dataTbl{i,8}=pdTag{dataMat(sortIdx(i),9)+1};
    dataTbl{i,9}=pbTag{dataMat(sortIdx(i),10)+1};
    dataTbl{i,10}=dataMat(sortIdx(i),1);
    dataTbl{i,11}=buildExpression(mdl,(dataMat(sortIdx(i),5)==dataMat(sortIdx(i),4)),dataTbl{i,5},dataMat(sortIdx(i),7),dataMat(sortIdx(i),6),dataMat(sortIdx(i),9));
    dataTbl{i,12}=mdl.Fitted.Response(sortIdx(i));
end

function expr=buildExpression(mdl,match,delay,gene,laser,pd)
intercpt=mdl.Coefficients.Estimate(1);
mC=-mdl.Coefficients.Estimate(2);
dC=-mdl.Coefficients.Estimate(3);
pC=-mdl.Coefficients.Estimate(4);
expr=sprintf('%0.1f - %.1f * %d - %.1f * expdecay(%.1f) - %.1f * %d * %d * expdecay(%.1f) * %d',...
             intercpt,mC,  match, dC,        delay,     pC,    gene, laser, delay,      pd);
end
