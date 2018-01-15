fn=    {'delay5s',     'delay8s',     'delay12s',     'secondOdor',     'baseline',     'firstOdor',     'bothOdor',     'responseDelay',          'gonogo'};
nlist=cell(0,4);
for i=1:length(fn)
    subList=pir.chr2.dnms.(fn{i});
    for j=1:size(subList,1)
        nlist=[nlist;{subList{j,2},subList{j,5},subList{6},fn{i}}];
    end
end

nlist=cell(0,4);
for i=1:length(fn)
    subList=pir.chr2.dnms.(fn{i});
    for j=1:size(subList,1)
        nlist=[nlist;{subList{j,2},subList{j,5},subList{j,6},fn{i}}];
    end
end

[p,tbl,stats]=anovan(cell2mat(nlist(:,1)),{nlist(:,2),nlist(:,3),nlist(:,4)},'model','full');