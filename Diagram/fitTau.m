function fitTau()
load('Qtr.mat');
Qs={'1Q','2Q','3Q','4Q'};
m=nan(1,4);
for i=1:4
    sel=(strcmpi(c(:,5),Qs{i}) & (strcmpi(c(:,6),'ChR2')));
    m(i)=mean(cell2mat((c(sel,2))));
end
end